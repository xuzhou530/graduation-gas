<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>广元市燃气远程监控系统登录界面</title>
<link rel="stylesheet" type="text/css" href="/gas/css/login.css"/>
<script type="text/javascript" src="/gas/js/login.js"></script>
</head>
<body>
<div id="bgk">
<div id="header">
	<div id="headerleft">广元市燃气远程监控系统&nbsp;&nbsp;&nbsp;</div>
	<div id="headerright"></div>
</div>
<div id="content">
	<div>
		<span>欢迎进入系统</span>
		<form id="login" method="post" action="/gas/login" onsubmit="checkForm()">
			<table>
				<tr>
					<td class="label">用户名：</td>
					<td><input type="text" name="name"/></td>
				</tr>
				<tr>
					<td class="label">密码：</td>
					<td><input type="password" name="password"/></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>
						<input id="submit" type="submit" value="登录"/>
						<input id="reset" type="reset" value="重置"/>
					</td>
				</tr>
			</table>
		</form>
	</div>
</div>
</div>
</body>
</html>
