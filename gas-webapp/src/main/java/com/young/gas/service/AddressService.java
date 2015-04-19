package com.young.gas.service;

import java.sql.Connection;
import java.util.List;

import org.springframework.stereotype.Service;

import young.database.ConnectionPool;

import com.young.gas.dao.AddressDao;
import com.young.gas.beans.Address;

@Service("addressService")
public class AddressService {
	private AddressDao dao=new AddressDao();	
	
	/**
	 * 增加地址
	 * @param address
	 * @return 操作结果
	 */
	public boolean addAddress(Address address){
		//获取连接池实例
		ConnectionPool pool=ConnectionPool.getInstance();
		//从池子中取出一个连接
		Connection connection=pool.getConnection();
		try{			
			//关闭事务自动提交，开启事务提交功能
			connection.setAutoCommit(false);
			dao.setConnection(connection);
			dao.addAddress(address);
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
	public boolean deleteAddress(int id){
		//获取连接池实例
		ConnectionPool pool=ConnectionPool.getInstance();
		//从池子中取出一个连接
		Connection connection=pool.getConnection();
		try{
			//关闭事务自动提交，开启事务提交功能
			connection.setAutoCommit(false);
			dao.setConnection(connection);
			dao.deleteAddress(id);
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
	 * 
	 * @param customer
	 * @throws Exception
	 */
	public boolean modifyAddress(Address address){
		//获取连接池实例
		ConnectionPool pool=ConnectionPool.getInstance();
		//从池子中取出一个连接
		Connection connection=pool.getConnection();	
		try{
			//关闭事务自动提交，开启事务提交功能
			connection.setAutoCommit(false);
			dao.setConnection(connection);
			dao.modifyAddress(address);
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
	public List<Address> listAllAddresss(){
		//获取连接池实例
		ConnectionPool pool=ConnectionPool.getInstance();
		//从池子中取出一个连接
		Connection connection=pool.getConnection();	
		try{
			dao.setConnection(connection);
			return dao.listAllAddresss();
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
	 * @return Address对象
	 */
	public List<Address> searchAddresssByDistrict(String district){
		//获取连接池实例
		ConnectionPool pool=ConnectionPool.getInstance();
		//从池子中取出一个连接
		Connection connection=pool.getConnection();	
		try{
			//关闭事务自动提交，开启事务提交功能
			connection.setAutoCommit(false);
			dao.setConnection(connection);
			return dao.searchAddressByDistrict(district); 
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
	 * 
	 * @param id
	 * @return
	 */
	public Address searchAddressById(int id){
		//获取连接池实例
		ConnectionPool pool=ConnectionPool.getInstance();
		//从池子中取出一个连接
		Connection connection=pool.getConnection();	
		try{
			//关闭事务自动提交，开启事务提交功能
			connection.setAutoCommit(false);
			dao.setConnection(connection);
			return dao.searchAddressById(id);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			pool.releaseConnection(connection);
		}
		return null;
	}
	
	public int getAreaCount(String district){
		//获取连接池实例
		ConnectionPool pool=ConnectionPool.getInstance();
		//从池子中取出一个连接
		Connection connection=pool.getConnection();	
		try{
			//关闭事务自动提交，开启事务提交功能
			connection.setAutoCommit(false);
			dao.setConnection(connection);
			return dao.getAreaCount(district);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			pool.releaseConnection(connection);
		}
		return 0;
	}
	
	public int getAddressId(String district,String area)  {
		//获取连接池实例
		ConnectionPool pool=ConnectionPool.getInstance();
		//从池子中取出一个连接
		Connection connection=pool.getConnection();	
		try{
			//关闭事务自动提交，开启事务提交功能
			connection.setAutoCommit(false);
			dao.setConnection(connection);
			return dao.getAddressId(district, area);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			pool.releaseConnection(connection);
		}
		return 0;	
	}
	
	
	public static void main(String[] args){
		AddressService service=new AddressService();
		
		//System.out.println(service.listAllAddresss());
		
//		Address address=new Address();
//		address.setAddressDistrict("利州区");
//		address.setAddressArea("黄金小区");
//		address.setAddressLocation("利州区黄金东路222号");
//		address.setAddressBuildings(15);
//		address.setAddressCustomers(200);
//		address.setAddressDesicribe("利州区的小区之一");		
//		service.addAddress(address);
		
//		List<Address> list=service.listAllAddresss();
//		Iterator<Address> it=list.iterator();
//		while(it.hasNext()){
//			System.out.println(it.next());
//		}
		System.out.println(service.getAddressId("利州区","黄金小区") );
	}
}
