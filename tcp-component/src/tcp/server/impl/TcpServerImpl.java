package tcp.server.impl;

import java.net.InetSocketAddress;
import java.net.Socket;
import java.nio.ByteBuffer;
import java.nio.channels.CancelledKeyException;
import java.nio.channels.SelectionKey;
import java.nio.channels.Selector;
import java.nio.channels.ServerSocketChannel;
import java.nio.channels.SocketChannel;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import tcp.server.TcpServer;
import tcp.server.TcpServerDataHandler;
import tcp.util.GeneralException;
import tcp.util.ThreadUtil;

public class TcpServerImpl implements TcpServer, Runnable {
	private String serverIp = null;		// 侦听的IP地址，如不指定，则为全部Ip地址
	private int serverPort;				// 侦听的端口号
	private int bufferSize = 4 * 1024;	// 接收数据的缓冲区大小
	private TcpServerDataHandler dataHandler = null;
	private ServerSocketChannel serverSocketChannel = null;
	private Selector selector = null;
	private boolean bStart = false;		// Server 是否已经启动
	private Thread recvThread = null;	// 建立连接、数据收发的线程
	private boolean bCanRun = true;		// 控制线程的标志
	private int nextConnectId = 1;		// 当前连接总数
	private Map<Integer, ConnectInfo> connectMap = new Hashtable<Integer, ConnectInfo>();
	
	public String getServerIp() {
		return serverIp;
	}
	public void setServerIp(String serverIp) {
		this.serverIp = serverIp;
	}
	
	public int getServerPort() {
		return serverPort;
	}
	public void setServerPort(int serverPort) {
		this.serverPort = serverPort;
	}
	
	public int getBufferSize() {
		return bufferSize;
	}
	public void setBufferSize(int bufferSize) {
		this.bufferSize = bufferSize;
	}
	
    public void setDataHandler(TcpServerDataHandler dataHandler) {
    	this.dataHandler = dataHandler;
    }
    public TcpServerDataHandler getDataHandler() {
    	return dataHandler;
    }

    //  Server 是否已经启动
    public boolean isStart() {
    	return bStart;
    }
    
    // 查询当前的客户端连接数
    public int getConnectCount() {
    	return connectMap.size();
    }
    
    // 启动服务器
    public void start() {
    	try {
			InetSocketAddress socketAddress = null;
			if (serverIp != null && serverIp.length() > 0){
				socketAddress = new InetSocketAddress(serverIp, serverPort);
			} else {
				socketAddress = new InetSocketAddress(serverPort);
			}
			serverSocketChannel = ServerSocketChannel.open();
			serverSocketChannel.socket().bind(socketAddress);
			serverSocketChannel.configureBlocking(false);	// 设为非阻塞
			
			// 注册 accept 事件
			selector = Selector.open();
			serverSocketChannel.register(selector, SelectionKey.OP_ACCEPT);
			
			// 启动数据处理线程
			bCanRun = true;
			recvThread = new Thread(this);
			recvThread.start();			
			
			bStart = true;
		} catch (Exception e) {
			throw new GeneralException(e);
		}
    }

    // 停止服务器
    public void stop() {
    	bStart = false;
    	bCanRun = false;
    	
    	// 停止接收线程
    	if (recvThread != null) {
    		ThreadUtil.stop(recvThread, 5000);
	    	recvThread = null;
    	}
    	
    	// 关闭Selector
    	if (selector != null) {
    		try {
    			selector.close();
    		} catch (Exception e) {}
    		selector = null;
    	}
    	
    	// 关闭ServerSocketChannel
    	if (serverSocketChannel != null) {
    		try {
    			serverSocketChannel.close();
    		} catch (Exception e) {}
    		serverSocketChannel = null;
    	}
    	
    	// 清除客户端信息
    	connectMap.clear();
    }

    //  往客户端发消息
    public void send(int connectId, byte[] bytes) {
    	send(connectId, bytes, 0, bytes.length);
    }
    
    public void send(int connectId, byte[] bytes, int offset, int len) {
    	if (!bStart) {
    		throw new GeneralException("server is not started!");
    	}
    	
    	ConnectInfo ci = (ConnectInfo)connectMap.get(connectId);
    	if (ci == null) {
    		throw new GeneralException("connectId " + connectId + " is invalid!");
    	}
    	
    	ci.addSendData(bytes, offset, len);
    	// 对读写都进行检测
    	ci.key.interestOps(SelectionKey.OP_WRITE | SelectionKey.OP_READ);
    	selector.wakeup();
    }

    // 断开指定的客户端
    public void disconnect(int connectId) {
    	ConnectInfo ci = (ConnectInfo)connectMap.get(connectId);
    	if (ci != null) {
    		removeConnection(ci);
    	}
    }
    
    
    public void run() {
    	while (bCanRun) {
    		try {
    			int iCount = selectKeys();
    			if (iCount > 0) {
    				Thread.yield();	// 避免一直占用CPU
    			}
    		} catch (Exception e) { }
    	}
    }
    
    private int selectKeys() throws Exception {
    	int iCount = selector.select(500);
    	if (iCount < 1) {
    		return iCount;
    	}
    	
    	Iterator it = selector.selectedKeys().iterator();
		while (it.hasNext()) {
			SelectionKey key = (SelectionKey)it.next();
			it.remove();
			
			if (key.isValid() == false) {
				continue;
			}
			
			if (key.isAcceptable()) {
				try {
					accept(key);
				} catch (Exception e) {}
			} else {
				try {
					// 当连接可读的时候响应
					if (key.isReadable()) {
						recvData(key);
					}
					// 当连接可写的时候响应
					if (key.isWritable()) {
						sendData(key);
					}
				} catch (CancelledKeyException ex) {
					removeConnection((ConnectInfo)key.attachment());
				}
			}
		}
		
		return iCount;
	}
    
    private void accept(SelectionKey key) throws Exception {
    	// 接受客户端的连接，获取客户端的Ip和Port
    	ServerSocketChannel server = (ServerSocketChannel)key.channel();
		SocketChannel socketChannel = server.accept();
		socketChannel.configureBlocking(false);
		Socket socket = socketChannel.socket();
		String ip = socket.getInetAddress().getHostAddress();
		int port = socket.getPort();
		
		// 将此连接存放connectMap里
		int connectId = nextConnectId++;
		ConnectInfo ci = new ConnectInfo(ip, port, socketChannel, connectId, bufferSize);
		SelectionKey sk = socketChannel.register(selector, SelectionKey.OP_READ, ci);
		ci.setKey(sk);
		
		connectMap.put(new Integer(connectId), ci);
		
		dataHandler.onConnect(connectId, ip, port);
	}
    
    private void recvData(SelectionKey key) {
		ConnectInfo ci = (ConnectInfo)key.attachment();
		boolean broken = false;
		int iRead = 0;
		while (true) {
			int iCount = ci.read();		// 读取数据
			if (iCount == -1) {
				broken = true;	// 连接断开
				break;
			} else if (iCount == 0) {	// 没有数据
				break;
			} else {
				iRead += iCount;
			}
		}
		
		if (!broken) {	// 连接正常
			if (iRead < 1) {	// 未收到数据
				return;
			}
			
			// 进行包边界识别
			ByteBuffer buffer = ci.recvBuffer;
			int dataLen = buffer.position();
			buffer.position(0);
			byte[] data = new byte[dataLen];
			buffer.get(data);
			int curDataLen = dataLen;
			while (true) {	
				int iLen = dataHandler.slice(ci.connectId, data, curDataLen);
				if (iLen > 0) {	// 有完整的数据包
					dataHandler.onReceiveMsg(ci.connectId, data, iLen);
					
					curDataLen -= iLen;
					if (curDataLen > 0) {	// 还有剩余数据
						System.arraycopy(data, iLen, data, 0, curDataLen);
					} else {
						break;
					}
				} else {	// 不够一个完整的数据包
					break;
				}
			}
			
			if (curDataLen < dataLen) {	// 收缩缓冲区
				buffer.position(dataLen - curDataLen);
				buffer.limit(dataLen);
				buffer.compact();
			}
		} else {		// 连接已经断开
			removeConnection(ci);
		}
	}
    
	private void sendData(SelectionKey key) throws Exception {
		ConnectInfo ci = (ConnectInfo)key.attachment();
		List sendList = ci.sendList;
		synchronized(sendList) {
			while (!sendList.isEmpty()) {
				byte[] bytes = (byte[])sendList.remove(0);
				ByteBuffer buffer = ByteBuffer.wrap(bytes);
				while (buffer.hasRemaining()) {
					ci.socketChannel.write(buffer);
				}
				
				dataHandler.onSendMsg(ci.connectId, bytes, bytes.length);
			}
		}
		
		key.interestOps(SelectionKey.OP_READ);	// 恢复读
	}
	
	private void removeConnection(ConnectInfo ci) {
		ci.close();
		synchronized (connectMap) {
			connectMap.remove(ci.connectId);
		}

		dataHandler.onDisconnect(ci.connectId, ci.ip, ci.port);		
	}
	
}
