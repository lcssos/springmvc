package cn.martin.springmvc.admin.service;

import java.util.List;

import cn.martin.springmvc.admin.entity.User;

public interface IUserService {

	public User getUser(String id);
	
	public void saveUser(User user);
	
	public List<User> list();
	
	public List<User> findAll();
}
