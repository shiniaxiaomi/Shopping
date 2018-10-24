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
	Category c=new Category();
	String strId=request.getParameter("id");
	if(strId!=null){
		try{
			int id=Integer.parseInt(strId);
			c=Category.loadById(id);
		}catch(NumberFormatException e){
			out.println("请选择正确的id");
		}
		
	}
	
	

	
	String action = request.getParameter("action");
	if (action != null && action.trim().equals("modify")) {
		String name=request.getParameter("name");
		String desrc=request.getParameter("desrc");
		
		if(name!=null && !name.trim().equals("") && desrc!=null  && !desrc.trim().equals("")){
			c.setName(name);
			c.setDesrc(desrc);
			boolean isModified=Category.modify(c);
			if(isModified){
				out.println("更改成功");
			}
			return ;
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
  	
  	<form action="admin/CategoryModify.jsp" method="post">
  		<input type="hidden" name="action" value="modify">
  		<input type="hidden" name="id" value="<%=c.getId() %>">
		<table>
			<tr>
				<td colspan="2" align="center">更改节点</td>
			</tr>
			<tr>
				<td>类别名称:</td>
				<td><input type="text" name="name" value="<%=c.getName() %>"></td>
			</tr>
			<tr>
				<td>类别描述:</td>
				<td><textarea rows="8" cols="40" name="desrc"><%=c.getDesrc() %></textarea></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="submit" value="提交"></td>
			</tr>
		</table>
	</form>


  </body>
</html>
