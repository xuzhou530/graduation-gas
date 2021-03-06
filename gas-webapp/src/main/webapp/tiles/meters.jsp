<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<link href="/gas/css/meters.css" type="text/css" rel="stylesheet" />
<link href="/gas/css/pages.css" type="text/css" rel="stylesheet" />

<!-- 弹窗的css与js-->
<link href="/gas/css/popup.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="/gas/js/popup.js"></script>

<div>
	<div class="addtitle">
		<div class="status-title">状态监测——${currentDistrict}>&nbsp;${currentArea}>&nbsp;${currentBuilding}栋</div>
		<div style="float:right;margin:5px 30px 0 0;">	
		<form id="searchform" action="/gas/searchMeter/${currentDistrict}" method="post" onsubmit="return checkform()">		
			<ul class="condition">
				<li>小区：<select id="areaName" name="areaName" style="width:95px; height:25px;">
							<option value =0>-请选择-</option></select></li>
				<li>楼号：
					<input name="buildingName" type="text" class="text-box"/>
					<span style="margin-left:-5px;"><input type="submit" class="query-btn" value="查询"/></span>
				</li>
			</ul>
		</form>
		</div>
		<div style="clear:both;"></div>
	</div>	
	
	<table style="width:1025px; height:490px;margin:0 auto 0 auto;">
	<tr>
		<c:forEach items="${gases}" var="item" varStatus="status" begin="0" end="3" > 
		<td>
			<div class="house">
				<div class="meter"></div>
				<div class="info">
					<ul>
						<li>房号：${item.customer.addressLayer}0${item.customer.addressRoom}室</li>
						<li>气量：${item.gasValue}.0000</li>
						<li>余额：
							<c:if test="${item.customer.money < 0 }">
								<span style="color:red">${item.customer.money}.0元</span>
							</c:if>
							<c:if test="${item.customer.money >= 0 }">
								<span>${item.customer.money}.0元</span>
							</c:if>
						</li>
						<li><div style="float:left;">状态：</div>
							<c:if test="${item.customer.status == 0 }">
								<div class="green-dot"></div>
							</c:if>
							<c:if test="${item.customer.status == 1 }">
								<div class="red-dot"></div>
							</c:if>
						</li>
					</ul>
				</div>
				<div class="control">
					<div class="buttons">
						<a class="open-button button" onclick="openMeter(${item.customer.customerId})">打开阀门</a>
						<a class="close-button button" onclick="closeMeter(${item.customer.customerId})">关闭阀门</a>
					</div>
				</div>
				<div style="clear:both"></div>
			</div>
		</td>
		</c:forEach>
	</tr>
	<tr>
		<c:forEach items="${gases}" var="item" varStatus="status" begin="4" end="7" > 
		<td>
			<div class="house">
				<div class="meter"></div>
				<div class="info">
					<ul>
						<li>房号：${item.customer.addressLayer}0${item.customer.addressRoom}室</li>
						<li>气量：${item.gasValue}.0000</li>
						<li>余额：
							<c:if test="${item.customer.money < 0 }">
								<span style="color:red">${item.customer.money}.0元</span>
							</c:if>
							<c:if test="${item.customer.money >= 0 }">
								<span>${item.customer.money}.0元</span>
							</c:if>
						</li>
						<li><div style="float:left;">状态：</div>
							<c:if test="${item.customer.status == 0 }">
								<div class="green-dot"></div>
							</c:if>
							<c:if test="${item.customer.status == 1 }">
								<div class="red-dot"></div>
							</c:if>
						</li>
					</ul>
				</div>
				<div class="control">
					<div class="buttons">
						<a class="open-button button" onclick="openMeter(${item.customer.customerId})">打开阀门</a>
						<a class="close-button button" onclick="closeMeter(${item.customer.customerId})">关闭阀门</a>
					</div>
				</div>
				<div style="clear:both"></div>
			</div>
		</td>
		</c:forEach>
	</tr>
	</table>
	<div id="digg"></div>
	
	<div id="layout"></div>  <!--实现灰色透明层效果-->
	    <div id="box">
	    <div id="title">提示</div>
		<div id="closed">×</div>
		<div id="boxcontent">
			<div id="content">
				<img src="/gas/images/check.png" width="32px" height="32px"/>
				<span id="tips"></span></div>
			<div id="buttons"><input type="button" class="closed-btn btn" value="取消"/><input type="button" id="ok-btn" class="closed-btn btn" value="确定" /></div>
	</div>
</div>
 <script type="text/javascript">
function openMeter(id) {
	var url = "/gas/openMeter/"+id; 
	if (window.XMLHttpRequest) { 
		req = new XMLHttpRequest(); 
	}else if (window.ActiveXObject) { 
		req = new ActiveXObject("Microsoft.XMLHTTP"); 
	} 
	if(req){ 
	    req.open("GET",url, true); 
	    req.onreadystatechange = completeOpen; 
	    req.send(null); 
	} 
} 
function closeMeter(id) {
	var url = "/gas/closeMeter/"+id; 
	if (window.XMLHttpRequest) { 
		req = new XMLHttpRequest(); 
	}else if (window.ActiveXObject) { 
		req = new ActiveXObject("Microsoft.XMLHTTP"); 
	} 
	if(req){ 
	    req.open("GET",url, true); 
	    req.onreadystatechange = completeClose; 
	    req.send(null); 
	} 
} 
function completeOpen(){
	if (req.readyState == 4) { 
	    if (req.status == 200) { 
	    	var str = req.responseText;
	    	if(str == 'success'){
	    		document.getElementById('tips').innerHTML='已发送开启指令！！！';
	    		document.getElementById('box').style.display = "block";
	    	}
	    	else if(str == "meter_is_open"){
	    		document.getElementById('tips').innerHTML='燃气表已经开启，无需打开！';
	    		document.getElementById('box').style.display = "block";
	    	}  
	    	else{
	    		document.getElementById('tips').innerHTML='连接异常，无法发送开启指令！！！';
	    		document.getElementById('box').style.display = "block";
	    	}
	    }
	}
}
function completeClose(){
	if (req.readyState == 4) { 
	    if (req.status == 200) { 
	    	var str = req.responseText;
	    	if(str == 'success'){
	    		document.getElementById('tips').innerHTML='已发送关断指令！！！';
	    		document.getElementById('box').style.display = "block";
	    	}
	    	else if(str == "meter_is_closed"){
	    		document.getElementById('tips').innerHTML='燃气表已经关闭，无需关闭！';
	    		document.getElementById('box').style.display = "block";
	    	}  
	    	else{
	    		document.getElementById('tips').innerHTML='连接异常，无法发送关断指令！！！';
	    		document.getElementById('box').style.display = "block";
	    	}      
	    }
	}
}
 </script>
<script type="text/javascript">
var select = document.getElementById('areaName');
select.options.length=0;
select.options.add(new Option('-请选择-','0'));
var areas = '${areaStr}';
var strs= new Array(); //定义一数组 
strs=areas.split(","); //字符分割 
for (i = 0; i < strs.length; i++) 
{ 
	select.options.add(new Option(strs[i],strs[i]));
}
</script>
<script type="text/javascript">
	var pages = ${pages};
	var current = ${currentPage};
	var currentNode;
	
	var left = document.createElement('a');
	if( current> 1){
		left.href = "/gas/viewMeters/"+'${currentDistrict}/'+'${currentArea}/'+'${currentBuilding}/'+(current-2);
	}
	left.text = "<上一页";
	document.getElementById("digg").appendChild(left);
	
	for(var i = 1; i <= pages; i++){
		var child = document.createElement('a');
		child.text = i;
		child.href = "/gas/viewMeters/"+'${currentDistrict}/'+'${currentArea}/'+'${currentBuilding}/'+(i-1);
		if(i==current){
			child.className = "currentclick";
			currentNode = child;
		}
		document.getElementById("digg").appendChild(child);	
	}
	
	var right = document.createElement('a');
	if( current != pages){
		right.href = "/gas/viewMeters/"+'${currentDistrict}/'+'${currentArea}/'+'${currentBuilding}/'+(current);
	}
	right.text = "下一页>";
	document.getElementById("digg").appendChild(right);
</script>