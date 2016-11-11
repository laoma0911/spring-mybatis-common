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
                <!--kaishi -->
                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <div class="muted pull-left">小组分类</div>
                        <div class="pull-right">
                            <pe:permission key="operate">
                                <button class="btn btn-success btn-small" style="margin-top: -5px"
                                        onclick="openModel('${BasePath}/groupCategory/toAdd','新增','40%','50%')">新增
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
                                    <th width="20%">分类名称</th>
                                    <th>背景图</th>
                                    <th>排序值</th>
                                    <th width="10%">小组数目</th>
                                    <th>总人数</th>
                                    <th>总话题数</th>
                                    <pe:permission key="operate">
                                        <th width="12%" style="text-align:center;">操作</th>
                                    </pe:permission>
                                </tr>
                                </thead>
                                <tbody id="tbodys">
                                <c:forEach items="${json}" var="obj">
                                    <tr>
                                        <td class="id">${obj.catId}</td>
                                        <td>
                                                ${obj.title}
                                        </td>
                                        <td>
                                            <img alt="" src="${imageHost}${obj.background}" width="220px" height="220px"/>
                                        </td>
                                        <td>
                                                ${obj.displayorder}
                                        </td>
                                        <td>
                                                ${obj.num}
                                        </td>
                                        <td>
                                                ${obj.membernum}
                                        </td>
                                        <td>
                                                ${obj.countTopics}
                                        </td>
                                        <pe:permission key="operate">
                                            <td style="vertical-align:middle">
                                                <a class="btn btn-success btn-small"
                                                   href="javascript:openModel('${BasePath}/groupCategory/toModify?id=${obj.catId}','修改','40%','72%')">修改</a>

                                                <button class="btn del btn-danger btn-small">删除</button>
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
                                        window.location.href = "${BasePath}/groupCategory/list?start=" + currentPage + "&limit=" + pageSize + "&type=${type}&itemId=${itemId}";
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

    $(function () {
        $(".del").bind('click', function () {
            if (!confirm('确定删除该条记录吗？')) {
                return false;
            }
            var id = $(this).parent().parent().find(".id").text();
            $.post('${BasePath}/groupCategory/delete', {
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