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
		<div class="status-title">日志管理</div>
		<div style="clear:both;"></div>
	</div>	
	<div style="height:50px;">
		<ul class="condition" style="margin-left:300px;">
			<li>起止时间：<input type="text" class="text-box"/>&nbsp;至</li>
			<li>截至时间：
				<input type="text" class="text-box"/>
				<span style="margin-left:-5px;"><input type="submit" class="query-btn" value="查询"/></span>
			</li>
		</ul>
	</div>
	
	<div id="datalist">
	
	<span style="text-align:center">
		历史事件记录
	</span>
	
	<table id="maintable">
	  <tr>
		<td width="10%"  class="tablehead">编号</td>
		<td width="20%" class="tablehead">操作员</td>
		<td width="15%" class="tablehead">操作员权限</td>
		<td width="25%" class="tablehead">操作内容</td>
		<td width="25%" class="tablehead">操作时间</td>
	  </tr>
	  <c:forEach items="${logs}" var="item" varStatus="status">  
	  <tr class="tablerow">
		<td class="tablecontent">${status.count}</td>
		<td class="tablecontent">${item.operator}</td>
		<td class="tablecontent">${item.grade}</td>
		<td class="tablecontent">${item.operateAction}</td>
		<td class="tablecontent">${item.operateTime}</td>
	  </tr> 
	  </c:forEach>
	 </table>
	</div>
</div>