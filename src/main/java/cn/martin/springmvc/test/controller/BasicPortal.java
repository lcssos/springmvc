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
    public String showHistory(HttpServletRequest request,@RequestParam(required=false) String animation){
        //String paraValue = request.getParameter("animation");
        request.setAttribute("animation", animation);
        return "test/analysis/history";
    }

    //wukong 运营开关
    @RequestMapping("/showSwitch.do")
    public String showSwitch(){
        return "test/config/switch";
    }

    //wukong 医院信息
    @RequestMapping("/showHospital.do")
    public String showHospital(){
        return "test/doctor/hospital";
    }

    //wukong 消息
    @RequestMapping("/showMessage.do")
    public String showMessage(){
        return "test/config/message";
    }


    //wukong 活跃度
    @RequestMapping("/showActivity.do")
    public String showActivity(){
        return "test/analysis/activity";
    }



}
