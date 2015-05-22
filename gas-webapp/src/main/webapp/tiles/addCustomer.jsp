<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%> 

<script type="text/javascript" src="/gas/js/stepAdd.js"></script>
<link href="/gas/css/stepAdd.css" type="text/css" rel="stylesheet" />

<div>
	<div class="addtitle">
		<div class="status-title">系统管理——添加住户</div>
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
	<form method="post" action="/gas/addCustomerData">
		<div id="write">
			<div id="table1">
				<table>
					<tr><td class="title">住户名:&nbsp;&nbsp;</td>
						<td><input class="txt" type="text" name="customerName" value='${customer.customerName}'/></td></tr>
					<tr><td class="title">联系方式:&nbsp;&nbsp;</td>
						<td><input class="txt" type="text" name="customerPhone" value='${customer.customerPhone}'/></td></tr>
				</table>
			</div>
			<div id="table2" class="hid">
				<table>
					<tr><td class="title">区县:&nbsp;&nbsp;</td>
						<td>
							<select id="opdis" name="districtName" class="txt">
								<option value = "-1">-请选择-</option>
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
					<tr><td class="title">小区:&nbsp;&nbsp;</td><td>	
						<select id="oparea" id="areaName" name="areaName" class="txt">
							<option value = "-1">-请选择-</option>
							<option value = "黄金小区">黄金小区</option>
							<option value = "东风小区">东风小区</option>
							<option value = "和苑小区">和苑小区</option>
							<option value = "智能小区">智能小区</option>
							<option value = "西郡兰庭">西郡兰庭</option>
						</select></td>
					</tr>
					<tr><td class="title">楼号:&nbsp;&nbsp;</td>
						<td><input class="txt" type="text" name="addressBuilding" value='${customer.addressBuilding}'/></td></tr>
					<tr><td class="title">楼层:&nbsp;&nbsp;</td>
						<td><input class="txt" type="text" name="addressLayer" value='${customer.addressLayer}'/></td></tr>
					<tr><td class="title">房号:&nbsp;&nbsp;</td>
						<td><input class="txt" type="text" name="addressRoom" value='${customer.addressRoom}'/></td></tr>
				</table>
			</div>
		</div>
		<div id="move">
			<input class="btn" id="btn-previous" type="button" value="上一步" onclick="previous()"/>
			<input class="btn" id="btn-next" type="button" value="下一步" onclick="next()"/>
			<input class="btn btn-compelete" type="submit" value="完成" onclick="return complete()"/>
		</div>
	</form>
</div>

<script type="text/javascript">
</script>