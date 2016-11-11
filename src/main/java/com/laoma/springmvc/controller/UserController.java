package com.laoma.springmvc.controller;

import com.laoma.springmvc.response.MsgBean;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Created by mazhenbang on 2016/11/11.
 */
@Controller
@RequestMapping("/user")
public class UserController {

    private final Logger logger = LoggerFactory.getLogger(getClass());

    @RequestMapping("/search")
    public
    @ResponseBody
    Object heihei(@RequestParam("name") String name) {
        logger.debug("查询用户名：" + name);

        MsgBean msg = new MsgBean();

        return msg.returnMsg();
    }
}
