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

	int pid=0;
	String strPid = request.getParameter("pid");
	if(strPid!=null && !strPid.trim().equals("")){
		pid=Integer.parseInt(strPid);
	}

	String action = request.getParameter("action");
	if (action != null && action.trim().equals("add")) {
	
		String name = request.getParameter("name");
		String desrc = request.getParameter("desrc");
		
		if(pid==0){
			boolean isSaved=Category.addTopCategory(name,desrc);
			if(isSaved){
				out.println("根节点添加成功!");
			}	
		}else{
			Category c=new Category();
			c.setPid(pid);
			c.setName(name);
			c.setDesrc(desrc);
			boolean isSaved=Category.addChildCategory(c);
			if(isSaved){
				out.println("子节点添加成功!");
			}
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
  	
  	<form action="admin/CategoryAdd.jsp" method="post">
  		<input type="hidden" name="action" value="add">
  		<input type="hidden" name="pid" value="<%=pid%>">
		<table>
			<tr>
				<td colspan="2" align="center"><%=pid==0?"添加根节点":"添加子结点" %></td>
			</tr>
			<tr>
				<td>类别名称:</td>
				<td><input type="text" name="name"></td>
			</tr>
			<tr>
				<td>类别描述:</td>
				<td><textarea rows="8" cols="40" name="desrc"></textarea></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="submit" value="提交"></td>
			</tr>
		</table>
	</form>


  </body>
</html>
