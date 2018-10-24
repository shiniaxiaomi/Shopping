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
String strPageNo=request.getParameter("pageNo");
String strPageCount=request.getParameter("pageCount");
int pageNo=1;
int pageCount=1;
if(strPageNo!=null){
	try{
		pageNo=Integer.parseInt(strPageNo);
	}catch(NumberFormatException e){
		out.println("请输入正确的页数!");
	}
}
if(strPageCount!=null){
	try{
		pageCount=Integer.parseInt(strPageCount);
	}catch(NumberFormatException e){
		out.println("请输入正确的页的总数!");
	}
}

if(pageNo<1) pageNo=1;
if(pageNo>pageCount) pageNo=pageCount;


int pageSize=3;
List<Product> products=new ArrayList<Product>();
pageCount=ProductMgr.getInstance().getProducts(products, pageNo, pageSize);


if(pageNo<1) pageNo=1;
if(pageNo>pageCount) pageNo=pageCount;
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
	    		<td>Desrc</td>
	    		<td>NormalPrice</td>
	    		<td>MemberPrice</td>
	    		<td>PDate</td>
	    		<td>CategoryId</td>
	    		<td>删除操作</td>
	    		<td>更改操作</td>
	    	</tr>
	    	
	   		<%
		   		for(Iterator<Product> it=products.iterator();it.hasNext();){
		   			Product p=it.next();
		   	%>
	    		<tr>
		    		<td><%=p.getId() %></td>
		    		<td><%=p.getName() %></td>
		    		<td><%=p.getDesrc() %></td>
		    		<td><%=p.getNormalPrice() %>元</td>
		    		<td><%=p.getMemberPrice() %>元</td>
		    		<td><%=p.getPdate() %></td>
		    		<td><%=p.getStrCategoryId() %></td>
		    		<td align="center"><a href="admin/ProductDelete.jsp?id=<%=p.getId() %>&pageNo=<%=pageNo %>" target="detail">删除</a></td>
		    		<td align="center"><a href="admin/ProductModify.jsp?id=<%=p.getId() %>" target="main">更改</a></td>
		    	</tr>
	    	
	    	<% 
	    	}
	    	%>
	    	
	    </table>
	    
	    <div align="right">
	    	共<%=pageCount %>页&nbsp;&nbsp;
	    	第<%=pageNo %>页&nbsp;&nbsp;
	    	<a href="admin/ProductList.jsp?pageNo=0&pageCount=<%=pageCount %>">首页</a>&nbsp;&nbsp;
	    	<a href="admin/ProductList.jsp?pageNo=<%=pageNo-1 %>&pageCount=<%=pageCount %>">上一页</a>&nbsp;&nbsp;
	    	<a href="admin/ProductList.jsp?pageNo=<%=pageNo+1 %>&pageCount=<%=pageCount %>">下一页</a>&nbsp;&nbsp;
	    	<a href="admin/ProductList.jsp?pageNo=<%=pageCount %>&pageCount=<%=pageCount %>">尾页</a>
	    </div>
	    
	    
    </div>
    
    
  </body>
</html>
