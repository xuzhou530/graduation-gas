package com.young.gas.service.impl;

import java.sql.Connection;
import java.util.List;

import org.springframework.stereotype.Service;

import com.young.gas.dao.GasDao;
import com.young.gas.service.GasService;
import com.young.gas.beans.Gas;

import young.database.ConnectionPool;

@Service("gasService")
public class GasServiceImpl implements GasService{
	private GasDao gasDao=new GasDao();	

	/**
	 * 查询指定名字的用户，返回用户对象
	 * @param name
	 * @return Customer对象
	 */
	public List<Gas> searchGasByBuilding(String district,String area,int building,int start,int count){
		//获取连接池实例
		ConnectionPool pool=ConnectionPool.getInstance();
		//从池子中取出一个连接
		Connection connection=pool.getConnection();	
		try{
			gasDao.setConnection(connection);	
			return gasDao.searchGasByBuilding(district, area, building, start, count);
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
			gasDao.setConnection(connection);			
			return gasDao.getCountWithSearchBuilding(district, area,building);
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
	 * 查询指定名字的用户，返回用户对象
	 * @param name
	 * @return Customer对象
	 */
	public List<Gas> searchWarningGasByBuilding(String district, String area, int building, int start, int count){
		//获取连接池实例
		ConnectionPool pool=ConnectionPool.getInstance();
		//从池子中取出一个连接
		Connection connection=pool.getConnection();	
		try{
			gasDao.setConnection(connection);	
			return gasDao.searchWarningGasByBuilding(district, area, building, start, count);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			pool.releaseConnection(connection);
		}
		return null;
	}
		
	public int getCountWithWarningSearchBuilding(String district,String area,int building){
		//获取连接池实例
		ConnectionPool pool=ConnectionPool.getInstance();
		//从池子中取出一个连接
		Connection connection=pool.getConnection();	
		try{
			gasDao.setConnection(connection);			
			return gasDao.getCountWithWarningSearchByBuilding(district, area, building);
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
	 * 查询指定名字的用户，返回用户对象
	 * @param name
	 * @return Customer对象
	 */
	public Gas searchCurrentGasByCustomerId(int customerId){
		//获取连接池实例
		ConnectionPool pool=ConnectionPool.getInstance();
		//从池子中取出一个连接
		Connection connection=pool.getConnection();	
		try{
			gasDao.setConnection(connection);	
			return gasDao.searchCurrentGasByCustomerId(customerId);
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
	 * @return Customer对象
	 */
	public List<Gas> searchAllGasByCustomerId(int customerId){
		//获取连接池实例
		ConnectionPool pool=ConnectionPool.getInstance();
		//从池子中取出一个连接
		Connection connection=pool.getConnection();	
		try{
			gasDao.setConnection(connection);	
			return gasDao.searchAllGasByCustomerId(customerId);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			pool.releaseConnection(connection);
		}
		return null;
	}	
	
	public void addGas(Gas gas){
		//获取连接池实例
		ConnectionPool pool=ConnectionPool.getInstance();
		//从池子中取出一个连接
		Connection connection=pool.getConnection();
		try{			
			//关闭事务自动提交，开启事务提交功能
			connection.setAutoCommit(false);
			gasDao.setConnection(connection);
			gasDao.addGas(gas);
			pool.commit(connection);
		}
		catch(Exception e){
			e.printStackTrace();
			pool.rollback(connection);
		}
		finally{
			pool.releaseConnection(connection);
		}
	}

	public static void main(String[] args){
		GasServiceImpl service=new GasServiceImpl();
		System.out.print(service.searchWarningGasByBuilding("利州区", "和苑小区", 1,0,30));
		//System.out.print(service.searchGasByBuilding("利州区", "和苑小区", 1,0,30));
	}
}
