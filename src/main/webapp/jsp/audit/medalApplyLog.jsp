<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="/permission" prefix="pe" %>
<jsp:include page="../include/head.jsp"/>
<!-- Body -->
<style>
    body {
        padding-top: 0px;
    }

    /* box */
    .box {
        position: absolute;
        width: 600px;
        left: 50%;
        height: auto;
        z-index: 100;
        background-color: #fff;
        border: 1px #ddd solid;
        padding: 1px;
    }

    .box h2 {
        height: 25px;
        font-size: 14px;
        background-color: #aaa;
        position: relative;
        padding-left: 10px;
        line-height: 25px;
        color: #fff;
    }

    .box h2 a {
        position: absolute;
        right: 5px;
        font-size: 12px;
        color: #fff;
    }

    .box .list {
        padding: 10px;
    }

    .box .list li {
        height: 24px;
        line-height: 24px;
    }

    .box .list li span {
        margin: 0 5px 0 0;
        font-family: "宋体";
        font-size: 12px;
        font-weight: 400;
        color: #ddd;
    }

    .showbtn {
        font: bold 24px '微软雅黑';
    }

    #bg {
        background-color: #666;
        position: absolute;
        z-index: 99;
        left: 0;
        top: 0;
        display: none;
        width: 100%;
        height: 100%;
        opacity: 0.5;
        filter: alpha(opacity=50);
        -moz-opacity: 0.5;
    }

</style>
<div class="container-fluid">
    <div class="block">
        <div class="navbar navbar-inner block-header" style="border-bottom: none;">
            <div class="block">
                <div class="navbar navbar-inner block-header">
                    <div class="muted pull-left">勋章申请审核历史列表</div>
                    </div>
                </div>
                <div class="block-content collapse in">
                    <table class="table table-hover">
                        <thead>
                        <tr>
                            <th>时间</th>
                            <th>状态</th>
                            <th>原因</th>
                            <th>操作人</th>
                        </tr>
                        </thead>
                        <tbody id="tbodys">
                        <c:forEach items="${data}" var="obj">
                            <tr>
                                <td>
                                    <script language="javascript">formatTime("${obj.dateline}");</script>
                                </td>
                                <td>
                                     ${obj.action }
                                </td>
                                <td>
                                    ${obj.reason }
                                </td>
                                <td>
                                   ${obj.adminName}
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>