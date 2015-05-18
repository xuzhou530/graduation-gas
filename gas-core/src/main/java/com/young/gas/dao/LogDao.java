package com.young.gas.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.young.gas.beans.Log;

public class LogDao {
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

	public void addLog(Log log) throws Exception{
		String sql="insert into log values(null,?,?,?)";
		PreparedStatement pst=connection.prepareStatement(sql);
		pst.setString(1, log.getOperator());
		pst.setString(2, log.getOperateAction());
		pst.setTimestamp(3, log.getOperateTime());
		pst.executeUpdate();		
	}
	
	public List<Log> listLogs() throws Exception{
		String sql="select * from log";
		PreparedStatement pst=connection.prepareStatement(sql);
		ResultSet rs=pst.executeQuery();
		List<Log> logs = convertResult(rs);
		if(logs != null && logs.size()>0){
			return logs;
		}
		return null;
	}
	
	public static List<Log> convertResult(ResultSet rs) throws Exception{
		List<Log> logs = new ArrayList<Log>();
		while(rs.next()){
			Log log = new Log();
			log.setLogId(rs.getInt(1));
			log.setOperator(rs.getString(2));
			log.setOperateAction(rs.getString(3));
			log.setOperateTime(rs.getTimestamp(4));
			logs.add(log);	
		}		
		return logs;
	}
}