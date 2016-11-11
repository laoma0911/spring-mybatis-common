package com.laoma.springmvc.aop;

import com.laoma.springmvc.exception.MyException;
import org.springframework.aop.ThrowsAdvice;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * 自定义aop
 * Created by mazhenbang on 2016/11/11.
 */
public class ServiceThrowsAdvice implements ThrowsAdvice {


    private Log log = LogFactory.getLog(ServiceThrowsAdvice.class);

    public void afterThrowing(Exception ex) {
        if (ex instanceof MyException) {

        } else {
            log.error(ex.getMessage(), ex);
            throw new RuntimeException(ex.getMessage());
        }

    }
}
