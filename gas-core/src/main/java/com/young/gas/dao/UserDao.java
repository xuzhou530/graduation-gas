package com.young.gas.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.young.gas.beans.Money;
import com.young.gas.beans.User;

public class UserDao {
	/**
	 * connection需要注入！！
	 */
	private Connection connection=null;
	
	public void setConnection(Connection connection){
		this.connection=connection;
	}
	
	public Connection getConnection(){
		return connection;
	}
	/**
	 * 
	 * @param 增加用户到数据库中
	 * @throws Exception
	 */
	public void addUser(User user) throws Exception{
		String sql="insert into user values(?,?,?,?,?,?)";
		PreparedStatement pst=connection.prepareStatement(sql);
		pst.setString(1, user.getUserName());
		pst.setString(2, user.getUserPwd());
		pst.setString(3, user.getUserPhone());
		pst.setString(4, user.getUserPhone());
		pst.setInt(5, user.getUserGrade());
		pst.setInt(6, user.getStatus());
		pst.executeUpdate();		
	}
	
	/**
	 * 
	 * @param 删除指定名字的用户
	 * @throws Exception
	 */
	public void deleteUser(String name) throws Exception{
		String sql="delete from user where user_name=?";
		PreparedStatement pst=connection.prepareStatement(sql);
		pst.setString(1, name);
		pst.executeUpdate();
	}
	
	/**
	 * 审核通过用户
	 * @param name
	 * @throws Exception
	 */
	public void passUser(String name) throws Exception{
		String sql="update user set status = 0 where user_name=?";
		PreparedStatement pst=connection.prepareStatement(sql);
		pst.setString(1, name);
		pst.executeUpdate();
	}
	
	/**
	 * 审核拒绝用户
	 * @param name
	 * @throws Exception
	 */
	public void rejectUser(String name) throws Exception{
		String sql="update user set status = 2 where user_name=?";
		PreparedStatement pst=connection.prepareStatement(sql);
		pst.setString(1, name);
		pst.executeUpdate();
	}
	
	/**
	 * 
	 * @param 判断用户是否存在
	 * @throws Exception
	 */
	public boolean existUser(String name) throws Exception{
		String sql="select * from user where user_name = ? and status = 0";
		PreparedStatement pst=connection.prepareStatement(sql);
		pst.setString(1, name);
		ResultSet rs = pst.executeQuery();
		while(rs.next()){
			return true;
		}
		return false;
	}
	
	/**
	 * 
	 * @return 返回所有用户
	 * @throws Exception
	 */
	public List<User> listAllRequestUsers() throws Exception{
		String sql="select * from user where status = 1";
		PreparedStatement pst=connection.prepareStatement(sql);
		ResultSet rs=pst.executeQuery();
		List<User> users = convertResult(rs);
		if(users != null && users.size()>0){
			return users;
		}
		return null;
	}
	
	public List<User> listAllUsers() throws Exception{
		String sql="select * from user";
		PreparedStatement pst=connection.prepareStatement(sql);
		ResultSet rs=pst.executeQuery();
		List<User> users = convertResult(rs);
		if(users != null && users.size()>0){
			return users;
		}
		return null;
	}
	
	/**
	 * 
	 * @param 返回指定用户名的用户
	 * @return
	 * @throws Exception
	 */
	public User listUser(String name) throws Exception{
		String sql="select * from user where user_name=?";
		PreparedStatement pst=connection.prepareStatement(sql);
		pst.setString(1, name);
		ResultSet rs=pst.executeQuery();
		List<User> users = convertResult(rs);
		if(users != null && users.size()>0){
			return users.get(0);
		}
		return null;
	}
	
	public static List<User> convertResult(ResultSet rs) throws Exception{
		List<User> users = new ArrayList<User>();
		while(rs.next()){
			User user = new User();
			user.setUserName(rs.getString(1));
			user.setUserPwd(rs.getString(2));
			user.setUserPhone(rs.getString(3));
			user.setUserEmail(rs.getString(4));
			user.setUserGrade(rs.getInt(5));
			user.setStatus(rs.getInt(6));
			users.add(user);	
		}		
		return users;
	}
}