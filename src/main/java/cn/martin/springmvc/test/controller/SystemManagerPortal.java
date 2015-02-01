package cn.martin.springmvc.test.controller;

import cn.martin.springmvc.test.model.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.*;

/**
 * Created by 昌胜 on 2015-01-25.
 */

@Controller
@RequestMapping("/system")
public class SystemManagerPortal {

    @ResponseBody
    @RequestMapping(value = "/getProvince.do", method = RequestMethod.GET)
    public Map getProvince() {
        Map<String, Object> map = new HashMap();

        List<Tprovince> list = new ArrayList<Tprovince>();

        Tprovince t = new Tprovince();
        t.setProvinceid("beijing");
        t.setName("北京");
        t.setNameEn("peking");
        t.setNameShort("京");

        list.add(t);

        map.put("list", list);
        map.put("status", 200);
        return map;

    }


    @ResponseBody
    @RequestMapping(value = "/listHospital.do", method = RequestMethod.POST)
    public Map listHospital() {
        Map map = new HashMap();

        List<Hospital> list = new ArrayList<Hospital>();

        Hospital h = new Hospital();

        h.setProvinceid("beijing");
        h.setProvinceName("北京");

        h.setCityName("北京");

        h.setName("中日友好医院");
        h.setHospitalid((long) 123);

        h.setMajorlevel((short) 4);



        list.add(h);


        map.put("hospital", list);
        map.put("status", 200);
        return map;
    }

    @ResponseBody
    @RequestMapping(value = "/getCity.do", method = RequestMethod.POST)
    public Map getCity(
            @RequestParam(value = "provinceid", required = true) String provinceid) {

        Map map = new HashMap();

        List<Tcity> list = new ArrayList<Tcity>();

        Tcity c = new Tcity();
        c.setProvinceid("beijing");
        c.setCityid("beijing");
        c.setName("北京");
        c.setNameShort("京");


        map.put("list", list);

        map.put("status", 200);
        return map;
    }


    @ResponseBody
    @RequestMapping(value = "/listSystemInform.do", method = RequestMethod.GET)
    public Map listSystemInform() {
        Map map = new HashMap();

        List<Tbcmessage> list =new ArrayList<Tbcmessage>();

        Tbcmessage m = new Tbcmessage();
        m.setBcmsgid((long) 123456);
        m.setContent("辅导辅导费");
        m.setSubmitby("刘昌胜");
        m.setSubmittime(new Date());

        list.add(m);

        map.put("status", 200);
        map.put("list", list);
        return map;
    }

}
