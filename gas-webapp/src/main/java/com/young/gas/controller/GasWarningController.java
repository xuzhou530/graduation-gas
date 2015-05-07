package com.young.gas.controller;

import java.io.PrintWriter;
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

import tcp.server.TcpServerDataHandler;

import com.young.gas.beans.Address;
import com.young.gas.beans.Gas;
import com.young.gas.beans.User;
import com.young.gas.service.AddressService;
import com.young.gas.service.CustomerService;
import com.young.gas.service.GasService;
import com.young.gas.tool.EncodingTool;

@Controller
public class GasWarningController {
	@Autowired
	AddressService addressService;
	@Autowired
	CustomerService customerService;
	@Autowired
	GasService gasService;
	@Autowired
	TcpServerDataHandler testServer;
	
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
	@RequestMapping ("viewwarning/{districtId}") 
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
		for(int i = 0; i < addresses.size()-1; i++){
			areas.add(addresses.get(i).getAddressArea());
			areaStr += addresses.get(i).getAddressArea()+",";
		}
		areas.add(addresses.get(addresses.size()-1).getAddressArea());
		areaStr += addresses.get(addresses.size()-1).getAddressArea();
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
	@RequestMapping ("viewwarning/{district}/{areaName}/{building}/{page}") 
	public ModelAndView viewWarningByBuilding(
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
		List<Address> addresses = addressService.searchAddresssByDistrict(district);
		String areaStr="";//用于生成动态下拉菜单
		for(int i = 0; i < addresses.size()-1; i++){
			areaStr += addresses.get(i).getAddressArea()+",";
		}
		areaStr += addresses.get(addresses.size()-1).getAddressArea();
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
	@RequestMapping ("searchwarning/{districtId}") 
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
		for(int i = 0; i < addresses.size()-1; i++){
			areaStr += addresses.get(i).getAddressArea()+",";
		}
		areaStr += addresses.get(addresses.size()-1).getAddressArea();
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
	
	//for ajax
	@RequestMapping ("reminder/{customerId}") 
	public ModelAndView reminderCustomer(
			@PathVariable("customerId") int customerId,
			HttpServletResponse response){
		if(!isLogged()){
			return new ModelAndView("redirect:/home");
		}
		PrintWriter out = null;
		try{
			out=response.getWriter();
			testServer.sendData(1, "hello from web".getBytes()); 
			out.write("success");
			
		}
		catch(Exception ex){
			out.write("error");
			//ex.printStackTrace();
			System.out.println("connection error!");
		}
		finally{
			out.close();
		}
		
	    return null;  
	}	
	
}