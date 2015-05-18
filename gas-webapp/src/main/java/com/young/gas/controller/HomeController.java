package com.young.gas.controller;

import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.young.gas.beans.Log;
import com.young.gas.beans.User;
import com.young.gas.service.LogService;
import com.young.gas.service.UserService;
import com.young.gas.tool.EncodingTool;

@Controller
public class HomeController {
	@Autowired
	UserService userService;
	@Autowired
	LogService logService;
	
	private static final String[] DISTRICTS = {"系统管理员","利州区","昭化区","朝天区","旺苍县","青川县","剑阁县","苍溪县"};	
	
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
		User user = userService.listUser(name);	
		ModelAndView mav = new ModelAndView();
		if(user != null && password.equals(user.getUserPwd())){ 
			if(user.getStatus() == 0){
				((ServletRequestAttributes)RequestContextHolder.getRequestAttributes())
				.getRequest().getSession().setAttribute("user", user);
				
				//登录事件写日志
				Log log = new Log();
				log.setOperator(user.getUserName());
				log.setOperateAction("登录系统");
				log.setOperateTime(new Timestamp(System.currentTimeMillis()));
				logService.addLog(log);
				
				mav.setViewName("index");
				return mav;
			}
			else if(user.getStatus() == 1){
				mav.setViewName("login");
				mav.addObject("result", "待审核中，请等候");
				return mav;
			}

		}
		else {
			mav.setViewName("login");
			mav.addObject("result", "用户不存在或密码错误");
			return mav;
		}
		return null;
	}
	
	//用户注册
	@RequestMapping ("registerUser") 
	public ModelAndView registerUser(
			@RequestParam("userName") String userName,
			@RequestParam("email") String email,
			@RequestParam("phone") String phone,
			@RequestParam("password") String password,
			@RequestParam("grade") int grade
			){
		User user = new User();
		user.setUserName(userName);
		user.setUserEmail(email);
		user.setUserPhone(phone);
		user.setUserGrade(grade);
		user.setUserPwd(password);
		user.setStatus(1);
		userService.addUser(user);
		return new ModelAndView("login");
	}
	
	//ajax校验用户是否存在
	@RequestMapping ("userExist/{name}")
	public void userExist(
			@PathVariable("name") String name,
			HttpServletResponse response){
		
		PrintWriter out = null;
		try{
			out=response.getWriter();
			if(userService.existUser(name)==true){
				out.write("y");
			}
			else{
				out.write("n");
			}
		}
		catch(Exception ex){
			out.write("error");
		}
		finally{
			out.close();
		}
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
	
	@RequestMapping ("statusDetails") 
	public ModelAndView statusDetails(){
		return new ModelAndView("statusDetails");
	}
	
	@RequestMapping ("meters") 
	public ModelAndView meters(){
		return new ModelAndView("meters");
	}
	
	
	/*
	 * 超级用户的权限,查看系统日志
	 */
	@RequestMapping ("logger") 
	public ModelAndView logger(){
		List<Log> logs = logService.listLogs();
		if(logs != null && logs.size()>0){
			for(Log log : logs){
				User user = userService.listUser(log.getOperator());
				if(user != null){
					String authority = DISTRICTS[user.getUserGrade()];
					user.setAuthority(authority);
					log.setGrade(user.getAuthority());
				}else{
					log.setGrade("");
				}
			}
		}
		ModelAndView mav = new ModelAndView();
		mav.addObject("logs", logs);
		mav.setViewName("logger");
		return mav;
	}
	
	@RequestMapping ("users") 
	public ModelAndView users(){
		List<User> users = userService.listAllUsers();
		if(users != null && users.size()>0){
			for(User user : users){
				String status;
				if(user.getStatus() == 0){
					status = "正常";
				}
				else if(user.getStatus() == 1){
					status = "审核中";
				}
				else{
					status = "审核未通过";
				}
				user.setCurrentSta(status);
				user.setAuthority(DISTRICTS[user.getStatus()]);
			}
		}
		ModelAndView mav = new ModelAndView();
		mav.addObject("users",users);
		mav.setViewName("users");
		return mav;
	}
	
	@RequestMapping ("audit") 
	public ModelAndView audit(){
		List<User> users = userService.listAllRequestUsers();
		if(users != null && users.size()>0){
			for(User user : users){
				String status;
				if(user.getStatus() == 0){
					status = "正常";
				}
				else if(user.getStatus() == 1){
					status = "审核中";
				}
				else{
					status = "审核未通过";
				}
				user.setCurrentSta(status);
				user.setAuthority(DISTRICTS[user.getStatus()]);
			}
		}
		ModelAndView mav = new ModelAndView();
		mav.addObject("users",users);
		mav.setViewName("auditUsers");
		return mav;
	}
	
	@RequestMapping ("passUser/{userName}") 
	public ModelAndView passUser(
			@PathVariable("userName") String userName
			){
		userName = EncodingTool.encodeStr(userName);
		userService.passUser(userName);
		return new ModelAndView("redirect:/audit");
	}

	@RequestMapping ("rejectUser/{userName}") 
	public ModelAndView rejectUser(
			@PathVariable("userName") String userName
			){
		userName = EncodingTool.encodeStr(userName);
		userService.rejectUser(userName);
		return new ModelAndView("redirect:/audit");
	}	
	
	@RequestMapping ("payHistory") 
	public ModelAndView payHistory(){
		return new ModelAndView("payHistory");
	}
} 