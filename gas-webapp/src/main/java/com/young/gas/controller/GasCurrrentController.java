package com.young.gas.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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
public class GasCurrrentController {
	@Autowired
	AddressService addressService;
	@Autowired
	CustomerService customerService;
	@Autowired
	MoneyService moneyService;
	@Autowired
	GasService gasService;
	
	private static final String[] DISTRICTS = {"系统管理员","利州区","昭化区","朝天区","旺苍县","青川县","剑阁县","苍溪县"};	
	private static int PERPAGE = 15;

	//判断用户是否已登录
	private boolean isLogged(){
		User loginUser = (User)((ServletRequestAttributes)RequestContextHolder.getRequestAttributes())
		.getRequest().getSession().getAttribute("user");	
		return loginUser == null?false:true;
	}
	
	private String getAreaStr(String district){
		List<Address> addresses = addressService.searchAddresssByDistrict(district);
		//获取燃气表数据
		if(addresses.size() > 0){//小区存在
		 	String areaStr="";//用于生成动态下拉菜单
			for(int i = 0; i < addresses.size()-1; i++){
				areaStr += addresses.get(i).getAddressArea()+",";
			}
			areaStr += addresses.get(addresses.size()-1).getAddressArea();
			return areaStr;
		}
		return "";
	}
	/**
	 * 通过导航栏下拉菜单查看，唯一的参数是区县名
	 * @param districtId
	 * @param request
	 * @param response
	 * @return 
	 */
	@RequestMapping ("viewgas/{districtId}") 
	public ModelAndView viewGas(
			@PathVariable("districtId") int districtId,
			HttpServletRequest request,
			HttpServletResponse response){
		
		if(!isLogged()){
			return new ModelAndView("redirect:/home");
		}
		
		String areaStr = getAreaStr(DISTRICTS[districtId]);
		if(!"".equals(areaStr)){
			String[] arr = areaStr.split(",");
			return viewGasData(DISTRICTS[districtId],arr[0],1,0,areaStr);
		}
		return null;
	}	
	
	/**
	 * 通过左右按钮查看分页
	 * @param districtId
	 * @param request
	 * @param response
	 * @return 
	 */
	@RequestMapping ("viewgas/{district}/{areaName}/{building}/{page}") 
	public ModelAndView viewGasByBuilding(
			@PathVariable("district") String district,
			@PathVariable("areaName") String areaName,
			@PathVariable("building") int building,
			@PathVariable("page") int page,
			HttpServletRequest request,
			HttpServletResponse response){
		if(!isLogged()){
			return new ModelAndView("redirect:/home");
		}
		
		district = EncodingTool.encodeStr(district);
		areaName = EncodingTool.encodeStr(areaName);
		String areaStr = getAreaStr(district);
		if(!"".equals(areaStr)){
			return viewGasData(district,areaName,building,page,areaStr);
		}
		return null;
	}	
	
	/**
	 * 查询某用户的历史记录
	 * @param districtId
	 * @param request
	 * @param response
	 * @return 
	 */
	@RequestMapping ("viewdetailgas/{customerId}") 
	public ModelAndView viewAllGasByCustomerId(
			@PathVariable("customerId") int customerId,
			HttpServletRequest request,
			HttpServletResponse response){
		
		if(!isLogged()){
			return new ModelAndView("redirect:/home");
		}
		
		Customer customer = customerService.searchCustomerById(customerId);
		customer.setMoney(moneyService.listCurrentByCusomerId(customer.getCustomerId()).getResult());
		List<Gas> gases = gasService.searchAllGasByCustomerId(customerId);	
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("customer", customer);
		mav.addObject("currentDistrict", customer.getAddressDistrict());
		mav.addObject("currentArea", customer.getAddressArea());
		mav.addObject("currentBuilding", customer.getAddressBuilding());
		mav.addObject("gases", gases);
		mav.setViewName("details");
		return mav;
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
	@RequestMapping ("searchgas/{districtId}") 
	public ModelAndView viewGasWithSearch(
			@PathVariable("districtId") int districtId,
			@RequestParam("areaName") String areaName,
			@RequestParam("buildingName") String buildingName,
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
	
		//第一页住户
		List<Customer> customers = customerService.searchCustomersByBuilding(district, areaName, Integer.parseInt(buildingName), 0, PERPAGE);
		//某区某小区某栋楼的住户数
		int countCustomers = customerService.getCountWithSearchBuilding(district, areaName, Integer.parseInt(buildingName));
		//某区某小区某栋楼的燃气值
		List<Gas> gases = new ArrayList<Gas>();
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
		mav.addObject("currentBuilding", Integer.parseInt(buildingName));
		mav.addObject("areaStr", areaStr);
		mav.addObject("gases", gases);
		mav.addObject("countCustomers", countCustomers);
		mav.addObject("pages", countCustomers/PERPAGE+1);
		mav.addObject("currentPage", 1);
		mav.setViewName("current");
		return mav;
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
	private ModelAndView viewGasData(
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
			try{
				customer.setMoney(moneyService.listCurrentByCusomerId(customer.getCustomerId()).getResult());
				Gas gas = gasService.searchCurrentGasByCustomerId(customer.getCustomerId());
				if(gas != null){
					gas.setCustomer(customer);
					gases.add(gas);
				}
			}
			catch(Exception e){
				e.printStackTrace();
			}
		}
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("currentDistrict", district);
		mav.addObject("currentArea", areaName);
		mav.addObject("currentBuilding", building);
		mav.addObject("areaStr", areaStr);
		mav.addObject("customers", customers);
		mav.addObject("gases", gases);
		mav.addObject("countCustomers", countCustomers);
		mav.addObject("pages", countCustomers/PERPAGE+1);
		mav.addObject("currentPage", page+1);
		mav.setViewName("current");
		return mav;
	} 
}