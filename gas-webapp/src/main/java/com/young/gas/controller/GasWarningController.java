package com.young.gas.controller;

import java.util.ArrayList;
import java.util.List;

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
import com.young.gas.beans.Gas;
import com.young.gas.beans.User;
import com.young.gas.service.AddressService;
import com.young.gas.service.CustomerService;
import com.young.gas.service.GasService;
import com.young.gas.service.MoneyService;
import com.young.gas.service.impl.AddressServiceImpl;
import com.young.gas.service.impl.CustomerServiceImpl;
import com.young.gas.service.impl.GasServiceImpl;

@Controller
public class GasWarningController {
	@Autowired
	AddressServiceImpl addressService;
	@Autowired
	CustomerServiceImpl customerService;
	@Autowired
	GasServiceImpl gasService;
	
	private static final String[] DISTRICTS = {"系统管理员","利州区","昭化区","朝天区","旺苍县","青川县","剑阁县","苍溪县"};	
	private static int PERPAGE = 15;
	
	//判断用户是否已登录
	private boolean isLogged(){
		User loginUser = (User)((ServletRequestAttributes)RequestContextHolder.getRequestAttributes())
		.getRequest().getSession().getAttribute("user");	
		return loginUser == null?false:true;
	}
	
	/**
	 * 通过导航栏下拉菜单查看，唯一的参数是区县名
	 * @param districtId
	 * @param request
	 * @param response
	 * @return 
	 */
	@RequestMapping ( "viewwarning/{districtId}") 
	public ModelAndView viewwarning(
			@PathVariable("districtId") int districtId,
			HttpServletRequest request,
			HttpServletResponse response){
		
		if(!isLogged()){
			return new ModelAndView("redirect:/home");
		}
		
		String district = DISTRICTS[districtId];
		List<Address> addresses = addressService.searchAddresssByDistrict(district);
		List<String> areas = new ArrayList<String>();//小区集合
	 	String areaStr="";//用于生成动态下拉菜单
		for(Address address : addresses){
			areas.add(address.getAddressArea());
			areaStr += address.getAddressArea()+",";
		}
		if(areas.size() > 0){
			return viewWarningData(district, areas.get(0), 1, 0, areaStr);
		}
		else{
			return null;
		}	
	}	
	
	/**
	 * 通过左右按钮查看分页
	 * @param districtId
	 * @param request
	 * @param response
	 * @return 
	 */
	@RequestMapping ( "viewwarning/{districtId}/{areaName}/{building}/{page}") 
	public ModelAndView viewWarningByBuilding(
			@PathVariable("districtId") int districtId,
			@PathVariable("areaName") String areaName,
			@PathVariable("building") int building,
			@PathVariable("page") int page,
			HttpServletRequest request,
			HttpServletResponse response){
		if(!isLogged()){
			return new ModelAndView("redirect:/home");
		}
		
		String district = DISTRICTS[districtId];
		List<Address> addresses = addressService.searchAddresssByDistrict(district);
	 	String areaStr="";//用于生成动态下拉菜单
		for(Address address : addresses){
			areaStr += address.getAddressArea()+",";
		}
		return viewWarningData(district, areaName, building, page, areaStr);
	}	
	
	/**
	 * 按区县、小区、楼号检索所有信息
	 * @param districtId
	 * @param areaName
	 * @param buildingName
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping ( "searchwarning/{districtId}") 
	public ModelAndView viewWarningWithSearch(
			@PathVariable("districtId") int districtId,
			@RequestParam("areaName") String areaName,
			@RequestParam("buildingName") String buildingName,
			HttpServletRequest request,
			HttpServletResponse response){
		if(!isLogged()){
			return new ModelAndView("redirect:/home");
		}
		
		List<Address> addresses = addressService.searchAddresssByDistrict(DISTRICTS[districtId]);
	 	String areaStr="";//用于生成动态下拉菜单
		for(Address address : addresses){
			areaStr += address.getAddressArea()+",";
		}
		return viewWarningData(DISTRICTS[districtId], areaName, Integer.parseInt(buildingName), 0, areaStr);
	}	
	
	/**
	 * 公共方法
	 * @param districtId
	 * @param areaName
	 * @param building
	 * @param page
	 * @return
	 */
	public ModelAndView viewWarningData(
			String district, String areaName, int building, int page, String areaStr){
		if(!isLogged()){
			return new ModelAndView("redirect:/home");
		}
		
		//某区某小区某栋楼的住户数
		int countCustomers = gasService.getCountWithWarningSearchBuilding(district, areaName, building);
		//某区某小区某栋楼的燃气值
		List<Gas> gases = gasService.searchWarningGasByBuilding(district, areaName, building, page, PERPAGE);
		for(Gas gas : gases){
			gas.setCustomer(customerService.searchCustomerById(gas.getCustomerId()));
		}
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("currentDistrict", district);
		mav.addObject("currentArea", areaName);
		mav.addObject("currentBuilding", building);
		mav.addObject("areaStr", areaStr);
		mav.addObject("gases", gases);
		mav.addObject("countCustomers", countCustomers);
		mav.addObject("pages", countCustomers/PERPAGE+1);
		mav.addObject("currentPage", page+1);
		mav.setViewName("warning");
		return mav;
	}
}