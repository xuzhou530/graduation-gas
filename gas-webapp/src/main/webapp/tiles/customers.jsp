<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ page import="com.young.gas.beans.User" %>

<!-- 弹窗的css与js-->
<link href="/gas/css/popup.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="/gas/js/popup.js"></script>

<%
	User user=(User)session.getAttribute("user");
	String[] districts={"系统管理员","利州区","昭化区","朝天区","旺苍县","青川县","剑阁县","苍溪县"};	
	int userGrade=user.getUserGrade();
%>

<div>
	<div class="addtitle">
		<div class="status-title">系统管理——所有住户</div>
		<div style="float:right;margin:5px 90px 0 0;">			
			<a class="add-btn" href="/gas/addCustomer"><strong>+</strong> 新建住户</a>
		</div>
		<div style="clear:both;"></div>
	</div>	
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
			<td width="5%" class="tablehead">状态</td>					
			<td width="8%" class="tablehead">操作</td>
		  </tr>
		  <c:forEach items="${customers}" var="item" varStatus="status"> 
		  <tr class="tablerow">
			<td class="tablecontent">${status.count}</td>
			<td class="tablecontent">${item.customerName}</td>
			<td class="tablecontent">${item.customerPhone}</td>
			<td class="tablecontent">${item.addressLayer}0${item.addressRoom}室</td>
			<td class="tablecontent">${item.money}</td>
			<td class="tablecontent">正常</td>						
			<td class="tablecontent">
				<span style="cursor:pointer"><a class="del-btn" href="/gas/jumpModifyCustomer/${item.customerId}">
					<img src="/gas/images/pencil.png">&nbsp;修改&nbsp;&nbsp;&nbsp;</a></span>
				<span style="cursor:pointer"><a class="del-btn" onclick="return clickDel('${item.customerId}')">
				<img src="/gas/images/remove.png">&nbsp;&nbsp;删除</a></span></td>
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
				  <table width="200px" height="20px" border="0px" cellpadding="0" cellspacing="0">
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
		
		<div id="layout"></div>  <!--实现灰色透明层效果-->
	    <div id="box">
	    <div id="title">提示</div>
		<div id="closed">×</div>
		<div id="boxcontent">
			<div id="content">
				<img src="/gas/images/check.png" width="32px" height="32px"/>
				<span class="tips">&nbsp;&nbsp;&nbsp;是否删除住户?</span></div>
			<div id="buttons"><input type="button" class="closed-btn btn" value="取消"/><input type="button" id="ok-btn" class="btn" value="确定" /></div>
		</div>
	</div>
</div>

<script>
function clickDel(id){
    layout.style.display = "block"; 
    box.style.display = "block"; 
    
    var mybutton = document.getElementById("ok-btn");
    mybutton.onclick = function(){
    	window.location.href="/gas/deleteCustomer/"+id;
        layout.style.display = "none"; 
        box.style.display = "none"; 
        return true;
    }
    return false;
}
</script>