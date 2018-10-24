<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.lyj.shopping.util.*" %>
<%@ page import="com.lyj.shopping.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%@ include file="SessionCheck.jsp" %>

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
	    		<td>Username</td>
	    		<td>Phone</td>
	    		<td>Addr</td>
	    		<td>Rdate</td>
	    		<td>Operation</td>
	    	</tr>
	    	
	   		<%
		   		for(Iterator<MyUser> it=UserMgr.getUsers().iterator();it.hasNext();){
		   			MyUser user=it.next();
		   	%>
	    		<tr>
		    		<td><%=user.getId() %></td>
		    		<td><%=user.getUsername() %></td>
		    		<td><%=user.getPhone() %></td>
		    		<td><%=user.getAddr() %></td>
		    		<td><%=user.getRdate() %></td>
		    		<td align="center"><a href="admin/DeleteUser.jsp?id=<%=user.getId()%>" target="detail">删除</a></td>
		    	</tr>
	    	
	    	<%
	    	}
	    	%>
	    	
	    </table>
    </div>
    
    
  </body>
</html>
