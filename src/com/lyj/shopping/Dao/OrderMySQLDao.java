package com.lyj.shopping.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.lyj.shopping.Cart;
import com.lyj.shopping.CartItem;
import com.lyj.shopping.MyUser;
import com.lyj.shopping.Product;
import com.lyj.shopping.SalesItem;
import com.lyj.shopping.SalesOrder;
import com.lyj.shopping.util.DB;

public class OrderMySQLDao {

	public boolean saveOrder(SalesOrder so) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rsKey=null;
		try {
			con = DB.getCon();
			con.setAutoCommit(false);
			
			String sql="insert into salesorder values(null,?,?,?,?)";
			pstmt=DB.getPStmt(con, sql,true);
			pstmt.setInt(1, so.getUser().getId());
			pstmt.setString(2, so.getAddr());
			pstmt.setTimestamp(3, so.getoDate());
			pstmt.setInt(4,so.getStates());
			pstmt.executeUpdate();
			rsKey=pstmt.getGeneratedKeys();
			rsKey.next();
			int key=rsKey.getInt(1);//拿到数据库自动生成的id号
			
			String sqlItem="insert into salesitem values(null,?,?,?,?)";
			pstmt=DB.getPStmt(con, sqlItem);
			Cart cart=so.getCart();
			List<CartItem> items=cart.getItems();
			for(int i=0;i<items.size();i++){
				CartItem ci=items.get(i);
				
				pstmt.setInt(1, ci.getProductId());
				if(cart.isMember()){
					pstmt.setDouble(2, ci.getMemberPrice());
				}else {
					pstmt.setDouble(2, ci.getNormalPrice());
				}
				
				pstmt.setInt(3, ci.getCount());
				pstmt.setInt(4, key);
				
				pstmt.addBatch();//将给定的 SQL 命令添加到此 Statement 对象的当前命令列表中(批处理)
				
			}
			
			pstmt.executeBatch();//将一批命令提交给数据库来执行，如果全部命令执行成功，则返回更新计数组成的数组(批处理)
			
			con.commit();
			con.setAutoCommit(true);
			

		} catch (SQLException e) {
			e.printStackTrace();
			try {
				con.setAutoCommit(true);//恢复现场
				con.rollback();	//回滚
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			
			return false;
		} finally {
			DB.close(pstmt);
			DB.close(rsKey);
			DB.close(con);
		}
		
		return true;
	}

	public int getOrders(List<SalesOrder> orders, int pageNo, int pageSize) {
		Connection con=null;
		ResultSet rs=null;
		ResultSet rsCategoryId=null;
		int pageCount=0;
		try {
			con = DB.getCon();
			rs=DB.executeQuery(con, "select count(*) from salesorder,ruser where (salesorder.userid=ruser.id)");
			if(rs.next()){
				pageCount=(rs.getInt(1)+pageSize-1)/pageSize;//计算出一共多少页
			}
			
			
			/*String sql="select salesorder.id,salesorder.userid,salesorder.odate,salesorder.addr,salesorder.status, " +
					   " ruser.id uid,ruser.username,ruser.password,ruser.addr uaddr,ruser.phone,ruser.rdate from salesorder " +
					   " join ruser on (salesorder.userid=ruser.id) " +
					   " limit "+(pageNo-1)*pageSize+","+pageSize;*/
			String sql="select salesorder.id,salesorder.userid,salesorder.odate,salesorder.addr,salesorder.status, " +
					   " ruser.id uid,ruser.username,ruser.password,ruser.addr uaddr,ruser.phone,ruser.rdate from salesorder,ruser " +
					   " where (salesorder.userid=ruser.id) " +
					   " limit "+(pageNo-1)*pageSize+","+pageSize;
			rs=DB.executeQuery(con, sql);
			while(rs.next()){
				MyUser u=new MyUser();
				u.setId(rs.getInt("uid"));
				u.setAddr(rs.getString("uaddr"));
				u.setUsername(rs.getString("username"));
				u.setPassword(rs.getString("password"));
				u.setPhone(rs.getString("phone"));
				u.setRdate(rs.getTimestamp("rdate"));
				
				SalesOrder so=new SalesOrder();
				so.setId(rs.getInt("id"));
				so.setAddr(rs.getString("addr"));
				so.setoDate(rs.getTimestamp("odate"));
				so.setStates(rs.getInt("status"));
				so.setUser(u);
				
				orders.add(so);
				
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rsCategoryId);
			DB.close(rs);
			DB.close(con);
		}
		
		return pageCount;
	}

	public SalesOrder loadById(int id) {
		
		Connection con=null;
		ResultSet rs=null;
		SalesOrder so=null;
		try {
			con = DB.getCon();
			String sql="select salesorder.id,salesorder.userid,salesorder.odate,salesorder.addr,salesorder.status, " +
					   " ruser.id uid,ruser.username,ruser.password,ruser.addr uaddr,ruser.phone,ruser.rdate from salesorder,ruser " +
					   " where (salesorder.userid=ruser.id) and salesorder.id="+id;
			rs=DB.executeQuery(con, sql);
			if(rs.next()){

				MyUser u=new MyUser();
				u.setId(rs.getInt("uid"));
				u.setAddr(rs.getString("uaddr"));
				u.setUsername(rs.getString("username"));
				u.setPassword(rs.getString("password"));
				u.setPhone(rs.getString("phone"));
				u.setRdate(rs.getTimestamp("rdate"));
				
				so=new SalesOrder();
				so.setId(rs.getInt("id"));
				so.setAddr(rs.getString("addr"));
				so.setoDate(rs.getTimestamp("odate"));
				so.setStates(rs.getInt("status"));
				so.setUser(u);

			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(con);
		}
		
		return so;
	}

	public List<SalesItem> getSalesItems(SalesOrder salesOrder) {
		Connection con=null;
		ResultSet rs=null;
		List<SalesItem> items=new ArrayList<SalesItem>();
		try {
			con = DB.getCon();
			
			//查询注册过的用户下的订单
			String sql="select salesorder.id,salesorder.userid,salesorder.odate,salesorder.addr,salesorder.status, " +
					   " salesitem.id itemid,salesitem.productid,salesitem.unitprice,salesitem.pcount,salesitem.orderid, " +
					   " product.id pid,product.name,product.desrc,product.normalprice,product.memberprice,product.pdate,product.categoryid " +
					   " from salesorder,salesitem,product " +
					   " where (salesorder.id=salesitem.orderid) and salesitem.productid=product.id and salesorder.id="+salesOrder.getId();
			rs=DB.executeQuery(con, sql);
			while(rs.next()){
				Product p=new Product();
				p.setId(rs.getInt("pid"));
				p.setCategoryId(rs.getInt("categoryid"));
				p.setName(rs.getString("name"));
				p.setDesrc(rs.getString("desrc"));
				p.setPdate(rs.getTimestamp("pdate"));
				p.setNormalPrice(rs.getDouble("normalprice"));
				p.setMemberPrice(rs.getDouble("memberprice"));
				
				SalesItem si=new SalesItem();
				si.setOrder(salesOrder);
				si.setId(rs.getInt("itemid"));
				si.setUnitPrice(rs.getDouble("unitprice"));
				si.setCount(rs.getInt("pcount"));
				si.setProduct(p);
				
				items.add(si);
				
			}
			
		

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {

			DB.close(rs);
			DB.close(con);
		}
		
		return items;
	}

	public void updateStates(SalesOrder salesOrder) {
		Connection con=null;
		try {
			con = DB.getCon();		
			String sql="update salesorder set status="+salesOrder.getStates()+" where id="+salesOrder.getId();			
			DB.executeUpate(con, sql);
		} finally {
			DB.close(con);
		}	
	}



}
