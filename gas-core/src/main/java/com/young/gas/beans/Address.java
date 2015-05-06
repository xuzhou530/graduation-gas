package com.young.gas.beans;

import java.io.Serializable;

public class Address implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int addressId;
	private String addressDistrict;//区县
	private String addressArea;//小区
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
