<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  

<div>
	<div class="addtitle">
		<div class="status-title">住户历史用气量</div>
		<div style="clear:both;"></div>
	</div>	
	<div id="datalist">
		<span>
			<div id="image">
				<image src="/gas/images/list.png" width=20px height=20px/>
			</div>
			${currentDistrict}&nbsp;
			<font class="STYLE1">&gt;</font>&nbsp;${currentArea}&nbsp;
			<font class="STYLE1">&gt;&nbsp;</font>${currentBuilding}栋
		</span>
		<table id="maintable" width="980px" border="1" align="center" bordercolor="#dddddd" cellpadding="0" cellspacing="0">
		<tr>
			<td width="4%"  class="tablehead">序号</td>
			<td width="8%" class="tablehead">用户名</td>
			<td width="8%" class="tablehead">房号</td>
			<td width="8%" class="tablehead">当前燃气值(m<SUP>3</SUP>)</td>
			<td width="8%" class="tablehead">周期内用量(m<SUP>3</SUP>)</td>
			<td width="8%" class="tablehead">账户余额(元)</td>			
			<td width="7%" class="tablehead">联系方式</td>
			<td width="12%" class="tablehead">采集时间</td>
	    </tr>
		<c:forEach items="${gases}" var="item" varStatus="status"> 
		  <tr class="tablerow">
			<td class="tablecontent">${status.count}</td>
			<td class="tablecontent">${customer.customerName}</td>	
			<td class="tablecontent">${customer.addressLayer}0${customer.addressRoom}室</td>
			<td class="tablecontent">${item.gasValue}.00</td>
			<td class="tablecontent">${item.gasValue-item.previousValue}.00</td>
			<td class="tablecontent">${item.gasMoney}.00</td>	
			<td class="tablecontent">${customer.customerPhone}</td>
			<td class="tablecontent">${item.collectTime}</td>
		  </tr> 
		</c:forEach>
		 </table>	
	</div>
</div>