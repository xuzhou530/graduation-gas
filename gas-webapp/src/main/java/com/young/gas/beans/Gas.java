package com.young.gas.beans;

import java.sql.Timestamp;

public class Gas {
	//append
	private Customer customer;
	
	private int gasId;
	private Timestamp collectTime;
	private int gasValue;
	private int previousValue;
	private int flag;
	private int customerId;
	public int getGasId() {
		return gasId;
	}
	public void setGasId(int gasId) {
		this.gasId = gasId;
	}
	public Timestamp getCollectTime() {
		return collectTime;
	}
	public void setCollectTime(Timestamp collectTime) {
		this.collectTime = collectTime;
	}
	public int getGasValue() {
		return gasValue;
	}
	public void setGasValue(int gasValue) {
		this.gasValue = gasValue;
	}
	public int getPreviousValue() {
		return previousValue;
	}
	public void setPreviousValue(int previousValue) {
		this.previousValue = previousValue;
	}
	public int getCustomerId() {
		return customerId;
	}
	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}
	public Customer getCustomer() {
		return customer;
	}
	public void setCustomer(Customer customer) {
		this.customer = customer;
	}
	public int getFlag() {
		return flag;
	}
	public void setFlag(int flag) {
		this.flag = flag;
	}
	@Override
	public String toString() {
		return "Gas [gasId=" + gasId + ", collectTime=" + collectTime
				+ ", gasValue=" + gasValue + ", previousValue=" + previousValue
				 + ", customerId=" + customerId + "]";
	}

}
