package cn.martin.springmvc.admin.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.martin.springmvc.admin.entity.User;
import cn.martin.springmvc.admin.service.IUserService;

@Controller
@RequestMapping("/admin")
public class UserController {
	private final Logger logger = LoggerFactory.getLogger(UserController.class);

	@Resource(name = "userService")
	IUserService userService;

	@RequestMapping("/user")
	public String get(HttpServletRequest request) {

		User user = userService.getUser("");

		request.setAttribute("user", user);

		return "index";
	}

	@RequestMapping("/user/save")
	public String save() {

		User user = new User();

		user.setName("张三");
		user.setAge(12);
		
		logger.debug("user save controller");
		userService.saveUser(user);

		return "user";
	}
	
	@RequestMapping("/user/list")
	public String list(){
		List<User> list = userService.list();
		
		logger.debug("用户个数：{}",list.size());
		
		for(User user : list){
			logger.debug(user.getId());
		}
		return "user";
	}
}
