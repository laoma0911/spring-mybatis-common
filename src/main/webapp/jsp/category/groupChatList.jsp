<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="/permission" prefix="pe" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="../include/top.jsp"/>
<!-- Body -->
<div class="container-fluid">
    <div class="row-fluid">
        <!-- Menu -->
        <jsp:include page="../include/menu.jsp"/>
        <div class="span9" id="content">
            <jsp:include page="../include/location.jsp"/>
            <div class="row-fluid">

                <div class="span12">
                    <div class="block">
                        <div class="navbar navbar-inner block-header"
                             style="border-bottom: none;">
                            <form class="form-inline" id="myForm" name="myForm" action="${BasePath}/groupchatconfig/list" method="post">
                                <%--小组分类：--%>
                                <%--<select id="topicGroupCategoryId" name="topicGroupCategoryId">--%>
                                    <%--<option value="-1" >全部分类</option>--%>
                                <%--<c:forEach items="${topicGroupCategoryList}" var="obj">--%>
                                    <%--<option value="${obj.id}" <c:if test="${obj.id==topicGroupCategoryId}">selected</c:if>>${obj.title}</option>--%>
                                <%--</c:forEach>--%>
                                <%--</select>--%>
                                小组名称: <input type="text" id="groupName" name="groupName" value="${groupName }">
                                <button type="button" onclick="submitForm()" class="btn btn-success btn-small">查询</button>
                                <input type="hidden" name="start" id="start" value="${start }"/>
                                <input type="hidden" name="limit" id="limit" value="${limit }"/>
                                <input type="hidden" name="type" id="type" value="${type }"/>
                                <input type="hidden" name="itemId" id="itemId" value="${itemId }"/>
                            </form>

                        </div>
                    </div>
                </div>
                <!--kaishi -->
                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <div class="muted pull-left">聊天室</div>
                        <div class="pull-right">
                        </div>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table class="table table-hover">
                                <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>小组分类</th>
                                    <th>小组名称</th>
                                    <th>小组公告</th>
                                    <th>链接</th>
                                    <th>最后修改时间</th>
                                    <th>聊天室人数</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody id="tbodys">
                                <c:forEach items="${json}" var="obj">
                                    <tr>
                                        <td>${obj.groupId}</td>
                                        <td>${obj.groupTypeName}</td>
                                        <td>${obj.groupName}</td>
                                        <td><textarea>${obj.announcement}</textarea></td>
                                        <td><textarea>${obj.link}</textarea></td>
                                        <td>
                                            <script>formatTime("${obj.lastupdate}");</script>
                                        </td>
                                        <td>${obj.memberCount}</td>
                                        <td style="vertical-align:middle">
                                            <pe:permission key="update">
                                                <a class="btn btn-success btn-small" href="javascript:openModel('${BasePath}/groupchatconfig/toGroupChatConfig?groupId=${obj.groupId}&conversationId=${obj.conversationId }','编辑','40%','40%')">编辑公告</a>
                                            </pe:permission>
                                            <pe:permission key="join">
                                                <a class="btn btn-success btn-small" href="${BasePath}/groupchatconfig/groupChatRoom?groupId=${obj.groupId}&conversationId=${obj.conversationId }&type=${type}&itemId=${itemId}"
                                                   target="_blank">进入聊天室</a>
                                            </pe:permission>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                            <div class="pagination pagination-centered" id="pager"></div>
                            <script type="text/javascript">
                                var sign = 0;
                                window.onload = function () {
                                    PAGER.initPager('${start}', ' ${total}',
                                            '${limit}', 8, 'pager', getData);
                                }
                                function getData(currentPage, pageSize) {
                                    if (sign > 0) {
                                        $("#start").val(currentPage);
                                        $("#limit").val(pageSize);
                                        $("#myForm").submit();
                                    }
                                    sign = 1;
                                }
                            </script>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<hr>

<jsp:include page="../include/bottom.jsp"/>


<script>

    function submitForm() {
        $("#myForm").submit();
    }
</script>