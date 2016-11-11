<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="/permission" prefix="pe" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="e" uri="https://www.owasp.org/index.php/OWASP_Java_Encoder_Project" %>
<jsp:include page="../../include/top.jsp"/>
<link href="${BasePath}/js/mediabox/css.css" rel="stylesheet" media="screen">
<!-- Body -->
<div class="container-fluid" onmousemove="initTrColor()">
    <div class="row-fluid">
        <!-- Menu -->
        <jsp:include page="../../include/menu.jsp"/>
        <div class="span9" id="content">
            <jsp:include page="../../include/location.jsp"/>
            <div class="row-fluid">
                <div class="span12">
                    <div class="block">
                        <div class="navbar navbar-inner block-header" style="border-bottom: none;">
                            <form class="form-inline" id="myForm" name="myForm"
                                  action="${BasePath}/meiyue/expertUser/list?${PublicParams}" method="post">
                                专家名称：
                                <input type="text" id="name" name="name" value="${name}">
                                状态：
                                <select name="expertUserType" id="expertUserType">
                                    <option
                                            <c:if test="${expertUserType==-1}">selected="selected" </c:if> value="-1">全部
                                    </option>
                                    <option
                                            <c:if test="${expertUserType==0}">selected="selected" </c:if> value="0">默认专家
                                    </option>
                                    <option
                                            <c:if test="${expertUserType==1}">selected="selected" </c:if> value="1">在线
                                    </option>
                                    <option
                                            <c:if test="${expertUserType==2}">selected="selected" </c:if> value="2">不在线
                                    </option>
                                </select>
                                <button type="button" onclick="submitForm()" class="btn btn-success btn-small">查询
                                </button>
                            </form>

                        </div>
                    </div>
                </div>

                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <div class="muted pull-left inline">专家列表</div>
                        <div class="pull-right">
                            <%--<pe:permission key="add">--%>
                                <button class="btn btn-success btn-small" style="margin-top: -5px" onclick="openModel('/meiyue/expertUser/toAdd','新增','40%','40%')">新增</button>
                            <%--</pe:permission>--%>
                        </div>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table class="table">
                                <thead>
                                <tr>
                                    <th nowrap="true">ID</th>
                                    <th nowrap="true">专家名称</th>
                                    <th nowrap="true">专家介绍</th>
                                    <th nowrap="true">专家头像</th>
                                    <th nowrap="true">添加时间</th>
                                    <th nowrap="true">状态</th>
                                    <th nowrap="true">操作</th>
                                </tr>
                                </thead>
                                <tbody id="tbodys">
                                <c:forEach items="${data}" var="obj">
                                    <tr>
                                        <td nowrap="true" id="clickId">
                                                ${obj.id}
                                        </td>

                                        <td nowrap="true" style="vertical-align:middle">
                                                ${obj.nick}
                                        </td>
                                        <td nowrap="true" style="vertical-align:middle">
                                                ${obj.describe}
                                        </td>
                                        <td nowrap="true" style="vertical-align:middle">
                                            <img src="${imageHost}${obj.expertIcon}" width="120px" height="120px">
                                        </td>
                                        <td nowrap="true" style="vertical-align:middle">
                                                <script>formatTime('${obj.dateline}');</script>
                                        </td>

                                        <td nowrap="true" style="vertical-align:middle">
                                            <c:if test="${obj.type==0}">
                                                <font color="green">默认专家</font>
                                            </c:if>
                                            <c:if test="${obj.type==1}">
                                                <font color="green">在线</font>
                                            </c:if>
                                            <c:if test="${obj.type==2}">
                                                <font color="red">未在线</font>
                                            </c:if>
                                        </td>
                                        <td nowrap="true" style="vertical-align:middle">
                                            <c:if test="${obj.type==1}">
                                                <%--<pe:permission key="online">--%>
                                                    <button class="btn btn-danger btn-small" onclick="setStatus(${obj.id},2)">下线</button>
                                                <%--</pe:permission>--%>
                                            </c:if>
                                            <c:if test="${obj.type==2}">
                                                <%--<pe:permission key="online">--%>
                                                    <button class="btn btn-success btn-small" onclick="setStatus(${obj.id},1)">上线</button>
                                                <%--</pe:permission>--%>
                                            </c:if>
                                            <%--<pe:permission key="update">--%>
                                                <button class="btn btn-success btn-small" onclick="openModel('/meiyue/expertUser/toAdd?id=${obj.id}','编辑','40%','40%')">编辑</button>
                                            <%--</pe:permission>--%>
                                            <%--<pe:permission key="delete">--%>
                                                <button class="btn btn-danger btn-small" onclick="deleteExpertUser(${obj.id})">删除</button>
                                            <%--</pe:permission>--%>
                                        </td>
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
<jsp:include page="../../include/bottom.jsp"/>


<script>

    function submitForm() {
        $("#myForm").submit();
    }

    function deleteExpertUser(id) {
        $.ajax({
            type: "POST",
            url: "${BasePath}/meiyue/expertUser/delete?id=" + id,
            datatype: "json",
            success: function (data) {
                if (data.errno == 1) {
                    alert(data.errdesc);
                } else {
                    submitForm();
                }
            },
            error: function () {
                alert("操作出错，请联系管理员！");
            }
        });
    }


    function setStatus(id,status) {
        $.ajax({
            type: "POST",
            url: "${BasePath}/meiyue/expertUser/setStatus?id=" + id + "&status=" + status,
            datatype: "json",
            success: function (data) {
                if (data.errno == 1) {
                    alert(data.errdesc);
                } else {
                    submitForm();
                }
            },
            error: function () {
                alert("操作出错，请联系管理员！");
            }
        });
    }
</script>