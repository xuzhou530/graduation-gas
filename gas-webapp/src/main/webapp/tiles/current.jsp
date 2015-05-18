<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.young.gas.beans.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%
	User user=(User)session.getAttribute("user");
	String[] districts={"系统管理员","利州区","昭化区","朝天区","旺苍县","青川县","剑阁县","苍溪县"};	
	int userGrade=user.getUserGrade();
%>
<link href="/gas/css/pages.css" type="text/css" rel="stylesheet" />
<div>
	<div class="addtitle">
		<div class="status-title">最新数据</div>
		<div style="clear:both;"></div>
	</div>	
	<div id="datalist">
	<span>
		<div id="image">
			<image src="/gas/images/311.gif"/>
		</div>
		${currentDistrict}&nbsp;
		<font class="STYLE1">&gt;</font>&nbsp;${currentArea}&nbsp;
		<font class="STYLE1">&gt;&nbsp;</font>${currentBuilding}栋
		<div id="search">
			<form id="searchform" action="/gas/searchgas/<%=userGrade%>" method="post" onsubmit="return checkform()">
				小区：<select id="areaName" name="areaName" style="width:95px; height:25px;">
					<option value =0>-请选择-</option>
				</select>&nbsp;
				楼号：<input type="text" id="buildingName" name="buildingName" style="width:35px; height:15px;"/>
				<input id="inputbutton" type="submit" value="查询"/>
				&nbsp;&nbsp;&nbsp;&nbsp;
			</form>
		</div>
	</span>
	<table id="maintable">
	  <tr>
		<td width="4%"  class="tablehead">序号</td>
		<td width="8%" class="tablehead">住户名</td>
		<td width="5%" class="tablehead">房号</td>
		<td width="10%" class="tablehead">当前燃气值(m<SUP>3</SUP>)</td>
		<td width="10%" class="tablehead">周期内用量(m<SUP>3</SUP>)</td>
		<td width="8%" class="tablehead">账户余额(元)</td>		
		<td width="7%" class="tablehead">住户编号</td>
		<td width="12%" class="tablehead">采集时间</td>
		<td width="7%" class="tablehead">历史记录</td>
	  </tr>
	  <c:forEach items="${gases}" var="item" varStatus="status">  
		  <tr class="tablerow">
			<td class="tablecontent">${status.count}</td>
			<td class="tablecontent">${item.customer.customerName}</td>
			<td class="tablecontent">${item.customer.addressLayer}0${item.customer.addressRoom}室</td>
			<td class="tablecontent">${item.gasValue}.0000</td>
			<td class="tablecontent">${item.gasValue-item.previousValue}.0000</td>
			<td class="tablecontent">${item.customer.money}.0</td>		
			<td class="tablecontent">${item.customer.customerId}</td>
			<td class="tablecontent">${item.collectTime}</td>
			<td class="tablecontent"><a href="/gas/viewdetailgas/${item.customer.customerId}"><span style="color:#3A5FCD;">查看</span></a></td>
		  </tr> 
	 </c:forEach>
	 </table>
	<div id="digg"></div>					
	</div>
</div>
<script type="text/javascript">
var select = document.getElementById('areaName');
select.options.length=0;
select.options.add(new Option('-请选择-','0'));
var areas = '${areaStr}';
var strs= new Array(); //定义一数组 
strs=areas.split(","); //字符分割 
for (i = 0; i < strs.length; i++) 
{ 
	select.options.add(new Option(strs[i],strs[i]));
}
</script>
<script type="text/javascript">
var pages = ${pages};
var current = ${currentPage};
var currentNode;

var left = document.createElement('a');
if( current> 1){
	left.href = '/gas/viewgas/'+'${currentDistrict}/'+'${currentArea}/'+'${currentBuilding}/'+(current-2);
}
left.text = "<上一页";
document.getElementById("digg").appendChild(left);

for(var i = 1; i <= pages; i++){
	var child = document.createElement('a');
	child.text = i;
	child.href = "/gas/viewgas/"+'${currentDistrict}/'+'${currentArea}/'+'${currentBuilding}/'+(i-1);
	if(i==current){
		child.className = "currentclick";
		currentNode = child;
	}
	document.getElementById("digg").appendChild(child);	
}

var right = document.createElement('a');
if( current != pages){
	right.href = "/gas/viewgas/"+'${currentDistrict}/'+'${currentArea}/'+'${currentBuilding}/'+(current);
}
right.text = "下一页>";
document.getElementById("digg").appendChild(right);
</script>