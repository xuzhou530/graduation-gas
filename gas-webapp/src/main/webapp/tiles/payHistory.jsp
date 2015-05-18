<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  

<!-- 弹窗的css与js-->
<link href="/gas/css/popup.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="/gas/js/popup.js"></script>

<div id="content">
	<div class="addtitle">
		<div class="status-title">费用管理——费用变动</div>
		<div style="float:right;margin:5px 90px 0 0;">			
			
		</div>
		<div style="clear:both;"></div>
	</div>	
	<div id="datalist">
		<span>
			<div id="image">
				<image src="/gas/images/text.png" style="width:20px; height:20px;" />
			</div>
			缴费&nbsp;
		</span>
		<table id="maintable">
		<tr>
			<td width="9%"  class="tablehead">序号</td>
			<td width="15%" class="tablehead">住户名</td>
			<td width="15%" class="tablehead">房号</td>
			<td width="15%" class="tablehead">缴费金额</td>
			<td width="15%" class="tablehead">缴费时间</td>
			<td width="15%" class="tablehead">操作员</td>
		</tr>
		  <tr class="tablerow">
			<td class="tablecontent">1</td>
			<td class="tablecontent">黄冬冬</td>
			<td class="tablecontent">黄金小区&nbsp;1栋&nbsp;104室</td>
			<td class="tablecontent">100</td>
			<td class="tablecontent">2015.5.17</td>
			<td class="tablecontent">余扬</td>
		  </tr>
		 </table>	
		<br/>
	</div>
</div>
</div>