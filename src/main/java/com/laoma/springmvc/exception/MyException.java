package com.laoma.springmvc.exception;

/**
 * 自定义exception
 * Created by mazhenbang on 2016/11/11.
 */
public class MyException extends RuntimeException {

    private static final long serialVersionUID = -2084401215148116454L;

    private String errCode;
    private String errMsg;

    public MyException() {
    }

    public MyException(String code) {
        super();
        this.errCode = code;
    }

    public MyException(String code, String errMsg) {
        super(errMsg);
        this.errCode = code;
        this.errMsg = errMsg;
    }

    public String getErrCode() {
        return errCode;
    }

    public String getErrMsg() {
        return errMsg;
    }
}
