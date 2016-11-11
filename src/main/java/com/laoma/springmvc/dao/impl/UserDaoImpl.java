package com.laoma.springmvc.dao.impl;

import com.laoma.mybatis.common.dao.GenericDaoImpl;
import com.laoma.springmvc.dao.UserDao;
import com.laoma.springmvc.model.User;

/**
 * Created by mazhenbang on 2016/11/11.
 */
public class UserDaoImpl extends GenericDaoImpl<User, Long> implements UserDao {

    public UserDaoImpl() {
        setNameSpace("com.laoma.springmvc.model.user");
    }

}
