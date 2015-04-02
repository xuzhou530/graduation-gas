<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ page import="com.young.gas.beans.User" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>燃气远程监控系统小区</title>
<link href="/gas/css/current.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="/gas/js/menu.js"></script>
<script type="text/javascript" src="/gas/js/jquery.js"></script>
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
	<p id="status">当前位置：<span>住户管理&nbsp;></span><span>&nbsp;所有住户&nbsp;></p>
	<div id="data">
		<span>
			<div id="image">
				<image src="/gas/images/list.png" width=20px height=20px/>
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
