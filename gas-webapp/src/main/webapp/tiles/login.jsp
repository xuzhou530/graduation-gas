<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<head>
<title>登陆页面</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<link href="/gas/css/loging.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div id="header"></div>
<div id="main">

	<form id="login" method="post" action="/gas/login" onsubmit="checkForm()">
		<div class="rows">
			<span class="input-title-user"></span>
			<input class="inp" tabindex="1" type="text" value="" name="name" placeholder="手机、邮箱、用户名"/>
		</div>
		<div class="rows">
			<span class="input-title-password"></span>
			<input class="inp" tabindex="2" type="password" value="" name="password" placeholder="请输入您的密码"/>
		</div>
		<div class="remember">
			<label class="checkbox">
				<input type="checkbox" name="rememberMe"/>
				<span class="week-login">一周内自动登录</span>
            </label>
            <a class="forget-link" href="/forgetInit">忘记密码?</a>
		</div>
		<div>
			<button type="submit" class="submit-btn">立即登录</button>
		</div>
		<div>
			<a href="/gas/register" class="reg-btn">注册账号</a>
		</div>
    </form>
</div>
</body>
</html>