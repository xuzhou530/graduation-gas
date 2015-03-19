package com.young.gas.service;

import java.sql.Connection;
//import java.util.Iterator;
import java.util.List;

import com.young.gas.dao.CustomerDao;
import com.young.gas.beans.Customer;

import young.database.ConnectionPool;

public class CustomerService {
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
	public boolean deleteCustomer(int customerId,int meterId){
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
	public static void main(String[] args){
//		CustomerService service=new CustomerService();
//
//		//List<Customer> customers=service.searchCustomersByBuilding("利州区", "和苑小区", 14, 0, 30);
//		//System.out.print(customers);
//		
//		int count=1;
//		String customerName="veyoung";
//		String customerPhone="123421312";
//		String addressDistrict="利州区";
//		String addressArea="和苑小区";
//		int addressBuilding=13;
//		int addressLayer=23;
//		int addressRoom=100;	
//
//		Customer customer=new Customer();
//		customer.setCustomerId(count);
//		customer.setCustomerName(customerName);
//		customer.setCustomerPhone(customerPhone);
//		customer.setAddressDistrict(addressDistrict);
//		customer.setAddressArea(addressArea);
//		customer.setAddressBuilding(addressBuilding);
//		customer.setAddressLayer(addressLayer);
//		customer.setAddressRoom(addressRoom);
//
//		System.out.print(service.searchCustomersByBuilding("利州区","和苑小区",13,0,30));
	}
}
