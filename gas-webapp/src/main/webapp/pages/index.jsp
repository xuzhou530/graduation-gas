<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.young.gas.beans.User" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>城市燃气远程监控系统首页</title>
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
</head>
<body>

<%@include file="menu.jsp" %>
<%@include file="leftmenu.html" %>
<div id="map" class="rightcontent">
	<img id="mappic" src="/gas/images/gy.jpg" onclick="clickme()"/>
</div>

<div id="demo" class="bottomtip">
  <div class="tip">
    <div id="demo1">
      <ul>
		<li>提示：利州区和苑小区有10户用气量异常！利州区常发豪郡有20户费用不足！</li>
      </ul>
    </div>
    <div id="demo2"></div>
  </div>
</div>

</body>
</html>
<script type="text/javascript">

var demo = document.getElementById("demo");
var demo1 = document.getElementById("demo1");
var demo2 = document.getElementById("demo2");
demo2.innerHTML=document.getElementById("demo1").innerHTML;

function Marquee(){
	if(demo.scrollLeft-demo2.offsetWidth>=0){
		demo.scrollLeft-=demo1.offsetWidth;
	}
	else{
		demo.scrollLeft++;
	}
}

var myvar=setInterval(Marquee,30);
demo.onmouseout=function (){myvar=setInterval(Marquee,30);}
demo.onmouseover=function(){clearInterval(myvar);}

function clickme(){
	document.getElementById("mappic").src = "/gas/images/lzhou.png";
	document.getElementById("mappic").onclick = function(){
		window.location.href="/gas/viewwarning/1"
	}
}
</script>
