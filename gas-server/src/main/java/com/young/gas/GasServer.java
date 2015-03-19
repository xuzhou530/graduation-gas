package com.young.gas;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;

public class GasServer {
	private ServerSocket welcome;
	private Socket sock;
	
	public ServerSocket getWelcome() {
		return welcome;
	}

	public void setWelcome(ServerSocket welcome) {
		this.welcome = welcome;
	}

	public Socket getSock() {
		return sock;
	}

	public void setSock(Socket sock) {
		this.sock = sock;
	}
	
	public void waiting(){
		ServerSocket welcome = null;
		try{
			welcome = new ServerSocket(5000);
			System.out.println("server is opened!! waiting...");
			while(true){
				//this function will be waiting 
				sock = welcome.accept();
				System.out.println("server is connected with "+sock.getInetAddress()+": "+sock.getPort());			
				
				//as soon as a new socket is started,new threading is working
				WorkingThread work=new WorkingThread(sock);
				work.start();			
			}
		}
		catch(IOException e){}
		catch(Exception e){}
		finally{
			try{
				welcome.close();
			}catch(IOException e){}
		}
	}
	
	public static void main(String[] args){
		GasServer test=new GasServer();
		test.waiting();
	}
}
