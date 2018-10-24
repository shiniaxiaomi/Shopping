<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.lyj.shopping.util.*" %>
<%@ page import="com.lyj.shopping.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%@ include file="SessionCheck.jsp" %>

<%
List<Category> categories=Category.getCategories();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'userlist.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	
<STYLE TYPE='text/css'>
.level1 {
	margin-left: 200px;
	margin-right: 200px;
}
</STYLE>

  </head>
  
  <body>
  	<div class="level1" >
	    <table border="4" style=" width:100%;">
	    	<tr>
	    		<td>ID</td>
	    		<td>Name</td>
	    		<td>PID</td>
	    		<td>Grade</td>
	    		<td>添加类别操作</td>
	    		<td>删除操作</td>
	    		<td>更改操作</td>
	    		<td>添加产品操作</td>
	    		<td>该类别下的产品个数</td>
	    		
	    	</tr>
	    	
	   		<%
		   		for(Iterator<Category> it=categories.iterator();it.hasNext();){
		   			Category c=it.next();
		   			String preStr="";
		   			for(int i=1;i<c.getGrade();i++){
		   				preStr=preStr+"--------";
		   			}
		   	%>
	    		<tr>
		    		<td><%=c.getId() %></td>
		    		<td><%=preStr+c.getName() %></td>
		    		<td><%=c.getPid() %></td>
		    		<td><%=c.getGrade() %></td>
		    		<td><a href="admin/CategoryAdd.jsp?pid=<%=c.getId() %>">添加结点</a></td>
		    		<td><a href="admin/CategoryDelete.jsp?id=<%=c.getId() %>">删除结点</a></td>
		    		<td><a href="admin/CategoryModify.jsp?id=<%=c.getId() %>">更改结点</a></td>
		    		<%
		    		if(c.isLeaf()){
		    		%>
		    			<td><a href="admin/ProductAdd.jsp?categoryId=<%=c.getId() %>">添加产品</a></td>
		    			<td><%=c.getProductNum() %></td>
		    		<%
		    		}
		    		%>
		    		
		    	</tr>
	    	
	    	<%
	    	}
	    	%>
	    	
	    </table>
    </div>
    
    
  </body>
</html>
