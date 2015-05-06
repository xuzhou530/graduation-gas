package com.young.gas.service;

import java.util.List;

import com.young.gas.beans.Address;

public interface AddressService {
	
	public boolean addAddress(Address address);
	
	public boolean deleteAddress(int id);
	
	public boolean modifyAddress(Address address);
	
	public List<Address> listAllAddresss();
	
	public List<Address> searchAddresssByDistrict(String district);

	public Address searchAddressById(int id);
	
	public int getAreaCount(String district);
	
	public int getAddressId(String district,String area);
	
}
