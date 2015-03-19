package com.young.gas.service;

import java.util.List;
import com.young.gas.beans.Address;

public class Validator {
	public static boolean validateAddress(String district,String area){
		AddressService service=new AddressService();
		List<Address> addresses=service.searchAddresssByDistrict(district);
		for(Address compareAddress : addresses){
			String compareArea=compareAddress.getAddressArea();
			if(compareArea.equals(area)){
				return true;
			}
		}
		return false;
	}
//	public static void main(String[] args){
//		String district="利州区";
//		String area="龙城华府";
//		System.out.print(validateAddress(district,area));
//	}
}
