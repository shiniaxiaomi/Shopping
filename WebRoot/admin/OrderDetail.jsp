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
String strId=request.getParameter("id");
int id=0;
if(strId!=null && !strId.trim().equals("")){
	id=Integer.parseInt(strId);
}


SalesOrder so=OrderMgr.getInstance().loadById(id);

%>

<<script type="text/javascript">
<!--
	function showProductInfo(desrc) {
		document.getElementById("productInfo").innerHTML="<font size=3 color=red>"+desrc+"</font>";
	}
//-->
</script>

<center>
	下单人:<%=so.getUser().getUsername() %><br>
	明细:<br>
		<table border="1" align="center">
		  	<tr>
		  		<td>商品名称</td>
		  		<td>商品价格</td>
		  		<td>购买数量</td>

			</tr>
			<%
			List<SalesItem> items=so.getItems();
			for(Iterator<SalesItem> it=items.iterator();it.hasNext();){
				SalesItem si=it.next();
			%>
				<tr>
			  		<td onmousemove="showProductInfo('<%=si.getProduct().getDesrc() %>')"><%=si.getProduct().getName() %></td>
			  		<td><%=si.getUnitPrice() %></td>
			  		<td><%=si.getCount() %></td>
			  		
				</tr>
			<%
			}
			%>


	  	</table>
	  	
	  	
	<div style="border: 5px double purple;width: 400" id="productInfo">
		&nbsp;
	
	</div>
	

</center>
