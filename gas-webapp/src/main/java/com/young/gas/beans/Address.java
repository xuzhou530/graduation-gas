package com.young.gas.beans;

public class Address {
	
	private int addressId;
	private String addressDistrict;//区县
	private String addressArea;//小区
	private int addressBuilding;//楼号
	private int addressLayer;//楼层
	private int addressRoom;//房号
	private String addressLocation;
	private int addressBuildings;
	private int addressCustomers;
	private String addressDesicribe;
	
	public int getAddressId() {
		return addressId;
	}


	public void setAddressId(int addressId) {
		this.addressId = addressId;
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


	public String getAddressLocation() {
		return addressLocation;
	}


	public void setAddressLocation(String addressLocation) {
		this.addressLocation = addressLocation;
	}


	public int getAddressBuildings() {
		return addressBuildings;
	}


	public void setAddressBuildings(int addressBuildings) {
		this.addressBuildings = addressBuildings;
	}


	public int getAddressCustomers() {
		return addressCustomers;
	}


	public void setAddressCustomers(int addressCustomers) {
		this.addressCustomers = addressCustomers;
	}


	public String getAddressDesicribe() {
		return addressDesicribe;
	}


	public void setAddressDesicribe(String addressDesicribe) {
		this.addressDesicribe = addressDesicribe;
	}
	
	@Override
	public String toString() {
		return "Address [addressId=" + addressId + ", addressDistrict="
				+ addressDistrict + ", addressArea=" + addressArea
				+ ", addressLocation=" + addressLocation
				+ ", addressBuildings=" + addressBuildings
				+ ", addressCustomers=" + addressCustomers
				+ ", addressDesicribe=" + addressDesicribe + "]";
	}
	
}
