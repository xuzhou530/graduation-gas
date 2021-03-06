package com.young.gas.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.young.gas.beans.Gas;

public class GasDao {
	/**
	 * connection需要注入！！
	 */
	private Connection connection=null;
	
	/**
	 * 
	 * @param setter and getter
	 */
	public void setConnection(Connection connection){
		this.connection=connection;
	}
	public Connection getConnection(){
		return connection;
	}


	/**
	 * 按区、小区、楼号查询
	 */
	public List<Gas> searchGasByBuilding(String district,String area,int building,int start,int count) throws Exception {
		String sql="select * from gas where customer_id in "
				+ "(select customer_id from customer where address_district=? and address_area=? and address_building=?) limit ?,?";
		PreparedStatement pst=connection.prepareStatement(sql);
		pst.setString(1, district);
		pst.setString(2, area);
		pst.setInt(3, building);
		pst.setInt(4, start*count);
		pst.setInt(5, count);
		ResultSet rs=pst.executeQuery();	
		return convertResult(rs);
	}

	/**
	 * 按区与小区查询,获取结果数
	 */
	public int getCountWithSearchBuilding(String district,String area,int building) throws Exception {
		String sql="select count(*) from gas where customer_id in "
				+ "(select customer_id from customer where address_district=? and address_area=? and address_building=?)";
		PreparedStatement pst=connection.prepareStatement(sql);
		pst.setString(1, district);
		pst.setString(2, area);
		pst.setInt(3, building);
		ResultSet rs=pst.executeQuery();	
		rs.next();
		return rs.getInt(1);
	}

	/**
	 * 按区、小区、楼号查询
	 */
	public List<Gas> searchWarningGasByBuilding(String district,String area,int building,int start,int count) throws Exception {
		String sql="select * from gas where customer_id in "
				+ "(select customer_id from customer where address_district=? and address_area=? and address_building=?) and gas_money<20 limit ?,?";
		PreparedStatement pst=connection.prepareStatement(sql);
		pst.setString(1, district);
		pst.setString(2, area);
		pst.setInt(3, building);
		pst.setInt(4, start*count);
		pst.setInt(5, count);
		ResultSet rs=pst.executeQuery();	
		return convertResult(rs);
	}
	
	/**
	 * 按区与小区查询,获取结果数
	 */
	public int getCountWithWarningSearchByBuilding(String district,String area,int building) throws Exception {
		String sql="select count(*) from gas where customer_id in "
				+ "(select customer_id from customer where address_district=? and address_area=? and address_building=?) and gas_money<20";
		PreparedStatement pst=connection.prepareStatement(sql);
		pst.setString(1, district);
		pst.setString(2, area);
		pst.setInt(3, building);
		ResultSet rs=pst.executeQuery();	
		rs.next();
		return rs.getInt(1);
	}
	
	/**
	 * 查询指定住户的最新燃气表数据
	 */
	public Gas searchCurrentGasByCustomerId(int customerId) throws Exception {
		String sql="select * from gas where customer_id=? and flag=0";
		PreparedStatement pst=connection.prepareStatement(sql);
		pst.setInt(1, customerId);
		ResultSet rs=pst.executeQuery();
		List<Gas> gases = convertResult(rs);
		if(gases.size() > 0){
			return gases.get(0);
		}
		else{
			return null;
		}	
	}
	
	/**
	 * 查询指定住户的所有燃气表数据
	 */
	public List<Gas> searchAllGasByCustomerId(int customerId) throws Exception {
		String sql="select * from gas where customer_id=?";
		PreparedStatement pst=connection.prepareStatement(sql);
		pst.setInt(1, customerId);
		ResultSet rs=pst.executeQuery();	
		return convertResult(rs);
	}
	
	//注意需要更改前一个gas的状态
	public void addGas(Gas gas) throws Exception {
		//增加新纪录
		String cmd = "update gas set flag=1 where flag=0 and customer_id=?";
		PreparedStatement pst0 = connection.prepareStatement(cmd);
		pst0.setInt(1, gas.getCustomerId());
		pst0.executeUpdate();
		
		String sql = "insert into gas values(null,null,?,?,?,0,?)";
		PreparedStatement pst = connection.prepareStatement(sql);
		pst.setLong(1, gas.getGasValue());
		pst.setLong(2, gas.getPreviousValue());
		pst.setInt(3, gas.getGasMoney());
		pst.setInt(4, gas.getCustomerId());
		pst.executeUpdate();	
	}
	
	
	/**
	 * @param rs
	 * @return
	 * @throws Exception
	 */
	public static List<Gas> convertResult(ResultSet rs) throws Exception{
		List<Gas> gases=new ArrayList<Gas>();
		while(rs.next()){
			Gas gas=new Gas();
			gas.setGasId(rs.getInt(1));
			gas.setCollectTime(rs.getTimestamp(2));
			gas.setGasValue(rs.getLong(3));
			gas.setPreviousValue(rs.getLong(4));			
			gas.setGasMoney(rs.getInt(5));
			gas.setFlag(rs.getInt(6));
			gas.setCustomerId(rs.getInt(7));
			gases.add(gas);			
		}		
		return gases;
	}
}