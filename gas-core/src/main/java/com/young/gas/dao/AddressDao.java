package com.young.gas.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.young.gas.beans.Address;

public class AddressDao {
	/**
	 * connection需要注入！！
	 */
	private Connection connection=null;
	
	/**
	 * 设置连接
	 * @param connection
	 */
	public void setConnection(Connection connection){
		this.connection=connection;
	}
	/**
	 * 获取连接
	 * @return
	 */
	public Connection getConnection(){
		return connection;
	}
	/**
	 * 
	 * @param 增加地址到数据库中
	 * @throws Exception
	 */
	public void addAddress(Address address) throws Exception{
		String sql="insert into address values(null,?,?,?,?,?,?)";
		PreparedStatement pst=connection.prepareStatement(sql);
		pst.setString(1,address.getAddressDistrict());
		pst.setString(2,address.getAddressArea());
		pst.setString(3, address.getAddressLocation());
		pst.setInt(4, address.getAddressBuildings());
		pst.setInt(5, address.getAddressCustomers());
		pst.setString(6, address.getAddressDesicribe());
		pst.executeUpdate();
	}
	/**
	 * 
	 * @param id
	 * @throws Exception
	 */
	public void deleteAddress(int id) throws Exception{
		String sql="delete from address where address_id=?";
		PreparedStatement pst=connection.prepareStatement(sql);
		pst.setInt(1, id);
		pst.executeUpdate();
	}
	
	/**
	 * 
	 * @param address的id的是待修改的address，其他字段则是待修改的内容
	 * @throws Exception
	 */
	public void modifyAddress(Address address) throws Exception{
		String sql="update address set address_district=?,address_area=?,address_location=?,"
				+ "address_buildings=?,address_customers=?,address_desicribe=? where address_id=?";
		PreparedStatement pst=connection.prepareStatement(sql);
		pst.setString(1,address.getAddressDistrict());
		pst.setString(2,address.getAddressArea());
		pst.setString(3, address.getAddressLocation());
		pst.setInt(4, address.getAddressBuildings());
		pst.setInt(5, address.getAddressCustomers());
		pst.setString(6, address.getAddressDesicribe());
		pst.setInt(7, address.getAddressId());
		pst.executeUpdate();
	}
	/**
	 * 
	 * @return
	 * @throws Exception
	 */
	public List<Address> listAllAddresss() throws Exception {
		String sql="select * from address order by address_district,address_area";
		PreparedStatement pst=connection.prepareStatement(sql);
		ResultSet rs=pst.executeQuery();
		return convertResult(rs);
	}
	/**
	 * 
	 */
	public List<Address> searchAddressByDistrict(String district) throws Exception {
		String sql="select * from address where address_district=?";
		PreparedStatement pst=connection.prepareStatement(sql);
		pst.setString(1, district);
		ResultSet rs=pst.executeQuery();	
		return convertResult(rs);
	}

	/**
	 * 
	 * @param district
	 * @param area
	 * @return
	 * @throws Exception
	 */
	public Address searchAddressById(int id) throws Exception {
		String sql="select * from address where address_id=?";
		PreparedStatement pst=connection.prepareStatement(sql);
		pst.setInt(1, id);
		ResultSet rs=pst.executeQuery();	
		return convertResult(rs).get(0);
	}	
	
	/**
	 * 
	 * @param district
	 * @return
	 * @throws Exception
	 */
	public int getAreaCount(String district) throws Exception {
		String sql="select count(*) from address where address_district=?";
		PreparedStatement pst=connection.prepareStatement(sql);
		pst.setString(1, district);
		ResultSet rs=pst.executeQuery();	
		rs.next();
		return rs.getInt(1);
	}	
	/**
	 * 
	 */
	public int getAddressId(String district,String area) throws Exception {
		String sql="select address_id from address where address_district=? and address_area=?";
		PreparedStatement pst=connection.prepareStatement(sql);
		pst.setString(1, district);
		pst.setString(2, area);
		ResultSet rs=pst.executeQuery();	
		
		return rs.next()?rs.getInt(1):-1;
	}

	/**
	 * 
	 * @param rs
	 * @return
	 * @throws Exception
	 */
	public static List<Address> convertResult(ResultSet rs) throws Exception{
		List<Address> addresses=new ArrayList<Address>();
		while(rs.next()){
			Address address=new Address();
			address.setAddressId(rs.getInt(1));
			address.setAddressDistrict(rs.getString(2));
			address.setAddressArea(rs.getString(3));
			address.setAddressLocation(rs.getString(4));
			address.setAddressBuildings(rs.getInt(5));
			address.setAddressCustomers(rs.getInt(6));
			address.setAddressDesicribe(rs.getString(7));
			addresses.add(address);
		}		
		return addresses;
	}
}