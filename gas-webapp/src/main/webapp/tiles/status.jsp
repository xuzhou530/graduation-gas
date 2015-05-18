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
		<Strong>抄读统计表 </Strong>
		<p style="text-align:right;">抄读时间：2015-3-12 12:00:00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
	</div>
	
	<table id="maintable">
	  <tr >
		<td width="7%"  class="tablehead">编号</td>
		<td width="15%" class="tablehead">小区名</td>
		<td width="15%" class="tablehead">应抄读总数(单位：户)</td>
		<td width="15%" class="tablehead">实抄读总数(单位：户)</td>
		<td width="15%" class="tablehead">漏抄读总数(单位：户)</td>
		<td width="15%" class="tablehead">抄读成功率</td>
		<td width="10%" class="tablehead">操作</td>
	  </tr>

	  <tr class="tablerow">
		<td class="tablecontent">1</td>
		<td class="tablecontent">黄金小区</td>
		<td class="tablecontent">200</td>
		<td class="tablecontent">200</td>
		<td class="tablecontent">0</td>
		<td class="tablecontent">100%</td>
		<td class="tablecontent"><span style="color:blue">查看详情</span></td>
	  </tr> 
	  
	  <tr class="tablerow">
		<td class="tablecontent">2</td>
		<td class="tablecontent">和苑小区</td>
		<td class="tablecontent">200</td>
		<td class="tablecontent">200</td>
		<td class="tablecontent">0</td>
		<td class="tablecontent">100%</td>
		<td class="tablecontent"><span style="color:blue">查看详情</span></td>
	  </tr> 
	  <tr class="tablerow">
		<td class="tablecontent">3</td>
		<td class="tablecontent">东风小区</td>
		<td class="tablecontent">300</td>
		<td class="tablecontent">300</td>
		<td class="tablecontent">0</td>
		<td class="tablecontent">100%</td>
		<td class="tablecontent"><span style="color:blue">查看详情</span></td>
	  </tr> 
	  
	  <tr class="tablerow">
		<td class="tablecontent">4</td>
		<td class="tablecontent">常发豪郡</td>
		<td class="tablecontent">400</td>
		<td class="tablecontent">400</td>
		<td class="tablecontent">0</td>
		<td class="tablecontent">100%</td>
		<td class="tablecontent"><span style="color:blue">查看详情</span></td>
	  </tr> 
	  <tr class="tablerow">
		<td class="tablecontent">5</td>
		<td class="tablecontent">世纪之城</td>
		<td class="tablecontent">500</td>
		<td class="tablecontent">500</td>
		<td class="tablecontent">0</td>
		<td class="tablecontent">100%</td>
		<td class="tablecontent"><span style="color:blue">查看详情</span></td>
	  </tr> 
	  <tr class="tablerow">
		<td class="tablecontent">6</td>
		<td class="tablecontent">西郡兰庭</td>
		<td class="tablecontent">200</td>
		<td class="tablecontent">200</td>
		<td class="tablecontent">0</td>
		<td class="tablecontent">100%</td>
		<td class="tablecontent"><span style="color:blue">查看详情</span></td>
	  </tr> 
	  
	  <tr class="tablerow">
		<td class="tablecontent">7</td>
		<td class="tablecontent">智能小区</td>
		<td class="tablecontent">200</td>
		<td class="tablecontent">198</td>
		<td class="tablecontent">2</td>
		<td class="tablecontent">99%</td>
		<td class="tablecontent"><a href="/gas/statusDetails"><span style="color:red">查看详情</span></a></td>
	  </tr> 	  
	 </table>
	<br/><br/>			
	</div>
</div>