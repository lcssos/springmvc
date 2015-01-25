package cn.martin.springmvc.test.controller;

/**
 * Created by 昌胜 on 2015-01-25.
 */

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/webbase")
public class BasicPortal {


    //wukong 平台历史统计数据
    @RequestMapping("/showHistory.do")
    public String showHistory(HttpServletRequest request,@RequestParam String animation){
        //String paraValue = request.getParameter("animation");
        request.setAttribute("animation", animation);
        return "test/analysis/history";
    }

}
