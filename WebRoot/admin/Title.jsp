<%@page import="com.lyj.shopping.util.FileUtil"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%@ include file="SessionCheck.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<script type="text/javascript">
function hide() {
	//parent.document.getElementById("di").cols="2,*";
	//parent.di.cols="2,*";
	top.di.cols="0%,*";

}
function show() {
	top.di.cols="15%,*";

}
function one() {
	top.right.rows="100%,*";
}
function two() {
	top.right.rows="75%,*";
}
function three() {
	top.right.rows="50%,*";
}
function four() {
	top.right.rows="25%,*";

}
function five() {
	top.right.rows="0%,*";

}

function logout() {
	window.open("admin/AdminIndex.jsp?admin=false","_top"); 
}

</script>

  <head>
    <base href="<%=basePath%>">
    
    <title>Title</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
     
     <table style="border:1px solid #0000FF;  width:100%;">
     	<tr>
     		<td style="width: 30%;">
	     		<div>
	     			<input type="button" onclick="hide()" value="隐藏">
	    			<input type="button" onclick="show()" value="显示">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	    			<input type="button" onclick="logout()" value="注销">
	     		</div>
     		</td>
     		<td align="center">
     			<p align="center">后台管理系统</p>
     		</td>
     		<td style="width: 30%; ">
	     		<div align="right" >
	     			<input type="button" onclick="one()" value="100%">
	     			<input type="button" onclick="two()" value="75%">
	   				<input type="button" onclick="three()" value="50%">
	   				<input type="button" onclick="four()" value="25%">
	   				<input type="button" onclick="five()" value="0%">
	     		</div>
     		</td>
     	</tr>
     
     </table>
     
    
  </body>
</html>
