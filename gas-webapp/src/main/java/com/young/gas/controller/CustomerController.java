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
import com.young.gas.beans.Money;
import com.young.gas.beans.User;
import com.young.gas.service.AddressService;
import com.young.gas.service.CustomerService;
import com.young.gas.service.MoneyService;
import com.young.gas.tool.EncodingTool;

@Controller
public class CustomerController {
	@Autowired
	AddressService addressService;
	@Autowired
	CustomerService customerService;
	@Autowired
	MoneyService moneyService;
	
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
	@RequestMapping("viewcustomers/{districtId}") 
	public ModelAndView viewCustomers(
			@PathVariable("districtId") int districtId,
			HttpServletRequest request,
			HttpServletResponse response){
		
		if(!isLogged()){
			return new ModelAndView("redirect:/home");
		}
		
		List<Address> addresses = addressService.searchAddresssByDistrict(DISTRICTS[districtId]);
		List<String> areas = new ArrayList<String>();//小区集合
	 	String areaStr="";//用于生成动态下拉菜单
		for(Address address : addresses){
			areas.add(address.getAddressArea());
			areaStr += address.getAddressArea()+",";
		}
		if(areas.size() > 0){
			return viewCustomerData(DISTRICTS[districtId], areas.get(0), 1, 0, areaStr);
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
	@RequestMapping ("viewcustomers/{districtId}/{areaName}/{building}/{page}") 
	public ModelAndView viewCustomersByBuilding(
			@PathVariable("districtId") int districtId,
			@PathVariable("areaName") String areaName,
			@PathVariable("building") int building,
			@PathVariable("page") int page,
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
		areaName = EncodingTool.encodeStr(areaName);
		return viewCustomerData(DISTRICTS[districtId], areaName, building, page, areaStr);
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
	@RequestMapping ("searchcustomers/{districtId}") 
	public ModelAndView viewCustomersWithSearch(
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
		return viewCustomerData(DISTRICTS[districtId], areaName, Integer.parseInt(buildingName), 0, areaStr);
	}	
	
	/**
	 * 公共方法
	 * @param districtId
	 * @param areaName
	 * @param building
	 * @param page
	 * @return
	 */
	public ModelAndView viewCustomerData(
			String district, String areaName, int building, int page, String areaStr){
	
		if(!isLogged()){
			return new ModelAndView("redirect:/home");
		}
		
		//某区某小区某栋楼的住户数
		int countCustomers = customerService.getCountWithSearchBuilding(district, areaName, building);
		//某区某小区某栋楼的住户集合
		List<Customer> customers = customerService.searchCustomersByBuilding(district, areaName, building, page, PERPAGE);
		for(Customer customer : customers){
			customer.setMoney(moneyService.listCurrentByCusomerId(customer.getCustomerId()).getResult());
		}
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("currentDistrict", district);
		mav.addObject("currentArea", areaName);
		mav.addObject("currentBuilding", building);
		mav.addObject("areaStr", areaStr);
		mav.addObject("customers", customers);
		mav.addObject("countCustomers", countCustomers);
		mav.addObject("pages", countCustomers/PERPAGE+1);
		mav.addObject("currentPage", page+1);
		mav.setViewName("customers");
		return mav;
	}
	
	/**
	 * 添加住户信息
	 * @return
	 */
	@RequestMapping("addCustomerData") 
	public ModelAndView addcustomerData(
			@RequestParam("customerName") String customerName,
			@RequestParam("customerPhone") String customerPhone,
			@RequestParam("districtName") int districtId,
			@RequestParam("areaName") String areaName,
			@RequestParam("addressBuilding") int addressBuilding,
			@RequestParam("addressLayer") int addressLayer,
			@RequestParam("addressRoom") int addressRoom){
		if(!isLogged()){
			return new ModelAndView("redirect:/home");
		}
		Customer customer = new Customer();
		customer.setCustomerName(customerName);
		customer.setCustomerPhone(customerPhone);
		customer.setAddressDistrict(DISTRICTS[districtId]);
		customer.setAddressArea(areaName);
		customer.setAddressBuilding(addressBuilding);
		customer.setAddressLayer(addressLayer);
		customer.setAddressRoom(addressRoom);	
		customerService.addCustomer(customer);
		
		Customer cus = customerService.searchCustomerByRoom(DISTRICTS[districtId], areaName, 
				addressBuilding, addressLayer, addressRoom);
		if(cus != null){
			Money money = new Money();
			money.setCustomerId(cus.getCustomerId());
			money.setResult(0);
			money.setOperate(0);
			money.setPrevious(0);
			money.setFlag(0);
			moneyService.addMoney(money);
		}
		return new ModelAndView("redirect:/viewcustomers/"+districtId);
	}
	
	/**
	 * 删除指定的住户
	 * @return
	 */
	@RequestMapping("deleteCustomer/{customerId}") 
	public ModelAndView deleteCustomer(
			@PathVariable("customerId") int customerId){
		if(!isLogged()){
			return new ModelAndView("redirect:/home");
		}
		
		customerService.deleteCustomer(customerId);
		moneyService.deleteMoneyByCusomerId(customerId);//同时删除住户的账户信息
		return new ModelAndView("redirect:/viewcustomers/"+1);
	}
	
	/**
	 * 修改页面的跳转
	 * @param customerId
	 * @return
	 */
	@RequestMapping("jumpModifyCustomer/{customerId}") 
	public ModelAndView jumpModifyCustomer(
			@PathVariable("customerId") int customerId){
		
		Customer customer = customerService.searchCustomerById(customerId);
		ModelAndView mav = new ModelAndView();
		mav.addObject("customer", customer);
		mav.setViewName("addCustomer");
		return mav;
	}
	
	//页面跳转
	@RequestMapping("addCustomer") 
	public ModelAndView addcustomer(){
		if(!isLogged()){
			return new ModelAndView("redirect:/home");
		}
		
		return new ModelAndView("addCustomer");
	}
}