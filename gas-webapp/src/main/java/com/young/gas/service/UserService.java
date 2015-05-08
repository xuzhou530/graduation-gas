package com.young.gas.service;

import java.util.List;

import com.young.gas.beans.User;

public interface UserService {

	public boolean addUser(User user);
	
	public boolean deleteUser(String name);
	
	public List<User> listAllUsers();
	
	public List<User> listAllRequestUsers();
	
	public User listUser(String name);
	
	public boolean existUser(String name);
	
	public boolean passUser(String name);
	
	public boolean rejectUser(String name);
	
}
