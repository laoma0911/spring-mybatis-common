package com.laoma.springmvc.model;

import java.io.Serializable;

/**
 * Created by mazhenbang on 2016/11/11.
 */
public class User implements Serializable {

    private Long id;
    private String name;
    private String password;
    private String nick;
    private Integer status;

    public User() {
    }

    public User(Long id, String name, String password, String nick, Integer status) {
        this.id = id;
        this.name = name;
        this.password = password;
        this.nick = nick;
        this.status = status;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getNick() {
        return nick;
    }

    public void setNick(String nick) {
        this.nick = nick;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }
}
