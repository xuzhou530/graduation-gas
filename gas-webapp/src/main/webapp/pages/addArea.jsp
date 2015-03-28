<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%> 
<%@ page import="com.young.gas.beans.User" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>燃气远程监控系统小区</title>
<link href="/gas-webapp/css/current.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="/gas-webapp/js/menu.js"></script>
<script type="text/javascript" src="/gas-webapp/js/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$(".div2").click(function(){ 
		$(this).next("div").slideToggle("slow").siblings(".div3:visible").slideUp("slow");
	});
});
</script>
</head>
<body>
<%
	User user=(User)session.getAttribute("user");
	String[] districts={"系统管理员","利州区","昭化区","朝天区","旺苍县","青川县","剑阁县","苍溪县"};	
	int userGrade=user.getUserGrade();
%>
<%@include file="menu.jsp" %>
<%@include file="leftmenu.html" %>

<div id="content" style="float:left;">
	<p id="status">当前位置：<span>住户管理&nbsp;&gt;</span><span>&nbsp;添加小区&nbsp;</span></p>
	<div id="data">
		<span>
			<div id="image">
				<image src="/gas-webapp/images/00.png" width=25px height=25px/>
			</div>添加小区
		</span>
		<form method="post" action="AddressServlet">
			<table width="40%" border="0" cellpadding="0" cellspacing="0" align="center" bordercolor="#CCCCCC">
				<tr><td class="title">区县名:&nbsp;&nbsp;</td>
					<td>
					<select name="districtName" style="width: 200px; height:30px;" >
						<option value =-1>-请选择-</option>
						<option value =0>利州区</option>
						<option value =1>昭化区</option>
						<option value=2>朝天区</option>
						<option value=3>旺苍县</option>
						<option value=4>青川县</option>
						<option value=5>剑阁县</option>	
						<option value=6>苍溪县</option>	
					</select>
					</td></tr>
				<tr><td class="title">小区名:&nbsp;&nbsp;</td><td><input type="text" name="areaName"/></td></tr>
				<tr><td class="title">小区地址:&nbsp;&nbsp;</td><td><input type="text" name="areaLocation"/></td></tr>
				<tr><td class="title">建筑数量:&nbsp;&nbsp;</td><td><input type="text" name="buildingNumbers"/></td></tr>
				<tr><td class="title">用户数量:&nbsp;&nbsp;</td><td><input type="text" name="customerNumbers"/></td></tr>
				<tr><td class="title">小区描述:&nbsp;&nbsp;</td><td><input type="text" name="areaDescribe"/></td></tr>
				<tr><td class="title">&nbsp;</td>
					<td>
						<input class="buttonsave" type="submit" value="保存"/>&nbsp;&nbsp;
						<input class="buttonreset" type="reset" value="重置"/>
						<input type="hidden" name="method" value="add"/>
					</td>
				</tr>
			</table>
		</form>
	<p>&nbsp;</p>
	</div>			
</div>
</body>
</html>
<script type="text/javascript">
setInterval("document.getElementById('time').innerHTML=new Date().toLocaleString();",5);
</script>
