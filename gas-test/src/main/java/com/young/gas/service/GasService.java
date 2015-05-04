package com.young.gas.service;

import java.util.List;

import com.young.gas.beans.Gas;

public interface GasService {

	public List<Gas> searchGasByBuilding(String district,String area,int building,int start,int count);
		
	public int getCountWithSearchBuilding(String district,String area,int building);
	
	public List<Gas> searchWarningGasByBuilding(String district, String area, int building, int start, int count);
		
	public int getCountWithWarningSearchBuilding(String district,String area,int building);
	
	public Gas searchCurrentGasByCustomerId(int customerId);
	
	public List<Gas> searchAllGasByCustomerId(int customerId);
	
}
