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
                            <form id="myForm" name="myForm" action="${BasePath}/user/list" method="post" class="form-inline">
                                用户名：<input type="text" name="name" value="${name }"/>
                                昵称：<input type="text" name="nick" value="${nick}"/>
                                <input type="button" value="查询" onclick="submitForm()" class="btn btn-success btn-small"/>
                                <input type="hidden" name="start" id="start" value="${start }"/>
                                <input type="hidden" name="limit" id="limit" value="${limit }"/>
                                <input type="hidden" name="type" id="type" value="${type }"/>
                                <input type="hidden" name="itemId" id="itemId" value="${itemId }"/>
                            </form>
                        </div>
                    </div>
                    <div class="block">
                        <div class="navbar navbar-inner block-header">
                            <div class="muted pull-left">用户列表</div>
                            <div class="pull-right">
                                <pe:permission key="add">
                                    <button class="btn btn-success btn-small" style="margin-top: -5px" onclick="openModel('${BasePath}/user/toAdd','新增')">新增</button>
                                </pe:permission>
                            </div>
                        </div>
                        <div class="block-content collapse in">
                            <div class="span12">
                                <table class="table">
                                    <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>用户名</th>
                                        <th>昵称</th>
                                        <th>组名</th>
                                        <th>操作</th>
                                    </tr>
                                    </thead>
                                    <tbody id="tbodys">
                                    <c:forEach items="${userList}" var="user">
                                        <tr>
                                            <td class="uid">${user.id}</td>
                                            <td>${user.name}</td>
                                            <td>${user.nick}</td>
                                            <td>${groupNameMap[user.groupId] }</td>
                                            <td>
                                                <pe:permission key="update">
                                                    <a class="btn btn-small btn-success" href="javascript:openModel('${BasePath}/user/toModify?uid=${user.id}','修改')">修改</a>
                                                </pe:permission>
                                                <pe:permission key="delete">
                                                    <button class="btn del btn-small btn-danger">删除</button>
                                                </pe:permission>
                                                <pe:permission key="grant">
                                                    <button class="btn btn-small btn-success" onclick="window.location='${BasePath}/user/toPermission?uid=${user.id}&type=${type}&itemId=${itemId}'">权限</button>
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
</div>
<hr>

<jsp:include page="../include/bottom.jsp"/>


<script>
    $(function () {
        $(".del").bind('click', function () {

            if (!confirm('确定删除该用户么？')) {
                return false;
            }
            var uid = $(this).parent().parent().find(".uid").text();
            var tr = $(this).parent().parent();
            $.post('${BasePath}/user/del', {
                'uid': uid
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
    function submitForm(){
        $("#start").val(1);
        $("#myForm").submit();
    }
</script>