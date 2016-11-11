<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../../include/head.jsp"/>
<style>
    body {
        padding-top: 0px;
    }
</style>
<!-- Body -->
<div class="container-fluid">
    <!-- block -->
    <div class="block">
        <div class="navbar navbar-inner block-header">
            <div class="muted pull-left">投票详情</div>
        </div>

        <div class="alert alert-error" id="alertErr" style="display: none;">
            <button class="close" data-dismiss="alert">×</button>
            <strong>Error!</strong> <span id="errodesc">This is an error message.</span>
        </div>
        <div class="block-content collapse in">
            <div class="span">
                <table>
                    <tr>
                        <td>投票名称：</td>
                        <td style="color: green">${obj.title}</td>
                    </tr>
                    <tr>
                        <td>有效时间：</td>
                        <td style="color: green">
                            <script>formatTime("${obj.dateline}");</script>
                            至
                            <script>formatTime("${obj.endDate}");</script>
                        </td>
                    </tr>
                    <tr>
                        <td>曝光量：</td>
                        <td style="color: green">${viewNum}</td>
                    </tr>
                    <tr>
                        <td>投票人数：</td>
                        <td style="color: green">${obj.totalUser}</td>
                    </tr>
                    <tr>
                        <td>投票状态：</td>
                        <td style="color: green">
                            <c:if test="${obj.endDate<=currentDate}">
                                <span style="color:#ff0000">已结束</span>
                            </c:if>
                            <c:if test="${obj.endDate>currentDate}">
                                <span style="color: green">进行中</span>
                            </c:if>
                        </td>
                    </tr>
                    <tr bgcolor="#7fffd4">
                        <td>话题ID</td>
                        <td>标题</td>
                    </tr>
                    <c:forEach items="${topicList}" var="topic" varStatus="status">
                        <tr bgcolor="#f0f8ff">
                            <td>${topic.topicId}</td>
                            <td>
                                <a target="_blank" href="${BasePath }/meiyue/topic/topicDetail?topicId=${topic.topicId}&type=${type}&itemId=${itemId}">${topic.topicTitle }</a>
                            </td>
                        </tr>
                    </c:forEach>
                    <tr bgcolor="#7fffd4">
                        <td colspan="3">投票详情</td>
                    </tr>
                    <c:forEach items="${voteItemList}" var="item" varStatus="status">
                        <tr bgcolor="#f0f8ff">
                            <td colspan="2">${status.index+1}.${item.title} <span style="color: royalblue">${item.num}票 ${item.bili}%</span></td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <div class="progress">
                                    <div class="bar" style="width: ${item.bili}%;"></div>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
    </div>
</div>