<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<%@ taglib uri="/permission" prefix="pe"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<jsp:include page="../include/top.jsp" />
<!-- Body -->
<div class="container-fluid">
    <div class="row-fluid">
        <!-- Menu -->
        <jsp:include page="../include/menu.jsp" />
        <div class="span9" id="content">
            <jsp:include page="../include/location.jsp" />
            <div class="row-fluid">
                <!--kaishi -->
                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <div class="muted pull-left">热门小组推荐</div>
                        <div class="pull-right">
                            <pe:permission key="add">
                                <button class="btn btn-success btn-small"
                                        style="margin-top: -5px"
                                        onclick="openModel('${BasePath}/groupCategory/toAddhotCategory','新增','50%','50%')">新增
                                </button>
                            </pe:permission>
                            <span class="badge badge-info">${userCount}</span>
                        </div>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table class="table table-hover">
                                <thead>
                                <%--ID、小组名称、位置、在线时间、状态、操作--%>
                                <tr>
                                    <th width="10%">ID</th>
                                    <th width="20%">小组名称</th>
                                    <th>位置</th>
                                    <th width="20%">在线时间</th>
                                    <th>状态</th>
                                    <%--<pe:permission key="operate">--%>
                                        <th>操作</th>
                                    <%--</pe:permission>--%>
                                </tr>
                                </thead>
                                <tbody id="tbodys">
                                <c:forEach items="${data}" var="obj">
                                    <tr>
                                        <td class="id">${obj.id}</td>

                                        <td>
                                            ${obj.title}
                                        </td>

                                        <td>
                                            ${obj.displayorder}
                                        </td>

                                        <td>
                                            <script>formatTime("${obj.startDate}");</script>
                                            <br>
                                            至
                                            <br>
                                            <script>formatTime("${obj.endDate}");</script>
                                        </td>

                                        <td>
                                            <c:if test="${obj.status == 1}">
                                                <br>
                                                <font color="red">
                                                    该小组不存在或已删除
                                                </font>
                                            </c:if>
                                            <c:if test="${nowDate > obj.endDate}">
                                                <br>
                                                <font color="red">
                                                    已结束
                                                </font>
                                            </c:if>
                                            <c:if test="${nowDate < obj.endDate}">
                                                <br>
                                                <font color="GREEN">
                                                    在线
                                                </font>
                                            </c:if>

                                        </td>

                                        <td style="vertical-align:middle">
                                            <pe:permission key="update">
                                                <c:if test="${obj.status != 1}">
                                                    <a class="btn btn-success btn-small"
                                                       href="javascript:openModel('${BasePath }/groupCategory/toModifyhotCategory?id=${obj.id}','编辑','50%','50%')">编辑</a>
                                                </c:if>
                                            </pe:permission>
                                            <pe:permission key="delete">
                                                <button class="btn del btn-danger btn-small">
                                                    删除
                                                </button>
                                            </pe:permission>
                                        </td>

                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                            <div class="pagination pagination-centered" id="pager"></div>
                            <script type="text/javascript">
                                var sign = 0;
                                window.onload = function() {
                                    PAGER.initPager('${start}', ' ${total}',
                                            '${limit}', 8, 'pager', getData);
                                }
                                function getData(currentPage, pageSize) {
                                    if (sign > 0) {
                                        $("#start").val(currentPage);
                                        $("#limit").val(pageSize);
                                        window.location.href = "${BasePath}/groupCategory/hotCategoryList?start=" + currentPage + "&limit=" + pageSize + "&type=${type}&itemId=${itemId}";
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

<jsp:include page="../include/bottom.jsp" />


<script>

    // 删除小组推荐
    $(function () {
        $(".del").bind('click', function () {
            if (!confirm('您确定要删除吗?')) {
                return false;
            }
            var id = $(this).parent().parent().find(".id").text();
            $.ajax({
                type: "POST",
                url: "${BasePath}/groupCategory/deleteHotCategory?id=" + id,
                datatype: "json",
                success: function (data) {
                    if (data.errno == 0) {
                        alert('操作成功');
                        window.location.reload(true);
                    } else {
                        alert(data.errdesc);
                    }
                },
                error: function () {
                    alert("操作出错，请联系管理员！");
                }
            });
        });
    });
</script>