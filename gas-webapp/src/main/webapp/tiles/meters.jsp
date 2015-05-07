<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<link href="/gas/css/meters.css" type="text/css" rel="stylesheet" />
<link href="/gas/css/pages.css" type="text/css" rel="stylesheet" />
<script type="text/javascript">
window.onload=function(){
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
}

</script>
<div>
	<div class="addtitle">
		<div class="status-title">状态监测</div>
		<div style="float:right;margin:5px 30px 0 0;">			
			<ul class="condition">
				<li>小区：<select id="areaName" name="areaName" style="width:95px; height:25px;">
							<option value =0>-请选择-</option></select></li>
				<li>楼号：
					<input type="text" class="text-box"/>
					<span style="margin-left:-5px;"><input type="submit" class="query-btn" value="查询"/></span>
				</li>
			</ul>
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
						<li>气量：${item.gasValue}.000</li>
						<li>余额：
							<c:if test="${item.customer.money < 0 }">
								<span style="color:red">${item.customer.money}.00元</span>
							</c:if>
							<c:if test="${item.customer.money >= 0 }">
								<span>${item.customer.money}.00元</span>
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
						<a href="" class="open-btn btn">打开阀门</a>
						<a href="" class="close-btn btn ">关闭阀门</a>
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
						<li>气量：${item.gasValue}.000</li>
						<li>余额：
							<c:if test="${item.customer.money < 0 }">
								<span style="color:red">${item.customer.money}.00元</span>
							</c:if>
							<c:if test="${item.customer.money >= 0 }">
								<span>${item.customer.money}.00元</span>
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
						<a href="" class="open-btn btn">打开阀门</a>
						<a href="" class="close-btn btn">关闭阀门</a>
					</div>
				</div>
				<div style="clear:both"></div>
			</div>
		</td>
		</c:forEach>
	</tr>
	</table>
	<div id="digg"></div>
</div>
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