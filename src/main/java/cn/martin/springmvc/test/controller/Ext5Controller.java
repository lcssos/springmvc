package cn.martin.springmvc.test.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by martin on 2015-01-22.
 */

@Controller
@RequestMapping("/test")
public class Ext5Controller {

    @RequestMapping("/index")
    public String index(){
        return "test/index";
    }
}
