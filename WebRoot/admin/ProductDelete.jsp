<%@page import="java.sql.Timestamp"%>
<%@page import="java.awt.Window"%>
<%@page import="com.lyj.shopping.ProductMgr"%>
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
			boolean isDeleted=ProductMgr.getInstance().deleteProduct(id);
			if(isDeleted){
				out.println("删除成功"+new Timestamp(System.currentTimeMillis()));
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
  
  <body onload="go(<%=request.getParameter("pageNo")%>)"">
  	
  	<script type="text/javascript">
  	function go(pageNo){
  		window.open("admin/ProductList.jsp?pageNo="+pageNo,"main");
  	}
  	</script>

  </body>
</html>
