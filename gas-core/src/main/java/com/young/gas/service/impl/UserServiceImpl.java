package com.young.gas.service.impl;

import java.sql.Connection;
import java.util.List;

import org.springframework.stereotype.Service;

import young.database.ConnectionPool;

import com.young.gas.beans.User;
import com.young.gas.dao.UserDao;
import com.young.gas.service.UserService;

@Service("userService")
public class UserServiceImpl implements UserService{
	private UserDao dao = new UserDao();	
	
	/**
	 * 增加用户
	 * @param user
	 * @return 操作结果
	 */
	public boolean addUser(User user){
		//获取连接池实例
		ConnectionPool pool = ConnectionPool.getInstance();
		//从池子中取出一个连接
		Connection connection = pool.getConnection();	
		try{
			//关闭事务自动提交，开启事务提交功能
			connection.setAutoCommit(false);
			dao.setConnection(connection);
			dao.addUser(user);
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
	 * 删除指定用户名的用户
	 * @param name
	 * @return 返回操作结果
	 */
	public boolean deleteUser(String name){
		//获取连接池实例
		ConnectionPool pool = ConnectionPool.getInstance();
		//从池子中取出一个连接
		Connection connection = pool.getConnection();	
		try{
			//关闭事务自动提交，开启事务提交功能
			connection.setAutoCommit(false);
			dao.setConnection(connection);
			dao.deleteUser(name);
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
	public List<User> listAllUsers(){
		//获取连接池实例
		ConnectionPool pool=ConnectionPool.getInstance();
		//从池子中取出一个连接
		Connection connection=pool.getConnection();	
		try{
			//关闭事务自动提交，开启事务提交功能
			connection.setAutoCommit(false);
			dao.setConnection(connection);
			return dao.listAllUsers();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			pool.releaseConnection(connection);
		}
		return null;
	}
	
	public List<User> listAllRequestUsers(){
		//获取连接池实例
		ConnectionPool pool=ConnectionPool.getInstance();
		//从池子中取出一个连接
		Connection connection=pool.getConnection();	
		try{
			//关闭事务自动提交，开启事务提交功能
			connection.setAutoCommit(false);
			dao.setConnection(connection);
			return dao.listAllRequestUsers();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			pool.releaseConnection(connection);
		}
		return null;
	}
	
	
	/**
	 * 查询指定名字的用户，返回用户对象
	 * @param name
	 * @return User对象
	 */
	public User listUser(String name){
		//获取连接池实例
		ConnectionPool pool=ConnectionPool.getInstance();
		//从池子中取出一个连接
		Connection connection=pool.getConnection();	
		try{
			//关闭事务自动提交，开启事务提交功能
			connection.setAutoCommit(false);
			dao.setConnection(connection);
			return dao.listUser(name);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			pool.releaseConnection(connection);
		}
		return null;
	}
	
	public boolean existUser(String name){
		//获取连接池实例
		ConnectionPool pool=ConnectionPool.getInstance();
		//从池子中取出一个连接
		Connection connection=pool.getConnection();	
		try{
			//关闭事务自动提交，开启事务提交功能
			connection.setAutoCommit(false);
			dao.setConnection(connection);
			return dao.existUser(name);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			pool.releaseConnection(connection);
		}
		return false;
	}
	
	public boolean passUser(String name){
		//获取连接池实例
		ConnectionPool pool = ConnectionPool.getInstance();
		//从池子中取出一个连接
		Connection connection = pool.getConnection();	
		try{
			//关闭事务自动提交，开启事务提交功能
			connection.setAutoCommit(false);
			dao.setConnection(connection);
			dao.passUser(name);
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
	
	public boolean rejectUser(String name){
		//获取连接池实例
		ConnectionPool pool = ConnectionPool.getInstance();
		//从池子中取出一个连接
		Connection connection = pool.getConnection();	
		try{
			//关闭事务自动提交，开启事务提交功能
			connection.setAutoCommit(false);
			dao.setConnection(connection);
			dao.rejectUser(name);
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
	
	public static void main(String[] args){
		UserService service=new UserServiceImpl();
		//System.out.println(service.listAllUsers());
	}
}
