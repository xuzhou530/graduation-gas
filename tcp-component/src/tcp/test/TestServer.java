package tcp.test;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import tcp.server.TcpServer;
import tcp.server.TcpServerDataHandler;
import tcp.server.impl.TcpServerImpl;

public class TestServer implements TcpServerDataHandler {
	
	private TcpServer server;
	
	public void setServer(TcpServer server) {
		this.server = server;
	}
	
	public static void main(String[] args) {
		TcpServer server = new TcpServerImpl();
		server.setServerIp("127.0.0.1");
		server.setServerPort(9902);
		
		TestServer testServer = new TestServer();
		server.setDataHandler(testServer);
		testServer.setServer(server);
		
		server.start();
		System.out.println("server is started!");
	}
	
	
	public void onConnect(int connectId, String ip, int port) {
		String str = String.format("s: client connect, id=%d, ip=%s, port=%d", 
				connectId, ip, port);
		System.out.println(str);
	}

	//当新连接断开的时候,响应
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

	// 接收到一个完整的数据包
	public void onReceiveMsg(int connectId, byte[] bytes, int byteCount) {
	  //String str = new String(bytes, 0, byteCount-1);
	  //System.out.println("s: recv: " + str);
		System.out.println(bytes.length);
		handleData(bytes, bytes.length);
	}

	// 通知应用上层，数据已经成功发送出去
	public void onSendMsg(int connectId, byte[] bytes, int byteCount) {
		String str = new String(bytes, 0, byteCount-1);
		System.out.println("s: send: " + str);
	}
	
	public void handleData(byte[] recv, int len){	
		if(len < 4096){		
			int iCount = (recv[len-2]<<8) | (recv[len-1]&0xff);
			if(recv[0] == (byte)127 && len-5 == iCount){//完整的一帧起始
		
				int district = recv[1];//填充区县
				int area = recv[2];//填充小区
				int start = 3;
				HashMap<String, Long> gasMap = new HashMap<String, Long>();
				for(int pace = 0; pace < iCount; pace += 6){
					
					String key = district + "," + area + "," + recv[start + pace] + "," + recv[start + pace+1] + "," + recv[start + pace+2]+ ": ";
					
					byte high = recv[start + pace+3];
					byte middle = recv[start + pace+4];
					byte low = recv[start + pace+5];
					long value = (high<<16) | ((middle<<8)&0xff00) | (low&0xff);

					gasMap.put(key, value);		
				}
				write2File(gasMap);
			}
		}
		else{//出现了不完整的一帧		
		}
	}
	
	/**
	 * 写入文件当中
	 * @param gasMap
	 */
	public void write2File(HashMap<String, Long> gasMap){
		try {
			File file = new File("d:/recvfile.txt");
			
			if (!file.exists()) {
				file.createNewFile();
			}
			
			FileWriter fw = new FileWriter(file.getAbsoluteFile());
			BufferedWriter bw = new BufferedWriter(fw);

		    Iterator iter = gasMap.entrySet().iterator();
		    while (iter.hasNext()) {
		    	Map.Entry entry = (Map.Entry) iter.next();
		    	Object key = entry.getKey();
		    	Object val = entry.getValue();
		    	String content = key.toString() + val.toString()+"\r\n";
		    	bw.write(content);
		    }
			
			bw.close();
		} 
		catch (IOException e) {
			e.printStackTrace();
		}	
	}
}
