package com.young.gas.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.young.gas.beans.Money;

public class MoneyDao {
	/**
	 * connection需要注入！！
	 */
	private Connection connection=null;
	
	public void setConnection(Connection connection){
		this.connection=connection;
	}
	
	public Connection getConnection(){
		return connection;
	}
	
	/**
	 * 
	 * @param 增加数据到数据库中
	 * @throws Exception
	 */
	public void addMoney(Money money) throws Exception{
		//增加新纪录
		String cmd = "update money set flag=1 where flag=0 and customer_id=?";
		PreparedStatement pst0 = connection.prepareStatement(cmd);
		pst0.setInt(1, money.getCustomerId());
		pst0.executeUpdate();
		
		String sql = "insert into money values(null,?,?,?,0,?,?)";
		PreparedStatement pst = connection.prepareStatement(sql);
		pst.setInt(1, money.getResult());
		pst.setInt(2, money.getPrevious());
		pst.setInt(3, money.getOperate());
		pst.setInt(4, money.getCustomerId());
		pst.setTimestamp(5, new Timestamp(System.currentTimeMillis()));
		pst.executeUpdate();		
	}

	/**
	 * 
	 * @return 返回所有用户
	 * @throws Exception
	 */
	public List<Money> listMoneysByCusomerId(int customerId) throws Exception{
		String sql="select * from money where customer_id=?";
		PreparedStatement pst=connection.prepareStatement(sql);
		pst.setInt(1, customerId);
		ResultSet rs=pst.executeQuery();
		return convertResult(rs);
	}
	
	/**
	 * 
	 * @return 返回所有用户
	 * @throws Exception
	 */
	public void deleteMoneyByCusomerId(int customerId) throws Exception{
		String sql="delete from money where customer_id=?";
		PreparedStatement pst=connection.prepareStatement(sql);
		pst.setInt(1, customerId);
		pst.executeUpdate();
	}
	
	/**
	 * 返回最新数据
	 * @return 返回所有用户
	 * @throws Exception
	 */
	public Money listCurrentByCusomerId(int customerId) throws Exception{
		String sql="select * from money where customer_id=? and flag=0";
		PreparedStatement pst=connection.prepareStatement(sql);
		pst.setInt(1, customerId);
		ResultSet rs=pst.executeQuery();
		List<Money> moneys = convertResult(rs);
		if(moneys != null && moneys.size() > 0){
			return moneys.get(0);
		}
		else{
			return null;
		}
	}
	
	/**
	 * @param rs
	 * @return
	 * @throws Exception
	 */
	public static List<Money> convertResult(ResultSet rs) throws Exception{
		List<Money> moneys = new ArrayList<Money>();
		while(rs.next()){
			Money money = new Money();
			money.setId(rs.getInt(1));
			money.setResult(rs.getInt(2));
			money.setPrevious(rs.getInt(3));
			money.setOperate(rs.getInt(4));
			money.setFlag(rs.getInt(5));
			money.setCustomerId(rs.getInt(6));
			money.setOperateTime(rs.getTimestamp(7));
			moneys.add(money);	
		}		
		return moneys;
	}
}