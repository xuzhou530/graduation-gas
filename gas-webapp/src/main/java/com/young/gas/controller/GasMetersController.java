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
import com.young.gas.beans.Customer;
import com.young.gas.beans.Gas;
import com.young.gas.beans.User;
import com.young.gas.service.AddressService;
import com.young.gas.service.CustomerService;
import com.young.gas.service.GasService;
import com.young.gas.service.MoneyService;
import com.young.gas.tool.EncodingTool;

@Controller
public class GasMetersController {
	@Autowired
	AddressService addressService;
	@Autowired
	CustomerService customerService;
	@Autowired
	MoneyService moneyService;
	@Autowired
	GasService gasService;
	
	private static final String[] DISTRICTS = {"系统管理员","利州区","昭化区","朝天区","旺苍县","青川县","剑阁县","苍溪县"};	
	private static int PERPAGE = 8;

	//判断用户是否已登录
	private boolean isLogged(){
		User loginUser = (User)((ServletRequestAttributes)RequestContextHolder.getRequestAttributes())
		.getRequest().getSession().getAttribute("user");	
		return loginUser == null?false:true;
	}
	
	/**
	 * 浏览所有燃气表状态
	 * @param districtId
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("viewMeters/{districtId}") 
	public ModelAndView viewMeters(
			@PathVariable("districtId") int districtId,
			HttpServletRequest request,
			HttpServletResponse response){
		
		if(!isLogged()){
			return new ModelAndView("redirect:/home");
		}
		
		String district = DISTRICTS[districtId];
		List<Address> addresses = addressService.searchAddresssByDistrict(district);
		if(addresses.size() > 0){//小区存在
			List<String> areas = new ArrayList<String>();//小区集合
		 	String areaStr="";//用于生成动态下拉菜单
			for(int i = 0; i < addresses.size()-1; i++){
				areas.add(addresses.get(i).getAddressArea());
				areaStr += addresses.get(i).getAddressArea()+",";
			}
			areas.add(addresses.get(addresses.size()-1).getAddressArea());
			areaStr += addresses.get(addresses.size()-1).getAddressArea();
			return viewMetersData(district,areas.get(0),1,0,areaStr);
		}
		return null;
	}
	
	/**
	 * 通过翻页查询燃气表状态
	 * @param districtId
	 * @param areaName
	 * @param building
	 * @param page
	 * @param areaStr
	 * @return
	 */
	@RequestMapping("viewMeters/{district}/{areaName}/{building}/{page}") 
	public ModelAndView viewMeters(
			@PathVariable("district") String district,
			@PathVariable("areaName") String areaName,
			@PathVariable("building") int building,
			@PathVariable("page") int page
			){
		if(!isLogged()){
			return new ModelAndView("redirect:/home");
		}
		district = EncodingTool.encodeStr(district);
		areaName = EncodingTool.encodeStr(areaName);
		
		List<Address> addresses = addressService.searchAddresssByDistrict(district);
		if(addresses.size() > 0){//小区存在
			List<String> areas = new ArrayList<String>();//小区集合
		 	String areaStr="";//用于生成动态下拉菜单
			for(int i = 0; i < addresses.size()-1; i++){
				areas.add(addresses.get(i).getAddressArea());
				areaStr += addresses.get(i).getAddressArea()+",";
			}
			areas.add(addresses.get(addresses.size()-1).getAddressArea());
			areaStr += addresses.get(addresses.size()-1).getAddressArea();
			return viewMetersData(district,areaName,building,page,areaStr);
		}
		return null;
	}
	
	/**
	 * 公共方法
	 * @param district
	 * @param areaName
	 * @param building
	 * @param page
	 * @param areaStr
	 * @return
	 */
	private ModelAndView viewMetersData(
			String district, String areaName, int building, int page, String areaStr){
		if(!isLogged()){
			return new ModelAndView("redirect:/home");
		}
		
		//某区某小区某栋楼的总住户数
		int countCustomers = customerService.
				getCountWithSearchBuilding(district, areaName, building);
		//某区某小区某栋楼的8户住户集合
		List<Customer> customers = customerService.
				searchCustomersByBuilding(district, areaName, building, page, PERPAGE);
		List<Gas> gases = new ArrayList<Gas>();//燃气表需要拥有的状态
		for(Customer customer : customers){
			customer.setMoney(moneyService.listCurrentByCusomerId(customer.getCustomerId()).getResult());
			Gas gas = gasService.searchCurrentGasByCustomerId(customer.getCustomerId());
			if(gas != null){
				gas.setCustomer(customer);
				gases.add(gas);
			}
		}
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("currentDistrict", district);
		mav.addObject("currentArea", areaName);
		mav.addObject("currentBuilding", building);
		mav.addObject("areaStr", areaStr);
		mav.addObject("customers", customers);
		mav.addObject("gases", gases);
		mav.addObject("countCustomers", countCustomers);
		mav.addObject("pages", countCustomers/PERPAGE+1);
		mav.addObject("currentPage", page+1);
		mav.setViewName("meters");
		return mav;
	} 
}