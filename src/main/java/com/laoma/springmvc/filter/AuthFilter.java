package com.laoma.springmvc.filter;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by mazhenbang on 2016/11/11.
 */
public class AuthFilter implements HandlerInterceptor {

    private String whiteList;

    public String getWhiteList() {
        return whiteList;
    }

    public void setWhiteList(String whiteList) {
        this.whiteList = whiteList;
    }


    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
                           ModelAndView modelAndView) throws Exception {
        if (modelAndView == null)
            return;
        String start = request.getParameter("start");
        if (start != null && !"".equals(start)) {
            modelAndView.addObject("start", start);
        } else {
            modelAndView.addObject("start", 1);
        }
        String limit = request.getParameter("limit");
        if (limit != null && !"".equals(limit)) {
            modelAndView.addObject("limit", limit);
        } else {
            modelAndView.addObject("limit", 25);
        }
    }

    /**
     * 获取请求的相对的url
     *
     * @param request
     * @return
     */
    private String getContextPath(HttpServletRequest request) {
        String uri = request.getServletPath();
        String pathInfo = request.getPathInfo();
        if (pathInfo != null && pathInfo.length() > 0) {
            uri = uri + pathInfo;
        }
        return uri;
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
            throws Exception {
    }
}
