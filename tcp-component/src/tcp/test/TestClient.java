package tcp.test;

import java.util.Random;

import tcp.client.TcpClient;
import tcp.client.TcpClientDataHandler;
import tcp.client.impl.TcpClientImpl;


public class TestClient implements TcpClientDataHandler {
	
	private TcpClient tcpClient;
	
	public void setClient(TcpClient client) {
		this.tcpClient = client;
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
		return -1;
	}
	
	/**
	 * Socket组件回调此方法，通知应用层收到了一个完整的数据包
	 * @param bytes 一个完整的数据包. 
	 * Socket组件通过调用slice方法，判断是否有完整的数据包。如有，则回调onReceiveMsg。
	 */
	public void onReceiveMsg(byte[] bytes, int byteCount) {
		//String str = new String(bytes, 0, byteCount-1);
		//System.out.println("c: recv: " + str);
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
	
	public void test() {
		tcpClient = new TcpClientImpl();
		tcpClient.setServerIp("127.0.0.1");
		tcpClient.setServerPort(9902);
		tcpClient.setDataHandler(this);
		tcpClient.connect();
		
		//发送业务逻辑
		int buildingcount = 10;//10栋建筑
		int layercount = 10;//每栋都是10层
		int roomcount = 6;//每层6户
		
		byte[] send = new byte[4096];
		int[][][] gas = new int[buildingcount][layercount][roomcount];		//产生的随机数
		for(int i = 0; i < buildingcount; i++){
			for(int j = 0; j < layercount; j++){
				for(int k = 0; k < roomcount; k++){
					gas[i][j][k] = 200;
				}
			}
		}
		
		Random rd = new Random();
		int iCount = 0;//发送了多少户人家
		int iSend = 0;
		send[iSend++] = (byte)255;//连续三个255构成一次开始的标志位
		send[iSend++] = (byte)255;
		send[iSend++] = (byte)255;
		send[iSend++] = 1;//1号区县
		send[iSend++] = 1;//1号小区
		for(int building = 1; building <= buildingcount; building++){
			for(int layer = 1; layer <= layercount; layer++ ){
				for(int room = 1; room <= roomcount;room++){
					send[iSend++] = (byte)building;//栋数
					send[iSend++] = (byte)layer;//层数
					send[iSend++] = (byte)room;//房号
					gas[building - 1][layer - 1][room - 1] += rd.nextInt(100);
					send[iSend++] = (byte)((gas[building - 1][layer - 1][room - 1] >> 16) & 0xff); //高字节
					send[iSend++] = (byte)((gas[building - 1][layer - 1][room - 1] >> 8) & 0xff); //中字节
					send[iSend++] = (byte)(gas[building -1 ][layer -1 ][room - 1] & 0xff); //低字节
					iCount++;
				}
			}
		}
		iCount *= 6;
		send[iSend++] = (byte)((iCount >> 8) & 0xff); //高字节
		send[iSend] = (byte)(iCount & 0xff); //低字节
		tcpClient.send(send, 0, iSend+1);
		
		try {
			Thread.sleep(1000);
		} catch (Exception e) {}
		
		tcpClient.disconnect();
		try {
			Thread.sleep(500);
		} catch (Exception e) {}
	}
	
	public static void main(String[] args) {
		TestClient testClient = new TestClient();
		testClient.test();
	}

}
