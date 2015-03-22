<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ page import="com.young.gas.beans.User" %>
<%@ page import="java.util.List"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>燃气远程监控系统小区</title>
<link rel="stylesheet" type="text/css" href="../css/current.css"/>
<script type="text/javascript" src="../js/menu.js"></script>
</head>
<body>
<%
	User user=(User)session.getAttribute("user");
	String[] districts={"系统管理员","利州区","昭化区","朝天区","旺苍县","青川县","剑阁县","苍溪县"};	
	int userGrade=user.getUserGrade();
%>
<%@include file="menu.jsp" %>

<div id="content" class="wp">
	<p id="status">当前位置：<span>数据管理&nbsp;></span><span>&nbsp;用量详情&nbsp;</p>
	<div id="datalist">
		<span>
			<div id="image">
				<image src="/gas-webapp/images/list.png" width=20px height=20px/>
			</div>
			${currentDistrict}&nbsp;
			<font class="STYLE1">&gt;</font>&nbsp;${currentArea}&nbsp;
			<font class="STYLE1">&gt;&nbsp;</font>${currentBuilding}栋
		</span>
		<table id="maintable" width="980px" border="1" align="center" bordercolor="#dddddd" cellpadding="0" cellspacing="0" onmouseover="changeto()"  onmouseout="changeback()">
		<tr>
			<td width="4%"  class="tablehead">序号</td>
			<td width="8%" class="tablehead">用户名</td>
			<td width="8%" class="tablehead">房号</td>
			<td width="8%" class="tablehead">燃气用量</td>
			<td width="8%" class="tablehead">账户余额</td>			
			<td width="7%" class="tablehead">联系方式</td>
			<td width="12%" class="tablehead">采集时间</td>
	    </tr>
		<c:forEach items="${gases}" var="item" varStatus="status"> 
		  <tr class="tablerow">
			<td class="tablecontent">${status.count}</td>
			<td class="tablecontent">${customer.customerName}</td>	
			<td class="tablecontent">${customer.addressLayer}楼${customer.addressRoom}室</td>
			<td class="tablecontent">${item.gasValue}</td>
			<td class="tablecontent">${item.gasMoney}</td>	
			<td class="tablecontent">${customer.customerPhone}</td>
			<td class="tablecontent">${item.collectTime}</td>
		  </tr> 
		</c:forEach>

		 </table>	
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
