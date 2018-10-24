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


<%
	request.setCharacterEncoding("utf-8");
	
	String strProductId=request.getParameter("productId");
	int productId=0;
	if(strProductId!=null && !strProductId.trim().equals("")){
		productId=Integer.parseInt(strProductId);
	}
	
	Product p=ProductMgr.getInstance().loadById(productId);

	
	String action = request.getParameter("action");
	if (action != null && action.trim().equals("add")) {

		
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>商品详细信息</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="desrciption" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	
	<script type="text/javascript">
	function check() {

		var num=document.getElementById("num").value;

		if(num%1===0){
			return true;
		}else{
			alert("请输入正确的购买数量");
			return false;
		}
			

	} 
	</script>

  </head>
  
  <body>
  	
  	<form action="Buy.jsp?productId=<%=p.getId() %>" method="post">
  		<input type="hidden" name="action" value="add">
		<table>
			<tr>
				<td colspan="2" align="center">产品详细信息</td>
			</tr>
			<tr>
				<td>产品名称:</td>
				<td><input type="text" name="name" value="<%=p.getName() %>"></td>
			</tr>
			<tr>
				<td>产品描述:</td>
				<td><textarea rows="8" cols="40" name="desrc" ><%=p.getDesrc() %></textarea></td>
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
				<td>类别ID:</td>
				<td><input type="text" name="categoryId" value="<%=p.getStrCategoryId() %>"></td>
			</tr>
			<tr>
				<td>购买数量:</td>
				<td><input type="text" id="num" name="num" value="1"></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="submit" value="购买" onclick="return check()"></td>
			</tr>
		</table>
	</form>


  </body>
</html>
