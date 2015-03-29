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

<div id="content" class="rightcontent">
	<h4 class="addtitle">集中器参数设置</h4>		
	<form method="post" action="AddressServlet">
	<table width="100%" border="0" cellpadding="0" cellspacing="0" align="left" bordercolor="#CCCCCC">

		<tr><td class="title">集中器编号:&nbsp;&nbsp;</td>
		<td><input type="text" name="areaName" value="01010101"/></td>
		</tr>
		<tr>
			<td class="title">采集周期:&nbsp;&nbsp;</td>
			<td>
				<select name="period" style="width: 280px; height:30px;" >
					<option value =0>每月一次</option>
					<option value =1>半月一次</option>
					<option value =2>每天一次</option>
				</select>
			</td>
		</tr>
		<tr>
			<td class="title">采集开始时间:&nbsp;&nbsp;</td>
			<td><input type="text" name="day" style="width:40px;" value="1"/><span class="describe">日</span>
				<input type="text" name="day" style="width:35px;" value="12"/><span class="describe">时：</span>
				<input type="text" name="day" style="width:35px;" value="00"/><span class="describe">分：</span>
				<input type="text" name="day" style="width:35px;" value="00"/><span class="describe">秒</span></td>
		</tr>
		<tr><td class="title">&nbsp;</td>
			<td>
				<input class="buttonsave" type="submit" value="保存"/>&nbsp;&nbsp;
				<input class="buttonreset" type="reset" value="重置"/>
				<input type="hidden" name="method" value="add"/>
			</td>
		</tr>
	</table>
	</form>			
</div>
</body>
</html>
<script type="text/javascript">
setInterval("document.getElementById('time').innerHTML=new Date().toLocaleString();",5);
</script>
