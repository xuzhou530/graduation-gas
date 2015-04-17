<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.young.gas.beans.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  

<%
	User user=(User)session.getAttribute("user");
	String[] districts={"系统管理员","利州区","昭化区","朝天区","旺苍县","青川县","剑阁县","苍溪县"};	
	int userGrade=user.getUserGrade();
%>

<div>
	<div class="addtitle">费用变动</div>	
	<div id="datalist">
	<span>
		<div id="image">
			<image src="/gas/images/money.png" width=25px height=25px/>
		</div>
		${currentDistrict}&nbsp;
		<font class="STYLE1">&gt;</font>&nbsp;${currentArea}&nbsp;
		<font class="STYLE1">&gt;&nbsp;</font>${currentBuilding}栋
		<div id="search">
			<form id="searchform" action="/gas/searchpay/<%=userGrade%>" method="post" onsubmit="return checkform()">
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