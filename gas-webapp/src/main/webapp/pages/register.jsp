<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<head>
<title>注册页面</title>
<link href="/gas/css/loging.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div id="header"></div>
<div id="main">

	<form method="post">
		<div class="rows">
			<span class="input-title-long">用户名:</span>
			<input class="inp" tabindex="1" type="text" value="" name="username"/>
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
			<select class="inp" name='sldd' style="width:200px;height:35px;">
				<option value='' selected >超级用户</option>
				<option value=''>利州区</option>
				<option value=''>昭化区</option>
				<option value=''>朝天区</option>
				<option value=''>青川县</option>
				<option value=''>剑阁县</option>
				<option value=''>旺苍县</option>
				<option value=''>苍溪县</option>
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
</body>
</html>