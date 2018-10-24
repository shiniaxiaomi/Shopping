package com.lyj.shopping.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

import com.lyj.shopping.Category;
import com.lyj.shopping.util.DB;

public class CategoryDao {

	public static boolean save(Category c) {
		Connection con = DB.getCon();
		String sql="";
		boolean isSaved=false;
		if(c.getId()==-1){
			sql = "insert into category values (null, ?, ?, ?, ?, ?)";
		}else{
			sql = "insert into category values ("+c.getId()+", ?, ?, ?, ?, ?)";
		}
		
		PreparedStatement pstmt = DB.getPStmt(con, sql);
		try {
			pstmt.setString(1, c.getName());
			pstmt.setInt(2, c.getPid());
			pstmt.setString(3, c.getDesrc());
			pstmt.setInt(4, c.isLeaf()?0:1);
			pstmt.setInt(5, c.getGrade());
			pstmt.executeUpdate();
			isSaved=true;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(pstmt);
			DB.close(con);
		}
		
		return isSaved;

	}
	
	public static void getCategories(List<Category> categories,int id){
		
		Connection con=DB.getCon();;
		ResultSet rs=null;
		try {
			getCategories(con,categories, id);
		} finally {
			DB.close(rs);
			DB.close(con);
		}
		
	}
	
	private static void getCategories(Connection con,List<Category> categories,int id){
		
		ResultSet rs=null;
		try {
			
			String sql="select * from category where pid="+id;
			rs=DB.executeQuery(con, sql);
			while(rs.next()){
				Category c=new Category();
				c.setId(rs.getInt("id"));
				c.setName(rs.getString("name"));
				c.setPid(rs.getInt("pid"));
				c.setDesrc(rs.getString("desrc"));
				c.setLeaf(rs.getInt("isleaf")==0?true:false);
				c.setGrade(rs.getInt("grade"));
				c.setProductNum(CategoryDao.getProductsNum(con, c.getId()));
				categories.add(c);
				if(!c.isLeaf()){
					getCategories(categories, c.getId());
				}
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
		}
		
	}
	
	public static int getProductsNum(Connection con,int id){
		ResultSet rs=null;
		int size=0;
		try {
			String sql="select COUNT(*) from product where categoryid="+id;
			rs=DB.executeQuery(con, sql);
			if(rs.next()){
				size=rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
		}	
		
		return size;
	}
	
	public static Category loadById(int id) {
		Category c=new Category();
		Connection con=null;
		ResultSet rs=null;
		try {
			con = DB.getCon();
			String sql="select * from category where id="+id;
			rs=DB.executeQuery(con, sql);
			while(rs.next()){
				c.setId(rs.getInt("id"));
				c.setName(rs.getString("name"));
				c.setPid(rs.getInt("pid"));
				c.setDesrc(rs.getString("desrc"));
				c.setLeaf(rs.getInt("isleaf")==0?true:false);
				c.setGrade(rs.getInt("grade"));
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(con);
		}
		return c;
	}

	public static boolean addChildCategory(Category c) {
		boolean isSaved=false;
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			con = DB.getCon();
			
			con.setAutoCommit(false);//取消自动提交
			rs=DB.executeQuery(con, "select * from category where id="+c.getPid());
			rs.next();
			int parentGrade=rs.getInt("grade");
			
			//存储新的category
			String sql="insert into category values(null,?,?,?,?,?)";
			pstmt=DB.getPStmt(con, sql);
			pstmt.setString(1, c.getName());
			pstmt.setInt(2, c.getPid());
			pstmt.setString(3, c.getDesrc());
			pstmt.setInt(4, 0);
			pstmt.setInt(5, parentGrade+1);
			pstmt.executeUpdate();
			
			//更新父节点,设置为非叶子节点
			DB.executeUpate(con, "update category set isleaf=1 where id="+c.getPid());

			con.commit();//手动提交
			con.setAutoCommit(true);//恢复自动提交
			
			isSaved=true;
		} catch (SQLException e) {
			try {
				con.rollback();//回滚
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(con);
		}
		
		return isSaved;
	}

	public static boolean delete(int id) {
		boolean isSucceed=true;//是否删除成功
		Connection con=null;
		ResultSet rs=null;
		con = DB.getCon();	
		int pid=0;
		
		
		rs=DB.executeQuery(con, "select * from category where id="+id);//获取isleaf
		try {
			rs.next();
			pid=rs.getInt("pid");//获取pid
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		if(deleteAll(con,id,isSucceed)){//如果删除孩子成功,说明类别下没有产品
			
			//查看父节点还有没有孩子,然后在更改父节点的isleaf
			rs=DB.executeQuery(con, "select COUNT(*) from category where pid="+pid);
			try {
				if(rs.next()&&rs.getInt(1)==0){//只有一条记录,那么孩子只有他自己,删除掉之后就要改变父节点上isleaf字段
					DB.executeUpate(con, "update category set isleaf=0 where id="+pid);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}else{
			isSucceed=false;
		}
		
		DB.close(con);
		return isSucceed;
	}
	
	private static boolean deleteAll(Connection con,int id,boolean isSucceed){
		ResultSet rs=null;
		ResultSet rsProduct=null;
		
		if(!isSucceed){
			return false;
		}
		
		try {
			rs=DB.executeQuery(con, "select * from category where pid="+id);//获取isleaf
			while(rs.next()){//判断本身传进来的id下是否有孩子
				if(rs.getInt("isleaf")==1){//判断孩子是否是叶子节点,如果不是叶子节点
					deleteAll(con,rs.getInt("id"),isSucceed);//删除孩子
				}else {//如果是叶子节点
					//先检测类别下是否有产品
					rsProduct=DB.executeQuery(con, "select COUNT(*) from product where categoryid="+rs.getInt("id"));
					if(rsProduct.next()){
						int size=rsProduct.getInt(1);
						if(size>=1){
							isSucceed=false;//直接返回false,说明该类别下有产品
						}
					}
					
					if(isSucceed){
						//如果类别下没有产品,则删除自身
						DB.executeUpate(con, "delete from category where id="+rs.getInt("id"));//删除自身
					}
					
				}
			}
			
			if(isSucceed){
				//先检测本身类别下是否有产品
				rsProduct=DB.executeQuery(con, "select COUNT(*) from product where categoryid="+id);
				if(rsProduct.next()){
					int size=rsProduct.getInt(1);
					if(size>=1){
						isSucceed=false;//直接返回false,说明该类别下有产品
					}else{
						DB.executeUpate(con, "delete from category where id="+id);//删除自身
					}
				}else{
					DB.executeUpate(con, "delete from category where id="+id);//删除自身
				}
				
				
			}
			

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			if(rsProduct!=null){
				DB.close(rsProduct);
			}
		}
		
		return isSucceed;
	}

	public static boolean modify(Category c) {
		boolean isModified=false;
		Connection con=null;
		PreparedStatement pstmt=null;
		try {
			con = DB.getCon();
			String sql="update category set id=?,name=?,pid=?,desrc=?,isleaf=?,grade=? where id="+c.getId();
			pstmt=DB.getPStmt(con, sql);
			pstmt.setInt(1, c.getId());
			pstmt.setString(2, c.getName());
			pstmt.setInt(3, c.getPid());
			pstmt.setString(4, c.getDesrc());
			pstmt.setInt(5, c.isLeaf()?0:1);
			pstmt.setInt(6, c.getGrade());
			pstmt.executeUpdate();
			isModified=true;

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(pstmt);
			DB.close(con);
		}
		
		return isModified;

	}

	
	
	
}
