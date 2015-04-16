<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%> 

<div>
	<h4 class="addtitle">住户信息—添加</h4>		
	<form action="addCustomer" method="get">
		<table width="40%" border="0" cellpadding="0" cellspacing="0" align="left" bordercolor="#CCCCCC">
			<tr><td class="title">住户名:&nbsp;&nbsp;</td><td><input type="text" name="customerName"/></td></tr>
			<tr><td class="title">联系方式:&nbsp;&nbsp;</td><td><input type="text" name="customerPhone"/></td></tr>
			<tr><td class="title">区县:&nbsp;&nbsp;</td>
				<td>
					<select name="districtName" style="width: 277px; height:30px;" onchange="cascade(this.value)" >
						<option value =-1>-请选择-</option>
						<option value =0>利州区</option>
						<option value =1>昭化区</option>
						<option value=2>朝天区</option>
						<option value=3>旺苍县</option>
						<option value=4>青川县</option>
						<option value=5>剑阁县</option>	
						<option value=6>苍溪县</option>	
					</select>
				</td>
			</tr>
			<tr><td class="title">小区:&nbsp;&nbsp;</td><td>	
				<select id="areaName" name="areaName" style="width:277px; height:30px;">
					<option value =0>-请选择-</option>
					<option value =0>黄金小区</option>
				</select></td>
			</tr>
			<tr><td class="title">楼号:&nbsp;&nbsp;</td><td><input type="text" name="addressBuilding"/></td></tr>
			<tr><td class="title">楼层:&nbsp;&nbsp;</td><td><input type="text" name="addressLayer"/></td></tr>
			<tr><td class="title">房号:&nbsp;&nbsp;</td><td><input type="text" name="addressRoom"/></td></tr>
			<tr><td class="title">&nbsp;</td>
				<td><input class="buttonsave" type="submit" value="保存"/>&nbsp;&nbsp;
					<input class="buttonreset" type="reset" value="重置"/>
				</td>
			</tr>
		</table>
	</form>			
</div>

<script type="text/javascript">
	setInterval("document.getElementById('time').innerHTML=new Date().toLocaleString();",5);

	//XMLHttpRequest组件
	var xhs;
	//区域菜单的值发生改变时调用该方法,并把区域菜单当前的value传递进来
	function cascade(id){
		id++;
	    //当id不大于0时，说明当前选择的是“请选择”这一项，则不做操作
	    if(id>0){
	    	var t=(new Date()).getTime();
	        //请求字符串,把区域的id作为页面参数传到后台
	        var url="cascade?id="+id+"&t="+t;
	        //创建XMLHttpRequest组件
	        xhs=createXmlHttpRequest();
	        //设置回调函数,processReuqest方法的定义在下面
	        xhs.onreadystatechange=processReuqest;
	        //打开与服务器的地址连接
	        xhs.open("get", url, true);
	        //发送请求
	        xhs.send(null);
	    }
	}
	
	//processReuqest方法作为回调方法
	function processReuqest(){
	    if(xhs.readyState==4){
	        if(xhs.status==200){
	            //创建新的select节点
	            var newSelect=document.getElementById("areaName"); 
	            newSelect.options.length=0; 
	            var op=document.createElement("option");
	            op.value=0;
	            op.innerHTML="-请选择-";
	            newSelect.appendChild(op);
	            //得到完成请求后返回的字串符
	            var str = xhs.responseText;
	            //根据返回的字符串为新创建的select节点添加option节点
	            var arr1=str.split(",");
	            //alert(arr1);
	            for(var i=0;i<arr1.length;i++){
	                var child=document.createElement("option");
	                child.innerHTML=arr1[i];
	                child.value=arr1[i];
	                newSelect.appendChild(child);
	            }
	        }
	    }
	}
	function createXmlHttpRequest(){
	    if(window.ActiveXObject){
	        return new ActiveXObject("Microsoft.XMLHTTP");
	    }else if(window.XMLHttpRequest){
	        return new XMLHttpRequest();
	    }
	}
</script>