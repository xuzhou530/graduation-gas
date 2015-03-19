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
	int userGrade = user.getUserGrade();
	String[] districts={"系统管理员","利州区","昭化区","朝天区","旺苍县","青川县","剑阁县","苍溪县"};	
	String district=districts[user.getUserGrade()];
%>
<div id="header">
	<div class="wp">
		<div id="logo">广元市燃气远程抄表<span>监控系统</span></div>
		<div class="right">
			<div id="welcome">登录用户：<font><%=user.getUserName()%></font>&nbsp;&nbsp;&nbsp;用户权限：<font><%=district%></font></div>
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
	<p id="status">当前位置：<span>住户管理&nbsp;></span><span>&nbsp;所有住户&nbsp;</p>
	<div id="datalist">
		<span>
			<div id="image">
				<image src="/gas-webapp/images/text.png" width=20px height=20px />
			</div>
			${currentDistrict}&nbsp;
			<font class="STYLE1">&gt;</font>&nbsp;${currentArea}&nbsp;
			<font class="STYLE1">&gt;&nbsp;</font>${currentBuilding}栋
			<div id="search">
				<form id="searchform" action="/gas-webapp/searchcustomers/<%=userGrade%>" method="post" onsubmit="return checkform()">
					小区：<select id="areaName" name="areaName" style="width:82px; height:25px;">
						<option value =0>-请选择-</option>
					</select>&nbsp;
					楼号：<input type="text" id="buildingName" name="buildingName" style="width:35px; height:15px;"/>
					<input id="inputbutton" type="submit" value="查询"/>
					&nbsp;&nbsp;&nbsp;&nbsp;
				</form>
			</div>
		</span>
		<table id="maintable" width=980px border="1" align="center" bordercolor="#dddddd" cellpadding="0" cellspacing="0">
		  <tr>
			<td width="3%"  class="tablehead">序号</td>
			<td width="7%" class="tablehead">用户名</td>
			<td width="10%" class="tablehead">联系方式</td>
			<td width="10%" class="tablehead">房号</td>
			<td width="6%" class="tablehead">燃气表状态</td>					
			<td width="7%" class="tablehead">燃气表控制</td>
		  </tr>
		  <c:forEach items="${customers}" var="item" varStatus="status"> 
		  <tr class="tablerow">
			<td class="tablecontent">${status.count}</td>
			<td class="tablecontent">${item.customerName}</td>
			<td class="tablecontent">${item.customerPhone}</td>
			<td class="tablecontent">${item.addressLayer}层${item.addressRoom}室</td>
			<td class="tablecontent">正常</td>						
			<td class="tablecontent"><input type="button" value="关闭" onclick="if(this.value=='打开') this.value='关闭'; else this.value='打开'"  style="width:40px;font-size:12px;"/></td>
		  </tr> 
		  </c:forEach>		  
		  
		 </table>	
		<table width=980px align="center" border="0" cellspacing="0" cellpadding="0">
		  <tr>
			<td width="25%" height="29" nowrap="nowrap">
				<span class="STYLE1">&nbsp;共<strong>&nbsp;${countCustomers} &nbsp;</strong>条纪录，当前第<strong>&nbsp;${currentPage}/${pages}&nbsp;</strong>页</span>
			</td>
			<td width="75%" valign="top" class="STYLE1">
				<div align="right">
				  <table width="200" height="20" border="0" cellpadding="0" cellspacing="0">
					<tr>
				  	 <c:choose>
					    <c:when test="${currentPage == 1 && currentPage == pages}">
						  <td width="62" height="28" valign="middle"><div align="right">
						  		<img class="imagebuttonhide" src="/gas-webapp//images/first.gif"width="37" height="15" /></div>
						  </td>
						  <td width="50" height="28" valign="middle"><div align="right">
						  		<img class="imagebuttonhide" src="/gas-webapp//images/back.gif" width="43" height="15" /></div>
						  </td>
						  <td width="54" height="28" valign="middle"><div align="right">
						  		<img class="imagebuttonhide" src="/gas-webapp//images/next.gif" width="43" height="15" /></div>
						  </td>
						  <td width="49" height="28" valign="middle"><div align="right">
						  		<img class="imagebuttonhide" src="/gas-webapp//images/last.gif" width="37" height="15" /></div>
						  </td>
					    </c:when>
					    <c:when test="${currentPage == 1 && currentPage != pages}">
						  <td width="62" height="28" valign="middle"><div align="right">
						  		<img class="imagebuttonhide" src="/gas-webapp//images/first.gif"width="37" height="15" /></div>
						  </td>
						  <td width="50" height="28" valign="middle"><div align="right">
						  		<img class="imagebuttonhide" src="/gas-webapp//images/back.gif" width="43" height="15" /></div>
						  </td>
						  <td width="54" height="28" valign="middle"><div align="right">
						  		<a href="/gas-webapp/viewcustomers/<%=userGrade %>/${currentArea}/${currentBuilding}/${currentPage}"><img class="imagebutton" src="/gas-webapp//images/next.gif" width="43" height="15" /></a></div>
						  </td>
						  <td width="49" height="28" valign="middle"><div align="right">
						  		<a href="/gas-webapp/viewcustomers/<%=userGrade %>/${currentArea}/${currentBuilding}/${pages-1}"><img class="imagebutton" src="/gas-webapp//images/last.gif" width="37" height="15" /></a></div>
						  </td>
					    </c:when>
					    <c:when test="${currentPage > 1 && currentPage < pages}">
						  <td width="62" height="28" valign="middle"><div align="right">
						  		<a href="/gas-webapp/viewcustomers/<%=userGrade %>/${currentArea}/${currentBuilding}/0"><img class="imagebutton" src="/gas-webapp//images/first.gif"width="37" height="15" /></a></div>
						  </td>
						  <td width="50" height="28" valign="middle"><div align="right">
						  		<a href="/gas-webapp/viewcustomers/<%=userGrade %>/${currentArea}/${currentBuilding}/${currentPage-2}"><img class="imagebutton" src="/gas-webapp/images/back.gif" width="43" height="15" /></a></div>
						  </td>
						  <td width="54" height="28" valign="middle"><div align="right">
						  		<a href="/gas-webapp/viewcustomers/<%=userGrade %>/${currentArea}/${currentBuilding}/${currentPage}"><img class="imagebutton" src="/gas-webapp//images/next.gif" width="43" height="15" /></a></div>
						  </td>
						  <td width="49" height="28" valign="middle"><div align="right">
						  		<a href="/gas-webapp/viewcustomers/<%=userGrade %>/${currentArea}/${currentBuilding}/${pages-1}"><img class="imagebutton" src="/gas-webapp//images/last.gif" width="37" height="15" /></a></div>
						  </td>
					    </c:when>
					    <c:otherwise>
						  <td width="62" height="28" valign="middle"><div align="right">
						  		<a href="/gas-webapp/viewcustomers/<%=userGrade %>/${currentArea}/${currentBuilding}/0"/><img class="imagebutton" src="/gas-webapp//images/first.gif" width="43" height="15" /></a></div>
						  </td>
						  <td width="50" height="28" valign="middle"><div align="right">
						  		<a href="/gas-webapp/viewcustomers/<%=userGrade %>/${currentArea}/${currentBuilding}/${currentPage-2}"><img class="imagebutton" src="/gas-webapp//images/back.gif" width="43" height="15" /></a></div>
						  </td>
						  <td width="54" height="28" valign="middle"><div align="right">
						  		<img class="imagebuttonhide" src="/gas-webapp//images/next.gif" width="43" height="15" /></div>
						  </td>
						  <td width="49" height="28" valign="middle"><div align="right">
						  		<img class="imagebuttonhide" src="/gas-webapp//images/last.gif" width="37" height="15" /></div>
						  </td>
					    </c:otherwise>
					 </c:choose>
			      	</tr>
				  </table>
				</div>
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
var arr1=str.split(",");
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
