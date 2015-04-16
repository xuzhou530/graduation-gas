<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%> 
<%@ page import="com.young.gas.beans.User" %>
<%
	User user=(User)session.getAttribute("user");
	String[] districts={"系统管理员","利州区","昭化区","朝天区","旺苍县","青川县","剑阁县","苍溪县"};	
	int userGrade=user.getUserGrade();
%>

<div>
	<h4 class="addtitle">用户缴费</h4>		
	<form action="/gas/addpay/<%=userGrade%>" method="get">
		<table class="addpaytable" >
			<tr><td class="title">区县:&nbsp;&nbsp;</td>
				<td>
					<select name="districtName" style="width: 203px; height:30px;" onchange="cascade(this.value)" >
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
			<tr><td class="title">小区:&nbsp;&nbsp;</td><td>	
				<select id="areaName000" name="areaName000" style="width:203px; height:30px;">
					<option value =0>-请选择-</option>
					<option value =0>黄金小区</option>
				</select></td>
			</tr>
			<tr><td class="title">楼号:&nbsp;&nbsp;</td><td><input type="text" name="addressBuilding"/></td></tr>
			<tr><td class="title">楼层:&nbsp;&nbsp;</td><td><input type="text" name="addressLayer"/></td></tr>
			<tr><td class="title">房号:&nbsp;&nbsp;</td><td><input type="text" name="addressRoom"/></td></tr>
			<tr><td class="title">用户名:&nbsp;&nbsp;</td><td><input type="text" name="name"/></td></tr>
			<tr><td class="title">金额:&nbsp;&nbsp;</td><td><input type="text" name="pay"/></td></tr>
			<tr><td class="title">&nbsp;</td>
				<td><input class="buttonsave" type="submit" value="缴费"/>&nbsp;&nbsp;
					<input class="buttonreset" type="reset" value="重置"/>
				</td>
			</tr>
		</table>
	</form>		
</div>