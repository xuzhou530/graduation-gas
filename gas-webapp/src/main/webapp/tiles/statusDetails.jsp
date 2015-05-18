<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.young.gas.beans.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  

<%
	User user=(User)session.getAttribute("user");
	String[] districts={"系统管理员","利州区","昭化区","朝天区","旺苍县","青川县","剑阁县","苍溪县"};	
	int userGrade=user.getUserGrade();
%>

<div>
	<div class="addtitle">
		<div class="status-title">运营管理——抄表统计</div>
		<div style="clear:both;"></div>
	</div>
	<div id="datalist">
	<span>
		<div id="image">
			<image src="/gas/images/311.gif"/>
		</div>
		${currentDistrict}利州区&nbsp;
	</span>
	<div style="text-align:center;margin-top:20px">
		<Strong>漏抄读详情表 </Strong>
	</div>
	
	<table id="maintable">
	  <tr >
		<td width="7%"  class="tablehead">编号</td>
		<td width="15%" class="tablehead">小区名</td>
		<td width="15%" class="tablehead">住户名</td>
		<td width="15%" class="tablehead">楼号</td>
		<td width="15%" class="tablehead">房号</td>
		<td width="15%" class="tablehead">采集表编号</td>
	  </tr>

	  <tr class="tablerow">
		<td class="tablecontent">1</td>
		<td class="tablecontent">黄金小区</td>
		<td class="tablecontent">刘军</td>
		<td class="tablecontent">1栋</td>
		<td class="tablecontent">404室</td>
		<td class="tablecontent">0213021404</td>
	  </tr> 
	  
	  <tr class="tablerow">
		<td class="tablecontent">2</td>
		<td class="tablecontent">黄金小区</td>
		<td class="tablecontent">范作伟</td>
		<td class="tablecontent">1栋</td>
		<td class="tablecontent">502室</td>
		<td class="tablecontent">0213021502</td>
	  </tr> 	  
	 </table>
	<br/><br/>			
	</div>
</div>