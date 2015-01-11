package cn.martin.spring.admin.controller

import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.RequestMapping

import javax.servlet.http.HttpServletRequest

/**
 * Created by martin on 2015-01-10.
 */

@Controller
class GroupController {

    @RequestMapping("/admin/group")
    def hello(HttpServletRequest req) {
        [code: 1, data: "Hello, group !"]
    }

}
