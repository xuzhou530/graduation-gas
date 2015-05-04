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
		<div class="status-title">系统用户管理</div>
		<div style="clear:both;"></div>
	</div>	
	<div id="datalist">
	<span style="text-align:center">
		系统用户一览表
	</span>
	
	<table id="maintable">
	  <tr>
		<td width="10%"  class="tablehead">账号名称</td>
		<td width="10%" class="tablehead">账号权限</td>
		<td width="10%" class="tablehead">账号状态</td>
		<td width="10%" class="tablehead">真实姓名</td>
		<td width="10%" class="tablehead">联系方式</td>
		<td width="10%" class="tablehead">注册时间</td>		
		<td width="10%" class="tablehead">操作</td>
	  </tr>

	  <tr class="tablerow">
		<td class="tablecontent">vyoung</td>
		<td class="tablecontent">利州区</td>
		<td class="tablecontent">启用</td>
		<td class="tablecontent">余扬</td>
		<td class="tablecontent">13518198078</td>
		<td class="tablecontent">2015-1-1 12:00:00</td>		
		<td class="tablecontent">删除</td>
	  </tr> 
	  
	  <tr class="tablerow">
		<td class="tablecontent">reking</td>
		<td class="tablecontent">旺苍县</td>
		<td class="tablecontent">启用</td>
		<td class="tablecontent">陈瑞钦</td>
		<td class="tablecontent">18510238078</td>
		<td class="tablecontent">2015-3-1 12:00:00</td>		
		<td class="tablecontent">删除</td>
	  </tr> 

 	  <tr class="tablerow">
		<td class="tablecontent">ljkai</td>
		<td class="tablecontent">昭化区</td>
		<td class="tablecontent">启用</td>
		<td class="tablecontent">刘俊</td>
		<td class="tablecontent">13810028078</td>
		<td class="tablecontent">2015-2-1 12:00:00</td>		
		<td class="tablecontent">删除</td>
	  </tr>
	 </table>
	 
	 
	</div>
</div>