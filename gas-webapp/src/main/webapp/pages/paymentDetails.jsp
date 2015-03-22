<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.young.gas.beans.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
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
	User user=(User)session.getAttribute("user");
	String[] districts={"系统管理员","利州区","昭化区","朝天区","旺苍县","青川县","剑阁县","苍溪县"};	
	int userGrade=user.getUserGrade();
%>
<%@include file="menu.jsp" %>

<div id="content" class="wp">
	<p id="status">当前位置：<span>最新数据&nbsp;</span></p>	
	<div id="datalist">
	<span>
		<div id="image">
			<image src="/gas-webapp/images/money.png" width=25px height=25px/>
		</div>
		${currentDistrict}&nbsp;
		<font class="STYLE1">&gt;</font>&nbsp;${currentArea}&nbsp;
		<font class="STYLE1">&gt;&nbsp;</font>${currentBuilding}栋
		<div id="search">
			<form id="searchform" action="/gas-webapp/searchpay/<%=userGrade%>" method="post" onsubmit="return checkform()">
				小区：<select id="areaName" name="areaName" style="width:82px; height:25px;">
					<option value =0>-请选择-</option>
				</select>&nbsp;
				楼号：<input type="text" id="buildingName" name="buildingName" style="width:35px; height:15px;"/>
				楼层：<input type="text" id="layerName" name="layerName" style="width:35px; height:15px;"/>
				房号：<input type="text" id="roomName" name="roomName" style="width:35px; height:15px;"/>
				<input id="inputbutton" type="submit" value="查询"/>
				&nbsp;&nbsp;&nbsp;&nbsp;
			</form>
		</div>
	</span>
	
	<table id="maintable" width="980px" border="1px" align="center" bordercolor="#dddddd" cellpadding="0" cellspacing="0" style="border-collapse:collapse;" onmouseover="changeto()"  onmouseout="changeback()">
	  <tr>
		<td width="4%"  class="tablehead">序号</td>
		<td width="8%" class="tablehead">用户名</td>
		<td width="8%" class="tablehead">房号</td>
		<td width="8%" class="tablehead">账户余额</td>		
		<td width="8%" class="tablehead">金额变动</td>	
		<td width="7%" class="tablehead">联系方式</td>
		<td width="12%" class="tablehead">变动时间</td>
		<td width="7%" class="tablehead">历史记录</td>
	  </tr>
	  <c:forEach items="${moneys}" var="item" varStatus="status">  
		  <tr class="tablerow">
			<td class="tablecontent">${status.count}</td>
			<td class="tablecontent">${item.customer.customerName}</td>
			<td class="tablecontent">${item.customer.addressLayer}层${item.customer.addressRoom}室</td>
			<td class="tablecontent">${item.result}</td>
			<td class="tablecontent">${item.operate}</td>	
			<td class="tablecontent">${item.customer.customerPhone}</td>
			<td class="tablecontent">${item.operateTime}</td>
			<td class="tablecontent">查看</td>
		  </tr> 
	 </c:forEach>
	 </table>
	 <table width="980px" align="center" border="0" cellspacing="0" cellpadding="0">
	  <tr>
		<td width="25%" height="29" nowrap="nowrap">
			<span class="STYLE1">&nbsp;共<strong>&nbsp;${countMoneys}&nbsp;</strong>条纪录</span>
		</td>

	  </tr>
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

var newSelect=document.getElementById("areaName"); 
newSelect.options.length=0; 
var op=document.createElement("option");
op.value=0;
op.innerHTML="-请选择-";
newSelect.appendChild(op);
//得到完成请求后返回的字串符
var str = "${areaStr}";
//根据返回的字符串为新创建的select节点添加option节点
var arr1 = str.split(",");
//alert(arr1);
for(var i=0;i<arr1.length;i++){
    var child=document.createElement("option");
    child.innerHTML=arr1[i];
    child.value=arr1[i];
    newSelect.appendChild(child);
}

function checkform(){
	var areaName=document.forms["searchform"]["areaName"];
	var buildingName=document.forms["searchform"]["buildingName"];
	if(areaName.value=="0")
	{
		alert("请选择小区");
		return false;
	}
	if(buildingName.value=="")
	{
		alert("请输入楼号");
		return false;
	}
	return true;	
}

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
