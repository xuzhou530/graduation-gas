<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  

<!-- 弹窗的css与js-->
<link href="/gas/css/popup.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="/gas/js/popup.js"></script>

<div id="content">
	<div class="addtitle">
		<div class="status-title">系统管理——所有小区</div>
		<div style="float:right;margin:5px 90px 0 0;">			
			<a class="add-btn" href="/gas/addArea"><strong>+</strong>新建小区</a>
		</div>
		<div style="clear:both;"></div>
	</div>	
	<div id="datalist">
		<span>
			<div id="image">
				<image src="/gas/images/text.png" style="width:20px; height:20px;" />
			</div>
			小区列表&nbsp;
		</span>
		<table id="maintable">
		<tr>
			<td width="3%"  class="tablehead">序号</td>
			<td width="8%" class="tablehead">区县名</td>
			<td width="8%" class="tablehead">小区名</td>
			<td width="12%" class="tablehead">小区地址</td>
			<td width="7%" class="tablehead">小区规模</td>
			<td width="7%" class="tablehead">小区住户数</td>
			<td width="10%" class="tablehead">操作</td>
		</tr>
		<c:forEach items="${addresses}" var="item" varStatus="status"> 
		  <tr class="tablerow">
			<td class="tablecontent">${status.count}</td>
			<td class="tablecontent">${item.addressDistrict}</td>
			<td class="tablecontent">${item.addressArea}</td>
			<td class="tablecontent">${item.addressLocation}</td>
			<td class="tablecontent">${item.addressBuildings}栋</td>
			<td class="tablecontent">${item.addressCustomers}户</td>
			<td class="tablecontent">
				<span style="cursor:pointer"><a class="del-btn" href="/gas/jumpModifyArea/${item.addressId}">
					<img src="/gas/images/pencil.png">&nbsp;修改&nbsp;&nbsp;&nbsp;</a></span>
				<span style="cursor:pointer"><a class="del-btn" onclick="return clickDel('${item.addressId}')">
					<img src="/gas/images/remove.png">&nbsp;删除</a></span></td>
		  </tr>
		 </c:forEach>
		 </table>	
		<br/>
	</div>
	
	<div id="layout"></div>  <!--实现灰色透明层效果-->
    <div id="box">
    <div id="title">提示</div>
	<div id="closed">×</div>
	<div id="boxcontent">
		<div id="content">
			<img src="/gas/images/check.png" width="32px" height="32px"/>
			<span class="tips">&nbsp;&nbsp;&nbsp;是否删除小区?</span></div>
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
    	window.location.href="/gas/deleteAddress/"+id;
        layout.style.display = "none"; 
        box.style.display = "none"; 
        return true;
    }
    return false;
}
</script>