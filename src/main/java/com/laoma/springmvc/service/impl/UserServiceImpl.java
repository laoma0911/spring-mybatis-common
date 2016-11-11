package com.laoma.springmvc.service.impl;

import com.laoma.mybatis.common.service.GenericServiceImpl;
import com.laoma.springmvc.dao.UserDao;
import com.laoma.springmvc.model.User;
import com.laoma.springmvc.service.UserService;

/**
 * Created by mazhenbang on 2016/11/11.
 */
public class UserServiceImpl extends GenericServiceImpl<User, Long> implements UserService {


    private UserDao dao;

    public UserServiceImpl(UserDao dao) {
        super(dao);
        this.dao = dao;
    }
}
