package cn.martin.springmvc.admin.controller;

import java.util.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

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

        // User user = userService.getUser("");
        //
        // request.setAttribute("user", user);

        return "user";
    }

    @RequestMapping("/user/get")
    public
    @ResponseBody
    User getUserById(@RequestParam String id) {
        User user = userService.getUser(id);
        return user;
    }

    @RequestMapping(value = "/user/save", method = RequestMethod.POST)
    public String save(@Valid User user, BindingResult result) {

        user = new User();

        user.setName("张三");
        user.setAge(12);
        user.setIsIt(false);
        user.setBirthday(new Date(System.currentTimeMillis()));

        if (logger.isDebugEnabled()) {
            logger.debug("user save controller");
        }
        userService.saveUser(user);

        if (result.hasErrors()) {
            return "error";
        } else {
            return "user";
        }

    }

    @RequestMapping(value = "/user/list", produces = "application/json;charset=UTF-8")
    public
    @ResponseBody
    List<User> list() {
        List<User> list = userService.list();

        logger.debug("用户个数：{}", list.size());

		/*
         * for (User user : list) { logger.debug(user.getId()); }
		 */

//		return "{name:\"张三\"}";
        return list;
    }


    @RequestMapping(value = "/user/page", produces = "application/json;charset=UTF-8")
    public
    @ResponseBody
    Map<String, Object> page(@RequestParam int page, @RequestParam int limit) {
        Map<String, Object> map = new HashMap<String, Object>();

        List<User> list = userService.list();

        map.put("total", 100);
        map.put("rows", list);

        return map;
    }

}
