<%@page import="com.lyj.shopping.util.FileUtil"%>
<%@page import="com.lyj.shopping.UserMgr"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%@ include file="SessionCheck.jsp" %>

<%
String id=request.getParameter("id");
//FileUtil.writeTime(Integer.parseInt(id), true);
if(id!=null){
	try{
		UserMgr.deleteUser(Integer.parseInt(id));
	}catch(NumberFormatException e){
		e.printStackTrace();
	}
}else {
	out.println("删除失败!");
	return ;
}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'DeleteUser.jsp' starting page</title>
    
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
    删除成功!
    <script type="text/javascript">
		window.parent.main.document.location.reload();//重新刷新页面
    </script>
  </body>
</html>
