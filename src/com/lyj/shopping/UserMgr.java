package com.lyj.shopping;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.lyj.shopping.exception.PasswordNotCorrectException;
import com.lyj.shopping.exception.UserNotFoundException;
import com.lyj.shopping.util.DB;

public class UserMgr {

	public static List<MyUser> getUsers(){
		List<MyUser> list=new ArrayList<MyUser>();
		Connection con=null;
		ResultSet rs=null;
		
		try {
			con=DB.getCon();
			String sql="select * from ruser";
			rs=DB.executeQuery(con, sql);
			while(rs.next()){
				MyUser user=new MyUser();
				user.setId(rs.getInt("id"));
				user.setUsername(rs.getString("username"));
				user.setPassword(rs.getString("password"));
				user.setPhone(rs.getString("phone"));
				user.setAddr(rs.getString("addr"));
				user.setRdate(rs.getTimestamp("rdate"));
				list.add(user);				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DB.close(rs);
			DB.close(con);
		}
		
		return list;
		
	}
	
	
	public static void deleteUser(int id){
		
		Connection con=null;
		
		con=DB.getCon();
		String sql="delete from ruser where id="+id;
		DB.executeUpate(con, sql);

		DB.close(con);

	}
	
	public static MyUser validate(String username,String password) throws UserNotFoundException, PasswordNotCorrectException{
		MyUser user=null;
		Connection con=null;
		ResultSet rs=null;
		
		try {
			con=DB.getCon();
			String sql="select * from ruser where username='"+username+"';";
			rs=DB.executeQuery(con, sql);
			
			if(!rs.next()){
				throw new UserNotFoundException();
			}else if(!rs.getString("password").equals(password)){
				throw new PasswordNotCorrectException();
			}else {
				user=new MyUser();
				user.setId(rs.getInt("id"));
				user.setUsername(rs.getString("username"));
				user.setPassword(rs.getString("password"));
				user.setPhone(rs.getString("phone"));
				user.setAddr(rs.getString("addr"));
				user.setRdate(rs.getTimestamp("rdate"));			
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DB.close(rs);
			DB.close(con);
		}
		
		return user;

	}
	
	public static boolean isUserExist(String username){
		Connection con=null;
		ResultSet rs=null;
		boolean isExist=false;
		
		try {
			con=DB.getCon();
			String sql="select * from ruser where username='"+username+"';";
			rs=DB.executeQuery(con, sql);
			if(rs.next()){
				if(rs.getString("username")!=null){
					isExist=true;
				}
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DB.close(rs);
			DB.close(con);
		}
		
		return isExist;

	}
	
}
