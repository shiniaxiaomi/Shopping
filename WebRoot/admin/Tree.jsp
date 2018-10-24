<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.lyj.shopping.util.*" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<%@ include file="SessionCheck.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<STYLE TYPE='text/css'>
.level1 {
	margin-left: 20;
}

.level2 {
	display: none;
	margin-left: 28;
}
</STYLE>

<script type="text/javascript">
function init() {
	var a=document.getElementsByTagName("div");//a是所有div数组
	//for语句遍历 把所有的div的id名称存放在b数组中
	var obj;
	for(var i=0;i<a.length;i++)
	{
		if(a[i].id!=""){
			obj=document.getElementById(a[i].id);
			obj.style.display="none";
		}	
	}
	
}

function change(name) {

	var obj=document.getElementById(name);
	if(obj.style.display=="none"){
		obj.style.display="block";
	}else if(obj.style.display=="block"){
		obj.style.display="none";
	}
	
}

function unfold() {
	var a=document.getElementsByTagName("div");//a是所有div数组
	//for语句遍历 把所有的div的id名称存放在b数组中
	var obj;
	for(var i=0;i<a.length;i++)
	{
		if(a[i].id!=""){
			obj=document.getElementById(a[i].id);
			obj.style.display="block";
		}	
	}
}

function fold() {
	var a=document.getElementsByTagName("div");//a是所有div数组
	//for语句遍历 把所有的div的id名称存放在b数组中
	var obj;
	for(var i=0;i<a.length;i++)
	{
		if(a[i].id!=""){
			obj=document.getElementById(a[i].id);
			obj.style.display="none";
		}	
	}
}



</script>

<head>
<base href="<%=basePath%>">

<title>Tree</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

</head>

<body onload="init()">

	<div class="level1">
		<input type="button" onclick="unfold()" value="展开">
		<input type="button" onclick="fold()" value="收起">
	</div>

	<DIV CLASS="level1" >
		<A class=OUTDENT href="" onclick="change('head2Child');return false;"> 用户管理</a>
	</DIV>
	
	<DIV CLASS="level2" ID='head2Child'>
		<A href="admin/UserList.jsp" id=ttt target="main"><LI>用户列表</LI></a>
		<!-- 
			<A href="UserList.jsp" id=ttt target="main"><LI>用户列表</LI></a>
			<A href="RoleManager.jsp" id=ttt target="main"><LI>系统角色</LI></a>
			<A href="RoleManager.jsp" id=ttt target="main"><LI>用户删除</LI></a>
		-->
	</DIV>
	
	<DIV CLASS="level1" >
		<A class=OUTDENT href="" onclick="change('head3Child');return false;"> 类别管理</a>
	</DIV>
	
	<DIV CLASS="level2" ID='head3Child'>
		<A href="admin/CategoryList.jsp" id=ttt target="main"><LI>类别列表</LI></a>
		<A href="admin/CategoryAdd.jsp" id=ttt target="main"><LI>类别添加</LI></a>
	</DIV>
	
	<DIV CLASS="level1" >
		<A class=OUTDENT href="" onclick="change('head4Child');return false;"> 订单管理</a>
	</DIV>
	
	<DIV CLASS="level2" ID='head4Child'>
		<A href="admin/OrderList.jsp" id=ttt target="main"><LI>订单列表</LI></a>
	</DIV>
	
	<DIV CLASS="level1" >
		<A class=OUTDENT href="" onclick="change('head6Child');return false;"> 新闻发布</a>
	</DIV>
	
	<DIV CLASS="level2" ID='head6Child'>
		<A href="News.jsp" id=ttt target="main"><LI>新闻管理</LI></a>
	</DIV>
	
	<DIV CLASS="level1" >
		<A class=OUTDENT href="" onclick="change('head7Child');return false;"> 组织结构</a>
	</DIV>
	
	<DIV CLASS="level2" ID='head7Child'>
		<A href="Applier.jsp" id=ttt target="main"><LI>组织结构管理</LI></a>
	</DIV>
	
	<DIV CLASS="level1" >
		<A class=OUTDENT href="" onclick="chang e('head8Child');return false;"> 直播管理</a>
	</DIV>
	
	<DIV CLASS="level2" ID='head8Child'>
	      <A href="Live.jsp" id=ttt target="main"><LI>直播组织</LI></a>
	      <A href="LiveWorkstation.jsp" id=ttt target="main"><LI>直播工作站管理</LI></a>
	</DIV>
	
	<DIV CLASS="level1" >
		<A class=OUTDENT href="" onclick="change('head9Child');return false;"> 订单管理</a>
	</DIV>
	
	<DIV CLASS="level2" ID='head9Child'>
	      <A href="Live.jsp" id=ttt target="main"><LI>直播组织</LI></a>
	      <A href="LiveWorkstation.jsp" id=ttt target="main"><LI>直播工作站管理</LI></a>
	</DIV>	

</body>
</html>
