<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="/permission" prefix="pe" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%--
  ~ /**
  ~  *dashan
  ~  */
  --%>

<jsp:include page="../../include/top.jsp"/>
<!-- Body -->
<div class="container-fluid">
    <div class="row-fluid">
        <!-- Menu -->
        <jsp:include page="../../include/menu.jsp"/>
        <div class="span9" id="content">
            <jsp:include page="../../include/location.jsp"/>
            <div class="row-fluid">
                <div class="span12">
                    <div class="block">
                        <div class="navbar navbar-inner block-header" style="border-bottom: none;">
                            <form id="myForm" name="myForm" action="${BasePath}/meiyue/vote/list" method="post" class="form-inline">
                                <table>
                                    <tr>
                                        <td style="vertical-align: middle;">投票名称：</td>
                                        <td>
                                            <input type="text" id="title" name="title" value="${title}"/>
                                        </td>
                                        <%--<td style="vertical-align: middle;">商家名称：</td>--%>
                                        <%--<td><input type="name" name="name" value="${name}"/></td>--%>
                                        <td>&nbsp;<input type="submit" value="查询"/></td>
                                    </tr>
                                </table>

                                <input type="hidden" name="start" id="start" value="${start }"/>
                                <input type="hidden" name="limit" id="limit" value="${limit }"/>
                                <input type="hidden" name="type" id="type" value="${type }"/>
                                <input type="hidden" name="itemId" id="itemId" value="${itemId }"/>
                            </form>
                        </div>
                    </div>
                </div>

                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <div class="muted pull-left">投票列表</div>
                        <div class="pull-right">
                            <pe:permission key="add">
                                <button class="btn btn-success btn-small" onclick="openModel('${BasePath}/meiyue/vote/toAdd','新增')">新增</button>
                            </pe:permission>
                        </div>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table class="table table-hover">
                                <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>投票名称</th>
                                    <th>总投票</th>
                                    <th>投票人数</th>
                                    <th>截至时间</th>
                                    <th>创建时间</th>
                                    <th>状态</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody id="tbodys">
                                <c:forEach items="${list}" var="obj">
                                    <tr >
                                        <td class="id">${obj.id}</td>
                                        <td>${obj.title}</td>
                                        <%--<td>--%>
                                            <%--<c:if test="${obj.topicId>0}">--%>
                                                <%--${obj.topicId}--%>
                                            <%--</c:if>--%>
                                        <%--</td>--%>
                                        <td>${obj.total}</td>
                                        <td>${obj.totalUser}</td>
                                        <td>
                                            <script>formatTime("${obj.endDate}");</script>
                                        </td>
                                        <td>
                                            <script>formatTime("${obj.dateline}");</script>
                                        </td>
                                        <td>
                                            <c:if test="${obj.endDate<=curentDate}">
                                                <span style="color: red">已结束</span>
                                            </c:if>
                                            <c:if test="${obj.endDate>curentDate}">
                                                <span style="color: green">进行中</span>
                                            </c:if>
                                        </td>
                                        <td>
                                            <pe:permission key="update">
                                                <button class="btn btn-success btn-small" onclick="openModel('${BasePath}/meiyue/vote/toModify?id=${obj.id}','修改')">修改</button>
                                            </pe:permission>
                                            <pe:permission key="delete">
                                                <button class="btn del btn-danger btn-small">删除</button>
                                            </pe:permission>
                                            <button class="btn btn-success btn-small" onclick="openModel('${BasePath}/meiyue/vote/toDetail?id=${obj.id}&type=${type}&itemId=${itemId}','详情')">详情</button>
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
    function openDetail(id) {
        var sign = $("#sign_" + id).val();
        $.each($("#" + id), function (i) {
            if (sign == 0) {
                this.style.display = 'none';
            } else {
                this.style.display = '';
            }
        });
        if (sign == 0) {
            $("#sign_" + id).val("1");
        } else {
            $("#sign_" + id).val("0");
        }
    }

    //删除奖品
    function deleteAward(id) {
        if (!confirm('确定删除该条记录吗？')) {
            return false;
        }
        $.post('${BasePath}/coinProduct/deleteAward', {
            'id': id
        }, function (data) {
            var obj = eval(data);
            if (obj.errno == 0) {
                alert('操作成功');
                window.location.reload();
            } else {
                alert(obj.errdesc);
            }
        });
    }


    // 删除记录
    $(function () {
        $(".del").bind('click', function () {
            if (!confirm('确定删除该条记录吗？')) {
                return false;
            }
            var id = $(this).parent().parent().find(".id").text();
            var tr = $(this).parent().parent();
            $.post('${BasePath}/meiyue/vote/delete', {
                'id': id
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