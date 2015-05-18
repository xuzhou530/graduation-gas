package com.young.gas.beans;

import java.io.Serializable;
import java.sql.Timestamp;

public class Log implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String grade;//操作员的用户权限
	
	private int logId;
	private String operator;
	private String operateAction;
	private Timestamp operateTime;
	
	public int getLogId() {
		return logId;
	}
	public void setLogId(int logId) {
		this.logId = logId;
	}
	public String getOperator() {
		return operator;
	}
	public void setOperator(String operator) {
		this.operator = operator;
	}
	public String getOperateAction() {
		return operateAction;
	}
	public void setOperateAction(String operateAction) {
		this.operateAction = operateAction;
	}
	public Timestamp getOperateTime() {
		return operateTime;
	}
	public void setOperateTime(Timestamp operateTime) {
		this.operateTime = operateTime;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
}
