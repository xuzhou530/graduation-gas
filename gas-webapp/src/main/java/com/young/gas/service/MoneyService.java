package com.young.gas.service;

import java.sql.Connection;
import java.util.List;

import org.springframework.stereotype.Service;

import com.young.gas.beans.Money;
import com.young.gas.dao.MoneyDao;

import young.database.ConnectionPool;

@Service("moneyService")
public class MoneyService {
	private MoneyDao moneyDao = new MoneyDao();	

	/**
	 * 增加记录
	 * @param name
	 * @return Customer对象
	 */
	public void addMoney(Money money){
		//获取连接池实例
		ConnectionPool pool=ConnectionPool.getInstance();
		//从池子中取出一个连接
		Connection connection=pool.getConnection();	
		try{
			moneyDao.setConnection(connection);	
			moneyDao.addMoney(money);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			pool.releaseConnection(connection);
		}
	}
		
	public List<Money> listMoneysByCusomerId(int customerId){
		//获取连接池实例
		ConnectionPool pool=ConnectionPool.getInstance();
		//从池子中取出一个连接
		Connection connection=pool.getConnection();	
		try{
			moneyDao.setConnection(connection);	
			return moneyDao.listMoneysByCusomerId(customerId);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			pool.releaseConnection(connection);
		}
		return null;
	}

	public Money listCurrentByCusomerId(int customerId){
		//获取连接池实例
		ConnectionPool pool=ConnectionPool.getInstance();
		//从池子中取出一个连接
		Connection connection=pool.getConnection();	
		try{
			moneyDao.setConnection(connection);	
			return moneyDao.listCurrentByCusomerId(customerId);
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
//		MoneyService service = new MoneyService();
//		Money m = service.listCurrentByCusomerId(9999);
//		
//		Money money = new Money();
//		money.setResult(100);
//		money.setPrevious(0);
//		money.setOperate(100);
//		money.setFlag(0);
//		money.setCustomerId(9999);
//		service.addMoney(money);
	}
}
