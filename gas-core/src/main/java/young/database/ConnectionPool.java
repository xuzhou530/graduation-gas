package young.database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.apache.commons.dbcp2.BasicDataSource;

public class ConnectionPool {
	//创建唯一的实例
	private static ConnectionPool pool=new ConnectionPool();
	//数据源引用定义
	private BasicDataSource bd=null;
	
	/**
	 * 构造函数，用于创建唯一的数据源
	 */
	private ConnectionPool(){
		//参数
        String driver = "com.mysql.jdbc.Driver";
        String url = "jdbc:mysql://localhost:3306/gas";
        String username ="root";
        String password ="root";
        
        // 创建 DBCP 数据源
        bd = new BasicDataSource ();
        bd.setDriverClassName(driver);
        bd.setUrl(url);
        bd.setUsername(username);
        bd.setPassword(password);
        
        bd.setInitialSize(10);
        bd.setMaxTotal(15);
        bd.setValidationQuery("select 1 from user");
	}
	
	/**
	 * 获取唯一的实例
	 * @return
	 */
	public static ConnectionPool getInstance(){
		return pool;
	}
	
	/**
	 * 获取连接
	 * @return
	 */
	public synchronized Connection getConnection() {  
		try {
			return bd.getConnection();
		} 
		catch (SQLException e) {     
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 释放连接
	 * @param connection
	 */
	public synchronized void releaseConnection(Connection connection){
		try {
			connection.close();
		} 
		catch (SQLException e) {     
			e.printStackTrace();
		}
	}
	
	/**
	 * 提交事务
	 * @return
	 * @throws SQLException
	 */
	public void commit(Connection connection) {
		try {
			connection.commit();
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 回退事务
	 * @return
	 * @throws SQLException
	 */
	public void rollback(Connection connection) {
		try {
			connection.rollback();
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * main函数
	 * @param args
	 * @throws Exception
	 */
	public static void main(String[] args) throws Exception{
		ConnectionPool pool=ConnectionPool.getInstance();
		Connection connection=pool.getConnection();
		
		PreparedStatement ps=connection.prepareStatement("select * from user");
		ResultSet rs=ps.executeQuery();
		while(rs.next()){
			System.out.println(rs.getString(1)+" "+rs.getString(2)+" "+rs.getInt(3));
		}
	}
	
}