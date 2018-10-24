<%@page import="com.lyj.shopping.util.FileUtil"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>


<%
String username=request.getParameter("username");
String password=request.getParameter("password");

boolean isLogin=false;
if(username!=null && username.equals("admin")){
	if(password!=null && password.equals("admin")){
		isLogin=true;
	}
}

FileUtil.writeTime(isLogin,true);

if(isLogin){
	session.setAttribute("admin", "true");
	response.sendRedirect("AdminIndex.jsp?admin=true");
 
}else {
	out.println("用户名或密码错误，请重新登陆!");
}
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<script type="text/javascript">
function clean() {
	document.getElementById("form").reset();
	
}

</script>

  <head>
    <base href="<%=basePath%>">
    
    <title>Login</title>
    
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
  
  	<div align="center">
	  	<form action="admin/Login.jsp" id="form" method="post">
	    	<table border="1" >
	    		<tr>
	    			<td>
	    				用户名:
	    			</td>
	    			<td>
	    				<input type="text" name="username">
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>
	    				密码:
	    			</td>
	    			<td>
	    				<input type="password" name="password">
	    			</td>
	    		</tr>
	    		<tr>
	    			<td colspan="2" align="center">
	    				<input type="submit" value="登入">
	    				<input type="button" value="重置" onclick="clean()">
	    			</td>
	    		</tr>
	    	</table>	    	
	    </form>
  	</div>
    
    
  </body>
</html>
