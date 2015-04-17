<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
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
    layout.onclick = function() { 
        layout.style.display = "none"; 
        box.style.display = "none"; 
    }
    layout.style.height = window.screen.height;
}
	
</script>

<div id="content">
	<div class="addtitle">住户管理——所有小区</div>	
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
			<td width="9%" class="tablehead">小区名</td>
			<td width="10%" class="tablehead">小区地址</td>
			<td width="10%" class="tablehead">小区规模</td>
			<td width="10%" class="tablehead">小区住户数</td>
			<td width="7%" class="tablehead">操作</td>
		</tr>
		<c:forEach items="${addresses}" var="item" varStatus="status"> 
		  <tr class="tablerow">
			<td class="tablecontent">${status.count}</td>
			<td class="tablecontent">${item.addressDistrict}</td>
			<td class="tablecontent">${item.addressArea}</td>
			<td class="tablecontent">${item.addressLocation}</td>
			<td class="tablecontent">${item.addressBuildings}栋</td>
			<td class="tablecontent">${item.addressCustomers}户</td>
			<td class="tablecontent"><a class="del-btn" onclick="return clickDel('${item.addressId}')">
				<img src="/gas/images/remove.png">&nbsp;&nbsp;删除</a></td>
		  </tr>
		 </c:forEach>
		 </table>	
		<br/>
	</div>
	<div id="layout"></div>  <!--实现灰色透明层效果-->
	<div id="box">
    <p class="words">是否要删除？</p>
    <div style="text-align:center;margin-top:50px;">
	    <input type="button" id="ok-btn" class="btn" value="确定" />
	    <input type="button" class="closed-btn btn" value="取消"/>
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