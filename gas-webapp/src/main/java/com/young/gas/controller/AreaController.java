package com.young.gas.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.young.gas.beans.Address;
import com.young.gas.beans.User;
import com.young.gas.service.AddressService;

@Controller
public class AreaController {
	@Autowired
	AddressService addressService;

	private static final String[] DISTRICTS = {"系统管理员","利州区","昭化区","朝天区","旺苍县","青川县","剑阁县","苍溪县"};	
	
	//判断用户是否已登录
	private boolean isLogged(){
		User loginUser = (User)((ServletRequestAttributes)RequestContextHolder.getRequestAttributes())
		.getRequest().getSession().getAttribute("user");	
		return loginUser == null?false:true;
	}
	
	@RequestMapping("viewaddress/{districtId}") 
	public ModelAndView listAreas(
			@PathVariable("districtId") int districtId,
			HttpServletRequest request,
			HttpServletResponse response){
		if(!isLogged()){
			return new ModelAndView("redirect:/home");
		}
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("addresses", addressService.searchAddresssByDistrict(DISTRICTS[districtId]));
		mav.setViewName("areas");
		return mav;
	}
	
	/**
	 * 
	 * @param districtId
	 * @param areaName
	 * @param areaLocation
	 * @param buildingNumbers
	 * @param customerNumbers
	 * @param areaDescribe
	 * @param addressId
	 * @return
	 */
	@RequestMapping("addAddress") 
	public ModelAndView addAddress(
			@RequestParam("districtName") int districtId,
			@RequestParam("areaName") String areaName,
			@RequestParam("areaLocation") String areaLocation,
			@RequestParam("buildingNumbers") int buildingNumbers,
			@RequestParam("customerNumbers") int customerNumbers,
			@RequestParam("areaDescribe") String areaDescribe,
			@RequestParam("addressId") String addressId
			){
		if(!isLogged()){
			return new ModelAndView("redirect:/home");
		}
		
		Address address = new Address();
		if("".equals(addressId)){//if addressid is empty ,then add a address
			address.setAddressDistrict(DISTRICTS[districtId]);
			address.setAddressArea(areaName);
			address.setAddressLocation(areaLocation);
			address.setAddressBuildings(buildingNumbers);
			address.setAddressCustomers(customerNumbers);
			address.setAddressDesicribe(areaDescribe);
			addressService.addAddress(address);	
		}
		else{//this type is modify an exist address
			address.setAddressId(Integer.parseInt(addressId));
			address.setAddressDistrict(DISTRICTS[districtId]);
			address.setAddressArea(areaName);
			address.setAddressLocation(areaLocation);
			address.setAddressBuildings(buildingNumbers);
			address.setAddressCustomers(customerNumbers);
			address.setAddressDesicribe(areaDescribe);
			addressService.modifyAddress(address);
		}
		return new ModelAndView("redirect:/viewaddress/" + districtId);
	}

	/**
	 * 
	 * @param addressId
	 * @return
	 */
	@RequestMapping("deleteAddress/{addressId}") 
	public ModelAndView deleteAddress(
			@PathVariable("addressId") int addressId){	
		if(!isLogged()){
			return new ModelAndView("redirect:/home");
		}
		
		addressService.deleteAddress(addressId);
		return new ModelAndView("redirect:/viewaddress/1");
	}
	
	@RequestMapping("existAddress") 
	public int existAddress(
			@RequestParam("districtName") int districtId,
			@RequestParam("areaName") String areaName){	
		if(addressService.getAddressId(DISTRICTS[districtId], areaName) != -1){
			return 1;
		}
		else{
			return 0;
		}	
	}
	
	@RequestMapping("addArea") 
	public ModelAndView addArea(){
		return new ModelAndView("addArea");
	}	
	
	/**
	 * 小区列表中，修改按钮请求响应
	 * @return
	 */
	@RequestMapping("jumpModifyArea/{addressId}") 
	public ModelAndView jumpModifyArea(
			@PathVariable("addressId") int addressId){
		Address address = addressService.searchAddressById(addressId);
		ModelAndView mav = new ModelAndView();
		mav.addObject("address", address);
		mav.setViewName("addArea");
		return mav;
	}
}