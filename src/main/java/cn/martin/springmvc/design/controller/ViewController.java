package cn.martin.springmvc.design.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by martin on 2015-01-09.
 */

@Controller
public class ViewController {

    @RequestMapping("design/view")
    public String view(){
        return "design_view";
    }
}
