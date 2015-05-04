package com.young.gas.service;

import java.util.List;

import com.young.gas.beans.User;

public interface UserService {

	public boolean addUser(User user);
	
	public boolean deleteUser(String name);
	
	public List<User> listAllUsers();
	
	public User listUser(String name);
	
}
