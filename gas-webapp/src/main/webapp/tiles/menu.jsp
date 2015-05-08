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
<div class="leftmenu">
	<div class="div1">
		<div class="div0"><div class="home"></div><a class="shine" href="/gas/index">首页</a></div>
		<div class="div2"><div class="warning"></div>异常提醒</div>
		<div class="div3">
			<ul>
				<li><a id="dd1" href="/gas/viewwarning/1" onclick="return forbid(1)">利州区</a></li>
				<li><a id="dd2" href="/gas/viewwarning/2" onclick="return forbid(2)">昭化区</a></li>
				<li><a id="dd3" href="/gas/viewwarning/3" onclick="return forbid(3)">朝天区</a></li>
				<li><a id="dd4" href="/gas/viewwarning/4" onclick="return forbid(4)">旺苍县</a></li>
				<li><a id="dd5" href="/gas/viewwarning/5" onclick="return forbid(5)">青川县</a></li>
				<li><a id="dd6" href="/gas/viewwarning/6" onclick="return forbid(6)">剑阁县</a></li>
				<li><a id="dd7" href="/gas/viewwarning/7" onclick="return forbid(7)">苍溪县</a></li>
			</ul>
		</div>
		<div class="div2"><div class="current"></div>最新数据</div>
		<div class="div3">
			<ul>
				<li><a id="d1" href="/gas/viewgas/1" onclick="return forbid(1)">利州区</a></li>
				<li><a id="d2" href="/gas/viewgas/2" onclick="return forbid(2)">昭化区</a></li>
				<li><a id="d3" href="/gas/viewgas/3" onclick="return forbid(3)">朝天区</a></li>
				<li><a id="d4" href="/gas/viewgas/4" onclick="return forbid(4)">旺苍县</a></li>
				<li><a id="d5" href="/gas/viewgas/5" onclick="return forbid(5)">青川县</a></li>
				<li><a id="d6" href="/gas/viewgas/6" onclick="return forbid(6)">剑阁县</a></li>
				<li><a id="d7" href="/gas/viewgas/7" onclick="return forbid(7)">苍溪县</a></li>
			</ul>
		</div>
		<div class="div2"><div class="datamanagement"></div>运营管理</div>
		<div class="div3">
			<ul>
				<li><a href="/gas/viewMeters/<%=menuUserGrade%>">状态监测</a></li>
				<li><a href="/gas/status">抄表统计</a></li>
				<li><a href="/gas/payaly">缴费统计</a></li>
			</ul>
		</div>
		<div class="div2"><div class="customermanagement"></div>系统管理</div>
		<div class="div3">
			<ul>
				<li><a href="/gas/viewaddress/<%=menuUserGrade%>">所有小区</a></li>
				<li><a href="/gas/viewcustomers/<%=menuUserGrade%>">所有住户</a></li>					
			</ul>
		</div>
		<div class="div2"><div class="payment"></div>费用管理</div>
		<div class="div3">
			<ul>
				<li><a href="/gas/addPay">用户缴费</a></li>
				<li><a href="/gas/viewpay/<%=menuUserGrade%>">变动记录</a></li>
			</ul>
		</div>
		<div class="div2"><div class="system"></div>系统设置</div>
		<div class="div3">
			<ul>
				<li><a href="/gas/setting">系统设置</a></li>
			</ul>
		</div>
	</div>
</div>
<script type="text/javascript">
function forbid(id){
	var grade = <%=menuUserGrade%>;
	if(grade == 0){
		return true;
	}
	else if(grade == id){
		return true;
	}
	else{
		alert("您不具备操作权限");
		return false;
	}
}
</script>