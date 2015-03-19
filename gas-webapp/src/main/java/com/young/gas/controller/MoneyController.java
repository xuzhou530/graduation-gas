package com.young.gas.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.young.gas.beans.Address;
import com.young.gas.beans.Customer;
import com.young.gas.beans.Money;
import com.young.gas.service.AddressService;
import com.young.gas.service.CustomerService;
import com.young.gas.service.MoneyService;

@Controller
public class MoneyController {
	private static final String[] DISTRICTS = {"系统管理员","利州区","昭化区","朝天区","旺苍县","青川县","剑阁县","苍溪县"};	
	
	/**
	 * @param districtId
	 * @param request
	 * @param response
	 * @return 
	 */
	@RequestMapping ( "addpay/{districtId}") 
	public ModelAndView addPay(
			@PathVariable("districtId") int districtId,
			@RequestParam("areaName") String areaName,
			@RequestParam("addressBuilding") String addressBuilding,
			@RequestParam("addressLayer") String addressLayer,
			@RequestParam("addressRoom") String addressRoom,
			@RequestParam("name") String name,
			@RequestParam("pay") String pay,
			HttpServletRequest request,
			HttpServletResponse response){
		String district = DISTRICTS[districtId];
		CustomerService customerService = new CustomerService();
		Customer customer = customerService.searchCustomerByRoom(district, areaName, 
				Integer.parseInt(addressBuilding), Integer.parseInt(addressLayer), Integer.parseInt(addressRoom));
		if(customer !=null && name.equals(customer.getCustomerName())){//输入的用户名匹配正确
			MoneyService moneyService = new MoneyService();
			Money previous = moneyService.listCurrentByCusomerId(customer.getCustomerId());
			if(previous != null){
				Money money = new Money();
				money.setResult(Integer.parseInt(pay) + previous.getResult());
				money.setPrevious(previous.getResult());
				money.setOperate(Integer.parseInt(pay));
				money.setCustomerId(customer.getCustomerId());
				moneyService.addMoney(money);
			}
			else{//该用户第一次缴费
				Money money = new Money();
				money.setResult(Integer.parseInt(pay));
				money.setPrevious(0);
				money.setOperate(Integer.parseInt(pay));
				money.setCustomerId(customer.getCustomerId());
				moneyService.addMoney(money);
			}	
			return viewPayData(districtId, customer.getCustomerId());
		}
		else{
			return null;
		}
	}	
	
	/**
	 * @param districtId
	 * @param request
	 * @param response
	 * @return 
	 */
	@RequestMapping ( "searchpay/{districtId}") 
	public ModelAndView searchPay(
			@PathVariable("districtId") int districtId,
			@RequestParam("areaName") String areaName,
			@RequestParam("buildingName") String buildingName,
			@RequestParam("layerName") String layerName,
			@RequestParam("roomName") String roomName,
			HttpServletRequest request,
			HttpServletResponse response){
		CustomerService customerService = new CustomerService();
		Customer customer = customerService.searchCustomerByRoom(DISTRICTS[districtId], areaName, 
				Integer.parseInt(buildingName), Integer.parseInt(layerName), Integer.parseInt(roomName));
		return viewPayData(districtId, customer.getCustomerId());
	}
	
	@RequestMapping ( "viewpay/{districtId}") 
	public ModelAndView viewPay(
			@PathVariable("districtId") int districtId,
			HttpServletRequest request,
			HttpServletResponse response){
		CustomerService customerService = new CustomerService();
		List<Customer> customers = customerService.searchSingleCustomerByDistrict(DISTRICTS[districtId]);
		if(customers != null && customers.size() > 0){
			return viewPayData(districtId, customers.get(0).getCustomerId());
		}
		else{
			return null;
		}
	}
	
	/**
	 * 公共方法
	 * @param districtId
	 * @param areaName
	 * @param building
	 * @param page
	 * @return
	 */
	public ModelAndView viewPayData(int districtId, int customerId){
		MoneyService moneyService = new MoneyService();
		CustomerService customerService = new CustomerService();
		AddressService addressService = new AddressService();
		
		Customer customer = customerService.searchCustomerById(customerId);
		List<Money> moneys = moneyService.listMoneysByCusomerId(customerId);
		for(Money money : moneys){
			money.setCustomer(customer);
		}
		
		List<Address> addresses = addressService.searchAddresssByDistrict(DISTRICTS[districtId]);
	 	String areaStr="";//用于生成动态下拉菜单
		for(Address address : addresses){
			areaStr += address.getAddressArea()+",";
		}
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("currentDistrict", customer.getAddressDistrict());
		mav.addObject("currentArea", customer.getAddressArea());
		mav.addObject("currentBuilding", customer.getAddressBuilding());
		mav.addObject("moneys", moneys);
		mav.addObject("countMoneys", moneys.size());
		mav.addObject("areaStr", areaStr);
		mav.setViewName("paymentDetails");
		return mav;
	}
}