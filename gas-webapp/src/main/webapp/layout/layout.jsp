<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>主页面</title>
<link href="/gas/css/current.css" rel="stylesheet" type="text/css"/>
<link href="/gas/css/style.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="/gas/js/jquery.js"></script>
<script type="text/javascript" src="/gas/js/script.js" ></script>
<script type="text/javascript" src="/gas/js/menu.js"></script>
<script type="text/javascript" src="/gas/js/enhance.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$(".div2").click(function(){ 
		$(this).next("div").slideToggle("slow").siblings(".div3:visible").slideUp("slow");
	});
});
</script>
<style type="text/css">
body{
width:100%;
height:100%;
margin:0;
}
#myframe{
width:100%;
height:100%;
}
#naviblock{
width:100%;
height:88px;
background-color:#333333;
}
#menublock{
float:left;
width:200px;
height:100%;
border-right:1px solid #cccccc;
}
#contentblock{
margin-left:210px;
height:100%;
}
</style>
</head>
<body>
<div id="myframe">
	<div id="naviblock">
		<tiles:insertAttribute name="header" />  
	</div>
	<div id="menublock">
		<tiles:insertAttribute name="menu" />  
	</div>
	<div id="contentblock">
		<tiles:insertAttribute name="body" />  
	</div>
</div>
</body>
</html>