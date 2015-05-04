<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.young.gas.beans.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<link href="/gas/css/basic.css" type="text/css" rel="stylesheet" />
<script type="text/javascript">
		// Run capabilities test
		enhance({
			loadScripts: [
				'/gas/js/excanvas.js',
				'/gas/js/jquery.min.js',
				'/gas/js/visualize.jQuery.js',
				'/gas/js/line.js'
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
		<div class="status-title">运营管理——抄表统计</div>
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
				小区：<select id="areaName" name="areaName" style="width:95px; height:25px;">
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
	
	<table style="display:none">
	  <caption>
	  住户用气量统计(单位：立方)
	  </caption>
	  <thead>
	    <tr>
	      <td></td>
	      <th scope="col">14/1/5</th>
	      <th scope="col">14/2/5</th>
	      <th scope="col">14/3/5</th>
	      <th scope="col">14/4/5</th>
	      <th scope="col">14/5/5</th>
	      <th scope="col">14/6/5</th>
	      <th scope="col">14/7/5</th>
	      <th scope="col">14/8/5</th>
	      <th scope="col">14/9/5</th>
	      <th scope="col">14/10/5</th>
	      <th scope="col">14/11/5</th>
	      <th scope="col">14/12/5</th>
	    </tr>
	  </thead>
	  <tbody>
	    <tr>
	      <th scope="row">余扬</th>
	      <td>45.5</td>
	      <td>67.9</td>
	      <td>34.3</td>
	      <td>38.9</td>
	      <td>66.4</td>
	      <td>33.6</td>
	      <td>68.0</td>
	      <td>45.1</td>
	      <td>55.5</td>
	      <td>34.2</td>
	      <td>10.2</td>
	      <td>69.0</td>
	    </tr>
	  </tbody>
	</table>	
	<br/><br/>							
	</div>
</div>