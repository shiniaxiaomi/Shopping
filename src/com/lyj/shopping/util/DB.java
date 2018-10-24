package com.lyj.shopping.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DB {
	
//	public static void main(String[] args) {
//		
//		String sql="select * from article where pid=0";
//		Connection con=DB.getCon();
//		Statement stmt=DB.creatStmt(con);
//		ResultSet rs=DB.executeQuery(stmt, sql);
//		
//		try {
//			while(rs.next()){
//				FileUtil.write(rs.getString("title"));
//			}
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//		FileUtil.close();
//		
//		FileUtil.writeOnce("写入完毕", true);
//
//
//	}

	public static Connection getCon(){
		
		Connection con=null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String dbUrl="jdbc:mysql://localhost/shopping?user=root&password=123456";
			con=DriverManager.getConnection(dbUrl);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		return con;
	}
	
	
	public static Statement creatStmt(Connection con){
		Statement stmt=null;
		
		try {
			stmt=con.createStatement();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return stmt;
	}
	
	public static PreparedStatement getPStmt(Connection con,String sql){
		PreparedStatement pstmt=null;
		
		try {
			pstmt=con.prepareStatement(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return pstmt;
	}
	
	public static PreparedStatement getPStmt(Connection con,String sql,boolean generateKey){
		PreparedStatement pstmt=null;
		
		try {
			pstmt=con.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return pstmt;
	}
	
	public static ResultSet executeQuery(Statement stmt,String sql){
		
		ResultSet rs=null;
		
		try {
			rs=stmt.executeQuery(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return rs;
	}
	
	public static ResultSet executeQuery(Connection con,String sql){
		
		ResultSet rs=null;
		Statement stmt=null;
		
		try {
			stmt=con.createStatement();
			rs=stmt.executeQuery(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return rs;
	}
	
	public static boolean executeUpate(Connection con,String sql){
		
		Statement stmt=null;
		
		try {
			stmt=con.createStatement();
			stmt.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally{
			DB.close(stmt);
		}
		return true;
		
	}
	
	
	public static void close(Connection con){
		if(con!=null){
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			con=null;
		}
	}
	
	public static void close(Statement stmt){
		if(stmt!=null){
			try {
				stmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			stmt=null;
		}
	}
	
	
	public static void close(ResultSet rs){
		if(rs!=null){
			try {
				rs.close();
			} catch (SQLException 
					e) {
				e.printStackTrace();
			}
			rs=null;
		}
	}
	
}















