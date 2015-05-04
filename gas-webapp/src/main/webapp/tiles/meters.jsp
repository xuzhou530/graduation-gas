<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<link href="/gas/css/meters.css" type="text/css" rel="stylesheet" />
<link href="/gas/css/pages.css" type="text/css" rel="stylesheet" />
<script type="text/javascript">
window.onload=function(){
	var pages = 10;
	var current = 5;
	var currentNode;
	
	var left = document.createElement('a');
	left.text = "<上一页";
	document.getElementById("digg").appendChild(left);
	
	for(var i = 1; i <= pages; i++){
		var child = document.createElement('a');
		child.text = i;
		child.href = "#";
		child.onclick = function(){
			currentNode.className = "";
		}
		if(i==current){
			child.className = "currentclick";
			currentNode = child;
		}
		document.getElementById("digg").appendChild(child);	
	}
	
	var right = document.createElement('a');
	right.text = "下一页>";
	document.getElementById("digg").appendChild(right);
}

</script>
<div>
	<div class="addtitle">
		<div class="status-title">状态监测</div>
		<div style="float:right;margin:5px 30px 0 0;">			
			<ul class="condition">
				<li>小区：<select id="areaName" name="areaName" style="width:85px; height:25px;">
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
		<td>
			<div class="house">
				<div class="meter"></div>
				<div class="info">
					<ul>
						<li>房号：101室</li>
						<li>气量：42232.23</li>
						<li>余额：<span style="color:red">-10元</span></li>
						<li><div style="float:left;">状态：</div><div class="red-dot"></div></li>
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
		<td>
			<div class="house">
				<div class="meter"></div>
				<div class="info">
					<ul>
						<li>房号：102室</li>
						<li>气量：42232.23</li>
						<li>余额：322元</li>
						<li><div style="float:left;">状态：</div><div class="green-dot"></div></li>
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
		<td>
			<div class="house">
				<div class="meter"></div>
				<div class="info">
					<ul>
						<li>房号：103室</li>
						<li>气量：42232.23</li>
						<li>余额：322元</li>
						<li><div style="float:left;">状态：</div><div class="green-dot"></div></li>
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
		<td>
			<div class="house">
				<div class="meter"></div>
				<div class="info">
					<ul>
						<li>房号：104室</li>
						<li>气量：42232.23</li>
						<li>余额：322元</li>
						<li><div style="float:left;">状态：</div><div class="green-dot"></div></li>
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
	</tr>
	<tr>
		<td>
			<div class="house">
				<div class="meter"></div>
				<div class="info">
					<ul>
						<li>房号：201室</li>
						<li>气量：42232.23</li>
						<li>余额：322元</li>
						<li><div style="float:left;">状态：</div><div class="red-dot"></div></li>
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
		<td>
			<div class="house">
				<div class="meter"></div>
				<div class="info">
					<ul>
						<li>房号：202室</li>
						<li>气量：42232.23</li>
						<li>余额：322元</li>
						<li><div style="float:left;">状态：</div><div class="red-dot"></div></li>
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
		<td>
			<div class="house">
				<div class="meter"></div>
				<div class="info">
					<ul>
						<li>房号：203室</li>
						<li>气量：42232.23</li>
						<li>余额：322元</li>
						<li><div style="float:left;">状态：</div><div class="green-dot"></div></li>
					</ul>
				</div>
				<div class="control">
					<div class="buttons">
						<a href="" class="open-btn btn" >打开阀门</a>
						<a href="" class="close-btn btn">关闭阀门</a>
					</div>
				</div>
				<div style="clear:both"></div>
			</div>
		</td>
		<td>
			<div class="house">
				<div class="meter"></div>
				<div class="info">
					<ul>
						<li>房号：204室</li>
						<li>气量：42232.23</li>
						<li>余额：322元</li>
						<li><div style="float:left;">状态：</div><div class="green-dot"></div></li>
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
	</tr>
	</table>
	<div id="digg"></div>
</div>