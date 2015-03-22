<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.young.gas.beans.User" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>广元市燃气远程监控系统首页</title>
<link href="/gas-webapp/css/current.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="/gas-webapp/js/menu.js"></script>
</head>
<body>
<%	
	User user=new User();
	user.setUserName("vyoung");
	user.setUserPwd("vyoung");
	user.setUserGrade(1);
	session.setAttribute("user",user);

%>
<%@include file="menu.jsp" %>

<div id="content" class="wp">
	<p id="status">当前位置：<span>首页&nbsp;</span></p>	
	<div id="data">
		<span>
			<image src="/gas-webapp/images/map.png" width=25px height=25px />&nbsp;地图
		</span>
		<div id="map">
			<iframe width=988px height=750px frameborder=0 scrolling=auto ></iframe>
		</div>	
	</div>
</div>
<div id="footer" class="wp">
	<hr width="1000px" size="1"/>
	<div class="left">
		Powered by :<font color="#0066FF">veyoung</font><br/>
		@Southwest jiaotong university 2014
	</div>
	<div class="right">
		<div id="time"></div>
			<font color="#0066FF">联系站长</font>&nbsp;|&nbsp;广元市燃气远程监控系统&nbsp;<br>
	</div>
	<p>&nbsp;</p>
</div>
</body>
</html>

