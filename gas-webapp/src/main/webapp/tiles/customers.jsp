<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ page import="com.young.gas.beans.User" %>

<%
	User user=(User)session.getAttribute("user");
	String[] districts={"系统管理员","利州区","昭化区","朝天区","旺苍县","青川县","剑阁县","苍溪县"};	
	int userGrade=user.getUserGrade();
%>
<!-- 弹窗的css与js  -->
<style>
#layout 
{ 
background:#000; 
position:absolute; 
top:0; 
left:0; 
width:100%;
opacity:0.5; 
filter:alpha(opacity=50); 
cursor:pointer; 
display:none; 
z-index:555; 
}
#box { 
width:350px; 
height:200px; 
position:absolute;
top:50%; 
left:50%; 
margin:-100px auto 0 -150px; 
background:#fafafa; 
z-index:999; 
border:2px solid #eee; 
border-radius:5px; 
box-shadow:0 0 40px #333; 
display:none; 
padding-top:10px;
}
.btn{
width:80px;
height:30px;
font-family: "Arial","Tahoma","微软雅黑","雅黑";
border: 0px;
border-radius:3px;
vertical-align: middle;
margin: 8px;
line-height: 18px;
font-size: 18px;
backgroud:blue;
}
.del-btn{
cursor:pointer;
}
</style>
<script>
window.onload = function() {
    var layout = document.getElementById("layout");    
    var box = document.getElementById("box");
    var closedbuttons = document.getElementsByClassName("closed-btn");
    for (var i=0; i<closedbuttons.length; i++) {
    	closedbuttons[i].onclick = function() { 
            layout.style.display = "none"; 
            box.style.display = "none"; 
            return false;
        }
    }      
}
	
</script>

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
		<table id="maintable">
		  <tr>
			<td width="3%"  class="tablehead">序号</td>
			<td width="7%" class="tablehead">用户名</td>
			<td width="10%" class="tablehead">联系方式</td>
			<td width="7%" class="tablehead">房号</td>
			<td width="7%" class="tablehead">账户余额(元)</td>
			<td width="6%" class="tablehead">状态</td>					
			<td width="7%" class="tablehead">操作</td>
		  </tr>
		  <c:forEach items="${customers}" var="item" varStatus="status"> 
		  <tr class="tablerow">
			<td class="tablecontent">${status.count}</td>
			<td class="tablecontent">${item.customerName}</td>
			<td class="tablecontent">${item.customerPhone}</td>
			<td class="tablecontent">${item.addressLayer}0${item.addressRoom}室</td>
			<td class="tablecontent">${item.money}</td>
			<td class="tablecontent">正常</td>						
			<td class="tablecontent"><a class="del-btn" onclick="return clickDel('${item.customerId}')">
				<img src="/gas/images/remove.png">&nbsp;&nbsp;删除</a></td>
		  </tr> 
		  </c:forEach>		  	  
		 </table>	
		 
		<div id="box">
	    	<p class="words">是否要删除?</p>
	    	<div style="text-align:center;margin-top:50px;">
		    	<input type="button" id="ok-btn" class="btn" value="确定" />
		    	<input type="button" class="closed-btn btn" value="取消"/>
	    	</div> 
    	</div>
    	
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
</div>

<script>
function clickDel(id){
    layout.style.display = "block"; 
    box.style.display = "block"; 
    
    var mybutton = document.getElementById("ok-btn");
    mybutton.onclick = function(){
    	window.location.href="/gas/deleteAddress/"+id;
        layout.style.display = "none"; 
        box.style.display = "none"; 
        return true;
    }
    return false;
}
</script>