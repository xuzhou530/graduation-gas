package tcp.util;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import org.springframework.beans.factory.BeanFactory;

import com.young.gas.beans.Customer;
import com.young.gas.beans.Gas;
import com.young.gas.beans.Money;
import com.young.gas.service.CustomerService;
import com.young.gas.service.GasService;
import com.young.gas.service.MoneyService;

import tcp.test.TestServer;

public class HandleData {

	public static void handleRecvData(byte[] recv, int len){	
		if(len > 0){		
			if((int)(recv[0]&0xff) != 239){//如果起始位不是239，注意需要byte转化成int
				System.out.println("data error");
			}
			if(recv[7] == 02){//表示为正确的上行数据
				int count = recv[8];
				int customerId = recv[14] + 10 * recv[15] + 100 * recv[16] + 1000 * recv[17] +
						10000 * recv[18] + 100000 * recv[19] + 1000000 * recv[20];
				System.out.println("住户编号: " + customerId);
				
				byte[] arr = new byte[4];
				arr[0] = recv[26]; 
				arr[1] = recv[27]; 
				arr[2] = recv[28]; 
				arr[3] = recv[29]; 
				long gasValue = byte2Long(arr)/10000;
				System.out.println("住户燃气值： " + gasValue);
				
				BeanFactory factory = GetBeanFactory.getInstance();
				GasService gasService = (GasService)factory.getBean("gasService");//应用层实例
				CustomerService customerService = (CustomerService)factory.getBean("customerService");//应用层实例
				MoneyService moneyService = (MoneyService)factory.getBean("moneyService");//应用层实例
						
				try{
					Customer customer = customerService.searchCustomerById(1055);
					
					if(customer != null){//住户存在					
						Money preMoney = moneyService.listCurrentByCusomerId(customerId);	
						Gas gas = gasService.searchCurrentGasByCustomerId(customerId);
						
						long gasPreValue;
						if(gas == null){//住户还没有燃气信息
							System.out.println("住户还没有燃气值...");
							gasPreValue = 0;
						}
						else{//住户存在燃气信息
							System.out.println("住户存在燃气值...");
							gasPreValue = gas.getGasValue();
						}
						
						long gasUse = gasValue - gasPreValue;//计算燃气用量
						if(gasUse > 0){//燃气用量为正值
							int moneyUse = (int)(gasUse/10);//计算费用消耗
							
							Money money = new Money();
							money.setResult(preMoney.getResult() - moneyUse);
							money.setPrevious(preMoney.getResult());
							money.setOperate(-moneyUse);
							money.setCustomerId(customerId);				
							moneyService.addMoney(money);
							
							Gas newGas = new Gas();
							newGas.setPreviousValue(gasPreValue);
							newGas.setGasValue(gasValue);
							newGas.setGasMoney(preMoney.getResult() - moneyUse);
							newGas.setCustomerId(customerId);
							gasService.addGas(newGas);
						}		
					}
					else{//住户不存在
						System.out.println("住户不存在...");					
					}
				
				}
				catch(Exception e){
					System.out.println("远程方法未启动...");
				}	
				
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
	
	/**
	 * byte数组转成成long类型
	 * @param arr
	 * @return
	 */
	public static long byte2Long(byte[] arr) {    
		long mask=0xff;  
		long temp=0;  
		long n=0;  
        for(int i = 3; i >= 0; i--){  
           n <<= 8;  
           temp = arr[i] & mask;  
           n |= temp;  
	    }  
        return n;  
	} 
	
	public static void main(String[] args){
		byte[] arr = new byte[4];
		arr[0] = 64;
		arr[1] = 75;
		arr[2] = 76;
		arr[3] = 0;
	    System.out.println(byte2Long(arr));
	}
}
