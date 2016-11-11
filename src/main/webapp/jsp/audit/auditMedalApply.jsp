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
                        <div class="navbar navbar-inner block-header" style="border-bottom: none;">
                            <form class="form-inline" id="myForm" name="myForm"
                                  action="${BasePath}/audit/auditMedalList"
                                  method="post">
                                申请勋章:
                                <select name="medalId" id="medalId">
                                    <option value="0">全部</option>
                                    <c:forEach items="${medalList}" var="obj">
                                        <option
                                                <c:if test="${medalId == obj.id}">selected="selected" </c:if>
                                                value="${obj.id}">${obj.name}</option>
                                    </c:forEach>
                                </select>


                                用户UID: <input type="text" id="uid" name="uid" value="${uid }">


                                状态:
                                <select name="status" id="status">
                                    <option <c:if test="${status==0 }">selected="selected"</c:if>
                                            value="0">未审核
                                    </option>
                                    <option
                                            <c:if test="${status==1 }">selected="selected" </c:if>
                                            value="1">已通过
                                    </option>
                                    <option
                                            <c:if test="${status==2 }">selected="selected" </c:if>
                                            value="2">被拒绝
                                    </option>
                                    <option
                                            <c:if test="${status==3 }">selected="selected" </c:if>
                                            value="3">被去除
                                    </option>
                                </select>
                                <input type="hidden" name="start" id="start" value="${start}"/>
                                <input type="hidden" name="limit" id="limit" value="${limit}"/>
                                <input type="hidden" name="type" id="type" value="${type}"/>
                                <input type="hidden" name="itemId" id="itemId" value="${itemId}"/>
                                <button type="button" onclick="submitForm()" class="btn btn-success btn-small">查询
                                </button>
                            </form>

                        </div>
                    </div>
                </div>


                <!--kaishi -->
                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <div class="muted pull-left">勋章申请审核列表</div>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table class="table table-hover">
                                <thead>
                                <%--ID、用户、头像、发帖数、回复数、粉丝数、用户等级、申请勋章、申请理由、申请时间、状态、操作--%>
                                <tr>
                                    <th width="4%">ID</th>
                                    <th>用户</th>
                                    <th>头像</th>
                                    <th>发帖数</th>
                                    <th>回复数</th>
                                    <th>粉丝数</th>
                                    <th>用户等级</th>
                                    <th>申请勋章</th>
                                    <th width="35%">申请理由</th>
                                    <th>申请时间</th>
                                    <th>状态</th>
                                    <pe:permission key="operate">
                                        <th width="10%">操作</th>
                                    </pe:permission>
                                </tr>
                                </thead>
                                <tbody id="tbodys">
                                <c:forEach items="${json}" var="obj">
                                    <tr>
                                        <td class="id">${obj.id}</td>

                                        <td>
                                            <a href="${BasePath }/custom/userList?type=4&itemId=20&uid=${obj.uid}"  target="_black">${obj.uid }</a>
                                                <c:if test="${obj.groupId == 2}">
                                                    <font style="color: #ff0000">[监控]</font>
                                                </c:if>
                                            <br>
                                            ${obj.nick}
                                        </td>

                                        <td>
                                            <img alt="" src="${obj.userIcon}" height="20PX" width="60PX"/>
                                        </td>

                                        <td>
                                            ${obj.topicNum}
                                        </td>

                                        <td>
                                                ${obj.replyNum}
                                        </td>

                                        <td>
                                                ${obj.fansNum}
                                        </td>

                                        <td>
                                                ${obj.level}
                                        </td>

                                        <td>
                                                ${obj.medalName}
                                        </td>

                                        <td>
                                                ${obj.reason}
                                        </td>

                                        <td>
                                            <script>formatTime("${obj.dateline}");</script>
                                        </td>
                                         <%--0申请中 1通过 2驳回 3被去除,--%>
                                        <td>
                                                <c:if test="${obj.status == 0}">未审核</c:if>
                                                <c:if test="${obj.status == 1}">已通过</c:if>
                                                <c:if test="${obj.status == 2}">被拒绝</c:if>
                                                <c:if test="${obj.status == 3}">被去除</c:if>
                                        </td>
                                        <pe:permission key="operate">
                                            <td style="vertical-align:middle">
                                                <c:if test="${obj.status == 0}">
                                                    <input class="btn del btn btn-primary btn-small"
                                                           type="button"
                                                           value="通过"
                                                           onclick="setMedalStatus(${obj.id},'1')"
                                                           style="margin-left: auto; margin-right: auto;margin-top: 5px; margin-bottom: 10px;"/>
                                                    <br>
                                                    <a class="btn del btn btn-danger btn-small"
                                                       style="margin-left: auto; margin-right: auto;margin-top: 5px; margin-bottom: 10px;"
                                                       href="javascript:openModel('${BasePath}/audit/toRefuseMedal?uid=${obj.uid}&id=${obj.id}&mark=','拒绝','40%','40%')">拒绝</a>
                                                    <br>
                                                </c:if>

                                                <c:if test="${obj.status == 1}">
                                                    <a class="btn del btn btn-danger btn-small"
                                                       style="margin-left: auto; margin-right: auto;margin-top: 5px; margin-bottom: 10px;"
                                                       href="javascript:openModel('${BasePath}/audit/toRefuseMedal?uid=${obj.uid}&id=${obj.id}&mark=makr','去勋章','40%','40%')">去勋章</a>
                                                    <br>
                                                </c:if>

                                                <c:if test="${obj.status == 2}">
                                                    <input class="btn del btn btn-primary btn-small"
                                                           type="button"
                                                           value="通过"
                                                           onclick="setMedalStatus(${obj.id},'1')"
                                                           style="margin-left: auto; margin-right: auto;margin-top: 5px; margin-bottom: 10px;"/>
                                                    <br>
                                                </c:if>

                                                <a class="btn btn-info btn-small"
                                                   style="margin-left: auto; margin-right: auto;margin-top: 5px; margin-bottom: 10px;"
                                                   href="javascript:openModel('${BasePath}/audit/toMedalLog?id=${obj.id}&type=${type}&itemId=${itemId}','历史')">历史</a>
                                            </td>
                                        </pe:permission>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                            <div class="pagination pagination-centered" id="pager"></div>
                            <script type="text/javascript">
                                var sign = 0;
                                window.onload = function () {
                                    PAGER.initPager('${start}', ' ${total}', '${limit}', 8, 'pager', getData);
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
        // $("#sign").val("2");
        $("#myForm").submit();
    }

    /**
     * 设置勋章申请状态
     * @param id
     */
    function setMedalStatus(id, status) {
        $.post('${BasePath}/audit/setMedalStatus', {
            'id': id, 'status': status
        }, function (data) {
            var obj = eval(data);
            if (obj.errno == 0) {
                window.location.reload();
            } else {
                alert(obj.errdesc);
            }
        });
    }
</script>