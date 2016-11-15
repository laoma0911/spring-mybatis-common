<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    String basePath = request.getContextPath();
    request.setAttribute("BasePath", basePath);
%>

<script src="${BasePath}/bootstrap/bootstrap/js/bootstrap.min.js"></script>
<script src="${BasePath}/bootstrap/vendors/jquery-1.9.1.min.js"></script>
<link href="${BasePath}/bootstrap/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
<link href="${BasePath}/bootstrap/bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet" media="screen">
<link href="${BasePath}/bootstrap/vendors/easypiechart/jquery.easy-pie-chart.css" rel="stylesheet" media="screen">
<link href="${BasePath}/bootstrap/assets/styles.css" rel="stylesheet" media="screen">
<link href="${BasePath}/bootstrap/assets/table.css" rel="stylesheet" media="screen">
<link href="${BasePath}/css/css.css" rel="stylesheet" media="screen">
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
<script src="${BasePath}/js/fixedtoolbar.js"></script>
<script src="${BasePath}/js/utils.js"></script>
<script src="${BasePath}/bootstrap/vendors/modernizr-2.6.2-respond-1.1.0.min.js"></script>
<script src="${BasePath}/js/mediabox/mootools-core.js"></script>
<script src="${BasePath}/js/mediabox/mediabox.js"></script>
<script src="${BasePath}/js/jquery/form.js"></script>
<script src="${BasePath}/js/pager.js"></script>

<!-- Body -->
<div class="block">
    <div class="navbar navbar-inner block-header" style="border-bottom: none;">
        <form id="myForm" name="myForm" action="${BasePath}/user/list" method="post" class="form-inline">
            用户名：<input type="text" name="name" value="${name }"/>
            昵称：<input type="text" name="nick" value="${nick}"/>
            <input type="button" value="查询" onclick="submitForm()" class="btn btn-success btn-small"/>
            <input type="hidden" name="start" id="start" value="${start }"/>
            <input type="hidden" name="limit" id="limit" value="${limit }"/>
        </form>
    </div>
</div>

<div class="panel-body" style="display: block;">
    <div class="slimScrollDiv" style="position: relative; overflow: hidden; width: 100%; height: auto;">
        <div class="table-responsive" style="overflow: hidden; width: 100%; height: auto;">
            <table id="editable-table" class="table table-striped" style="cursor: pointer;">
                <thead>
                <tr>
                    <th rowspan="1" colspan="1">id</th>
                    <th rowspan="1" colspan="1">name</th>
                    <th rowspan="1" colspan="1">nick</th>
                    <th rowspan="1" colspan="1">状态</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${userList}" var="obj">
                    <tr role="row"
                            <c:if test="${obj.id % 2 == 0 }"> class="even"</c:if>
                            <c:if test="${obj.id % 2 != 1 }"> class="odd"</c:if>>
                        <td class="sorting_1">${obj.id}</td>
                        <td>${obj.name}</td>
                        <td>${obj.nick}</td>
                        <td>${obj.status}</td>
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
            <%--<div class="row">--%>
            <%--<div class="col-md-4 col-xs-12">--%>
            <%--<div class="dataTables_info" id="basic-datatables_info" role="status" aria-live="polite">Showing--%>
            <%--1 to 25 of 57 entries--%>
            <%--</div>--%>
            <%--</div>--%>
            <%--<div class="col-md-8 col-xs-12">--%>
            <%--<div class="dataTables_paginate paging_bootstrap" id="basic-datatables_paginate">--%>
            <%--<ul class="pagination">--%>
            <%--<li class="prev disabled"><a href="#">← Previous</a></li>--%>
            <%--<li class="active"><a href="#">1</a></li>--%>
            <%--<li><a href="#">2</a></li>--%>
            <%--<li><a href="#">3</a></li>--%>
            <%--<li class="next"><a href="#">Next → </a></li>--%>
            <%--</ul>--%>
            <%--</div>--%>
            <%--</div>--%>
            <%--</div>--%>
            <div class="slimScrollBar ui-draggable"
                 style="background: rgb(255, 255, 255); height: 3px; position: absolute; bottom: 3px; opacity: 0.4; display: none; border-radius: 3px; z-index: 99; width: 981px;"></div>
            <div class="slimScrollRail"
                 style="width: 100%; height: 3px; position: absolute; bottom: 3px; display: none; border-radius: 3px; background: rgb(51, 51, 51); opacity: 1; z-index: 90;"></div>
        </div>
    </div>
</div>

<script>

    function submitForm(){
        $("#start").val(1);
        $("#myForm").submit();
    }
</script>