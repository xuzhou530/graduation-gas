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
		<td width="20%" class="tablehead">发生时间</td>
		<td width="15%" class="tablehead">账号名称</td>
		<td width="25%" class="tablehead">内容</td>
	  </tr>

	  <tr class="tablerow">
		<td class="tablecontent">1</td>
		<td class="tablecontent">2015-3-1 12:00:00</td>
		<td class="tablecontent">vyoung</td>
		<td class="tablecontent">关断燃气阀门</td>
	  </tr> 
	  
	  <tr class="tablerow">
		<td class="tablecontent">2</td>
		<td class="tablecontent">2015-3-1 13:00:00</td>
		<td class="tablecontent">vyoung</td>
		<td class="tablecontent">下发采集指令</td>
	  </tr> 
	
		  <tr class="tablerow">
		<td class="tablecontent">3</td>
		<td class="tablecontent">2015-3-1 14:00:00</td>
		<td class="tablecontent">vyoung</td>
		<td class="tablecontent">设定系统参数</td>
	  </tr>   
	 </table>
	 
	 
	</div>
</div>