package com.young.gas.service;

import java.util.List;

import com.young.gas.beans.Money;

public interface MoneyService {

	public void addMoney(Money money);
		
	public List<Money> listMoneysByCusomerId(int customerId);

	public void deleteMoneyByCusomerId(int customerId);
	
	public Money listCurrentByCusomerId(int customerId);

}
