package com.young.gas.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;



import com.young.gas.beans.User;
import com.young.gas.service.AddressService;


@Controller
public class AreaController {
	private static final String[] DISTRICTS = {"系统管理员","利州区","昭化区","朝天区","旺苍县","青川县","剑阁县","苍溪县"};	
	
	@RequestMapping ( "viewaddress/{districtId}") 
	public ModelAndView listAreas(
			@PathVariable("districtId") int districtId,
			HttpServletRequest request,
			HttpServletResponse response){
		User loginUser = (User)((ServletRequestAttributes)RequestContextHolder.getRequestAttributes())
		.getRequest().getSession().getAttribute("user");
		if(loginUser == null){
			return new ModelAndView("redirect:/home");
		}
		
		AddressService addressService = new AddressService();
		ModelAndView mav = new ModelAndView();
		mav.addObject("addresses", addressService.searchAddresssByDistrict(DISTRICTS[districtId]));
		mav.setViewName("areas");
		return mav;
	}
	
	@RequestMapping ( "addaddress/{districtId}") 
	public ModelAndView addAddress(
			@PathVariable("districtId") int districtId,
			HttpServletRequest request,
			HttpServletResponse response){
		
		AddressService addressService = new AddressService();
		ModelAndView mav = new ModelAndView();
		mav.addObject("addresses", addressService.searchAddresssByDistrict(DISTRICTS[districtId]));
		return mav;
	}
}