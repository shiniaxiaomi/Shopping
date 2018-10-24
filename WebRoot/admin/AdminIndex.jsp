<%@page import="com.lyj.shopping.util.FileUtil"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%@ include file="SessionCheck.jsp" %>

<%
String s=request.getParameter("admin");
if(s!=null && s.equals("false")){
	session.setAttribute("admin", "false");
	response.sendRedirect("Login.jsp");
}
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

  <head>
    <base href="<%=basePath%>">
    
    <title>AdminIndex</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
  </head>
  
  <frameset rows="6%,*" >
  	<frame noresize scrolling="NO" src="admin/Title.jsp">	<!-- 顶上 -->

  	<frameset cols="15%,*" id="di">
  		<frame noresize src="admin/Tree.jsp">	<!-- 左边 -->
  		<frameset rows="75%,*" noresize id="right">		<!-- 右边 -->
			<frame name="main" scrolling="YES">	<!-- 右边上面 -->
  			<frame name="detail" scrolling="YES">	<!-- 右边下面 -->
  		</frameset>
  	</frameset>
  </frameset>	
	
	
</html>
