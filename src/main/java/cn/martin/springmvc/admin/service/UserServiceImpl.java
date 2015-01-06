package cn.martin.springmvc.admin.service;

import java.util.List;

import javax.annotation.Resource;
import javax.transaction.Transactional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import cn.martin.springmvc.admin.dao.IUserDao;
import cn.martin.springmvc.admin.entity.User;

@Service("userService")
@Transactional
public class UserServiceImpl implements IUserService {
	private final Logger logger = LoggerFactory.getLogger(UserServiceImpl.class);

	@Resource(name = "userDao")
	private IUserDao userDao;

	public User getUser(String id) {

		User user = new User();

		return user;
	}

	public void saveUser(User user) {
		logger.debug("save user service");
		userDao.save(user);

	}

	public List<User> findAll() {
		return userDao.findAll();
	}

	public List<User> list() {
		return userDao.findList("from User");
	}

}
