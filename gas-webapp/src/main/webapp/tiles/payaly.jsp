<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.young.gas.beans.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  

<script type="text/javascript">
	// Run capabilities test
	enhance({
		loadScripts: [
			'/gas/js/excanvas.js',
			'/gas/js/jquery.min.js',
			'/gas/js/visualize.jQuery.js',
			'/gas/js/bar.js'
		],
		loadStyles: [
			'/gas/css/visualize.css',
			'/gas/css/visualize-dark.css'
		]	
	});   
</script>

<%
	User user=(User)session.getAttribute("user");
	String[] districts={"系统管理员","利州区","昭化区","朝天区","旺苍县","青川县","剑阁县","苍溪县"};	
	int userGrade=user.getUserGrade();
%>

<div id="content" class="rightcontent">
	<div class="addtitle">
		<div class="status-title">运营管理——缴费统计</div>
		<div style="clear:both;"></div>
	</div>	
	<div id="datalist">
	<span>
		<div id="image">
			<image src="/gas/images/money.png" width=25px height=25px/>
		</div>
		${currentDistrict}利州区&nbsp;
		<font class="STYLE1">&gt;</font>&nbsp;${currentArea}黄金小区&nbsp;
		<font class="STYLE1">&gt;&nbsp;</font>${currentBuilding}1栋&nbsp;
		<font class="STYLE1">&gt;&nbsp;</font>${currentBuilding}101室&nbsp;
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
	<div class="describe"></div>
	<div style="height:50px;margin-top:20px;font-size:17px">
		<ul class="condition" style="margin-left:300px;">
			<li>起止时间：<input type="text" class="text-box"/>&nbsp;至</li>
			<li>截至时间：
				<input type="text" class="text-box"/>
				<span style="margin-left:-5px;"><input type="submit" class="query-btn" value="查询"/></span>
			</li>
		</ul>
	</div>
	<table style="display:none">
	  <caption>
	  住户缴费统计(单位：元)
	  </caption>
	  <thead>
	    <tr>
	      <td></td>
	       <th scope="col">2014.1.3</th>
	      <th scope="col">2014.3.19</th>
	      <th scope="col">2014.5.2</th>
	      <th scope="col">2014.6.30</th>
	      <th scope="col">2014.8.1</th>
	      <th scope="col">2014.9.3</th>
	      <th scope="col">2014.11.1</th>
	      <th scope="col">2015.1.1</th>
	      <th scope="col">2015.2.10</th>
	      <th scope="col">2015.4.1</th>
	    </tr>
	  </thead>
	  <tbody>
	    <tr>
	      <th scope="row">余扬</th>
	      <td>200</td>
	      <td>100</td>
	      <td>100</td>
	      <td>200</td>
	      <td>150</td>
	      <td>200</td>
	      <td>100</td>
	      <td>100</td>
	      <td>200</td>
	      <td>100</td>
	    </tr>
	  </tbody>
	</table>
	<br/><br/>								
	</div>
</div>