package com.young.gas;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.Socket;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class GasClient extends Thread {
	private Socket client;
	
	private byte[] recv = new byte[1024];
	private byte[] send = new byte[1024];
	
	//receive stream from server
	private BufferedReader fromServer;
	//sending stream to server
	private OutputStream toServer;
	
	public void connect(){
		try{
			client = new Socket("192.168.1.108",5000);
			client.setSendBufferSize(4 * 4096);
			fromServer=new BufferedReader(new InputStreamReader(client.getInputStream()));
			toServer=client.getOutputStream();		
			System.out.println("client is connecnted to server!!");
		}	
		
		//如果UnknownHostException的异常捕获放在IOException后面则会报错！！！！！！！
		catch(UnknownHostException e){}
		catch(IOException e){}		
	} 
	
	//专门负责向服务器发送数据的函数
	public void send(){
		
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
		try{				
			//每个线程都将自己的线程信息发送给服务器
			toServer.write(send, 0, iSend+1);
		}catch(IOException e){}
	}
	
	public void close(){
		
		try{
			//toServer.flush();
			if(client != null){
				client.close();
			}
			fromServer.close();
			toServer.close();
		}
		catch(IOException e){
		}
	}
	
	//用来读取数据接收的线程
	public void run(){

	}

	public static void main(String[] args) {
		GasClient myClient = new GasClient();
		myClient.connect();
		myClient.start();
		myClient.send();
//		myClient.close();
		
	}
}

