<%@page import="com.lyj.shopping.Product"%>
<%@page import="com.lyj.shopping.ProductMgr"%>
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
	Product p=new Product();
	String strId=request.getParameter("id");
	if(strId!=null){
		try{
			int id=Integer.parseInt(strId);
			p=ProductMgr.getInstance().loadById(id);
		}catch(NumberFormatException e){
			out.println("请选择正确的id");
		}
		
	}
	
	
	String action = request.getParameter("action");
	if (action != null && action.trim().equals("modify")) {
		
		String name=request.getParameter("name");
		String desrc=request.getParameter("desrc");
		String strNoralPrice=request.getParameter("normalPrice");
		String strMemberPrice=request.getParameter("memberPrice");
		String strCategoryId=request.getParameter("categoryId");
		double normalPrice;
		double memberPrice;
		int categoryId;
		if(name!=null && desrc!=null && strNoralPrice!=null && strMemberPrice!=null && strCategoryId!=null){
			try{
				normalPrice=Double.parseDouble(strNoralPrice);
				memberPrice=Double.parseDouble(strMemberPrice);
				categoryId=Integer.parseInt(strCategoryId);
			}catch(NumberFormatException e){
				out.println("请输入正确的数值!");
				return ;
			}
			

			p.setName(name);
			p.setDesrc(desrc);
			p.setNormalPrice(normalPrice);
			p.setMemberPrice(memberPrice);
			p.setCategoryId(categoryId);
			
			boolean isModified=ProductMgr.getInstance().modify(p);
			if(isModified){
				out.println("更改成功");
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
  	
  	<form action="admin/ProductModify.jsp" method="post">
  		<input type="hidden" name="action" value="modify">
  		<input type="hidden" name="id" value="<%=p.getId() %>">
		<table>
			<tr>
				<td colspan="2" align="center">更改产品</td>
			</tr>
			<tr>
				<td>产品名称:</td>
				<td><input type="text" name="name" value="<%=p.getName() %>"></td>
			</tr>
			<tr>
				<td>产品描述:</td>
				<td><textarea rows="8" cols="40" name="desrc"><%=p.getDesrc() %></textarea></td>
			</tr>
			<tr>
				<td>市场价:</td>
				<td><input type="text" name="normalPrice" value="<%=p.getNormalPrice() %>"></td>
			</tr>
			<tr>
				<td>会员价:</td>
				<td><input type="text" name="memberPrice" value="<%=p.getMemberPrice() %>"></td>
			</tr>
			<tr>
				<td>产品类别:</td>
				<td><input type="text" name="categoryId" value="<%=p.getCategoryId() %>"></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="submit" value="提交"></td>
			</tr>
		</table>
	</form>


  </body>
</html>
