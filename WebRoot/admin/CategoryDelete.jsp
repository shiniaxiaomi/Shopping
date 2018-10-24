<%@page import="com.lyj.shopping.Dao.CategoryDao"%>
<%@page import="com.lyj.shopping.Category"%>
<%@page import="com.lyj.shopping.util.FileUtil"%>
<%@page import="com.lyj.shopping.UserMgr"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%@ include file="SessionCheck.jsp" %>

<%
	request.setCharacterEncoding("utf-8");
	
	String strId=request.getParameter("id");
	if(strId!=null && !strId.trim().equals("")){
		try{
			int id=Integer.parseInt(strId);
			boolean isDeleted=Category.delete(id);
			if(isDeleted){
				out.println("节点删除成功");
			}else {
				out.println("节点删除失败,该类别下有产品,请先删除该类别下的产品");
			}
		}catch(NumberFormatException e){
			out.println("请选择正确的节点");
		}
		
			
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
  	

  </body>
</html>
