<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.young.gas.beans.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>广元市燃气远程监控系统首页</title>
<link href="/gas-webapp/css/current.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="/gas-webapp/js/menu.js"></script>
<script type="text/javascript" src="/gas-webapp/js/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$(".div2").click(function(){ 
		$(this).next("div").slideToggle("slow").siblings(".div3:visible").slideUp("slow");
	});
});
</script>

<link href="../css/basic.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="../js/enhance.js"></script>
<script type="text/javascript">
		// Run capabilities test
		enhance({
			loadScripts: [
				'../js/excanvas.js',
				'../js/jquery.min.js',
				'../js/visualize.jQuery.js',
				'../js/line.js'
			],
			loadStyles: [
				'../css/visualize.css',
				'../css/visualize-dark.css'
			]	
		});   
</script>

</head>
<body>
<%
	User user=(User)session.getAttribute("user");
	String[] districts={"系统管理员","利州区","昭化区","朝天区","旺苍县","青川县","剑阁县","苍溪县"};	
	int userGrade=user.getUserGrade();
%>
<%@include file="menu.jsp" %>
<%@include file="leftmenu.html" %>

<div id="content" style="float:left;">
	<p id="status">当前位置：<span>运营管理&nbsp;&gt;用气量统计</span></p>	
	<div id="datalist">
	<span>
		<div id="image">
			<image src="/gas-webapp/images/money.png" width=25px height=25px/>
		</div>
		${currentDistrict}利州区&nbsp;
		<font class="STYLE1">&gt;</font>&nbsp;${currentArea}黄金小区&nbsp;
		<font class="STYLE1">&gt;&nbsp;</font>${currentBuilding}1栋
		<div id="search">
			<form id="searchform" action="/gas-webapp/searchpay/<%=userGrade%>" method="post" onsubmit="return checkform()">
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
	  住户用气量统计
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
</body>
</html>
<script type="text/javascript">
setInterval("document.getElementById('time').innerHTML=new Date().toLocaleString();",5);

var newSelect=document.getElementById("areaName"); 
newSelect.options.length=0; 
var op=document.createElement("option");
op.value=0;
op.innerHTML="-请选择-";
newSelect.appendChild(op);
//得到完成请求后返回的字串符
var str = "${areaStr}";
//根据返回的字符串为新创建的select节点添加option节点
var arr1 = str.split(",");
//alert(arr1);
for(var i=0;i<arr1.length;i++){
    var child=document.createElement("option");
    child.innerHTML=arr1[i];
    child.value=arr1[i];
    newSelect.appendChild(child);
}

function checkform(){
	var areaName=document.forms["searchform"]["areaName"];
	var buildingName=document.forms["searchform"]["buildingName"];
	if(areaName.value=="0")
	{
		alert("请选择小区");
		return false;
	}
	if(buildingName.value=="")
	{
		alert("请输入楼号");
		return false;
	}
	return true;	
}

var grade = "<%=userGrade%>";
if(grade != 0){
	var cls1 = 'd' + grade;
	var cls2 = 'dd' + grade;
	document.getElementById(cls1).onclick="return true";
	document.getElementById(cls2).onclick="return true";	
}
else{
	for(var i = 1; i <= 7; i++){
		var cls1 = 'd' + i;
		var cls2 = 'dd' + i;
		document.getElementById(cls1).onclick="return true";
		document.getElementById(cls2).onclick="return true";
	}
}

function forbid(){
	alert("您无操作权限");
	return false;
}
</script>
