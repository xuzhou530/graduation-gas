package com.young.gas.beans;

import java.io.Serializable;

public class User implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public static final int SUPER=0;
	public static final int NORMAL=1;
	private String userName;
	private String userPwd;
	private String userPhone;
	private String userEmail;
	private int userGrade;
	private int status;//0表示审核通过，1表示待审核，2表示审核被拒绝
	
	public String getUserName() {
		return userName;
	}
	
	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	public String getUserPwd() {
		return userPwd;
	}
	
	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}
	
	public String getUserEmail() {
		return userEmail;
	}
	
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	
	public int getUserGrade() {
		return userGrade;
	}
	
	public void setUserGrade(int userGrade) {
		this.userGrade = userGrade;
	}
	

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}
	
	public String getUserPhone() {
		return userPhone;
	}

	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}
	
	@Override
	public String toString() {
		return "User [userName=" + userName + ", userPwd=" + userPwd
				+ ", userEmail=" + userEmail + ", userGrade=" + userGrade + "]";
	}
}
