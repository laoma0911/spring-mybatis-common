<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="/permission" prefix="pe" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="../include/head.jsp"/>
<style>
    body {
        padding-top: 0px;
    }
</style>
<!-- Body -->
<div class="block">
    <div class="navbar navbar-inner block-header">
        <div class="muted pull-left">日志列表</div>
    </div>
    <div class="block-content collapse in">
        <div class="span12">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>实际广告位</th>
                    <th>预设广告位</th>
                    <th nowrap="true">标题|Topic ID|Link</th>
                    <th nowrap="true">图片</th>
                    <th nowrap="true">今日点击数</th>
                </tr>
                </thead>
                <tbody id="tbodys">
                <c:forEach items="${data}" var="obj" varStatus="status">
                    <tr>
                        <td style="width: 50px;vertical-align:middle" class="id">
                                ${obj.id}
                        </td>

                        <td style="width: 50px;vertical-align:middle" class="id">
                                ${status.index + 1}
                        </td>

                        <td style="width: 50px;vertical-align:middle" class="id">
                                ${obj.position}
                        </td>

                        <td style="width: 240px;vertical-align:middle" class="tdBreak">
                                ${obj.title}<br>
                            <c:if test="${obj.topicId != null}">${obj.topicId}</c:if><br>
                                ${obj.linkurl}
                        </td>

                        <td style="width: 210px;vertical-align:middle" class="tdBreak">
                            <img alt="" src="${obj.adPictureUrl}" width="200" height="94px"/>
                        </td>

                        <td style="width: 210px;vertical-align:middle" class="tdBreak">
                                ${obj.todayClick}
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
<hr>
<jsp:include page="../include/bottom.jsp"/>


