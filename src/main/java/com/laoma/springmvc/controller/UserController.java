package com.laoma.springmvc.controller;

import com.laoma.springmvc.model.User;
import com.laoma.springmvc.response.MsgBean;
import com.laoma.springmvc.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
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

    @Autowired
    private UserService userService;

    @RequestMapping("/search")
    public
    @ResponseBody
    Object heihei(@RequestParam("name") String name) {
        logger.debug("查询用户名：" + name);

        MsgBean msg = new MsgBean();

        User user = new User();
        user.setName(name);
        user.setNick("laoma");
        user.setStatus(0);
        user.setPassword("123");
        userService.insert(user);
        return msg.returnMsg();
    }
}
