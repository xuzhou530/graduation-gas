package com.young.gas.service.impl;

import java.sql.Connection;
import java.util.List;

import org.springframework.stereotype.Service;

import young.database.ConnectionPool;

import com.young.gas.beans.Log;
import com.young.gas.dao.LogDao;
import com.young.gas.service.LogService;

@Service("logService")
public class LogServiceImpl implements LogService{
	private LogDao dao = new LogDao();	
	
	public boolean addLog(Log log){
		//获取连接池实例
		ConnectionPool pool = ConnectionPool.getInstance();
		//从池子中取出一个连接
		Connection connection = pool.getConnection();	
		try{
			//关闭事务自动提交，开启事务提交功能
			connection.setAutoCommit(false);
			dao.setConnection(connection);
			dao.addLog(log);
			pool.commit(connection);
			return true;
		}
		catch(Exception e){
			e.printStackTrace();
			pool.rollback(connection);
		}
		finally{
			pool.releaseConnection(connection);
		}
		return false;
	}
	

	
	/**
	 * 列出所有用户
	 * @return
	 */
	public List<Log> listLogs(){
		//获取连接池实例
		ConnectionPool pool=ConnectionPool.getInstance();
		//从池子中取出一个连接
		Connection connection=pool.getConnection();	
		try{
			//关闭事务自动提交，开启事务提交功能
			connection.setAutoCommit(false);
			dao.setConnection(connection);
			return dao.listLogs();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			pool.releaseConnection(connection);
		}
		return null;
	}
	
	
	
	public static void main(String[] args){
		//UserService service=new LogServiceImpl();
		//System.out.println(service.listAllUsers());
	}
}
