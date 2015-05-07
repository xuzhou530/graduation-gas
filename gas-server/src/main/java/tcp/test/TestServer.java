package tcp.test;

import org.springframework.beans.factory.BeanFactory;

import tcp.server.TcpServer;
import tcp.server.TcpServerDataHandler;
import tcp.util.GetBeanFactory;
import tcp.util.HandleData;

public class TestServer implements TcpServerDataHandler {
	
	private TcpServer server;
	
	public void setServer(TcpServer server) {
		this.server = server;
	}
	
	public static void main(String[] args) {
	    BeanFactory factory = GetBeanFactory.getInstance();
	    TcpServer tcpServer = (TcpServer)factory.getBean("tcpServer");//通信层实例
	    tcpServer.start();
		System.out.println("server is started!");
	}
	
	/**
	 * 发送数据到客户端
	 */
	public void sendData(int connectId, byte[] bytes){
		server.send(connectId, bytes);
	}
	
	/**
	 * 当连通时
	 */
	public void onConnect(int connectId, String ip, int port) {
		String str = String.format("s: client connect, id=%d, ip=%s, port=%d", 
				connectId, ip, port);
		System.out.println(str);
		sendData(1,"hello world".getBytes());
	}

	/**
	 * 当断连时
	 */
	public void onDisconnect(int connectId, String ip, int port) {
		String str = String.format("s: client disconnect, id=%d, ip=%s, port=%d", 
				connectId, ip, port);
		System.out.println(str);
	}

	/*
	 * 服务器端应用程序对接收到的消息进行切片
	 * 如果可以切到一个完整的消息包,就返回此包的长度,
	 * 如果没有得到一个完整的消息包,就返回-1.
	*/
	public int slice(int connectId, byte[] bytes, int byteCount) {
		for (int i = 0; i < byteCount; i++) {
			if (bytes[i] == 0) {
				return i + 1;
			}
		}
		return -1;
	}

	/**
	 * 当接收到数据
	 */
	public void onReceiveMsg(int connectId, byte[] bytes, int byteCount) {
		System.out.println("s: recv: " + bytes.length);
		HandleData.handleRecvData(bytes, bytes.length);	
	}

	/**
	 * 当发送出去数据
	 */
	public void onSendMsg(int connectId, byte[] bytes, int byteCount) {
		String str = new String(bytes, 0, byteCount-1);
		System.out.println("s: send: " + byteCount);
	}
	
	public void sayHello(){
		System.out.println("hello world...");
	}
}
