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
<script type="text/javascript" src="/gas/js/script.js" ></script>
<link href="/gas/css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
$(document).ready(function(){
	$(".div2").click(function(){ 
		$(this).next("div").slideToggle("slow").siblings(".div3:visible").slideUp("slow");
	});
});
</script>
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
	<div class="addtitle">设置</div>	
	<div>
		<table class="tabTitlesContainer">
			<tr id="tabTitles">
				<td class="tabTitleSelected" onclick="tabPageControl(0)">系统设置</td>
				<td class="tabTitleUnSelected" onclick="tabPageControl(1)">集中器设置</td>
				<td class="tabTitleUnSelected" onclick="tabPageControl(2)">采集器设置</td>
			</tr>
		</table>
		<table id="tabPagesContainer">
			<tbody class="tabPageSelected">
				<tr class="tabPage">
				<td>
					<table class="tabtable">
						<tr><td class="title">阀门关断方式:&nbsp;&nbsp;</td>
							<td class="content">
								<select name="open" style="height:30px;" >
									<option value =0>人工关闭</option>
									<option value =1>自动关闭</option>
								</select>
							</td>
						</tr>
						<tr><td class="title">余额报警值:&nbsp;&nbsp;</td>
							<td>
								<input type="text" name="moneyGuard" value="5.00"/><span class="describe">元</span>
								</td>
						</tr>
						<tr><td class="title">用气量异常值:&nbsp;&nbsp;</td>
							<td>
								<input type="text" name="gasGuard" value="100.00"/><span class="describe">立方</span>
								</td>
						</tr>
						<tr><td class="title">当前燃气单价:&nbsp;&nbsp;</td>
							<td>
								<input type="text" name="gasGuard" value="100.00"/><span class="describe">元/立方</span>
								</td>
						</tr>
						
						<tr><td class="title">&nbsp;</td>
							<td>
								<input class="buttonsave" type="submit" value="保存"/>&nbsp;&nbsp;
								<input class="buttonreset" type="reset" value="重置"/>
								<input type="hidden" name="method" value="add"/>
							</td>
						</tr>
					</table>
				</td>
				</tr>
			</tbody>
			<tbody class="tabPageUnSelected">
				<tr class="tabPage">
				<td><br/><br/><br/><br/>
					<table class="tabtable">
						<tr><td class="title">集中器编号:&nbsp;&nbsp;</td>
						<td><input type="text" name="areaName" value="01010101"/></td>
						</tr>
						<tr>
							<td class="title">采集周期:&nbsp;&nbsp;</td>
							<td>
								<select name="period" style="width: 280px; height:30px;" >
									<option value =0>每月一次</option>
									<option value =1>半月一次</option>
									<option value =2>每天一次</option>
								</select>
							</td>
						</tr>
						<tr>
							<td class="title">采集时间:&nbsp;&nbsp;</td>
							<td><input type="text" name="day" style="width:40px;" value="1"/><span class="describe">日</span>
								<input type="text" name="day" style="width:35px;" value="12"/><span class="describe">时：</span>
								<input type="text" name="day" style="width:35px;" value="00"/><span class="describe">分：</span>
								<input type="text" name="day" style="width:35px;" value="00"/><span class="describe">秒</span></td>
						</tr>
						<tr>
							<td class="title">采集指令:&nbsp;&nbsp;</td>
							<td>
								<input type="radio" name="start" value="0" checked="checked" style="width:50px;"/><span class="describe">不采集</span>
								<input type="radio" name="start" value="1" style="width:50px;"/><span class="describe">采集</span>
							</td>
						</tr>
						<tr>
							<td class="title">校时:&nbsp;&nbsp;</td>
							<td>
								<input type="radio" name="time" value="0" checked="checked" style="width:50px;"/><span class="describe">不校准</span>
								<input type="radio" name="time" value="1" style="width:50px;"/><span class="describe">校准</span>
							</td>
						</tr>
						<tr><td class="title">&nbsp;</td>
							<td>
								<input class="buttonsave" type="submit" value="保存"/>&nbsp;&nbsp;
								<input class="buttonreset" type="reset" value="重置"/>
								<input type="hidden" name="method" value="add"/>
							</td>
						</tr>
					</table>				
				</td>
				</tr>
			</tbody>
			<tbody class="tabPageUnSelected">
				<tr class="tabPage">
								<td><br/><br/><br/><br/>
					<table class="tabtable">
						<tr><td class="title">采集器编号:&nbsp;&nbsp;</td>
						<td><input type="text" name="areaName" value="01010101"/></td>
						</tr>
						<tr>
							<td class="title">采集周期:&nbsp;&nbsp;</td>
							<td>
								<select name="period" style="width: 280px; height:30px;" >
									<option value =0>每月一次</option>
									<option value =1>半月一次</option>
									<option value =2>每天一次</option>
								</select>
							</td>
						</tr>
						<tr>
							<td class="title">采集时间:&nbsp;&nbsp;</td>
							<td><input type="text" name="day" style="width:40px;" value="1"/><span class="describe">日</span>
								<input type="text" name="day" style="width:35px;" value="12"/><span class="describe">时：</span>
								<input type="text" name="day" style="width:35px;" value="00"/><span class="describe">分：</span>
								<input type="text" name="day" style="width:35px;" value="00"/><span class="describe">秒</span></td>
						</tr>
						<tr>
							<td class="title">采集指令:&nbsp;&nbsp;</td>
							<td>
								<input type="radio" name="start" value="0" checked="checked" style="width:50px;"/><span class="describe">不采集</span>
								<input type="radio" name="start" value="1" style="width:50px;"/><span class="describe">采集</span>
							</td>
						</tr>
						<tr>
							<td class="title">校时:&nbsp;&nbsp;</td>
							<td>
								<input type="radio" name="time" value="0" checked="checked" style="width:50px;"/><span class="describe">不校准</span>
								<input type="radio" name="time" value="1" style="width:50px;"/><span class="describe">校准</span>
							</td>
						</tr>
						<tr><td class="title">&nbsp;</td>
							<td>
								<input class="buttonsave" type="submit" value="保存"/>&nbsp;&nbsp;
								<input class="buttonreset" type="reset" value="重置"/>
								<input type="hidden" name="method" value="add"/>
							</td>
						</tr>
					</table>				
				</td>
				</tr>
			</tbody>
		</table>
	</div>	
</div>
</body>
</html>
