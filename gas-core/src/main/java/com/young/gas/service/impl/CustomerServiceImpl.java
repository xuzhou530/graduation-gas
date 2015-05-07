package com.young.gas.service.impl;

import java.sql.Connection;
import java.util.List;

import org.springframework.stereotype.Service;

import com.young.gas.dao.CustomerDao;
import com.young.gas.service.CustomerService;
import com.young.gas.beans.Customer;

import young.database.ConnectionPool;

@Service("customerService")
public class CustomerServiceImpl implements CustomerService{
	private CustomerDao customerDao=new CustomerDao();		
	/**
	 * 增加用户
	 * @param user
	 * @return 操作结果
	 */
	public boolean addCustomer(Customer customer){
		//获取连接池实例
		ConnectionPool pool=ConnectionPool.getInstance();
		//从池子中取出一个连接
		Connection connection=pool.getConnection();	
		try{
			//关闭事务自动提交，开启事务提交功能
			//尝试两个dao用同一个connection
			connection.setAutoCommit(false);
			customerDao.setConnection(connection);
			customerDao.addCustomer(customer);
			
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
	public boolean deleteCustomer(int customerId){
		//获取连接池实例
		ConnectionPool pool=ConnectionPool.getInstance();
		//从池子中取出一个连接
		Connection connection=pool.getConnection();	
		try{
			//关闭事务自动提交，开启事务提交功能
			connection.setAutoCommit(false);
			customerDao.setConnection(connection);
			customerDao.deleteCustomer(customerId);

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
	 * 查询指定名字的用户，返回用户对象
	 * @param name
	 * @return Customer对象
	 */
	public List<Customer> searchCustomersByBuilding(String district,String area,int building,int start,int count){
		//获取连接池实例
		ConnectionPool pool=ConnectionPool.getInstance();
		//从池子中取出一个连接
		Connection connection=pool.getConnection();	
		try{
			customerDao.setConnection(connection);	
			return customerDao.searchCustomersByBuilding(district, area, building, start, count);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			pool.releaseConnection(connection);
		}
		return null;
	}
		
	public int getCountWithSearchBuilding(String district,String area,int building){
		//获取连接池实例
		ConnectionPool pool=ConnectionPool.getInstance();
		//从池子中取出一个连接
		Connection connection=pool.getConnection();	
		try{
			//关闭事务自动提交，开启事务提交功能
			connection.setAutoCommit(false);
			customerDao.setConnection(connection);			
			return customerDao.getCountWithSearchBuilding(district, area,building);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			pool.releaseConnection(connection);
		}
		return 0;
	}
	
	/**
	 * 
	 * @param id
	 * @return
	 */
	public Customer searchCustomerById(int customerId){
		//获取连接池实例
		ConnectionPool pool=ConnectionPool.getInstance();
		//从池子中取出一个连接
		Connection connection=pool.getConnection();	
		try{
			//关闭事务自动提交，开启事务提交功能
			connection.setAutoCommit(false);
			customerDao.setConnection(connection);
			return customerDao.searchCustomerById(customerId);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			pool.releaseConnection(connection);
		}
		return null;
	}
	
	public List<Customer> searchSingleCustomerByDistrict(String district){
		//获取连接池实例
		ConnectionPool pool=ConnectionPool.getInstance();
		//从池子中取出一个连接
		Connection connection=pool.getConnection();	
		try{
			//关闭事务自动提交，开启事务提交功能
			connection.setAutoCommit(false);
			customerDao.setConnection(connection);
			return customerDao.searchSingleCustomerByDistrict(district);
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
	 * 按房号查询用户
	 * @param district
	 * @param area
	 * @param building
	 * @param layer
	 * @param room
	 * @return
	 */
	public Customer searchCustomerByRoom(String district, String area, int building, int layer, int room){
		//获取连接池实例
		ConnectionPool pool=ConnectionPool.getInstance();
		//从池子中取出一个连接
		Connection connection=pool.getConnection();	
		try{
			//关闭事务自动提交，开启事务提交功能
			connection.setAutoCommit(false);
			customerDao.setConnection(connection);
			return customerDao.searchCustomerByRoom(district, area, building, layer, room);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			pool.releaseConnection(connection);
		}
		return null;	
	}
	
	public boolean openMeter(int customerId){
		//获取连接池实例
		ConnectionPool pool=ConnectionPool.getInstance();
		//从池子中取出一个连接
		Connection connection=pool.getConnection();	
		try{
			//关闭事务自动提交，开启事务提交功能
			connection.setAutoCommit(false);
			customerDao.setConnection(connection);
			customerDao.openMeter(customerId);

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
	
	public boolean closeMeter(int customerId){
		//获取连接池实例
		ConnectionPool pool=ConnectionPool.getInstance();
		//从池子中取出一个连接
		Connection connection=pool.getConnection();	
		try{
			//关闭事务自动提交，开启事务提交功能
			connection.setAutoCommit(false);
			customerDao.setConnection(connection);
			customerDao.closeMeter(customerId);

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
	
	public int getMeterStatus(int customerId){
		//获取连接池实例
		ConnectionPool pool=ConnectionPool.getInstance();
		//从池子中取出一个连接
		Connection connection=pool.getConnection();	
		try{
			customerDao.setConnection(connection);
			return customerDao.getMeterStatus(customerId);
		}
		catch(Exception e){
			e.printStackTrace();
			pool.rollback(connection);
		}
		finally{
			pool.releaseConnection(connection);
		}
		return 0;
	}
	
	public static void main(String[] args){
		CustomerService cus = new CustomerServiceImpl();
		Customer c = cus.searchCustomerById(1055);
		System.out.println(c);
	}
}
