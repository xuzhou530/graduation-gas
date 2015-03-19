package com.young.gas.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class LoginController {
	
	@RequestMapping ( "/pages/login" ) 
	public ModelAndView login(
			 @RequestParam(required=true) String name,
			 @RequestParam (required=true ) String password){
		
		//System.out.println("name= "+name+" pass="+password);
		ModelAndView mav=new ModelAndView();
		mav.setViewName("welcome");
		return mav;
	}
	

	
}