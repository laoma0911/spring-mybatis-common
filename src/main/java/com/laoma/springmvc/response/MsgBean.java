package com.laoma.springmvc.response;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * 返回json信息的bean
 * <p>
 * Created by mazhenbang on 2016/11/11.
 */
public class MsgBean {
    private String errdesc;
    private String errno;

    private Map dto;

    public MsgBean() {
        // 默认的数据
        this.errdesc = "";
        this.errno = "0";
        dto = new HashMap();
        dto.put(AjaxReturn.STATUS_INFO, errdesc);
        dto.put(AjaxReturn.STATUS_CODE, this.errno);
        dto.put("timestamp", (new Date()).getTime() / 1000);
    }

    public MsgBean(String errno, String errdesc) {
        // 默认的数据
        this.errdesc = errdesc;
        this.errno = errno;
        dto = new HashMap();
        dto.put(AjaxReturn.STATUS_INFO, errdesc);
        dto.put(AjaxReturn.STATUS_CODE, this.errno);
        dto.put("timestamp", (new Date()).getTime() / 1000);
    }

    /**
     * 公开的插入数据的接口
     */
    public void put(String key, Object value) {
        dto.put(key, value);
    }

    /**
     * map的键值对放入到返回数据
     */
    public void putAll(Map msg) {
        if (msg != null && msg.size() > 0) {
            dto.putAll(msg);
        }
    }

    /**
     * 设置错误信息 标记为后台出错 自定义错误信息
     */
    public void setFailure(String errorMsg) {
        dto.put(AjaxReturn.STATUS_CODE, 1);
        if (errorMsg == null || errorMsg.contains("dubbo")) {
            dto.put(AjaxReturn.STATUS_INFO, "网络繁忙，请重试");
        } else {
            dto.put(AjaxReturn.STATUS_INFO, errorMsg);
        }

    }

    /**
     * 设置错误信息 标记为后台出错 自定义错误信息
     */
    public void setFailure(String errno, String errorMsg) {
        dto.put(AjaxReturn.STATUS_CODE, errno);
        if (errorMsg == null || errorMsg.contains("dubbo") || errorMsg.contains("Exception")) {
            dto.put(AjaxReturn.STATUS_INFO, "网络繁忙，请重试");
        } else {
            dto.put(AjaxReturn.STATUS_INFO, errorMsg);
        }
    }

    /**
     * 设置错误信息 标记为后台出错 自定义错误信息
     */
    public void setFailure(int errno, String errorMsg) {
        setFailure(String.valueOf(errno), errorMsg);
    }

    public MsgBean failure(String errorMsg) {
        setFailure("1", errorMsg);
        return this;
    }

    /**
     * 返回给前台信息
     */
    public Map returnMsg() {
        return dto;
    }

    /*
     * ajax返回的参数
     *
     */
    static class AjaxReturn {
        // AJAX返回的成功标志值
        public static final String SUCCESS = "success";
        // AJAX返回的状态码KEY值
        public static final String STATUS_CODE = "errno";
        // AJAX返回的状态的信息
        public static final String STATUS_INFO = "errdesc";
    }
}
