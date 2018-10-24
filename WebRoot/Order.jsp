<%@page import="com.lyj.shopping.SalesOrder"%>
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
	user=new MyUser();
	user.setId(-1);
}

%>

<% 
String addr=request.getParameter("addr");
SalesOrder so=new SalesOrder();
so.setCart(cart);
so.setAddr(addr);
so.setUser(user);
so.setoDate(new Timestamp(System.currentTimeMillis()));
so.setStates(0);

so.save();

session.removeAttribute("cart");

%>

<center>
	谢谢你在本站购物,欢迎再次光临!
</center>



