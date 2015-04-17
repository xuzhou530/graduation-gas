<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  

<div id="content">
	<div class="addtitle">住户管理——所有小区</div>	
	<div id="datalist">
		<span>
			<div id="image">
				<image src="/gas/images/text.png" width=20px height=20px/>
			</div>
			小区列表&nbsp;
		</span>
		<table id="maintable">
		<tr>
			<td width="3%"  class="tablehead">序号</td>
			<td width="8%" class="tablehead">区县名</td>
			<td width="9%" class="tablehead">小区名</td>
			<td width="10%" class="tablehead">小区地址</td>
			<td width="10%" class="tablehead">小区规模</td>
			<td width="10%" class="tablehead">小区住户数</td>
			<td width="7%" class="tablehead">操作</td>
		</tr>
		<c:forEach items="${addresses}" var="item" varStatus="status"> 
		  <tr class="tablerow">
			<td class="tablecontent">${status.count}</td>
			<td class="tablecontent">${item.addressDistrict}</td>
			<td class="tablecontent">${item.addressArea}</td>
			<td class="tablecontent">${item.addressLocation}</td>
			<td class="tablecontent">${item.addressBuildings}栋</td>
			<td class="tablecontent">${item.addressCustomers}户</td>
			<td class="tablecontent"><img src="/gas/images/remove.png">&nbsp;<a href="/gas/deleteAddress/${item.addressId}">删除</a></td>
		  </tr>
		 </c:forEach>
		 </table>	
		<br/>
	</div>
</div>