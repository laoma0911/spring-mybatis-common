<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="/permission" prefix="pe" %>
<%
    String basePath = request.getContextPath();
    request.setAttribute("BasePath", basePath);
    String publicParams = "itemId=" + request.getParameter("itemId") + "&type=" + request.getParameter("type");
    request.setAttribute("PublicParams", publicParams);
%>
<!DOCTYPE html>
<html class="no-js">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>大姨吗管理后台</title>
    <!-- Bootstrap -->
    <script src="${BasePath}/bootstrap/bootstrap/js/bootstrap.min.js"></script>
    <script src="${BasePath}/bootstrap/vendors/jquery-1.9.1.min.js"></script>
    <link href="${BasePath}/bootstrap/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
    <link href="${BasePath}/bootstrap/bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet" media="screen">
    <link href="${BasePath}/bootstrap/vendors/easypiechart/jquery.easy-pie-chart.css" rel="stylesheet" media="screen">
    <link href="${BasePath}/bootstrap/assets/styles.css" rel="stylesheet" media="screen">
    <link href="${BasePath}/bootstrap/assets/table.css" rel="stylesheet" media="screen">
    <link href="${BasePath}/css/css.css" rel="stylesheet" media="screen">

    <%-- <link rel="stylesheet" href="${BasePath}/plugin/pages/pagination.css" media="all"/> --%>
    <!--分页样式-->
    <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
    <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

    <script src="${BasePath}/js/fixedtoolbar.js"></script>
    <script src="${BasePath}/js/pager.js"></script>
    <script src="${BasePath}/js/utils.js"></script>
    <script src="${BasePath}/js/My97DatePicker/WdatePicker.js"></script>
    <script src="${BasePath}/bootstrap/vendors/modernizr-2.6.2-respond-1.1.0.min.js"></script>
    <script src="${BasePath}/js/mediabox/mootools-core.js"></script>
    <script src="${BasePath}/js/mediabox/mediabox.js"></script>


    <script src="${BasePath}/js/jquery/form.js"></script>
</head>

<body>