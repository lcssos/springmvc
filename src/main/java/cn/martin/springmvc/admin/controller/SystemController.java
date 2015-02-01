package cn.martin.springmvc.admin.controller;

import org.springframework.cache.annotation.EnableCaching;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.persistence.Cacheable;

@Controller
public class SystemController {

    @RequestMapping("/error")
	public String error(){
		
		return "";
	}
}
