<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ page import="com.young.gas.beans.User" %>
<%@ page import="java.util.List"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>燃气远程监控系统告警</title>
<link rel="stylesheet" type="text/css" href="/gas-webapp/css/current.css"/>
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
	<p id="status">当前位置：<span>告警数据&nbsp;</span></p>
	<div id="datalist">
	<span>
		<div id="image"><image src="/gas-webapp/images/warning.png"/></div>
		${currentDistrict}&nbsp;
		<font class="STYLE1">&gt;</font>&nbsp;${currentArea}&nbsp;
		<font class="STYLE1">&gt;&nbsp;</font>${currentBuilding}栋
		<div id="search">
			<form id="searchform" action="/gas-webapp/searchwarning/<%=userGrade%>" method="post" onsubmit="return checkform()">
				小区：<select id="areaName" name="areaName" style="width:95px; height:25px;">
					<option value =0>-请选择-</option>
				</select>&nbsp;
				楼号：<input type="text" id="buildingName" name="buildingName" style="width:35px; height:15px;"/>
				<input id="inputbutton" type="submit" value="查询"/>
				&nbsp;&nbsp;&nbsp;&nbsp;
			</form>
		</div>
	</span>
	
	<table id="maintable" width="980px" border="1" align="center" bordercolor="#dddddd" cellpadding="0" cellspacing="0" onmouseover="changeto()"  onmouseout="changeback()">
	  <tr>
		<td width="4%"  class="tablehead">序号</td>
		<td width="8%" class="tablehead">用户名</td>
		<td width="8%" class="tablehead">房号</td>		
		<td width="8%" class="tablehead">当前燃气值(m<SUP>3</SUP>)</td>
		<td width="8%" class="tablehead">账户余额(元)</td>
		<td width="7%" class="tablehead">联系方式</td>
		<td width="12%" class="tablehead">采集时间</td>
		<td width="6%" class="tablehead">燃气表状态</td>	
		<td width="7%" class="tablehead">燃气表控制</td>
	  </tr>
  	  <c:forEach items="${gases}" var="item" varStatus="status">  
		  <tr class="tablerow">
			<td class="tablecontent">${status.count}</td>
			<td class="tablecontent">${item.customer.customerName}</td>
			<td class="tablecontent">${item.customer.addressLayer}0${item.customer.addressLayer}室</td>
			<td class="tablecontent">${item.gasValue}</td>
			<td class="tablecontent"><font color="red">${item.customer.money}</font></td>
			<td class="tablecontent">${item.customer.customerPhone}</td>
 			<td class="tablecontent">${item.collectTime}</td>
 			<td class="tablecontent">正常</td>	
			<td class="tablecontent"><input type="button" value="关闭" onclick="if(this.value=='打开') this.value='关闭'; else this.value='打开'"  style="width:40px;font-size:12px;"/></td>
		  </tr> 
	  </c:forEach>
	  </table>

	<table width=980px border="0" cellspacing="0" cellpadding="0">
	  <tr>
		<td width="25%" height="29" nowrap="nowrap">
			<span class="STYLE1">&nbsp;共<strong>&nbsp;${countCustomers}&nbsp;</strong>条纪录，当前第<strong>&nbsp;${currentPage}/${pages}&nbsp;</strong>页</span>
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
					  		<a href="/gas-webapp/viewwarning/<%=userGrade %>/${currentArea}/${currentBuilding}/${currentPage}"><img class="imagebutton" src="/gas-webapp//images/next.gif" width="43" height="15" /></a></div>
					  </td>
					  <td width="49" height="28" valign="middle"><div align="right">
					  		<a href="/gas-webapp/viewwarning/<%=userGrade %>/${currentArea}/${currentBuilding}/${pages-1}"><img class="imagebutton" src="/gas-webapp//images/last.gif" width="37" height="15" /></a></div>
					  </td>
				    </c:when>
				    <c:when test="${currentPage > 1 && currentPage < pages}">
					  <td width="62" height="28" valign="middle"><div align="right">
					  		<a href="/gas-webapp/viewwarning/<%=userGrade %>/${currentArea}/${currentBuilding}/0"><img class="imagebutton" src="/gas-webapp//images/first.gif"width="37" height="15" /></a></div>
					  </td>
					  <td width="50" height="28" valign="middle"><div align="right">
					  		<a href="/gas-webapp/viewwarning/<%=userGrade %>/${currentArea}/${currentBuilding}/${currentPage-2}"><img class="imagebutton" src="/gas-webapp/images/back.gif" width="43" height="15" /></a></div>
					  </td>
					  <td width="54" height="28" valign="middle"><div align="right">
					  		<a href="/gas-webapp/viewwarning/<%=userGrade %>/${currentArea}/${currentBuilding}/${currentPage}"><img class="imagebutton" src="/gas-webapp//images/next.gif" width="43" height="15" /></a></div>
					  </td>
					  <td width="49" height="28" valign="middle"><div align="right">
					  		<a href="/gas-webapp/viewwarning/<%=userGrade %>/${currentArea}/${currentBuilding}/${pages-1}"><img class="imagebutton" src="/gas-webapp//images/last.gif" width="37" height="15" /></a></div>
					  </td>
				    </c:when>
				    <c:otherwise>
					  <td width="62" height="28" valign="middle"><div align="right">
					  		<a href="/gas-webapp/viewwarning/<%=userGrade %>/${currentArea}/${currentBuilding}/0"/><img class="imagebutton" src="/gas-webapp//images/first.gif" width="43" height="15" /></a></div>
					  </td>
					  <td width="50" height="28" valign="middle"><div align="right">
					  		<a href="/gas-webapp/viewwarning/<%=userGrade %>/${currentArea}/${currentBuilding}/${currentPage-2}"><img class="imagebutton" src="/gas-webapp//images/back.gif" width="43" height="15" /></a></div>
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
</script>