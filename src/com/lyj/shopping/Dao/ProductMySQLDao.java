package com.lyj.shopping.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.lyj.shopping.Product;
import com.lyj.shopping.util.DB;
import com.lyj.shopping.util.StringUtil;

public class ProductMySQLDao implements ProductDao{

	public List<Product> getProducts(){
		Connection con=null;
		ResultSet rs=null;
		ResultSet rsCategoryId=null;
		List<Product> list=new ArrayList<Product>();
		try {
			con = DB.getCon();
			String sql="select * from product";
			rs=DB.executeQuery(con, sql);
			while(rs.next()){
				Product p=new Product();
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDesrc(rs.getString("desrc"));
				p.setNormalPrice(rs.getDouble("normalprice"));
				p.setMemberPrice(rs.getDouble("memberprice"));
				p.setPdate(rs.getTimestamp("pdate"));
				p.setCategoryId(rs.getInt("categoryid"));
				
				rsCategoryId=DB.executeQuery(con, "select name from category where id="+rs.getInt("categoryid"));
				if(rsCategoryId.next()){
					p.setStrCategoryId(rsCategoryId.getString("name"));
				}
				
				list.add(p);
				
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rsCategoryId);
			DB.close(rs);
			DB.close(con);
		}
		return list;
		
	}
	
	public List<Product> getProducts(int pageNo,int pageSize){
		Connection con=null;
		ResultSet rs=null;
		ResultSet rsCategoryId=null;
		List<Product> list=new ArrayList<Product>();
		try {
			con = DB.getCon();
			String sql="select * from product limit "+(pageNo-1)*pageSize+","+pageSize;
			rs=DB.executeQuery(con, sql);
			while(rs.next()){
				Product p=new Product();
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDesrc(rs.getString("desrc"));
				p.setNormalPrice(rs.getDouble("normalprice"));
				p.setMemberPrice(rs.getDouble("memberprice"));
				p.setPdate(rs.getTimestamp("pdate"));
				p.setCategoryId(rs.getInt("categoryid"));
				
				rsCategoryId=DB.executeQuery(con, "select name from category where id="+rs.getInt("categoryid"));
				if(rsCategoryId.next()){
					p.setStrCategoryId(rsCategoryId.getString("name"));
				}
				
				
				list.add(p);
				
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rsCategoryId);
			DB.close(rs);
			DB.close(con);
		}
		return list;
	}
	
	public int findProducts(List<Product> products,int[] categoryId,
									  String keyWord,
									  double lowNormalPrice,
									  double highNormalPrice,
									  double lowMemberPrice,
									  double highMemberPrice,
									  Date startDate,
									  Date endDate,
									  int pageNo,
									  int pageSize){
		
		Connection con=null;
		ResultSet rs=null;
		ResultSet rsCount=null;
		ResultSet rsCategoryId=null;
		int pageCount=0;
		
		try {
			con = DB.getCon();
			String sql="select * from product where 1=1 ";
			
			if(categoryId.length>0 && categoryId[0]!=0){
				String strId="(";
				for(int i=0;i<categoryId.length;i++){
					strId+=categoryId[i]+",";
				}
				strId+=")";
				strId=StringUtil.replaceLast(strId, ",", "");
				sql+=" and categoryid in "+strId;
			}
			
			if(keyWord!=null && !keyWord.trim().equals("")){
				sql+=" and name like '%"+keyWord+"%'"+" or desrc like '%"+keyWord+"%'";
			}
			
			if(lowNormalPrice>=0){
				sql+=" and normalprice > "+lowNormalPrice;
			}
			
			if(highNormalPrice >0){
				sql+=" and normalprice < "+highNormalPrice;
			}
			
			if(lowMemberPrice>=0){
				sql+=" and memberprice > "+lowMemberPrice;
			}
			
			if(highMemberPrice>0){
				sql+=" and memberprice < "+highMemberPrice;
			}
			
			if(startDate!=null){
				sql+=" and pdate>='"+new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(startDate)+"'";
			}
			
			if(endDate!=null){
				sql+=" and pdate<='"+new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(endDate)+"'";
			}
			
			//计算总页数
			String sqlCount=sql.replaceFirst("select \\*", "select count(*)");
//System.out.println(sqlCount);			
			rsCount=DB.executeQuery(con, sqlCount);
			if(rsCount.next()){
				pageCount=(rsCount.getInt(1)+pageSize-1)/pageSize;
			}
			

			sql+=" limit "+(pageNo-1)*pageSize+","+pageSize;		
System.out.println(sql);
			rs=DB.executeQuery(con, sql);
			while(rs.next()){
				Product p=new Product();
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDesrc(rs.getString("desrc"));
				p.setNormalPrice(rs.getDouble("normalprice"));
				p.setMemberPrice(rs.getDouble("memberprice"));
				p.setPdate(rs.getTimestamp("pdate"));
				p.setCategoryId(rs.getInt("categoryid"));
				
				rsCategoryId=DB.executeQuery(con, "select name from category where id="+rs.getInt("categoryid"));
				if(rsCategoryId.next()){
					p.setStrCategoryId(rsCategoryId.getString("name"));
				}
				
				
				products.add(p);
				
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rsCategoryId);
			DB.close(rs);
			DB.close(rsCount);
			DB.close(con);
		}
		
		return pageCount;
		
		
	}
	
	public List<Product> findProducts(String name){
		
		return null;
	}
	
	public boolean deleteProductByCategoryId(int categoryId){
		
		return false;
	}

	public boolean addProduct(Product p) {
		Connection con=null;
		PreparedStatement pstmt=null;
		try {
			con = DB.getCon();
			String sql="insert into product values(null,?,?,?,?,?,?)";
			pstmt=DB.getPStmt(con, sql);
			pstmt.setString(1, p.getName());
			pstmt.setString(2, p.getDesrc());
			pstmt.setDouble(3, p.getNormalPrice());
			pstmt.setDouble(4, p.getMemberPrice());
			pstmt.setTimestamp(5, p.getPdate());
			pstmt.setInt(6, p.getCategoryId());
			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			DB.close(pstmt);
			DB.close(con);
		}
		
		return true;
	}

	public int getProducts(List<Product> products, int pageNo, int pageSize) {
		Connection con=null;
		ResultSet rs=null;
		ResultSet rsCategoryId=null;
		int pageCount=0;
		try {
			con = DB.getCon();
			rs=DB.executeQuery(con, "select count(*) from product;");
			rs.next();
			pageCount=(rs.getInt(1)+pageSize-1)/pageSize;//计算出一共多少页
			
			String sql="select * from product limit "+(pageNo-1)*pageSize+","+pageSize;
			rs=DB.executeQuery(con, sql);
			while(rs.next()){
				Product p=new Product();
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDesrc(rs.getString("desrc"));
				p.setNormalPrice(rs.getDouble("normalprice"));
				p.setMemberPrice(rs.getDouble("memberprice"));
				p.setPdate(rs.getTimestamp("pdate"));
				p.setCategoryId(rs.getInt("categoryid"));
				
				rsCategoryId=DB.executeQuery(con, "select name from category where id="+rs.getInt("categoryid"));
				if(rsCategoryId.next()){
					p.setStrCategoryId(rsCategoryId.getString("name"));
				}
				
				products.add(p);
				
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


	public boolean deleteProduct(int id) {
		Connection con=null;
		con = DB.getCon();
		boolean isSucceed=DB.executeUpate(con, "delete from product where id="+id);
		DB.close(con);
		
		return isSucceed;
	}

	public Product loadById(int id) {
		Product p=new Product();
		Connection con=null;
		ResultSet rs=null;
		ResultSet rsCategoryId=null;
		try {
			con = DB.getCon();
			String sql="select * from product where id="+id;
			rs=DB.executeQuery(con, sql);
			while(rs.next()){
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDesrc(rs.getString("desrc"));
				p.setNormalPrice(rs.getDouble("normalprice"));
				p.setMemberPrice(rs.getDouble("memberprice"));
				p.setPdate(rs.getTimestamp("pdate"));
				p.setCategoryId(rs.getInt("categoryid"));
				
				rsCategoryId=DB.executeQuery(con, "select name from category where id="+rs.getInt("categoryid"));
				if(rsCategoryId.next()){
					p.setStrCategoryId(rsCategoryId.getString("name"));
				}
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rsCategoryId);
			DB.close(rs);
			DB.close(con);
		}
		return p;

	}

	public boolean modify(Product p) {
		Connection con=null;
		PreparedStatement pstmt=null;
		try {
			con = DB.getCon();
			String sql="update product set id=?,name=?,desrc=?,normalprice=?,memberprice=?,pdate=?,categoryid=? where id="+p.getId();
			pstmt=DB.getPStmt(con, sql);
			pstmt.setInt(1, p.getId());
			pstmt.setString(2, p.getName());
			pstmt.setString(3, p.getDesrc());
			pstmt.setDouble(4, p.getNormalPrice());
			pstmt.setDouble(5, p.getMemberPrice());
			pstmt.setTimestamp(6, p.getPdate());
			pstmt.setInt(7, p.getCategoryId());
			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			DB.close(pstmt);
			DB.close(con);
		}
		
		return true;
		
	}

	public List<Product> getLastProducts(int num) {
		Connection con=null;
		ResultSet rs=null;
		ResultSet rsCategoryId=null;
		List<Product> products=new ArrayList<Product>();
		try {
			con = DB.getCon();
			String sql="select * from product order by pdate desc limit 0,"+num;
			rs=DB.executeQuery(con, sql);
			while(rs.next()){
				Product p=new Product();
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDesrc(rs.getString("desrc"));
				p.setNormalPrice(rs.getDouble("normalprice"));
				p.setMemberPrice(rs.getDouble("memberprice"));
				p.setPdate(rs.getTimestamp("pdate"));
				p.setCategoryId(rs.getInt("categoryid"));
				
				rsCategoryId=DB.executeQuery(con, "select name from category where id="+rs.getInt("categoryid"));
				if(rsCategoryId.next()){
					p.setStrCategoryId(rsCategoryId.getString("name"));
				}
				
				products.add(p);
				
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rsCategoryId);
			DB.close(rs);
			DB.close(con);
		}
		return products;
	}



}
