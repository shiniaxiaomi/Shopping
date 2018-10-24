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

List<CartItem> items=cart.getItems();
for(int i=0;i<items.size();i++){
	CartItem ci=items.get(i);
	String strCount=request.getParameter("p"+ci.getProductId());
	if(strCount!=null && !strCount.trim().equals("")){
		ci.setCount(Integer.parseInt(strCount));
	}
	
}


response.sendRedirect("Cart.jsp?isChanged=true");


%>



