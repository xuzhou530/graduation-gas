package tcp.client.impl;

import java.io.IOException;
import java.io.InputStream;
import java.io.InterruptedIOException;
import java.io.OutputStream;
import java.net.InetSocketAddress;
import java.net.Socket;

import tcp.client.TcpClient;
import tcp.client.TcpClientDataHandler;
import tcp.util.GeneralException;
import tcp.util.ThreadUtil;


public class TcpClientImpl implements TcpClient, Runnable {
	private String serverIp;
	private int serverPort;
	private boolean autoReconnect = false;
	private int reconnectInterval = 5000;
	private int bufferSize = 4 * 1024;
	
	private TcpClientDataHandler dataHandler;
	private boolean bConnected = false;	// 当前是否连接
	private Socket socket = null;		// 连接
	private InputStream inputStream;	// 接收数据的流
	private OutputStream outputStream;	// 发送数据的流
	private Thread recvThread;			// 接收数据的线程
	private boolean bCanRun = true;		// 控制接收线程退出的变量
	private byte[] recvBuffer;			// 接收数据的缓冲区
	private int recvCount = 0;			// 当前接收到的数据，字节数
	
	
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
	
	public void setAutoReconnect(boolean autoReconnect) {
		this.autoReconnect = autoReconnect;
	}
	
	public boolean isAutoReconnect() {
		return autoReconnect;
	}
	
	public int getReconnectInterval() {
		return reconnectInterval;
	}
	public void setReconnectInterval(int reconnectInterval) {
		this.reconnectInterval = reconnectInterval;
	}
	
	public int getBufferSize() {
		return bufferSize;
	}
	public void setBufferSize(int bufferSize) {
		this.bufferSize = bufferSize;
	}
	
	
	public TcpClientDataHandler getDataHandler() {
		return dataHandler;
	}
	public void setDataHandler(TcpClientDataHandler tcpClientDataHandler) {
		this.dataHandler = tcpClientDataHandler;
	}
	
	//	 查询当前的连接状态
    public boolean isConnected() {
    	return bConnected;
    }
    
	// 连接服务器
    public void connect() {
    	try {
    		// 1. 初始化Socket
    		if (socket == null) {
	    		socket = new Socket();
	    		socket.setSoTimeout(3000);	// 设置超时时间
	    		socket.setSendBufferSize(bufferSize);
	    		socket.setReceiveBufferSize(bufferSize);
	    		
	    		recvBuffer = new byte[bufferSize];	// 接收数据的缓冲区
	    		recvCount = 0;
    		}
    		
    		// 2. 建立连接
    		try {
	    		InetSocketAddress address = new InetSocketAddress(serverIp, serverPort);
	    		socket.connect(address);
	    		   		
	    		inputStream = socket.getInputStream();
	    		outputStream = socket.getOutputStream();
	    		bConnected = true;
	    		
	    		// 3. 通知应用上层，连接已经成功建立
	    		if (dataHandler != null) {
	    			dataHandler.onConnect(serverIp, serverPort);
	    		}
    		} finally {
	    		// 4. 创建接收/重连线程
    			if ((bConnected || autoReconnect) && (recvThread == null)) {
		    		bCanRun = true;
		    		recvThread = new Thread(this);
		    		recvThread.start();
    			}
    		}
    	} catch (Exception e) {
    		throw new GeneralException(e);
    	}
    }

    // 向服务器发送数据
    public void send(byte[] bytes) {
    	send(bytes, 0, bytes.length);
    }
    
    public void send(byte[] bytes, int offset, int len) {
    	if (bConnected) {
    		try {
    			synchronized(outputStream) {
    				outputStream.write(bytes, offset, len);
    			}
    			
    			if (dataHandler != null) {
    				byte[] data = bytes;
    				if (len != bytes.length) {
    					data = new byte[len];
    					System.arraycopy(bytes, offset, data, 0, len);
    				}
    				dataHandler.onSendMsg(data, len);
    			}
    		} catch (Exception e) {
    			//bConnected = false;		// 此处不设置断连标志，断连的检测全部放到线程中进行
    			throw new GeneralException(e);
    		}
    	} else {
    		throw new GeneralException("connection is broken!");
    	}
    }


    // 断开和服务器的连接
    public void disconnect() {
    	bCanRun = false;
		bConnected = false;	// 阻止应用再发送数据
		
		// 停止接收线程
		if (recvThread != null) {
			ThreadUtil.stop(recvThread, 5000);
			recvThread = null;
		}
		
		// 关闭连接
		if (socket != null) {
			closeSocket();
			
			// 通知应用，连接已经断开
			if (dataHandler != null) {
				dataHandler.onDisconnect();
			}
		}
    }
    
    private void closeSocket() {
    	if (socket != null) {
    		try {
				inputStream.close();
			} catch (Exception e) {}
			try {
				outputStream.close();
			} catch (Exception e) {}
			try {
				socket.close();
			} catch (Exception e) {}
			socket = null;
			inputStream = null;
			outputStream = null;
    	}
    }
    
    public void run() {
    	while (bCanRun) {
    		if (bConnected) {	// 连接正常时，收取数据
    			try {
    				int iLen = bufferSize - recvCount;
    				int iCount = inputStream.read(recvBuffer, recvCount, iLen);
    				if (iCount < 1) {	// 流被关闭
    					bConnected = false;
    				} else {  
    					
    					recvCount += iCount;
    					while (true) {
    						iCount = dataHandler.slice(recvBuffer, recvCount);
    						
    						if (iCount > 0) {	// 有一个完整的数据包
    							if (dataHandler != null) {
    								dataHandler.onReceiveMsg(recvBuffer, iCount);
    							}
    							
    							recvCount -= iCount;	// 剩余字节数
    							if (recvCount > 0) {
    								System.arraycopy(recvBuffer, iCount, recvBuffer, 0, recvCount);
    							} else {				// 缓冲区没有数据了
    								break;
    							}
    						} else {	// 不够一个完整的数据包
    							break;
    						}
    					}
    				}
    			} catch (InterruptedIOException e) {
    				// 暂时没有数据到来
    			} catch (IOException e) {
    				// 发生异常，连接断开
    				bConnected = false;
    			}
    			
    			if (bConnected == false) {	// 发生断连
	    			if (bCanRun && dataHandler != null) {
						dataHandler.onDisconnect();
					}
    			}
    		} else {	// 断开时，处理自动重连
				if (!autoReconnect) {	// 不自动重连，则退出
					break;
				}
				
				// 休眠
				boolean bSleep = ThreadUtil.sleep(reconnectInterval);
				
				// 尝试重连
				if (bSleep) {
					try {
						connect();
					} catch (Exception e) { }
				}
    		}
    	}
    	
    } 
}
