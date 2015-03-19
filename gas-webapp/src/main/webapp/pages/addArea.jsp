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
</head>
<body>
<%
	User user=(User)session.getAttribute("user");
	String[] districts={"系统管理员","利州区","昭化区","朝天区","旺苍县","青川县","剑阁县","苍溪县"};	
	int userGrade=user.getUserGrade();
%>
<div id="header">
	<div class="wp">
		<div id="logo">广元市燃气远程抄表<span>监控系统</span></div>
		<div class="right">
			<div id="welcome">登录用户：<font><%=user.getUserName()%></font>&nbsp;&nbsp;&nbsp;用户权限：<font><%=districts[userGrade]%></font></div>
		</div>
	</div>
</div>
<div id="navigation">
	<div class="wp">
		<div id="menu" class="left">
			<ul>
				<li><a class="shine" href="/gas-webapp/pages/index.jsp">首页</a></li>
				<li><a href=#>最新数据</a>
					<ul>
						<li><a id="d1" href="/gas-webapp/viewgas/1" onclick="return forbid()">利州区</a></li>
						<li><a id="d2" href="/gas-webapp/viewgas/2" onclick="return forbid()">昭化区</a></li>
						<li><a id="d3" href="/gas-webapp/viewgas/3" onclick="return forbid()">朝天区</a></li>
						<li><a id="d4" href="/gas-webapp/viewgas/4" onclick="return forbid()">旺苍县</a></li>
						<li><a id="d5" href="/gas-webapp/viewgas/5" onclick="return forbid()">青川县</a></li>
						<li><a id="d6" href="/gas-webapp/viewgas/6" onclick="return forbid()">剑阁县</a></li>
						<li><a id="d7" href="/gas-webapp/viewgas/7" onclick="return forbid()">苍溪县</a></li>
					</ul>
				</li>
				<li><a href=#>告警数据</a>
					<ul>
						<li><a id="dd1" href="/gas-webapp/viewwarning/1" onclick="return forbid()">利州区</a></li>
						<li><a id="dd2" href="/gas-webapp/viewwarning/2" onclick="return forbid()">昭化区</a></li>
						<li><a id="dd3" href="/gas-webapp/viewwarning/3" onclick="return forbid()">朝天区</a></li>
						<li><a id="dd4" href="/gas-webapp/viewwarning/4" onclick="return forbid()">旺苍县</a></li>
						<li><a id="dd5" href="/gas-webapp/viewwarning/5" onclick="return forbid()">青川县</a></li>
						<li><a id="dd6" href="/gas-webapp/viewwarning/6" onclick="return forbid()">剑阁县</a></li>
						<li><a id="dd7" href="/gas-webapp/viewwarning/7" onclick="return forbid()">苍溪县</a></li>
					</ul>
				</li>
				<li><a href=#>数据管理</a>
					<ul>
						<li><a href="/gas-webapp/pages/print.jsp">报表打印</a></li>
						<li><a href="/gas-webapp/pages/details.jsp">用量详情</a></li>
					</ul>
				</li>
				<li><a href=#>住户管理</a>
					<ul>
						<li><a href="/gas-webapp/viewaddress/<%=userGrade%>">所有小区</a></li>
						<li><a href="/gas-webapp/pages/addArea.jsp">添加小区</a></li>
						<li><a href="/gas-webapp/viewcustomers/<%=userGrade%>">所有住户</a></li>					
						<li><a href="/gas-webapp/pages/addCustomer.jsp">添加住户</a></li>
					</ul>
				</li>
				<li><a href=#>缴费管理</a>
					<ul>
						<li><a href="/gas-webapp/pages/addPay.jsp">用户缴费</a></li>
						<li><a href="/gas-webapp/viewpay/<%=userGrade%>">缴费记录</a></li>
					</ul>
				</li>
				<li><a href="login.jsp">退出系统</a></li>
			</ul>
		</div>
	</div>
</div>
<div id="content" class="wp">
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
<script type="text/javascript">
setInterval("document.getElementById('time').innerHTML=new Date().toLocaleString();",5);

var grade = "<%=userGrade%>";
if(grade != 0){
	var cls1 = 'd' + grade;
	var cls2 = 'dd' + grade;
	document.getElementById(cls1).onclick="return true";
	document.getElementById(cls2).onclick="return true";	
}
else{
	for(var i = 1; i <= 7; i++){
		var cls1 = 'd' + i;
		var cls2 = 'dd' + i;
		document.getElementById(cls1).onclick="return true";
		document.getElementById(cls2).onclick="return true";
	}
}

function forbid(){
	alert("您无操作权限");
	return false;
}
</script>
