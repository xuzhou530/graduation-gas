<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%> 
<%@ page import="com.young.gas.beans.User" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>燃气远程监控系统小区</title>
<link href="/gas/css/current.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="/gas/js/menu.js"></script>
<script type="text/javascript" src="/gas/js/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$(".div2").click(function(){ 
		$(this).next("div").slideToggle("slow").siblings(".div3:visible").slideUp("slow");
	});
});
</script>
<script language="JavaScript" type="text/JavaScript">
function previous(){
	document.getElementById('second').className="line line2";
	document.getElementById('third').className="line line2";
	document.getElementById('table1').style.display="block";
	document.getElementById('table2').style.display="none";
	document.getElementById('btn-next').disabled = false;
}
function next(){
	document.getElementById('second').className = "line line1";
	document.getElementById('third').className = "line line1";
	document.getElementById('table1').style.display = "none";
	document.getElementById('table2').style.display = "block";
	document.getElementById('btn-next').disabled = true;
}
function complete(){
	document.getElementById('forth').className="line line1";
	document.getElementById('btn-next').disabled = true;
	document.getElementById('btn-previous').disabled = true;
}
</script>
<style type="text/css">
#step{
width:750px;
height:30px;
margin-left:200px;
margin-top:50px;
}
.block{
float:left;
}
.number{
border-radius:100%;
border:4px solid #5293c4;
width:30px;
height:30px;
text-align:center;
line-height:30px;
font-size: 15px;
color: #546474;
font-family: "\5FAE\8F6F\96C5\9ED1",sans-serif,Arial,"\5b8b\4f53",sans-serif;
}
.line{
float:left;
width:150px;
height:8px;
margin-top:15px;
}
.line1{
background-color:#5293c4;
}
.line2{
background-color:#dddddd;
}
.desc{
font-size:12px;
color: #546474;
font-family: "\5FAE\8F6F\96C5\9ED1",sans-serif,Arial,"\5b8b\4f53",sans-serif;
}
/*******************************/
#write{
width:800px;
height:400px;
margin-left:200px;
}
.txt{
width:200px;
height:30px;
font-family: "\5FAE\8F6F\96C5\9ED1",sans-serif,Arial,"\5b8b\4f53",sans-serif;
color: #393939;
font-size: 16px;
}
.hid{
display:none;
}
table{
width:100%;
border:0;
cellpadding:0;
cellspacing:0;
align:left;
bordercolor:#CCCCCC;
}
#table1{
position:absolute;
top:40%;
}
/******************************/
#move{
width:300px;
height:100px;
margin-left:400px;
}
.btn{
border-radius:5px;
border:1px solid #cccccc;
width:80px;
height:35px;
font-size:15px;
background-color:#146ebe;
color: #FFFFFF;
font-family: "\5FAE\8F6F\96C5\9ED1",sans-serif,Arial,"\5b8b\4f53",sans-serif;
}
.btn-compelete{
background-color:#669900;
}
</style>
</head>
<body>
<%
	User user=(User)session.getAttribute("user");
	String[] districts={"系统管理员","利州区","昭化区","朝天区","旺苍县","青川县","剑阁县","苍溪县"};	
	int userGrade=user.getUserGrade();
%>
<%@include file="menu.jsp" %>
<%@include file="leftmenu.html" %>

<div id="content" class="rightcontent">
	<h4 class="addtitle">小区信息—添加</h4>		
	<div id="step">
		<div class="block">
			<div class="number">1</div>
			<div class="desc">第一步</div>
		</div>
		<div class="line line1" id="first"></div>
		<div class="line line2" id="second"></div>
		<div class="block">
			<div class="number">2</div>
			<div class="desc">第二步</div>
		</div>
		<div class="line line2" id="third"></div>
		<div class="line line2" id="forth"></div>
		<div class="block">
			<div class="number">3</div>
		<div class="desc">完成</div>
		</div>
	</div>
	<div id="write">
		<div id="table1">
			<table>
				<tr ><td class="title">区县名:&nbsp;&nbsp;</td><td>
					<select name="districtName" class="txt" >
							<option value =-1>-请选择-</option>
							<option value =0>利州区</option>
							<option value =1>昭化区</option>
							<option value=2>朝天区</option>
							<option value=3>旺苍县</option>
							<option value=4>青川县</option>
							<option value=5>剑阁县</option>	
							<option value=6>苍溪县</option>	
						</select>
					</td>
				</tr>
				<tr><td class="title">小区名:&nbsp;&nbsp;</td><td><input class="txt" type="text" name="areaName"/></td></tr>
			</table>
		</div>
		<div id="table2" class="hid">
			<table>
				<tr ><td class="title">小区地址:&nbsp;&nbsp;</td><td><input class="txt" type="text" name="areaLocation"/></td></tr>
				<tr><td class="title">建筑数量:&nbsp;&nbsp;</td><td><input class="txt" type="text" name="buildingNumbers"/></td></tr>
				<tr><td class="title">住户数量:&nbsp;&nbsp;</td><td><input class="txt" type="text" name="customerNumbers"/></td></tr>
				<tr><td class="title">小区描述:&nbsp;&nbsp;</td><td><textarea name="areaDescribe" rows="8" cols="37"></textarea></td></tr>
			</table>
		</div>
	</div>
	<div id="move">
		<input class="btn" id="btn-previous" type="button" value="上一步" onclick="previous()"/>
		<input class="btn" id="btn-next" type="button" value="下一步" onclick="next()"/>
		<input class="btn btn-compelete" type="button" value="完成" onclick="complete()"/>
	</div>
</div>
</body>
</html>