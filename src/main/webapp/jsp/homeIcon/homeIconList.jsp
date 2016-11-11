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
                        <div class="muted pull-left">首页入口ICON列表</div>
                        <div class="pull-right">
                            <pe:permission key="add">
                                <button class="btn btn-small btn-success" style="margin-top: -5px" onclick="openModel('${BasePath}/homeIcon/toAdd','新增')">新增</button>
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
                                    <th width="20%">在线时间</th>
                                    <th>位置</th>
                                    <th width="10%">图片</th>
                                    <th>文案</th>
                                    <%--<th width="20%">链接</th>--%>
                                    <th>点击数</th>
                                    <th>状态</th>
                                    <th width="12%" style="text-align:center;">操作</th>
                                </tr>
                                </thead>
                                <tbody id="tbodys">
                                <c:forEach items="${json.data}" var="obj">
                                    <tr>
                                        <td class="id">${obj.id}</td>
                                        <td>
                                            <script>formatDate("${obj.startTime }");</script>
                                            到
                                            <script>formatDate("${obj.endTime}");</script>
                                        </td>
                                        <td>
                                                ${obj.position}
                                        </td>
                                        <td>
                                            <img alt="" src="${imageHost }${obj.imgPath}" height="20PX" width="60PX"/>
                                        </td>
                                        <td>
                                                ${obj.title}
                                        </td>
                                        <%--<td>--%>
                                                <%--${obj.url}--%>
                                        <%--</td>--%>
                                        <td>
                                                ${obj.clickNum}
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${obj.startTime<=nowDate && nowDate<=obj.endTime}">
                                                    <font color="green">在线</font>
                                                </c:when>
                                                <c:when test="${nowDate <= obj.startTime}">
                                                    <font color="red">未上线</font>
                                                </c:when>
                                                <c:when test="${obj.endTime<nowDate }">
                                                    <font color="red">已结束</font>
                                                </c:when>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <pe:permission key="update">
                                                <a class="btn btn-success btn-small"
                                                   href="javascript:openModel('${BasePath}/homeIcon/toModify?id=${obj.id}','修改')">修改</a>
                                            </pe:permission>
                                            <pe:permission key="delete">
                                                <button class="btn del btn-danger btn-small">删除</button>
                                            </pe:permission>
                                            <pe:permission key="log">
                                                <a class="btn btn-info btn-small" href="javascript:openModel('${BasePath}/homeIcon/toHomeIconLog?id=${obj.id}&position=${obj.position}','查看每日')">查看每日</a>
                                            </pe:permission>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                            <div class="pagination pagination-centered" id="pager"></div>
                            <script type="text/javascript">
                                var sign=0;
                                window.onload=function(){
                                    PAGER.initPager('${start}',' ${json.total}','${limit}', 8, 'pager', getData);
                                }
                                function getData(currentPage,pageSize) {
                                    if(sign>0){
                                        $("#start").val(currentPage);
                                        $("#limit").val(pageSize);
                                        window.location.href="${BasePath}/homeIcon/list?start="+currentPage+"&limit="+pageSize+"&type=${type}&itemId=${itemId}";
                                    }
                                    sign=1;
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
            $.post('${BasePath}/homeIcon/delete', {
                'id': id
            }, function (data) {
                var obj = eval(data);
                if (obj.errno == 0) {
                    window.location.reload();
                    <%--window.location.href="${BasePath}/homeIcon/list?type=${type}&itemId=${itemId}";--%>
                } else {
                    alert(obj.errdesc);
                }
            });
        });
    });
</script>