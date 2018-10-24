<%@page import="com.lyj.shopping.MyUser"%>
<%@page import="com.lyj.shopping.Cart"%>
<%@page import="com.lyj.shopping.CartItem"%>
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
//从session中获取cart购物车对象
Cart cart= (Cart)session.getAttribute("cart");
if(cart==null){	//如果没有该对象的话,则new一个对象
	cart=new Cart();
	session.setAttribute("cart", cart);
}
%>

<%
if(cart==null){
	out.println("没有任何购物项");
	return;
}
%>

<%
request.setCharacterEncoding("utf-8");

MyUser user=(MyUser)session.getAttribute("user");
if(user==null){
	out.println("检测到您现在没有登入,可以立即登入或注册后再购买则按照会员价计算,如需继续购买,则按照市场价计算<br>");
	out.println("<div align='center'><a href='UserLogin.jsp'>登入</a>&nbsp;&nbsp;&nbsp;&nbsp;");
	out.println("<a href='Register.jsp'>注册</a></div><br><br><br>");
}

String isChanged=request.getParameter("isChanged");
if(isChanged!=null && isChanged.trim().equals("true")){
	out.println("修改成功");
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

  </head>
  
  <body>
  	<center>您一共购买了这么多的商品</center>
  	
  	<form action="CartUpdate.jsp">
	  	<table border="1" align="center">
		  	<tr>
		  		<td>商品ID</td>
		  		<td>商品名称</td>
		  		<td>会员价</td>
		  		<td>市场价</td>
		  		<td>购买数量</td>
		  		<td>单件商品总价<%=(user==null?"(市场价)":"(会员价)") %></td>
			</tr>
			<%
			List<CartItem> items=cart.getItems();
			for(Iterator<CartItem> it=items.iterator();it.hasNext();){
				CartItem ci=it.next();
			%>
				<tr>
			  		<td><%=ci.getProductId() %></td>
			  		<td><%=ci.getPeoductName() %></td>
			  		<td <%=(user==null?"style='text-decoration: line-through;'":"") %>><%=ci.getMemberPrice() %> </td>
			  		<td <%=(user==null?"":"style='text-decoration: line-through;'") %>><%=ci.getNormalPrice() %></td>
			  		<td>
			  			<input type="text" name="<%="p"+ci.getProductId() %>" value="<%=ci.getCount() %>">
			  		</td>
			  		<td><%=(user==null?ci.getNormalTotalPrice():ci.getMemberTotalPrice()) %></td>
			  		
				</tr>
			<%
			}
			%>
			<tr>
				<td align="center" colspan="6">一共<%=(user==null?cart.getNormalTotalPrice():cart.getMemberTotalPrice()) %>元</td>	
	  		</tr>
			<tr>
				<td align="center" colspan="6">
	  				<input type="submit" value="修改数量">
	  				<input type="button" value="确认订单" onclick="document.location.href='Confirm.jsp'">
				</td>	
	  		</tr>
	  		
	  	</table>
	</form>

  </body>
</html>
