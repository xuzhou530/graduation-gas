package com.young.gas.beans;

import java.io.Serializable;
import java.sql.Timestamp;

public class Money implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Customer customer;
	
	private int id;
	private int result;
	private int previous;
	private int operate;
	private int flag;
	private int customerId;
	private Timestamp operateTime;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getResult() {
		return result;
	}
	public void setResult(int result) {
		this.result = result;
	}
	public int getPrevious() {
		return previous;
	}
	public void setPrevious(int previous) {
		this.previous = previous;
	}
	public int getOperate() {
		return operate;
	}
	public void setOperate(int operate) {
		this.operate = operate;
	}
	public int getFlag() {
		return flag;
	}
	public void setFlag(int flag) {
		this.flag = flag;
	}
	public int getCustomerId() {
		return customerId;
	}
	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}
	public Timestamp getOperateTime() {
		return operateTime;
	}
	public void setOperateTime(Timestamp operateTime) {
		this.operateTime = operateTime;
	}	
	public Customer getCustomer() {
		return customer;
	}
	public void setCustomer(Customer customer) {
		this.customer = customer;
	}
	
	@Override
	public String toString() {
		return "Money [id=" + id + ", result=" + result
				+ ", previous=" + previous + ", operate=" + operate
				+ ", flag=" + flag + ", customerId=" + customerId + "]"
				+ ", operateTime=" + operateTime;
	}
}
