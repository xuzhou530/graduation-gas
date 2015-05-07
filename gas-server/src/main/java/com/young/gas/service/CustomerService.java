package com.young.gas.service;

import java.util.List;

import com.young.gas.beans.Customer;

public interface CustomerService {

	public boolean addCustomer(Customer customer);
	
	public boolean deleteCustomer(int customerId);
	
	public List<Customer> searchCustomersByBuilding(String district,String area,int building,int start,int count);
		
	public int getCountWithSearchBuilding(String district,String area,int building);

	public Customer searchCustomerById(int customerId);
	
	public List<Customer> searchSingleCustomerByDistrict(String district);
	
	public Customer searchCustomerByRoom(String district, String area, int building, int layer, int room);
	
	public boolean openMeter(int customerId);
	
	public boolean closeMeter(int customerId);
	
	public int getMeterStatus(int customerId);

}
