package cn.martin.springmvc.admin.dao;

import org.springframework.stereotype.Repository;

import cn.martin.springmvc.admin.entity.User;

@Repository(value = "userDao")
public class UserDaoImpl extends BaseDaoImpl<User, String> implements IUserDao {

}
