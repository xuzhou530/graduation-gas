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
		<div class="status-title">新用户审核</div>
		<div style="clear:both;"></div>
	</div>	
	<div id="datalist">
	<span style="text-align:center">
		新申请用户
	</span>
	
	<table id="maintable">
	<tr>
		<td width="5%" class="tablehead">序号</td>
		<td width="10%" class="tablehead">用户名称</td>
		<td width="10%" class="tablehead">联系方式</td>
		<td width="10%" class="tablehead">注册邮箱</td>
		<td width="10%" class="tablehead">用户权限</td>
		<td width="10%" class="tablehead">账号状态</td>
		<td width="10%" class="tablehead">操作</td>
	  </tr>
	<c:forEach items="${users}" var="item" varStatus="status">  
	  <tr>
	  	<td class="tablecontent">${status.count}</td>
		<td class="tablecontent">${item.userName}</td>
		<td class="tablecontent">${item.userPhone}</td>
		<td class="tablecontent">${item.userEmail}</td>
		<td class="tablecontent">${item.authority}</td>
		<td class="tablecontent">${item.currentSta}</td>
		<td class="tablecontent">
		<a href="/gas/passUser/${item.userName}" style="margin-right:10px;"><span style="color:blue;">通过</span></a>
		<a href="/gas/rejectUser/${item.userName}"><span style="color:red;">拒绝</span></a></td>
	  </tr>
	</c:forEach>
	</table>
	</div>
</div>
