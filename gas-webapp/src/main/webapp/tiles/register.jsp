<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<title>注册页面</title>
<link href="css/loging.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div id="header"></div>
<div id="main">
	<form action="/gas/registerUser" method="post">
		<div class="rows">
			<span class="input-title-long">用户名:</span>
			<input class="inp" tabindex="1" type="text" value="" name="userName"/>
		</div>
		<div class="rows">
			<span class="input-title-short">邮箱:</span>
			<input class="inp" tabindex="1" type="text" value="" name="email"/>
		</div>
		<div class="rows">
			<span class="input-title-long">设置密码:</span>
			<input class="inp" tabindex="1" type="password" value="" name="password"/>
		</div>
		<div class="rows">
			<span class="input-title-long">确认密码:</span>
			<input class="inp" tabindex="1" type="password" value="" name="passwordconfirm"/>
		</div>
		<div class="rows">
			<span class="input-title-long">用户权限:</span>
			<select class="inp" name='grade' style="width:200px;height:35px;">
				<option value='0' selected >超级用户</option>
				<option value='1'>利州区</option>
				<option value='2'>昭化区</option>
				<option value='3'>朝天区</option>
				<option value='4'>青川县</option>
				<option value='5'>剑阁县</option>
				<option value='6'>旺苍县</option>
				<option value='7'>苍溪县</option>
			</select>	
		</div>
		<div class="remember">
			<label class="checkbox">
				<input type="checkbox" name="rememberMe"/>
				<span class="week-login">我已阅读并同意用户协议条款</span>
            </label>
		</div>
		<div>
			<button type="submit" class="submit-btn">立即注册</button>
		</div>
    </form>
</div>
<div id="bottom">
	<ul class="describe">
		<li><a class="about">关于我们</a></li>
		<li><a class="about">联系我们</a></li>
		<li><a class="about">用户协议</a></li>
		<li><a class="about">隐私条款</a></li>
	</ul>
	<span style="color:#666">Copyright ©2015燃气远程监控系统<br/>西南交通大学信息科学与技术学院自动化实验室</span>
</div>
</body>
</html>