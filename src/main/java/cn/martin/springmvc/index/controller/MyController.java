package cn.martin.springmvc.index.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.support.RequestContextUtils;

import cn.martin.springmvc.base.interceptor.DefaultReturn;
import cn.martin.springmvc.index.service.ISpring;

@Controller
public class MyController {

	// 使用注解获取bean
//	@Resource(name = "springManager")
//	private ISpring springManager;

	@RequestMapping({ "/index", "/", "" })
	public String index() {

		System.out.println("");

		return "index";
	}

	@RequestMapping("/spring/get")
	public String success(HttpServletRequest request) {
		
		//在springMVC中获取Spring的上下文
		WebApplicationContext wac1 = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
		
		//springMVC的上下文
		WebApplicationContext wac2 = RequestContextUtils.getWebApplicationContext(request);
		

//		springManager.getMessage();

		return "success";
	}
}
