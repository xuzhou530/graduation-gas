<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.young.gas.beans.User" %>
<%
	Object u = session.getAttribute("user");
	User menuUser = null;	
	int menuUserGrade;
	String[] menuDistricts={"系统管理员","利州区","昭化区","朝天区","旺苍县","青川县","剑阁县","苍溪县"};	
	if(u != null){
		menuUser = (User)u;
		menuUserGrade=menuUser.getUserGrade();
	}
	else{
		menuUser = new User();
		menuUser.setUserName("visitor");
		menuUser.setUserGrade(0);
		menuUserGrade=menuUser.getUserGrade();
	}
%>

<div id="header">
	<div style="margin-left:50px;">
		<div id="logo">城市燃气远程抄表<span>监控系统</span></div>
		<div class="right">
			<div id="welcome">登录用户：<font><%=menuUser.getUserName()%></font>&nbsp;&nbsp;&nbsp;用户权限：<font><%=menuDistricts[menuUserGrade]%></font></div>
		</div>
	</div>
</div>
<div id="navigation">
	<div id="menu" class="right">
		<ul>
			<li><font style="color:#dddddd; cursor:pointer;">用户中心</font>
				<ul>
					<li><a href="/gas/audit" onclick="return forbid()">待审核用户</a></li>
					<li><a href="/gas/users" onclick="return forbid()">所有用户</a></li>
					<li><a href="/gas/logger" onclick="return forbid()">系统日志</a></li>
				</ul>
			</li>
			<li><a href="/gas/logout">退出系统</a></li>
		</ul>
	</div>
</div>

<script type="text/javascript">
function forbid(){
	var grade = <%=menuUserGrade%>;
	if(grade == 0){
		return true;
	}
	else{
		alert("您不具备操作权限");
		return false;
	}
}
</script>
