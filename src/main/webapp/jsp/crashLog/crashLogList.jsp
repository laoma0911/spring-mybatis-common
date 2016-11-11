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
                <!--搜索栏 -->
                <div class="span12">
                    <div class="block"  >
                        <div class="navbar navbar-inner block-header"  style="border-bottom: none;" >
                            <form id="myForm" name="myForm" action="${BasePath}/crashLog/list" method="post">
                                <table >
                                    <tr valign="middle">
                                        <td>uid：</td><td><input type="text" name="uid"  id="uid"  value="${uid}" /></td>
                                        <td><input class="btn btn-success btn-small" type="submit" value="查询" /></td>
                                    </tr>

                                </table>
                                <input type="hidden"  name="start" id="start" value="${start }"/>
                                <input type="hidden"  name="limit" id="limit" value="${limit }"/>
                                <input type="hidden"  name="type" id="type" value="${type }"/>
                                <input type="hidden"  name="itemId" id="itemId" value="${itemId }"/>
                            </form>
                        </div>
                    </div>
                </div>

                <!--kaishi -->
                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <div class="muted pull-left">用户日志上传</div>
                        <div class="pull-right">
                            <pe:permission key="add">
                                <button class="btn btn-success btn-small" style="margin-top: -5px"
                                        onclick="openModel('${BasePath}/crashLog/toAdd','新增','45%','60%')">新增
                                </button>
                            </pe:permission>
                            <span class="badge badge-info">${userCount}</span>
                        </div>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table class="table table-hover">
                                <thead>
                                <tr>
                                    <th>ID</th>
                                    <th width="10%">用户信息</th>
                                    <th width="15%">dervice</th>
                                    <th>日志路径</th>
                                    <th>上传日志时间</th>
                                    <th>是否上传</th>
                                    <th width="10%" style="text-align:center;">操作</th>
                                </tr>
                                </thead>
                                <tbody id="tbodys">
                                <c:forEach items="${json.data}" var="obj">
                                    <tr>
                                        <td class="id">${obj.id}</td>
                                        <td>
                                            ${obj.uid}
                                        </td>
                                        <td>
                                                ${obj.device}
                                        </td>
                                        <td>
                                            <c:if test="${obj.file != null && obj.file != ''}">
                                                <a href="${downloadHost}${obj.file}">${downloadHost}${obj.file}</a>
                                            </c:if>
                                        </td>
                                        <td>
                                            <c:if test="${obj.dateline != 0}">
                                                <script>formatTime("${obj.dateline}");</script>
                                            </c:if>
                                        </td>
                                        <td>
                                            <c:if test="${obj.flag == 0}"><font color="red">否</font></c:if>
                                            <c:if test="${obj.flag == 1}"><font color="green">是</font></c:if>
                                        </td>
                                        <td style="vertical-align:middle">
                                            <pe:permission key="allow">
                                                <c:if test="${obj.flag == 0}">
                                                    <input class="btn btn btn-success btn-small" type="button"
                                                           value="允许上传"
                                                           onclick="setFlag(${obj.id},1)"/>
                                                </c:if>
                                            </pe:permission>
                                            <pe:permission key="refuse">
                                                <c:if test="${obj.flag == 1}">
                                                    <input class="btn btn-danger btn-small" type="button" value="禁止上传"
                                                           onclick="setFlag(${obj.id},0)"/>
                                                </c:if>
                                            </pe:permission>
                                            <pe:permission key="delete">
                                                <button class="btn del btn-danger btn-small">删除</button>
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
                                    PAGER.initPager('${start}', ' ${json.total}', '${limit}', 8, 'pager', getData);
                                }
                                function getData(currentPage, pageSize) {
                                    if (sign > 0) {
                                        $("#start").val(currentPage);
                                        $("#limit").val(pageSize);
                                        window.location.href = "${BasePath}/crashLog/list?start=" + currentPage + "&limit=" + pageSize + "&type=${type}&itemId=${itemId}";
                                    }
                                    sign = 1;
                                }
                            </script>
                        </div>
                    </div>
                </div>
                <!--jieshu-->
            </div>
        </div>
    </div>
</div>
<hr>
<jsp:include page="../include/bottom.jsp"/>

<script>

    function setFlag(id,flag) {
        $.post('${BasePath}/crashLog/setcrashLogFlag', {
            'id': id, 'flag': flag
        }, function (data) {
            var obj = eval(data);
            if (obj.errno == 0) {
                window.location.reload();
            } else {
                alert(obj.errdesc);
            }
        });
    }


    $(function () {
        $(".del").bind('click', function () {
            if (!confirm('确定删除该条记录吗？')) {
                return false;
            }
            var id = $(this).parent().parent().find(".id").text();
            $.post('${BasePath}/crashLog/delete', {
                'id': id
            }, function (data) {
                var obj = eval(data);
                if (obj.errno == 0) {
                    window.location.reload();
                } else {
                    alert(obj.errdesc);
                }
            });
        });
    });

</script>