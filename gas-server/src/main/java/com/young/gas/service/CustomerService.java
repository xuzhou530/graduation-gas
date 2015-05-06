package com.young.gas.service;

import java.util.List;

import com.young.gas.beans.Customer;

public interface CustomerService {
	/**
	 * 增加用户
	 * @param user
	 * @return 操作结果
	 */
	public boolean addCustomer(Customer customer);
	
	/**
	 * 删除指定用户名的用户
	 * @param name
	 * @return 返回操作结果
	 */
	public boolean deleteCustomer(int customerId);
	
	/**
	 * 查询指定名字的用户，返回用户对象
	 * @param name
	 * @return Customer对象
	 */
	public List<Customer> searchCustomersByBuilding(String district,String area,int building,int start,int count);
		
	public int getCountWithSearchBuilding(String district,String area,int building);
	
	/**
	 * 
	 * @param id
	 * @return
	 */
	public Customer searchCustomerById(int customerId);
	
	public List<Customer> searchSingleCustomerByDistrict(String district);
	
	/**
	 * 按房号查询用户
	 * @param district
	 * @param area
	 * @param building
	 * @param layer
	 * @param room
	 * @return
	 */
	public Customer searchCustomerByRoom(String district, String area, int building, int layer, int room);
}
