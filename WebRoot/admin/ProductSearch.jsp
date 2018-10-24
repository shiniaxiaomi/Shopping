<%@page import="java.net.URLEncoder"%>
<%@page import="com.lyj.shopping.util.StringUtil"%>
<%@page import="com.lyj.shopping.ProductMgr"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.lyj.shopping.Product"%>
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
List<Category> categories=Category.getCategories();//获取类别

%>


<%
	request.setCharacterEncoding("utf-8");

	String action = request.getParameter("action");
	if (action != null && action.trim().equals("complexSearch")) {
	%>
	<jsp:forward page="ProductComplexSearch.jsp" ></jsp:forward>
	<%
	}else if(action != null && action.trim().equals("simpleSearch")){
	%>
	<jsp:forward page="ProductSimpleSearch.jsp"></jsp:forward>
	<%	
	}else if(action != null && action.trim().equals("simpleSearch2")){
	%>
	<jsp:forward page="ProductSimpleSearch2.jsp"></jsp:forward>
	<%	
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
	<meta http-equiv="desrciption" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	

  </head>
  
  <body>
  	
  	<form action="admin/ProductSearch.jsp" method="post">
  		<input type="hidden" name="action" value="simpleSearch">
		<table>
			<tr>
				<td colspan="2" align="center">简单搜索</td>
			</tr>
			<tr>
				<td>类别:</td>
				<td> 
					<select name="categoryId">
					<option value="0" selected="selected">所有类别</option>
					<% 
					for(Iterator<Category> it=categories.iterator();it.hasNext();){
						Category c=it.next();
						String preStr="";
						for(int i=1;i<c.getGrade();i++){
							preStr+="---";
						}
					%>
						<option value="<%=c.getId() %>"><%=preStr+c.getName() %></option>
					<%
					}
					%> 
					</select> 
				</td>
			</tr>
			<tr>
				<td>关键字:</td>
				<td><input type="text" name="keyWord"></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="submit" value="搜索"></td>
			</tr>
		</table>
	</form>
	
	
	
	<form action="admin/ProductSearch.jsp" method="post">
  		<input type="hidden" name="action" value="simpleSearch2">
		<table>
			<tr>
				<td colspan="2" align="center">简单搜索2</td>
			</tr>
			<tr>
				<td>类别:</td>
				<td> 
					<% 
					for(Iterator<Category> it=categories.iterator();it.hasNext();){
						Category c=it.next();
						String preStr="";
						for(int i=1;i<c.getGrade();i++){
							preStr+="---";
						}
					%>
						<input type="checkbox" name="categoryId" value="<%=c.getId() %>"><%=c.getName() %>&nbsp;&nbsp;
					<%
					}
					%> 
					
				</td>
			</tr>
			<tr>
				<td>关键字:</td>
				<td><input type="text" name="keyWord"></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="submit" value="搜索"></td>
			</tr>
		</table>
	</form>
	


  	<form action="admin/ProductSearch.jsp" method="post" >
  		<input type="hidden" name="action" value="complexSearch" >
		<table>
			<tr>
				<td colspan="2" align="center">复杂搜索</td>
			</tr>
			<tr>
				<td>类别:</td>
				<td> 
					<select name="categoryId">
					<option value="0" selected="selected">所有类别</option>
					<% 
					for(Iterator<Category> it=categories.iterator();it.hasNext();){
						Category c=it.next();
						String preStr="";
						for(int i=1;i<c.getGrade();i++){
							preStr+="---";
						}
					%>
						<option value="<%=c.getId() %>"><%=preStr+c.getName() %></option>
					<%
					}
					%> 
					</select> 
				</td>
			</tr>
			<tr>
				<td>关键字:</td>
				<td><input type="text" name="keyWord"></td>
			</tr>
			<tr>
				<td>市场价:</td>
				<td>
					from<input type="text" name="lowNormalPrice">
					to<input type="text" name="highNormalPrice">
				</td>
			</tr>
			<tr>
				<td>会员价:</td>
				<td>
					from<input type="text" name="lowMemberPrice">
					to<input type="text" name="highMemberPrice">
				</td>
			</tr>
			<tr>
				<td>日期:</td>
				<td>
					from<input type="text" name="startDate">
					to<input type="text" name="endDate">
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="submit" value="搜索"></td>
			</tr>
		</table>
	</form>


  </body>
</html>
