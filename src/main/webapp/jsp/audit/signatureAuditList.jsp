<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="/permission" prefix="pe" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="e" uri="https://www.owasp.org/index.php/OWASP_Java_Encoder_Project" %>
<jsp:include page="../include/top.jsp"/>
<link href="${BasePath}/js/mediabox/css.css" rel="stylesheet" media="screen">
<!-- Body -->
<div class="container-fluid" onmousemove="initTrColor()">
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
                                  action="${BasePath}/audit/signatureAudit?${PublicParams}" method="post">
                                UID: <input type="text" id="uid" name="uid" value="${uid}">
                                <select name="status" id="status">
                                    <option
                                            <c:if test="${status==1}">selected="selected" </c:if> value="1">已审核
                                    </option>
                                    <option
                                            <c:if test="${status==0 }">selected="selected" </c:if> value="0">待审核
                                    </option>
                                </select>
                                <button type="button" onclick="submitForm()" class="btn btn-success btn-small">查询
                                </button>
                                <input type="hidden" name="start" id="start" value="${start }"/>
                                <input type="hidden" name="limit" id="limit" value="${limit }"/>
                            </form>

                        </div>
                    </div>
                </div>

                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <div class="muted pull-left inline">签名审核列表</div>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table class="table">
                                <thead>
                                <tr>
                                    <th nowrap="true">用户</th>
                                    <th nowrap="true">签名内容</th>
                                    <th nowrap="true">修改时间</th>
                                    <c:if test="${status == 1}">
                                        <th nowrap="true">审核时间</th>
                                        <th nowrap="true">审核结果</th>
                                        <th nowrap="true">审核人</th>
                                    </c:if>
                                    <c:if test="${status == 0}">
                                        <pe:permission key="banUser">
                                            <th nowrap="true">操作</th>
                                        </pe:permission>
                                    </c:if>
                                </tr>
                                </thead>
                                <tbody id="tbodys">
                                <c:forEach items="${data}" var="obj">
                                    <tr>
                                        <td nowrap="true" style="vertical-align:middle">
                                            <a href="${BasePath }/custom/userList?type=4&itemId=20&uid=${obj.uid}"
                                               target="_black">${obj.uid}</a>
                                            <br>
                                            <font color="#08c">昵称：</font>${obj.nick}
                                            <br>
                                            <a href="${BasePath }/audit/topicList?uid=${obj.uid}&type=${type}&itemId=${itemId}&status=-1">她的全部话题</a><br>
                                            <a href="${BasePath }/audit/replyList?uid=${obj.uid}&type=8&itemId=44&status=-1">她的全部回复</a>
                                        </td>
                                        <td nowrap="true" style="vertical-align:middle">
                                                ${obj.content}
                                        </td>
                                        <td nowrap="true" style="vertical-align:middle">
                                            <script>formatTime("${obj.dateline}");</script>
                                        </td>
                                        <c:if test="${status == 1}">
                                            <td nowrap="true" style="vertical-align:middle">
                                                <script>formatTime("${obj.auditTime}");</script>
                                            </td>
                                            <td nowrap="true" style="vertical-align:middle">
                                                <c:if test="${obj.isBan >-1}">
                                                    <font color="red">已封禁</font>
                                                </c:if>
                                                    <%--状态 0:待审核，-1:拒绝，1:通过--%>
                                                <c:if test="${obj.status ==1}">
                                                    <font color="red">已通过</font>
                                                </c:if>
                                                <c:if test="${obj.status ==-1}">
                                                    <font color="red">已删除</font>
                                                </c:if>
                                            </td>
                                            <td nowrap="true" style="vertical-align:middle">
                                                    ${obj.adminName}
                                            </td>
                                        </c:if>


                                        <c:if test="${status == 0}">
                                            <td nowrap="true" style="vertical-align:middle">
                                                <pe:permission key="pass">
                                                    <input class="btn btn-success btn-small" type="button" value="通过" onclick="setSignatureStatus(${obj.id},'1')"/>
                                                </pe:permission>
                                                <pe:permission key="delete">
                                                    <button class="btn del btn btn-danger btn-small" type="button"
                                                           onclick="openModel('${BasePath}/audit/refuseSignature?auditId=${obj.id}&uid=${obj.uid}','拒绝','40%','40%')">
                                                        拒绝
                                                    </button>
                                                </pe:permission>
                                                <pe:permission key="banUser">
                                                    <button class="btn btn-danger btn-small"
                                                            onclick="openModel('${BasePath}/audit/toSignatureBanUser?id=${obj.id}&uid=${obj.uid}&nick=${obj.nick}','封禁楼主','45%','70%')">
                                                        封禁用户
                                                    </button>
                                                </pe:permission>
                                            </td>
                                        </c:if>

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
        $("#myForm").submit();
    }


    /* 设置审核状态*/
    function setSignatureStatus(id, status) {
        $.post('${BasePath}/audit/setSignatureStatus', {
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


    function qqAjax(path) {
        $.ajax({
            type: "POST",
            url: path,
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