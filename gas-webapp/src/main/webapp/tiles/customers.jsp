<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ page import="com.young.gas.beans.User" %>

<%
	User user=(User)session.getAttribute("user");
	String[] districts={"系统管理员","利州区","昭化区","朝天区","旺苍县","青川县","剑阁县","苍溪县"};	
	int userGrade=user.getUserGrade();
%>

<div>
	<div class="addtitle">住户管理——所有住户</div>	
	<div id="datalist">
		<span>
			<div id="image">
				<image src="/gas/images/text.png" width=20px height=20px />
			</div>
			${currentDistrict}&nbsp;
			<font class="STYLE1">&gt;</font>&nbsp;${currentArea}&nbsp;
			<font class="STYLE1">&gt;&nbsp;</font>${currentBuilding}栋
			<div id="search">
				<form id="searchform" action="/gas/searchcustomers/<%=userGrade%>" method="post" onsubmit="return checkform()">
					小区：<select id="areaName" name="areaName" style="width:82px; height:25px;">
						<option value =0>-请选择-</option>
					</select>&nbsp;
					楼号：<input type="text" id="buildingName" name="buildingName" style="width:35px; height:15px;"/>
					<input id="inputbutton" type="submit" value="查询"/>
					&nbsp;&nbsp;&nbsp;&nbsp;
				</form>
			</div>
		</span>
		<table id="maintable" width=980px border="1" align="center" bordercolor="#dddddd" cellpadding="0" cellspacing="0">
		  <tr>
			<td width="3%"  class="tablehead">序号</td>
			<td width="7%" class="tablehead">用户名</td>
			<td width="10%" class="tablehead">联系方式</td>
			<td width="7%" class="tablehead">房号</td>
			<td width="7%" class="tablehead">账户余额(元)</td>
			<td width="6%" class="tablehead">燃气表状态</td>					
			<td width="7%" class="tablehead">燃气表控制</td>
		  </tr>
		  <c:forEach items="${customers}" var="item" varStatus="status"> 
		  <tr class="tablerow">
			<td class="tablecontent">${status.count}</td>
			<td class="tablecontent">${item.customerName}</td>
			<td class="tablecontent">${item.customerPhone}</td>
			<td class="tablecontent">${item.addressLayer}0${item.addressRoom}室</td>
			<td class="tablecontent">${item.money}</td>
			<td class="tablecontent">正常</td>						
			<td class="tablecontent"><input type="button" value="关闭" onclick="if(this.value=='打开') this.value='关闭'; else this.value='打开'"  style="width:40px;font-size:12px;"/></td>
		  </tr> 
		  </c:forEach>		  	  
		 </table>	
		 
		<table class="movetable">
		  <tr>
			<td style="width:25%;" >
				<span class="STYLE1">&nbsp;共<strong>&nbsp;${countCustomers} &nbsp;</strong>条纪录，当前第<strong>&nbsp;${currentPage}/${pages}&nbsp;</strong>页</span>
			</td>
			<td style="width:75%;" class="STYLE1">
				<div align="right">
				  <table width="200" height="20" border="0" cellpadding="0" cellspacing="0">
					<tr>
				  	 <c:choose>
					    <c:when test="${currentPage == 1 && currentPage == pages}">
						  <td width="62" height="28" valign="middle"><div align="right">
						  		<img class="imagebuttonhide" src="/gas//images/first.gif"width="37" height="15" /></div>
						  </td>
						  <td width="50" height="28" valign="middle"><div align="right">
						  		<img class="imagebuttonhide" src="/gas//images/back.gif" width="43" height="15" /></div>
						  </td>
						  <td width="54" height="28" valign="middle"><div align="right">
						  		<img class="imagebuttonhide" src="/gas//images/next.gif" width="43" height="15" /></div>
						  </td>
						  <td width="49" height="28" valign="middle"><div align="right">
						  		<img class="imagebuttonhide" src="/gas//images/last.gif" width="37" height="15" /></div>
						  </td>
					    </c:when>
					    <c:when test="${currentPage == 1 && currentPage != pages}">
						  <td width="62" height="28" valign="middle"><div align="right">
						  		<img class="imagebuttonhide" src="/gas//images/first.gif"width="37" height="15" /></div>
						  </td>
						  <td width="50" height="28" valign="middle"><div align="right">
						  		<img class="imagebuttonhide" src="/gas//images/back.gif" width="43" height="15" /></div>
						  </td>
						  <td width="54" height="28" valign="middle"><div align="right">
						  		<a href="/gas/viewcustomers/<%=userGrade %>/${currentArea}/${currentBuilding}/${currentPage}"><img class="imagebutton" src="/gas//images/next.gif" width="43" height="15" /></a></div>
						  </td>
						  <td width="49" height="28" valign="middle"><div align="right">
						  		<a href="/gas/viewcustomers/<%=userGrade %>/${currentArea}/${currentBuilding}/${pages-1}"><img class="imagebutton" src="/gas//images/last.gif" width="37" height="15" /></a></div>
						  </td>
					    </c:when>
					    <c:when test="${currentPage > 1 && currentPage < pages}">
						  <td width="62" height="28" valign="middle"><div align="right">
						  		<a href="/gas/viewcustomers/<%=userGrade %>/${currentArea}/${currentBuilding}/0"><img class="imagebutton" src="/gas//images/first.gif"width="37" height="15" /></a></div>
						  </td>
						  <td width="50" height="28" valign="middle"><div align="right">
						  		<a href="/gas/viewcustomers/<%=userGrade %>/${currentArea}/${currentBuilding}/${currentPage-2}"><img class="imagebutton" src="/gas/images/back.gif" width="43" height="15" /></a></div>
						  </td>
						  <td width="54" height="28" valign="middle"><div align="right">
						  		<a href="/gas/viewcustomers/<%=userGrade %>/${currentArea}/${currentBuilding}/${currentPage}"><img class="imagebutton" src="/gas//images/next.gif" width="43" height="15" /></a></div>
						  </td>
						  <td width="49" height="28" valign="middle"><div align="right">
						  		<a href="/gas/viewcustomers/<%=userGrade %>/${currentArea}/${currentBuilding}/${pages-1}"><img class="imagebutton" src="/gas//images/last.gif" width="37" height="15" /></a></div>
						  </td>
					    </c:when>
					    <c:otherwise>
						  <td width="62" height="28" valign="middle"><div align="right">
						  		<a href="/gas/viewcustomers/<%=userGrade %>/${currentArea}/${currentBuilding}/0"/><img class="imagebutton" src="/gas//images/first.gif" width="43" height="15" /></a></div>
						  </td>
						  <td width="50" height="28" valign="middle"><div align="right">
						  		<a href="/gas/viewcustomers/<%=userGrade %>/${currentArea}/${currentBuilding}/${currentPage-2}"><img class="imagebutton" src="/gas//images/back.gif" width="43" height="15" /></a></div>
						  </td>
						  <td width="54" height="28" valign="middle"><div align="right">
						  		<img class="imagebuttonhide" src="/gas//images/next.gif" width="43" height="15" /></div>
						  </td>
						  <td width="49" height="28" valign="middle"><div align="right">
						  		<img class="imagebuttonhide" src="/gas//images/last.gif" width="37" height="15" /></div>
						  </td>
					    </c:otherwise>
					 </c:choose>
			      	</tr>
				  </table>
				</div>
			</td>
		  </tr>
		</table>
	</div>
</div>

<script type="text/javascript">
setInterval("document.getElementById('time').innerHTML=new Date().toLocaleString();",5);

var newSelect=document.getElementById("areaName"); 
newSelect.options.length=0; 
var op=document.createElement("option");
op.value=0;
op.innerHTML="-请选择-";
newSelect.appendChild(op);
//得到完成请求后返回的字串符
var str = "${areaStr}";
//根据返回的字符串为新创建的select节点添加option节点
var arr1=str.split(",");
//alert(arr1);
for(var i=0;i<arr1.length;i++){
    var child=document.createElement("option");
    child.innerHTML=arr1[i];
    child.value=arr1[i];
    newSelect.appendChild(child);
}

function checkform(){
	var areaName=document.forms["searchform"]["areaName"];
	var buildingName=document.forms["searchform"]["buildingName"];
	if(areaName.value=="0")
	{
		alert("请选择小区");
		return false;
	}
	if(buildingName.value=="")
	{
		alert("请输入楼号");
		return false;
	}
	return true;	
}
var grade = "<%=userGrade%>";
if(grade != 0){
	var cls1 = 'd' + grade;
	var cls2 = 'dd' + grade;
	document.getElementById(cls1).onclick="return true";
	document.getElementById(cls2).onclick="return true";	
}
else{
	for(var i = 1; i <= 7; i++){
		var cls1 = 'd' + i;
		var cls2 = 'dd' + i;
		document.getElementById(cls1).onclick="return true";
		document.getElementById(cls2).onclick="return true";
	}
}

function forbid(){
	alert("您无操作权限");
	return false;
}
</script>
