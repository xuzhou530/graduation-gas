package com.young.gas;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.Socket;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class WorkingThread extends Thread {
	private static final int SIZE = 4096;
	private Socket sock;

	private InputStream fromClient;
	private OutputStream toClient;
	
	public WorkingThread(Socket sock){
		this.sock=sock;
	}
	
	public void run(){
		while(true){
			try{
			
				fromClient=sock.getInputStream();
				toClient=sock.getOutputStream();
				
				//用fromClient.readLine()方法读取输入一直出错！读取不到内容，仔细分析！！！				
				/**
				*问题已解决：查阅API可知，“Reads a line of text. ”这个line的text必须是以“\r” "\n"结尾的，所以必须在发送端
				*发送回车换号的字符，否则readLine会一直等待回车换行符而不读取输入流
				*/
				byte[] recv = new byte[SIZE];
				int iLen = fromClient.read(recv);
				System.out.println("iLen: " + iLen);
				if(iLen != -1){
					//String str=new String(bytes,0,iLen);	
					for(int i = 0; i < 20;i++){
						System.out.print(recv[i]+" ");
					}
					System.out.println("****************");
					handleData(recv, iLen);
				}
			}
			catch(IOException e){}
		}
	}
	
	public void handleData(byte[] recv, int len){
		
		if(len < 4096){		
			int iCount = (recv[len-2]<<8) | (recv[len-1]&0xff);
			if(recv[0] == (byte)255 && recv[1] == (byte)255 
					&& recv[2] == (byte)255 && len-7 == iCount){//完整的一帧起始
		
				int district = recv[3];//填充区县
				int area = recv[4];//填充小区
				int start = 5;
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
	
	public void write2File(HashMap<String, Long> gasMap){
		try {
			File file = new File("d:/filename.txt");
			
			// if file doesnt exists, then create it
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
			} catch (IOException e) {
				e.printStackTrace();
			}	
	}
}
