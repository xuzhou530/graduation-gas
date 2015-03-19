<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
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
	int userGrade=user.getUserGrade();
	String[] districts={"系统管理员","利州区","昭化区","朝天区","旺苍县","青川县","剑阁县","苍溪县"};	
	String district=districts[user.getUserGrade()];
%>
<div id="header">
	<div class="wp">
		<div id="logo">广元市燃气远程抄表<span>监控系统</span></div>
		<div class="right">
			<div id="welcome">登录用户：<font>admin</font>&nbsp;&nbsp;&nbsp;用户权限：<font>利州区</font></div>
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
	<p id="status">当前位置：<span>住户管理&nbsp;></span><span>&nbsp;所有住户&nbsp;></p>
	<div id="data">
		<span>
			<div id="image">
				<image src="/gas-webapp/images/list.png" width=20px height=20px/>
			</div>
			报表:&nbsp;利州区
		</span>
		<table id="maintable" width=980px border="1" align="center" bordercolor="#dddddd" cellpadding="0" cellspacing="0" onmouseover="changeto()"  onmouseout="changeback()">
		  <tr>
			<td width="5%"  class="tablehead">序号</td>
			<td width="10%" class="tablehead">小区名</td>
			<td width="10%" class="tablehead">小区地址</td>
			<td width="10%" class="tablehead">小区规模</td>
			<td width="10%" class="tablehead">小区住户数</td>
			<td width="7%" class="tablehead">操作</td>
		  </tr>
		  <tr class="tablerow">
			<td class="tablecontent">1</td>
			<td class="tablecontent">和苑小区</td>
			<td class="tablecontent">利州区和苑东路111号</td>
			<td class="tablecontent">20栋</td>
			<td class="tablecontent">200户</td>
			<td class="tablecontent">查看</td>
		  </tr> 
		  <tr class="tablerow">
			<td class="tablecontent">2</td>
			<td class="tablecontent">和苑小区</td>
			<td class="tablecontent">利州区和苑东路111号</td>
			<td class="tablecontent">20栋</td>
			<td class="tablecontent">200户</td>
			<td class="tablecontent">查看</td>
		  </tr> 
		  <tr class="tablerow">
			<td class="tablecontent">3</td>
			<td class="tablecontent">和苑小区</td>
			<td class="tablecontent">利州区和苑东路111号</td>
			<td class="tablecontent">20栋</td>
			<td class="tablecontent">200户</td>
			<td class="tablecontent">查看</td>
		  </tr> 
		 <tr class="tablerow">
			<td class="tablecontent">4</td>
			<td class="tablecontent">和苑小区</td>
			<td class="tablecontent">利州区和苑东路111号</td>
			<td class="tablecontent">20栋</td>
			<td class="tablecontent">200户</td>
			<td class="tablecontent">查看</td>
		  </tr> 
		  <tr class="tablerow">
			<td class="tablecontent">1</td>
			<td class="tablecontent">和苑小区</td>
			<td class="tablecontent">利州区和苑东路111号</td>
			<td class="tablecontent">20栋</td>
			<td class="tablecontent">200户</td>
			<td class="tablecontent">查看</td>
		  </tr> 
		  <tr class="tablerow">
			<td class="tablecontent">2</td>
			<td class="tablecontent">和苑小区</td>
			<td class="tablecontent">利州区和苑东路111号</td>
			<td class="tablecontent">20栋</td>
			<td class="tablecontent">200户</td>
			<td class="tablecontent">查看</td>
		  </tr> 
		  <tr class="tablerow">
			<td class="tablecontent">3</td>
			<td class="tablecontent">和苑小区</td>
			<td class="tablecontent">利州区和苑东路111号</td>
			<td class="tablecontent">20栋</td>
			<td class="tablecontent">200户</td>
			<td class="tablecontent">查看</td>
		  </tr> 
		  <tr class="tablerow">
			<td class="tablecontent">4</td>
			<td class="tablecontent">和苑小区</td>
			<td class="tablecontent">利州区和苑东路111号</td>
			<td class="tablecontent">20栋</td>
			<td class="tablecontent">200户</td>
			<td class="tablecontent">查看</td>
		  </tr> 
		 </table>	
		<br>
	</div>
	<p>&nbsp;</p>
	<p>&nbsp;</p>
	<p>&nbsp;</p>
	<p>&nbsp;</p>
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
