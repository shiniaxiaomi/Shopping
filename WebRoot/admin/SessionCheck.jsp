<%@page import="com.lyj.shopping.util.FileUtil"%>




<% 
String admin=(String)session.getAttribute("admin");
if(admin==null || !admin.equals("true")){
	response.sendRedirect("Login.jsp");
}
%>