package com.young.gas.service.impl;

import java.util.List;
import com.young.gas.beans.Address;

public class Validator {
	public static boolean validateAddress(String district,String area){
		AddressServiceImpl service=new AddressServiceImpl();
		List<Address> addresses=service.searchAddresssByDistrict(district);
		for(Address compareAddress : addresses){
			String compareArea=compareAddress.getAddressArea();
			if(compareArea.equals(area)){
				return true;
			}
		}
		return false;
	}

}
