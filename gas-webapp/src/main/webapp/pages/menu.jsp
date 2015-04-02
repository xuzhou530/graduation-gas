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
				<li><font style="color:#dddddd;">用户中心</font>
					<ul>
						<li><a href="/gas/pages/addPay.jsp">系统设置</a></li>
						<li><a href="/gas/viewpay/<%=menuUserGrade%>">集中器设置</a></li>
					</ul>
				</li>
				<li><a href="/gas/logout">退出系统</a></li>
			</ul>
		</div>
</div>
<script type="text/javascript">
setInterval("document.getElementById('time').innerHTML=new Date().toLocaleString();",5);
</script>