package com.young.gas.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.young.gas.beans.Customer;

public class CustomerDao {
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
	 * @param 增加顾客
	 * @throws Exception
	 */
	public void addCustomer(Customer customer) throws Exception{
		String sql="insert into customer values(null,?,?,?,?,?,?,?,0)";
		PreparedStatement pst=connection.prepareStatement(sql);
		pst.setString(1,customer.getCustomerName());
		pst.setString(2,customer.getCustomerPhone());
		pst.setString(3,customer.getAddressDistrict());
		pst.setString(4, customer.getAddressArea());
		pst.setInt(5, customer.getAddressBuilding());
		pst.setInt(6, customer.getAddressLayer());
		pst.setInt(7, customer.getAddressRoom());
		pst.executeUpdate();
	}
	/**
	 * 
	 * @param 删除顾客
	 * @throws Exception
	 */
	public void deleteCustomer(int id) throws Exception{
		String sql="delete from customer where customer_id=?";
		PreparedStatement pst=connection.prepareStatement(sql);
		pst.setInt(1, id);
		pst.executeUpdate();
	}
	
	/**
	 * 
	 * @param  修改顾客
	 * @throws Exception
	 */
	public void modifyCustomer(Customer customer) throws Exception{
		String sql="update customer set customer_name=?,customer_phone=?,address_district=?,"
				+ "address_area=?,address_building=?,address_room=? where customer_id=?";
		PreparedStatement pst=connection.prepareStatement(sql);
		pst.setString(1,customer.getCustomerName()); 
		pst.setString(2,customer.getCustomerPhone());
		pst.setString(3,customer.getAddressDistrict());
		pst.setString(4, customer.getAddressArea());
		pst.setInt(5, customer.getAddressBuilding());
		pst.setInt(6, customer.getAddressLayer());
		pst.setInt(7, customer.getAddressRoom());
		pst.setInt(8, customer.getCustomerId());
		pst.executeUpdate();
	}
	/**
	 * 
	 * @return 返回所有顾客
	 * @throws Exception
	 */
	public List<Customer> listAllCustomers(int start,int count) throws Exception {
		String sql="select * from customer limit ?,?";
		PreparedStatement pst=connection.prepareStatement(sql);
		pst.setInt(1, start*count);
		pst.setInt(2, count);
		ResultSet rs=pst.executeQuery();
		return convertResult(rs);
	}
	
	/**
	 * 
	 * @return
	 * @throws Exception
	 */
	public int getCountOfAllCustomers() throws Exception {
		String sql="select count(*)  from customer";
		PreparedStatement pst=connection.prepareStatement(sql);
		ResultSet rs=pst.executeQuery();
		rs.next();
		return rs.getInt(1);
	}
	
	
	/**
	 * 按区与小区查询
	 */
	public List<Customer> searchCustomers(String district,String area,int start,int count) throws Exception {
		String sql="select * from customer where address_district=? and address_area=? limit ?,?";
		PreparedStatement pst=connection.prepareStatement(sql);
		pst.setString(1, district);
		pst.setString(2, area);
		pst.setInt(3, start*count);
		pst.setInt(4, count);
		ResultSet rs=pst.executeQuery();	
		return convertResult(rs);
	}
	/**
	 * 按区与小区以及楼号查询
	 */
	public List<Customer> searchCustomersByBuilding(String district,String area,int building,int start,int count) throws Exception {
		String sql="select * from customer where address_district=? and address_area=? and address_building=? limit ?,?";
		PreparedStatement pst=connection.prepareStatement(sql);
		pst.setString(1, district);
		pst.setString(2, area);
		pst.setInt(3, building);
		pst.setInt(4, start*count);
		pst.setInt(5, count);
		ResultSet rs=pst.executeQuery();	
		return convertResult(rs);
	}
	
	public List<Customer> searchSingleCustomerByDistrict(String district) throws Exception {
		String sql="select * from customer where address_district=? limit 0,1";
		PreparedStatement pst=connection.prepareStatement(sql);
		pst.setString(1, district);
		ResultSet rs=pst.executeQuery();	
		return convertResult(rs);
	}
	
	/**
	 * 按区与小区查询,获取结果数
	 */
	public int getCountWithSearch(String district,String area) throws Exception {
		String sql="select  count(*) from customer where address_district=? and address_area=?";
		PreparedStatement pst=connection.prepareStatement(sql);
		pst.setString(1, district);
		pst.setString(2, area);
		ResultSet rs=pst.executeQuery();	
		rs.next();
		return rs.getInt(1);
	}
	/**
	 * 按区与小区查询,获取结果数
	 */
	public int getCountWithSearchBuilding(String district,String area,int building) throws Exception {
		String sql="select  count(*) from customer where address_district=? and address_area=? and address_building=?";
		PreparedStatement pst=connection.prepareStatement(sql);
		pst.setString(1, district);
		pst.setString(2, area);
		pst.setInt(3, building);
		ResultSet rs=pst.executeQuery();	
		rs.next();
		return rs.getInt(1);
	}
	/**
	 * 
	 * @param 按id查询顾客
	 * @param area
	 * @return
	 * @throws Exception
	 */
	public Customer searchCustomerById(int id) throws Exception {
		String sql="select * from customer where customer_id=?";
		PreparedStatement pst=connection.prepareStatement(sql);
		pst.setInt(1, id);
		ResultSet rs=pst.executeQuery();	
		return convertResult(rs).get(0);
	}	
	
	/**
	 * 按房号查询用户
	 * @param district
	 * @param area
	 * @param building
	 * @param layer
	 * @param room
	 * @return
	 * @throws Exception
	 */
	public Customer searchCustomerByRoom(String district, String area, int building, int layer, int room) throws Exception {
		String sql="select * from customer where address_district=? and address_area=? and address_building=? and address_layer=? and address_room=?";
		PreparedStatement pst=connection.prepareStatement(sql);
		pst.setString(1, district);
		pst.setString(2, area);
		pst.setInt(3, building);
		pst.setInt(4, layer);
		pst.setInt(5, room);
		ResultSet rs=pst.executeQuery();
		List<Customer> customers = convertResult(rs);
		if(customers != null && customers.size()>0){
			return customers.get(0);
		}
		else{
			return null;
		}
	}
	
	/**
	 * 
	 * @param rs
	 * @return
	 * @throws Exception
	 */
	public static List<Customer> convertResult(ResultSet rs) throws Exception{
		List<Customer> customers=new ArrayList<Customer>();
		while(rs.next()){
			Customer customer=new Customer();
			customer.setCustomerId(rs.getInt(1));
			customer.setCustomerName(rs.getString(2));
			customer.setCustomerPhone(rs.getString(3));
			customer.setAddressDistrict(rs.getString(4));
			customer.setAddressArea(rs.getString(5));
			customer.setAddressBuilding(rs.getInt(6));
			customer.setAddressLayer(rs.getInt(7));
			customer.setAddressRoom(rs.getInt(8));
			customers.add(customer);
		}		
		return customers;
	}
}