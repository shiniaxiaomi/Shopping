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
	
	String strCategoryId=request.getParameter("categoryId");
	int categoryId=0;
	if(strCategoryId!=null && !strCategoryId.trim().equals("")){
		categoryId=Integer.parseInt(strCategoryId);
	}
	

	String action = request.getParameter("action");
	if (action != null && action.trim().equals("add")) {
	
		String name = request.getParameter("name");
		String desrc = request.getParameter("desrc");
		String strNormalPrice=request.getParameter("normalPrice");
		String strMemberPrice=request.getParameter("memberPrice");
		if(name==null ||name.trim().equals("")){
			out.print("产品名称不能为空");	
			return ;
		}
		if(desrc==null ||desrc.trim().equals("")){
			out.print("产品名称不能为空");	
			return ;
		}
		if(strNormalPrice==null ||strNormalPrice.trim().equals("")){
			out.print("市场价不能为空");	
			return ;
		}
		if(strMemberPrice==null ||strMemberPrice.trim().equals("")){
			out.print("会员价不能为空");	
			return ;
		}
		double normalPrice;
		double memberPrice;
		try{
			normalPrice=Double.parseDouble(strNormalPrice);
			memberPrice=Double.parseDouble(strMemberPrice);
		}catch(NumberFormatException e){
			out.print("请输入正确的市场价和会员价");	
			return ;
		}
		
		
		Product p=new Product();
		p.setId(-1);
		p.setName(name);
		p.setDesrc(desrc);
		p.setNormalPrice(normalPrice);
		p.setMemberPrice(memberPrice);
		p.setPdate(new Timestamp(System.currentTimeMillis()));
		p.setCategoryId(categoryId);
		
		ProductMgr.getInstance().addProduct(p);
		out.println("产品添加成功!");
		
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
  	
  	<form action="admin/ProductAdd.jsp" method="post">
  		<input type="hidden" name="action" value="add">
		<table>
			<tr>
				<td colspan="2" align="center">产品添加</td>
			</tr>
			<tr>
				<td>产品名称:</td>
				<td><input type="text" name="name"></td>
			</tr>
			<tr>
				<td>产品描述:</td>
				<td><textarea rows="8" cols="40" name="desrc"></textarea></td>
			</tr>
			<tr>
				<td>市场价:</td>
				<td><input type="text" name="normalPrice"></td>
			</tr>
			<tr>
				<td>会员价:</td>
				<td><input type="text" name="memberPrice"></td>
			</tr>
			<tr>
				<td>类别ID:</td>
				<td>
					<select name="categoryId">
					<% 
					for(Iterator<Category> it=categories.iterator();it.hasNext();){
						Category c=it.next();
						String preStr="";
						for(int i=1;i<c.getGrade();i++){
							preStr+="---";
						}
						if(c.isLeaf()){	
							%>
								<option value="<%=c.getId() %>" <%if(categoryId==c.getId()){out.println("selected='selected'");} %> ><%=preStr+c.getName() %></option>
							<%
						}
					}
					%> 
					</select> 
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="submit" value="提交"></td>
			</tr>
		</table>
	</form>


  </body>
</html>
