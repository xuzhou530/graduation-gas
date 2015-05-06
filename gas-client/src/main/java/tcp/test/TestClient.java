package tcp.test;

import tcp.client.TcpClient;
import tcp.client.TcpClientDataHandler;
import tcp.client.impl.TcpClientImpl;

public class TestClient implements TcpClientDataHandler {
	
	private TcpClient tcpClient;
	
	public void setClient(TcpClient client) {
		this.tcpClient = client;
	}
		
	public static void main(String[] args) {
		TcpClient tcpClient = new TcpClientImpl();
		tcpClient.setServerIp("192.168.1.108");
		tcpClient.setServerPort(9902);
		
		TestClient testClient = new TestClient();
		testClient.setClient(tcpClient);
		tcpClient.setDataHandler(testClient);
		
		tcpClient.connect();
		//testClient.sendData();
	}
	
	/**
	 * 功能函数：负责发送数据操作
	 */
	public void sendData() {
		
		byte[] send = new byte[4096];
		int iSend = 0;
		
		send[iSend++] = (byte)239;//开始标志位
		send[iSend++] = (byte)1;//帧序号
		send[iSend++] = (byte)1;//地址1
		send[iSend++] = (byte)2;//地址2
		send[iSend++] = (byte)3;//地址3
		send[iSend++] = (byte)4;//地址4
		send[iSend++] = (byte)5;//地址5
		send[iSend++] = (byte)2;//控制码02表示上行
		send[iSend++] = (byte)1;//M-Bus数量
		send[iSend++] = (byte)19;//长度
		
		send[iSend++] = (byte)254;//前导字节
		send[iSend++] = (byte)254;//前导字节
		send[iSend++] = (byte)104;//帧起始68H
		send[iSend++] = (byte)48;//燃气表类型30H 	
		send[iSend++] = (byte)5;//地址1
		send[iSend++] = (byte)5;//地址2
		send[iSend++] = (byte)0;//地址3
		send[iSend++] = (byte)1;//地址4
		send[iSend++] = (byte)0;//地址5
		send[iSend++] = (byte)0;//地址6
		send[iSend++] = (byte)0;//地址7	
		send[iSend++] = (byte)129;//控制码：读数据的正常响应
		send[iSend++] = (byte)07;//长度
		send[iSend++] = (byte)144;//DI	
		send[iSend++] = (byte)31;//DI
		send[iSend++] = (byte)1;//1	
		send[iSend++] = (byte)64;//数据位1
		send[iSend++] = (byte)13;//数据位2
		send[iSend++] = (byte)4;//数据位3
		send[iSend++] = (byte)0;//数据位4
		send[iSend++] = (byte)255;//校验
		send[iSend++] = (byte)22;//结束符	
		
		send[iSend++] = (byte)15;//时间
		send[iSend++] = (byte)5;//时间
		send[iSend++] = (byte)1;//时间
		send[iSend++] = (byte)10;//时间	
		send[iSend++] = (byte)32;//时间
		send[iSend++] = (byte)0;//时间	
		send[iSend++] = (byte)255;//校验
		send[iSend] = (byte)38;//结束
		
		//发送
		tcpClient.send(send, 0, iSend+1);
	}	
	
	public void onConnect(String serverIp,  int serverPort) {
		String str = String.format("c: connected, serverIp=%s, serverPort=%d", 
				serverIp, serverPort);
		System.out.println(str);
	}

	/**
	 * Socket组件通知应用层，Socket 连接已经断开
	 * 应用层主动调用disconnect方法断开连接，或者服务器断开连接，或者网络原因导致连接断开，
	 * 都会导致onDisconnect 被回调。但反复尝试重连时，此方法不会被重复调用。
	 */
	public void onDisconnect() {
		String str = "c: disconnected";
		System.out.println(str);
	}

	/**
	 * Socket 组件接收到数据后，递交应用层进行包边界识别。
	 * @param bytes Socket组件接收到的所有数据，可能不够一个完整的数据包，也可能包含多个数据包
	 * @return 如果应用层能识别bytes中至少包含一个完整数据包，则返回第一个数据包的长度。
	 * Socket组件会根据返回的长度，将第一包切出来，然后回调onReceiveMsg方法。
	 *         如果不足一个完整的数据包，应用层必须返回-1
	 */ 
	public int slice(byte[] bytes, int byteCount) {
		for (int i = 0; i < byteCount; i++) {
			if (bytes[i] == 0) {
				return i + 1;
			}
		}
		return byteCount;
	}
	
	/**
	 * Socket组件回调此方法，通知应用层收到了一个完整的数据包
	 * @param bytes 一个完整的数据包. 
	 * Socket组件通过调用slice方法，判断是否有完整的数据包。如有，则回调onReceiveMsg。
	 */
	public void onReceiveMsg(byte[] bytes, int byteCount) {
		String str = new String(bytes, 0, byteCount);
		System.out.println("c: recv: " + str);
		//server.send(connectId, bytes);
	}
	
	/**
	 * Socket组件通知应用层，消息已经成功发送
	 * @param bytes 已经成功发送到数据包
	 */
	public void onSendMsg(byte[] bytes, int byteCount) {
		//String str = new String(bytes, 0, byteCount-1);
		System.out.println("c: send: " + byteCount);
	}
}
