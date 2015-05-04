package tcp.util;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

public class HandleData {

	public static void handleRecvData(byte[] recv, int len){	
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
	public static void write2File(HashMap<String, Long> gasMap){
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
