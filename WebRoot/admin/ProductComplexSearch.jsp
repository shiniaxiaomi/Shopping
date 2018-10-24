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
String keyWord;
double lowNormalPrice;
double highNormalPrice;
double lowMemberPrice;
double highMemberPrice;
int categoryId;
Timestamp startDate;
Timestamp endDate;
%>

<%
	request.setCharacterEncoding("utf-8");

	keyWord=request.getParameter("keyWord").trim();
	
	lowNormalPrice=StringUtil.changeDouble(request.getParameter("lowNormalPrice"));
	highNormalPrice=StringUtil.changeDouble(request.getParameter("highNormalPrice"));
	lowMemberPrice=StringUtil.changeDouble(request.getParameter("lowMemberPrice"));
	highMemberPrice=StringUtil.changeDouble(request.getParameter("highMemberPrice"));
	categoryId=StringUtil.changeInt(request.getParameter("categoryId"));
	
	String strStartDate=request.getParameter("startDate");
	if(strStartDate==null||strStartDate.trim().equals("")||strStartDate.trim().equals("null")){
		startDate=null;
	}else{
		startDate=Timestamp.valueOf(request.getParameter("startDate"));
	}		
	
	String strEndDate=request.getParameter("endDate");
	if(strEndDate==null||strEndDate.trim().equals("")||strEndDate.trim().equals("null")){
		endDate=null;
	}else{
		endDate=Timestamp.valueOf(request.getParameter("endDate"));
	}
	
	int[] idArray=new int[1];
	idArray[0]=categoryId;
	
	int pageSize=3;
	String strPageNo=request.getParameter("pageNo");
	int pageNo=1;
	if(strPageNo!=null){
		try{
			pageNo=Integer.parseInt(strPageNo);
		}catch(NumberFormatException e){
			out.println("请输入整数!");
		}
	}
	if(pageNo<1) pageNo=1;	
	
	
	List<Product> products=new ArrayList<Product>();
	int pageCount=ProductMgr.getInstance().findProducts(products,idArray, keyWord, lowNormalPrice, highNormalPrice,
										 lowMemberPrice, highMemberPrice, startDate, endDate, pageNo, pageSize);
				
	
	if(pageNo>pageCount-1) pageNo=pageCount-1;			 
	if(pageNo<1) pageNo=1;	
	
	
	%>
	<div class="level1" >
		<center>搜索结果</center>
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
		    		<td align="center"><a href="admin/ProductDelete.jsp?id=<%=p.getId() %>" target="detail">删除</a></td>
		    		<td align="center"><a href="admin/ProductModify.jsp?id=<%=p.getId() %>" target="main">更改</a></td>
		    	</tr>
	    	
	    	<% 
	    	}
	    	%>
	    	
	    </table>
	    
	    <div align="right">
	    	共<%=pageCount %>页&nbsp;&nbsp;
	    	第<%=pageNo %>页&nbsp;&nbsp;
	    	<a href="ProductComplexSearch.jsp?pageNo=0&action=complexSearch&keyWord=<%=keyWord %>
		    	&lowNormalPrice=<%=lowNormalPrice %>&highNormalPrice=<%=highNormalPrice %>
		    	&lowMemberPrice=<%=lowMemberPrice %>&highMemberPrice=<%=highMemberPrice %>
		    	&categoryId=<%=categoryId %>&startDate=<%=startDate %>&endDate=<%=endDate %>">首页
	    	</a>&nbsp;&nbsp;
	    	<a href="ProductComplexSearch.jsp?pageNo=<%=(pageNo-1)>1?(pageNo-1):1 %>&action=complexSearch&keyWord=<%=keyWord %>
		    	&lowNormalPrice=<%=lowNormalPrice %>&highNormalPrice=<%=highNormalPrice %>
		    	&lowMemberPrice=<%=lowMemberPrice %>&highMemberPrice=<%=highMemberPrice %>
		    	&categoryId=<%=categoryId %>&startDate=<%=startDate %>&endDate=<%=endDate %>">上一页
	    	</a>&nbsp;&nbsp;
	    	<a href="ProductComplexSearch.jsp?pageNo=<%=(pageNo+1)>(pageCount)?(pageCount):(pageNo+1) %>&action=complexSearch&keyWord=<%=keyWord %>
		    	&lowNormalPrice=<%=lowNormalPrice %>&highNormalPrice=<%=highNormalPrice %>
		    	&lowMemberPrice=<%=lowMemberPrice %>&highMemberPrice=<%=highMemberPrice %>
		    	&categoryId=<%=categoryId %>&startDate=<%=startDate %>&endDate=<%=endDate %>" >下一页
	    	</a>&nbsp;&nbsp;
	    	<a href="ProductComplexSearch.jsp?pageNo=<%=pageCount %>&action=complexSearch&keyWord=<%=keyWord %>
		    	&lowNormalPrice=<%=lowNormalPrice %>&highNormalPrice=<%=highNormalPrice %>
		    	&lowMemberPrice=<%=lowMemberPrice %>&highMemberPrice=<%=highMemberPrice %>
		    	&categoryId=<%=categoryId %>&startDate=<%=startDate %>&endDate=<%=endDate %>">尾页
	    	</a>&nbsp;&nbsp;
	    	
	    	<a href="ProductSearch.jsp?pageNo=<%=pageCount %>action=return&keyWord=<%=keyWord %>
		    	&lowNormalPrice=<%=lowNormalPrice %>&highNormalPrice=<%=highNormalPrice %>
		    	&lowMemberPrice=<%=lowMemberPrice %>&highMemberPrice=<%=highMemberPrice %>
		    	&categoryId=<%=categoryId %>&startDate=<%=startDate %>&endDate=<%=endDate %>">返回搜索页面
	    	</a>&nbsp;&nbsp;
	    	
		</div>
	
	
	</div>

