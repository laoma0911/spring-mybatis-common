<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="/permission" prefix="pe" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="../include/top.jsp"/>
<!-- Body -->
<script type="text/javascript">
    function exposuresum(action,sublabel){
        var num = 0;
        $.ajax({
            type: "POST",
            url: '${BasePath}/periodicremind/exposuresum?action=' + action + "&sublabel=" + sublabel,
            datatype: "json",
            async:false ,
            success: function (data) {
                num = data.data;
            },
            error: function () {
                alert("操作出错，请联系管理员！");
            }
        });
        document.write(num);
    }
</script>
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
                        <div class="muted pull-left">时期提醒</div>
                        <div class="pull-right">
                            <pe:permission key="add">
                                <button class="btn btn-success btn-small" style="margin-top: -5px"
                                        onclick="openModel('${BasePath}/periodicremind/toModify?id=','新增','45%','60%')">新增
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
                                    <th nowrap="true">提醒内容</th>
                                    <th nowrap="true">提醒连接</th>
                                    <th nowrap="true">提醒时机</th>
                                    <th nowrap="true">平台</th>
                                    <th nowrap="true">在线时间</th>
                                    <th nowrap="true">点击量</th>
                                    <th nowrap="true">状态</th>
                                    <th nowrap="true">操作</th>
                                </tr>
                                </thead>
                                <tbody id="tbodys">
                                <c:forEach items="${json}" var="obj">
                                    <tr>
                                        <td style="width: 50px;vertical-align:middle" class="id">${obj.id}</td>

                                        <td style="width: 250px;vertical-align:middle" class="tdBreak">
                                                ${obj.content}
                                        </td>

                                        <td style="width: 250px;vertical-align:middle" class="tdBreak">
                                                <a href="${obj.linkurl}" target="_black">${obj.linkurl}</a>
                                        </td>

                                        <td style="width: 180px;vertical-align:middle" class="tdBreak">
                                            <c:if test="${obj.period == 1}">月经期<br></c:if>
                                            <c:if test="${obj.period == 2}">卵泡期<br></c:if>
                                            <c:if test="${obj.period == 3}">排卵期<br></c:if>
                                            <c:if test="${obj.period == 4}">黄体期<br></c:if>
                                            <c:if test="${obj.period == 5}">排卵日<br></c:if>
                                            <c:if test="${obj.range == -1}">之前<br></c:if>
                                            <c:if test="${obj.range == 0}">之中<br></c:if>
                                            <c:if test="${obj.range == 1}">之后<br></c:if>
                                            第${obj.day}天
                                        </td>

                                        <td style="width: 130px;vertical-align:middle" class="tdBreak">
                                            <script type="text/javascript">formatPlatform("${obj.platform}");	</script>
                                        </td>

                                        <td style="width: 180px;vertical-align:middle" class="tdBreak">
                                            <script>formatDate("${obj.start }");</script>
                                            <br>到<br>
                                            <script>formatDate("${obj.end }");</script>
                                        </td>

                                        <td style="width: 120px;vertical-align:middle" class="tdBreak">
                                            IOS:${obj.iosClick}<br>
                                            Andorid:${obj.androidClick}
                                        </td>

                                        <td style="width: 100px;vertical-align:middle" class="tdBreak">
                                            <c:if test="${now < obj.start}"><font color="red">未上线</font></c:if>
                                            <c:if test="${now > obj.end}"><font color="red">已结束</font></c:if>
                                            <c:if test="${now >= obj.start && now <= obj.end}"><font color="green">在线</font></c:if>
                                        </td>

                                        <td style="width: 170px;vertical-align:middle" class="tdBreak">
                                            <pe:permission key="update">
                                                <a class="btn btn-success btn-small"
                                                   href="javascript:openModel('${BasePath}/periodicremind/toModify?id=${obj.id}','修改','45%','60%')">修改</a>
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
                                    PAGER.initPager('${start}', ' ${total}', '${limit}', 8, 'pager', getData);
                                }
                                function getData(currentPage, pageSize) {
                                    if (sign > 0) {
                                        $("#start").val(currentPage);
                                        $("#limit").val(pageSize);
                                        window.location.href = "${BasePath}/periodicremind/list?start=" + currentPage + "&limit=" + pageSize + "&type=${type}&itemId=${itemId}";
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
            $.post('${BasePath}/periodicremind/delete', {
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