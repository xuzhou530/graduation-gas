package com.young.gas.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
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
		String sql="insert into user values(?,?,?)";
		PreparedStatement pst=connection.prepareStatement(sql);
		pst.setString(1, user.getUserName());
		pst.setString(2, user.getUserPwd());
		pst.setInt(3, user.getUserGrade());
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
	 * 
	 * @return 返回所有用户
	 * @throws Exception
	 */
	public List<User> listAllUsers() throws Exception{
		List<User> list=new ArrayList<User>();
		String sql="select * from user";
		PreparedStatement pst=connection.prepareStatement(sql);
		ResultSet rs=pst.executeQuery();
		while(rs.next()){
			User user=new User();
			user.setUserName(rs.getString(1));
			user.setUserPwd(rs.getString(2));
			user.setUserGrade(rs.getInt(3));
			list.add(user);
		}
		return list;
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
		while(rs.next()){
			User user=new User();
			user.setUserName(rs.getString(1));
			user.setUserPwd(rs.getString(2));
			user.setUserGrade(rs.getInt(3));
			return user;
		}
		return null;
	}
}