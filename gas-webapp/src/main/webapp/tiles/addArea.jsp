<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<script type="text/javascript" src="/gas/js/stepAdd.js"></script>
<link href="/gas/css/stepAdd.css" type="text/css" rel="stylesheet" />

<div>
	<div class="addtitle">
		<div class="status-title">系统管理——添加小区</div>
		<div style="clear:both;"></div>
	</div>		
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
	<form method="post" action="/gas/addAddress">
		<div id="write">
			<div id="table1">
				<table>
					<tr><td class="title">区县名:&nbsp;&nbsp;</td><td>
						<select id="opdis" name="districtName" class="txt" >
								<option value =-1>-请选择-</option>
								<option value = "1">利州区</option>
								<option value = "2">昭化区</option>
								<option value = "3">朝天区</option>
								<option value = "4">旺苍县</option>
								<option value = "5">青川县</option>
								<option value = "6">剑阁县</option>	
								<option value = "7">苍溪县</option>	
						</select>
						</td>
					</tr>
					<tr><td class="title">小区名:&nbsp;&nbsp;</td>
						<td><input class="txt" type="text" name="areaName" value='${address.addressArea}'/></td></tr>
				</table>
			</div>
			<div id="table2" class="hid">
				<table>
					<tr ><td class="title">小区地址:&nbsp;&nbsp;</td>
						<td><input class="txt" type="text" name="areaLocation" value='${address.addressLocation}'/></td></tr>
					<tr><td class="title">建筑数量:&nbsp;&nbsp;</td>
						<td><input class="txt" type="text" name="buildingNumbers" value='${address.addressBuildings}'/></td></tr>
					<tr><td class="title">住户数量:&nbsp;&nbsp;</td>
						<td><input class="txt" type="text" name="customerNumbers" value='${address.addressCustomers}'/></td></tr>
					<tr><td class="title">小区描述:&nbsp;&nbsp;</td>
						<td><textarea id="describe" name="areaDescribe" rows="6" cols="37">${address.addressDesicribe}</textarea></td></tr>
				</table>
			</div>
		</div>
		<div id="move">
			<input type="hidden" name="addressId" value='${address.addressId}'/>
			<input class="btn" id="btn-previous" type="button" value="上一步" onclick="previous()"/>
			<input class="btn" id="btn-next" type="button" value="下一步" onclick="next()"/>
			<input class="btn btn-compelete" type="submit" value="完成" onclick="return complete()"/>
		</div>
	</form>
</div>

<script type="text/javascript">
	var dis = ['利州区','昭化区','朝天区','旺苍县','青川县','剑阁县','苍溪县'];
	var district = '${address.addressDistrict}';
	var id;
	for(var id=0;id<7;id++){
		if(dis[id]==district){
			break;
		}
	}
	document.getElementById("opdis").value = id+1;
</script>