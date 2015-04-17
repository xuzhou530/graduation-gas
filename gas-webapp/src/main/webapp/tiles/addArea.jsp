<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%> 
<script type="text/javascript" src="/gas/js/stepAdd.js"></script>
<link href="/gas/css/stepAdd.css" type="text/css" rel="stylesheet" />

<div>
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
	<form method="post" action="/gas/addAddress">
		<div id="write">
			<div id="table1">
				<table>
					<tr ><td class="title">区县名:&nbsp;&nbsp;</td><td>
						<select name="districtName" class="txt" >
								<option value =-1>-请选择-</option>
								<option value =1>利州区</option>
								<option value =2>昭化区</option>
								<option value=3>朝天区</option>
								<option value=4>旺苍县</option>
								<option value=5>青川县</option>
								<option value=6>剑阁县</option>	
								<option value=7>苍溪县</option>	
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
			<input class="btn btn-compelete" type="submit" value="完成" onclick="return complete()"/>
		</div>
	</form>
</div>
