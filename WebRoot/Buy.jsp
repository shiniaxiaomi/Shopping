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
	request.setCharacterEncoding("utf-8");
	
	String strProductId=request.getParameter("productId");
	int productId=1;
	if(strProductId!=null && !strProductId.trim().equals("")){
		productId=Integer.parseInt(strProductId);
	}
	
	String strNum=request.getParameter("num");//购买数量
	int num=1;
	if(strNum!=null && !strNum.trim().equals("")){
		num=Integer.parseInt(strNum);
	}
	
	Product p=ProductMgr.getInstance().loadById(productId);
	if(p!=null){//设置购买的数量
		CartItem ci=new CartItem();
		ci.setProductId(p.getId());

		ci.setNormalPrice(p.getNormalPrice());
		ci.setMemberPrice(p.getMemberPrice());
		ci.setPeoductName(p.getName());
		
		List<CartItem> items=cart.getItems();	
		int i;
		for(i=0;i<items.size();i++){
			CartItem item=items.get(i);
			if(item.getProductId()==productId){
				item.setCount(item.getCount()+num);
				break;
			}
		}
		if(i==items.size()){
			ci.setCount(num);
			cart.add(ci);
		}

		
		response.sendRedirect("Cart.jsp");
	}else {
		out.println("添加到购物车失败!");
		return;
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
  	
  


  </body>
</html>
