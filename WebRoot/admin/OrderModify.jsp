<%@page import="java.awt.Window"%>
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
String strId=request.getParameter("id");
int id=0;
if(strId!=null && !strId.trim().equals("")){
	id=Integer.parseInt(strId);
}


SalesOrder so=OrderMgr.getInstance().loadById(id);

String action=request.getParameter("action");
if(action!=null && action.trim().equals("modify")){
	int status=Integer.parseInt(request.getParameter("status"));
	so.setStates(status);
	so.updateStates();
%>

<script type="text/javascript">
<!--
	window.parent.main.document.location.reload();//让main这个页面重新刷新
	
//-->
</script>
	
<%	
}

%>

<center>
	下单人:<%=so.getUser().getUsername() %><br>
	<form id="form" name="form" action="OrderModify.jsp" method="post">
		<input type="hidden" name="action" value="modify">
		<input type="hidden" name="id" value="<%=id %>">
		<select name="status">
			<option value="0" <%=(so.getStates()==0?"selected='selected'":"") %>>未处理</option>
			<option value="1" <%=(so.getStates()==1?"selected='selected'":"") %>>已处理</option>
			<option value="2" <%=(so.getStates()==2?"selected='selected'":"") %>>费单</option>
		</select><br>
		
		<input type="submit" value="提交">
		
	</form>

</center>


