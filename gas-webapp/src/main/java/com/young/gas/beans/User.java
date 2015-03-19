package com.young.gas.beans;

public class User {
	public static final int SUPER=0;
	public static final int NORMAL=1;
	private String userName;
	private String userPwd;
	private String userEmail;
	private int userGrade;
	
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
	
	@Override
	public String toString() {
		return "User [userName=" + userName + ", userPwd=" + userPwd
				+ ", userEmail=" + userEmail + ", userGrade=" + userGrade + "]";
	}
}
