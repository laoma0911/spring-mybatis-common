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
                                  action="${BasePath}/meiyue/expertService/list?${PublicParams}" method="post">
                                服务名称：
                                <input type="text" id="name" name="name" value="${name}">
                                状态：
                                <select name="status" id="status">
                                    <option
                                            <c:if test="${status==-1}">selected="selected" </c:if> value="-1">全部
                                    </option>
                                    <option
                                            <c:if test="${status==0}">selected="selected" </c:if> value="0">可订阅
                                    </option>
                                    <option
                                            <c:if test="${status==1}">selected="selected" </c:if> value="1">不可订阅
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
                        <div class="muted pull-left inline">小助手管理</div>
                        <div class="pull-right">
                            <pe:permission key="add">
                                <button class="btn btn-success btn-small" style="margin-top: -5px" onclick="openModel('/meiyue/expertService/toAdd','新增','40%','40%')">新增</button>
                            </pe:permission>
                        </div>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table class="table">
                                <thead>
                                <tr>
                                    <th nowrap="true">ID</th>
                                    <th nowrap="true">服务名称</th>
                                    <th nowrap="true">服务时长</th>
                                    <th nowrap="true">价格</th>
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
                                            ${obj.name}
                                        </td>
                                        <td nowrap="true" style="vertical-align:middle">
                                            ${obj.duration}个月
                                        </td>
                                        <td nowrap="true" style="vertical-align:middle">
                                            ${obj.price}
                                        </td>

                                        <td nowrap="true" style="vertical-align:middle">
                                            <c:if test="${obj.status==0}">
                                                <font color="green">可订阅</font>
                                            </c:if>
                                            <c:if test="${obj.status==1}">
                                                <font color="red">不可订阅</font>
                                            </c:if>
                                        </td>
                                        <td nowrap="true" style="vertical-align:middle">
                                            <c:if test="${obj.status==0}">
                                                <pe:permission key="online">
                                                    <button class="btn btn-danger btn-small" onclick="setStatus(${obj.id},1)">下线</button>
                                                </pe:permission>
                                            </c:if>
                                            <c:if test="${obj.status==1}">
                                                <pe:permission key="online">
                                                    <button class="btn btn-success btn-small" onclick="setStatus(${obj.id},0)">上线</button>
                                                </pe:permission>
                                            </c:if>
                                            <pe:permission key="update">
                                                <button class="btn btn-success btn-small" onclick="openModel('/meiyue/expertService/toAdd?id=${obj.id}','编辑','40%','40%')">编辑</button>
                                            </pe:permission>
                                            <pe:permission key="delete">
                                                <button class="btn btn-danger btn-small" onclick="deleteExpert(${obj.id})">删除</button>
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

    function deleteExpert(id) {
        $.ajax({
            type: "POST",
            url: "${BasePath}/meiyue/expertService/delete?id=" + id,
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
            url: "${BasePath}/meiyue/expertService/setStatus?id=" + id + "&status=" + status,
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