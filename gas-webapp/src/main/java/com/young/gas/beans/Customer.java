package com.young.gas.beans;

public class Customer {
	
	private int customerId;
	private String customerName;//姓名
	private String customerPhone;//电话
	private String addressDistrict;//所属区
	private String addressArea;//所属小区
	private int addressBuilding;//楼号
	private int addressLayer;//楼层
	private int addressRoom;//房号
	
	public int getCustomerId() {
		return customerId;
	}
	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}
	public String getCustomerName() {
		return customerName;
	}
	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}
	public String getCustomerPhone() {
		return customerPhone;
	}
	public void setCustomerPhone(String customerPhone) {
		this.customerPhone = customerPhone;
	}
	public String getAddressDistrict() {
		return addressDistrict;
	}
	public void setAddressDistrict(String addressDistrict) {
		this.addressDistrict = addressDistrict;
	}
	public String getAddressArea() {
		return addressArea;
	}
	public void setAddressArea(String addressArea) {
		this.addressArea = addressArea;
	}
	public int getAddressBuilding() {
		return addressBuilding;
	}
	public void setAddressBuilding(int addressBuilding) {
		this.addressBuilding = addressBuilding;
	}
	public int getAddressLayer() {
		return addressLayer;
	}
	public void setAddressLayer(int addressLayer) {
		this.addressLayer = addressLayer;
	}
	public int getAddressRoom() {
		return addressRoom;
	}
	public void setAddressRoom(int addressRoom) {
		this.addressRoom = addressRoom;
	}
	@Override
	public String toString() {
		return "Customer [customerId=" + customerId + ", customerName="
				+ customerName + ", customerPhone=" + customerPhone
				+ ", addressDistrict=" + addressDistrict + ", addressArea="
				+ addressArea + ", addressBuilding=" + addressBuilding
				+ ", addressLayer=" + addressLayer + ", addressRoom="
				+ addressRoom + "]";
	}
}
