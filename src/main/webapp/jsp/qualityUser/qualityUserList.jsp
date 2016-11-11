<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="/permission" prefix="pe" %>

<%--
  ~ /**
  ~  *dashan
  ~  */
  --%>

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
                            <form id="myForm" name="myForm" action="${BasePath}/qualityUser/list" method="post" class="form-inline">
                                用户级别：
                                <select id="level" name="level">
                                    <option value="">全部</option>
                                    <option value="A" <c:if test="${level=='A'}">selected</c:if> >A</option>
                                    <option value="B" <c:if test="${level=='B'}">selected</c:if> >B</option>
                                    <option value="C"<c:if test="${level=='C'}">selected</c:if> >C</option>
                                </select>
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
                                <pe:permission key="promote">
                                    <button class="btn btn-success btn-small" style="margin-top: -5px" onclick="openModel('${BasePath}/qualityUser/toLevel?level=B','提升B级','50%','50%')">提升B级</button>
                                    <button class="btn btn-success btn-small" style="margin-top: -5px" onclick="openModel('${BasePath}/qualityUser/toLevel?level=C','提升C级','50%','50%')">提升C级</button>
                                </pe:permission>
                                <pe:permission key="export">
                                    <button class="btn btn-success btn-small" style="margin-top: -5px" onclick="openModel('${BasePath}/qualityUser/toExport','导出数据','50%','50%')">导出数据</button>
                                </pe:permission>
                            </div>
                        </div>
                        <div class="block-content collapse in">
                            <div class="span12">
                                <table class="table">
                                    <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>用户</th>
                                        <th>等级</th>
                                        <th>用户级别</th>
                                        <th>登录天数</th>
                                        <th>勋章</th>
                                        <th>创建小组</th>
                                        <th>注册时间</th>
                                        <th>操作</th>
                                    </tr>
                                    </thead>
                                    <tbody id="tbodys">
                                    <c:forEach items="${list}" var="obj">
                                        <tr>
                                            <td class="uid">${obj.id}</td>
                                            <td>
                                                UID:<a href="${BasePath }/custom/userList?type=4&itemId=20&uid=${obj.uid} " target="_black">${obj.uid }</a><br/>
                                                昵称：${obj.nick}<br/>
                                                <a href="${BasePath }/audit/topicList?uid=${obj.uid}&type=8&itemId=43&status=-1" target="_blank">她的全部话题</a><br>
                                                <a href="${BasePath }/audit/replyList?uid=${obj.uid}&type=8&itemId=44&status=-1" target="_blank">她的全部回复</a><br>
                                            </td>
                                            <td>
                                                <c:if test="${obj.userLevel>0}">
                                                    LV${obj.userLevel}
                                                </c:if>
                                            </td>
                                            <td>
                                                    ${obj.level}
                                            </td>
                                            <td>${obj.loginDays}</td>
                                            <td>${obj.userMedal}</td>
                                            <td>
                                                <textarea readonly>${obj.topicCategory}</textarea>
                                            </td>
                                            <td>
                                                <script>
                                                    formatTime("${obj.regTime}");
                                                </script>
                                            </td>
                                            <td>
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
            if (!confirm('确定删除吗？')) {
                return false;
            }
            var uid = $(this).parent().parent().find(".uid").text();
            var tr = $(this).parent().parent();
            $.post('${BasePath}/qualityUser/delete', {'id': uid}, function (data) {
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
    function submitForm() {
        $("#start").val(1);
        $("#myForm").submit();
    }
</script>