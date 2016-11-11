<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="/permission" prefix="pe" %>

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
                            <div class="span" style="float: left;">
                                <label class="control-label" for="groupId" style="float: left;">所属域名 ：</label>
                                <select class="control-label" id="domainId" name="domainId">
                                    <c:forEach items="${domainJson.data}" var="domain">
                                        <c:choose>
                                            <c:when test="${domainId == domain.id}">
                                                <option value="${domain.id}" selected="selected">${domain.domain}</option>
                                            </c:when>
                                            <c:otherwise>
                                                <option value="${domain.id}">${domain.domain}</option>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="block">
                        <div class="navbar navbar-inner block-header">
                            <div class="muted pull-left">URL列表</div>
                            <div class="pull-right">
                                <pe:permission key="add">
                                    <button class="btn btn-success btn-small" style="margin-top: -5px" onclick="openModel('${BasePath}/url/toAdd','新增','50%','50%')">新增</button>
                                </pe:permission>
                            </div>
                        </div>
                        <div class="block-content collapse in">
                            <div class="span12">
                                <table class="table table-hover">
                                    <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>域名</th>
                                        <th>短链接</th>
                                        <th>原始链接</th>
                                        <th>目的链接</th>
                                        <th>操作</th>
                                    </tr>
                                    </thead>
                                    <tbody id="tbodys">
                                    <c:forEach items="${json.data}" var="url">
                                        <tr>
                                            <td class="id">${url.id}</td>
                                            <td>${url.domain}</td>
                                            <td>${url.shortUrl}</td>
                                            <td>${url.originalUrl}</td>
                                            <td>${url.targetUrl}</td>
                                            <td>
                                                <pe:permission key="update">
                                                    <a class="btn btn-success btn-small" href="javascript:openModel('${BasePath}/url/get?id=${url.id}','修改','50%','50%')">修改</a>
                                                </pe:permission>
                                                <pe:permission key="delete">
                                                    <button class="btn del btn-small btn-danger">删除</button>
                                                </pe:permission>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                                <div class="pagination pagination-centered" id="pager"></div>
                                <script type="text/javascript">
                                    var sign = 0;
                                    window.onbeforeunload(aa());
                                    function aa() {
                                        PAGER.initPager('${json.currpage}', ' ${json.total}', '${json.pagesize}', 8, 'pager', getData);
                                    }
                                    function getData(tp) {
                                        if (sign > 0) {
                                            window.location.href = "${BasePath}/url/query?start=" + tp + "&limit=${json.pagesize }&type=${type}&itemId=${itemId}&domainId=${domainId}";
                                        }
                                        sign = 1;
                                    }
                                </script>
                                <script type="text/javascript">
                                    var sign = 0;
                                    window.onload = function () {
                                        PAGER.initPager('${start}', ' ${json.total}', '${limit}', 8, 'pager', getData);
                                    }
                                    function getData(currentPage, pageSize) {
                                        if (sign > 0) {
                                            window.location.href = "${BasePath}/url/query?start=" + currentPage + "&limit=" + pageSize + "&type=${type}&itemId=${itemId}&domainId=${domainId}";
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
</div>
<hr>
<jsp:include page="../include/bottom.jsp"/>


<script>
    $("#domainId").bind("change", function () {
        var domainId = $("#domainId").val();
        window.location.href = "${BasePath }/url/query?type=${type}&itemId=${itemId}&domainId=" + domainId;
    });


    $(function () {
        $(".del").bind('click', function () {

            if (!confirm('确定删除该条记录吗？')) {
                return false;
            }
            var uid = $(this).parent().parent().find(".id").text();
            var tr = $(this).parent().parent();
            $.post('${BasePath}/url/delete', {
                'id': uid
            }, function (data) {
                var obj = eval(data);
                if (obj.errno == 0) {
                    alert('操作成功');
                    tr.remove();
                } else {
                    alert(obj.errdesc);
                }
            });

        });
    });
</script>