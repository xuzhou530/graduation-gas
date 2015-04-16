<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.young.gas.beans.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<script type="text/javascript">
		// Run capabilities test
		enhance({
			loadScripts: [
				'/gas/js/excanvas.js',
				'/gas/js/jquery.min.js',
				'/gas/js/visualize.jQuery.js',
				'/gas/js/pie.js'
			],
			loadStyles: [
				'/gas/css/visualize.css',
				'/gas/css/visualize-dark.css'
			]	
		});   
</script>

<%
	User user=(User)session.getAttribute("user");
	String[] districts={"系统管理员","利州区","昭化区","朝天区","旺苍县","青川县","剑阁县","苍溪县"};	
	int userGrade=user.getUserGrade();
%>

<div>
	<div class="addtitle">运营管理——抄表统计</div>	
	<div id="datalist">
	<span>
		<div id="image">
			<image src="/gas/images/311.gif"/>
		</div>
		${currentDistrict}利州区&nbsp;
	</span>
	<table style="display:none">
	  <caption>
	  小区抄表总数对照表
	  </caption>
	  <thead>
	    <tr>
	      <td></td>
	      <th scope="col">gas</th>
	    </tr>
	  </thead>
	  <tbody>
	    <tr>
	      <th scope="row">黄金小区</th>
	      <td>23</td>
	    </tr>
	    <tr>
	      <th scope="row">和苑小区</th>
	      <td>23</td>
	      <td>34</td>
	      <td>23</td>
	      <td>34</td>
	    </tr>
	    <tr>
	      <th scope="row">东风小区</th>
	      <td>23</td>
	      <td>34</td>
	      <td>23</td>
	      <td>34</td>
	    </tr>
	    <tr>
	      <th scope="row">常发豪郡</th>
	      <td>23</td>
	      <td>34</td>
	      <td>23</td>
	      <td>34</td>
	    </tr>
	   	<tr>
	      <th scope="row">世纪之城</th>
	      <td>23</td>
	      <td>34</td>
	      <td>23</td>
	      <td>34</td>
	    </tr>
	    <tr>
	      <th scope="row">皇家花园</th>
	      <td>23</td>
	      <td>34</td>
	      <td>23</td>
	      <td>34</td>
	    </tr>
	  </tbody>
	</table>
	<br/><br/>			
	</div>
</div>