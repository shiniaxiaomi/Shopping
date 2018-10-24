<%@page import="com.lyj.shopping.Cart"%>
<%@page import="com.lyj.shopping.MyUser"%>
<%@page import="com.lyj.shopping.exception.PasswordNotCorrectException"%>
<%@page import="com.lyj.shopping.exception.UserNotFoundException"%>
<%@page import="com.lyj.shopping.UserMgr"%>
<%@page import="com.lyj.shopping.util.FileUtil"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
String username=request.getParameter("username");
String password=request.getParameter("password");

if(username!=null && password!=null){
	MyUser user=null;
	
	try{
		user=UserMgr.validate(username, password);
	}catch(UserNotFoundException e){
		out.println("用户名不存在!");
		return;
	}catch(PasswordNotCorrectException e){
		out.println("密码不正确!");
		return;
	}	
	
	if(user!=null){
		Cart cart=(Cart)session.getAttribute("cart");
		if(cart==null){
			cart=new Cart();
		}
		cart.setMember(true);
		
		session.setAttribute("user", user);
		session.setAttribute("cart", cart);
		response.sendRedirect("index.jsp");
	}
}




%>


<html>
<head>

<base href="<%=basePath%>">

<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>用户登入</title>
<link href="./Login/login.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
function clean() {
	document.getElementById("form").reset();
	
}

</script>

</head>
<body>

<div class="login_box">
      <div class="login_l_img"><img src="./Login/login-img.png"></div>
      <div class="login">
          <div class="login_logo"><img src="./Login/login_logo.png"></div>
          <div class="login_name">
               <p style="height: 50px; ">用户登入 </p>
               
          </div>
          <form action="UserLogin.jsp" method="post" id="form">          
              <input name="username" type="text" value="用户名" onfocus="this.value=&#39;&#39;" onblur="if(this.value==&#39;&#39;){this.value=&#39;用户名&#39;}">
              <span id="password_text" onclick="this.style.display=&#39;none&#39;;document.getElementById(&#39;password&#39;).style.display=&#39;block&#39;;document.getElementById(&#39;password&#39;).focus().select();">密码</span>
			  <input name="password" type="password" id="password" style="display:none;" onblur="if(this.value==&#39;&#39;){document.getElementById(&#39;password_text&#39;).style.display=&#39;block&#39;;this.style.display=&#39;none&#39;};">
              <input value="登录" style="width:45%;" type="submit">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              <input value="重置" style="width:45%;" type="button" onclick="clean()">
              
          </form>
      </div>
</div>



</body>
</html>