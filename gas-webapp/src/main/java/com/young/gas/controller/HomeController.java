package com.young.gas.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.young.gas.beans.User;
import com.young.gas.service.UserService;

@Controller
public class HomeController {
	@Autowired
	UserService userService;
	
	/**
	 * 隐藏主页面
	 */
	@RequestMapping ("home") 
	public ModelAndView homeJump(){
		ModelAndView mav = new ModelAndView();
		mav.setViewName("login");
		return mav;
	}	
	
	/**
	 * 登陆
	 * @param name
	 * @param password
	 * @param session
	 * @return
	 */
	@RequestMapping ("login") 
	public ModelAndView login(
			@RequestParam("name") String name,
			@RequestParam("password") String password
			){
		ModelAndView mav = new ModelAndView();
		User user = userService.listUser(name);	
		
		if(user != null && password.equals(user.getUserPwd())){ 
			((ServletRequestAttributes)RequestContextHolder.getRequestAttributes())
				.getRequest().getSession().setAttribute("user", user);  
			mav.setViewName("index");
			return mav;
		}
		else{
			mav.setViewName("login");
			return mav;
		}
	}
	@RequestMapping ("registerUser") 
	public ModelAndView registerUser(
			@RequestParam("userName") String userName,
			@RequestParam("email") String email,
			@RequestParam("password") String password,
			@RequestParam("grade") String grade
			){
		ModelAndView mav = new ModelAndView();
		mav.setViewName("register");
		return mav;
	}
	
	@RequestMapping ("logout") 
	public ModelAndView logout(){
		ModelAndView mav = new ModelAndView();
		mav.setViewName("login");
		return mav;
	}
	//静态页面的跳转
	@RequestMapping ("register") 
	public ModelAndView register(){
		ModelAndView mav = new ModelAndView();
		mav.setViewName("register");
		return mav;
	}
			
	@RequestMapping ("index") 
	public ModelAndView index(){
		ModelAndView mav = new ModelAndView();
		mav.setViewName("index");
		return mav;
	}
	
	@RequestMapping ("setting") 
	public ModelAndView setting(){
		return new ModelAndView("setting");
	}
	@RequestMapping ("payaly") 
	public ModelAndView payaly(){
		ModelAndView mav = new ModelAndView();
		mav.setViewName("payaly");
		return mav;
	}
			
	@RequestMapping ("usealy") 
	public ModelAndView usealy(){
		ModelAndView mav = new ModelAndView();
		mav.setViewName("usealy");
		return mav;
	}
	
	@RequestMapping ("status") 
	public ModelAndView status(){
		return new ModelAndView("status");
	}
	
	@RequestMapping ("logger") 
	public ModelAndView logger(){
		ModelAndView mav = new ModelAndView();
		mav.setViewName("logger");
		return mav;
	}
	
	@RequestMapping ("users") 
	public ModelAndView users(){
		return new ModelAndView("users");
	}
	
	@RequestMapping ("meters") 
	public ModelAndView meters(){
		return new ModelAndView("meters");
	}
}