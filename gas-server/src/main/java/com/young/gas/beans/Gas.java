package com.young.gas.beans;

import java.io.Serializable;
import java.sql.Timestamp;

public class Gas  implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	//append
	private Customer customer;
	
	private int gasId;
	private Timestamp collectTime;
	private long gasValue;
	private long previousValue;
	private int gasMoney;
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
	public long getGasValue() {
		return gasValue;
	}
	public void setGasValue(long gasValue) {
		this.gasValue = gasValue;
	}
	public long getPreviousValue() {
		return previousValue;
	}
	public void setPreviousValue(long previousValue) {
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
	public int getGasMoney() {
		return gasMoney;
	}
	public void setGasMoney(int gasMoney) {
		this.gasMoney = gasMoney;
	}

}
