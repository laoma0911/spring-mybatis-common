package com.laoma.springmvc.controller;

import com.laoma.mybatis.common.filter.DynamicSQLFilterImpl;
import com.laoma.mybatis.common.filter.PagingBean;
import com.laoma.mybatis.common.filter.QueryFilter;
import com.laoma.springmvc.model.User;
import com.laoma.springmvc.response.MsgBean;
import com.laoma.springmvc.service.UserService;
import com.laoma.springmvc.utils.MD5Util;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by mazhenbang on 2016/11/11.
 */
@Controller
@RequestMapping("/user")
public class UserController {

    private final Logger logger = LoggerFactory.getLogger(getClass());

    @Autowired
    private UserService userService;


    @RequestMapping("/list")
    public
    @ResponseBody
    ModelAndView list(@RequestParam(value = "start", required = false) String start,
                      @RequestParam(value = "limit", required = false) String limit,
                      @RequestParam(value = "name", required = false) String name,
                      @RequestParam(value = "nick", required = false) String nick) {
        ModelAndView mav = new ModelAndView("/user/userList");
        QueryFilter filter = new DynamicSQLFilterImpl();
        PagingBean page = new PagingBean();
        int currentPage = 0;
        int pageSize = 10;
        if (StringUtils.isNotEmpty(limit) && StringUtils.isNumeric(limit)) {
            pageSize = Integer.parseInt(limit);
        }
        if (StringUtils.isNotEmpty(start) && StringUtils.isNumeric(start)) {
            currentPage = (Integer.parseInt(start) - 1) * pageSize;
        }
        page.setPageSize(pageSize);
        page.setStart(currentPage);
        filter.setPagingBean(page);

        if (StringUtils.isNotBlank(name)) {
            filter.addFilter("Q_name_S_EQ", name);
        }
        if (StringUtils.isNotBlank(nick)) {
            filter.addFilter("Q_nick_S_EQ", nick);
        }
        mav.addObject("userList", userService.find(filter));
        mav.addObject("count", userService.count(filter));
        mav.addObject("start", start);
        mav.addObject("limit", limit);
        return mav;
    }


    /**
     * 新增用户
     *
     * @param nick
     * @param password
     * @param name
     * @return
     */
    @RequestMapping("/insert")
    public
    @ResponseBody
    Object insert(@RequestParam("nick") String nick, @RequestParam("password") String password, @RequestParam("name") String name) {
        MsgBean msg = new MsgBean();
        User user = new User();
        user.setName(name);
        user.setNick(nick);
        user.setStatus(0);
        user.setPassword(MD5Util.MD5(password));
        userService.insert(user);
        return msg.returnMsg();
    }


    /**
     * 查找用户
     *
     * @param id
     * @return
     */
    @RequestMapping("/find")
    public
    @ResponseBody
    Object find(@RequestParam("id") Long id) {
        MsgBean msg = new MsgBean();
        User user = userService.get(id);
        msg.put("userInfo", user);
        return msg.returnMsg();
    }


    /**
     * 修改用户
     *
     * @param id
     * @param nick
     * @param password
     * @param name
     * @return
     */
    @RequestMapping("/update")
    public
    @ResponseBody
    Object update(@RequestParam("id") Long id, @RequestParam(value = "nick", required = false) String nick,
                  @RequestParam(value = "password", required = false) String password, @RequestParam(value = "name", required = false) String name) {
        MsgBean msg = new MsgBean();
        User user = userService.get(id);
        if (null == user) {
            msg.setFailure(1, "妈的，出错了，没这人，修改个j8");
        }
        user.setPassword(MD5Util.MD5(password));
        user.setNick(nick);
        user.setName(name);
        userService.update(user);
        return msg.returnMsg();
    }


    /**
     * filter只用[eq格式使用]
     *
     * @param name
     * @return
     */
    @RequestMapping("/filter_EQ")
    public
    @ResponseBody
    Object filter_EQ(@RequestParam(value = "name", required = false) String name) {
        MsgBean msg = new MsgBean();
        QueryFilter filter = new DynamicSQLFilterImpl();
        filter.addFilter("Q_name_S_EQ", name);
        msg.put("userInfo", userService.find(filter));

        return msg.returnMsg();
    }
}
