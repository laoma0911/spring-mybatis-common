<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="/permission" prefix="pe" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="../include/top.jsp"/>
<!-- Body -->
<script src="${BasePath}/js/json.js"></script>
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
                            <form id="myForm" name="myForm" action="${BasePath}/homepageReminder/list" method="post"
                                  class="form-inline">
                                标题：<input type="text" name="title" value="${title}"/> <input type="submit"
                                                                                             value="查询"
                                                                                             class="btn btn-success btn-small"/>

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
                        <div class="muted pull-left">列表</div>
                        <div class="pull-right">
                            <pe:permission key="add">
                                <button class="btn btn-success btn-small" style="margin-top: -5px"
                                        onclick="openModel('${BasePath}/homepageReminder/toAdd','新增')">新增
                                </button>
                            </pe:permission>
                        </div>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table class="table table-hover">
                                <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>平台</th>
                                    <th>用户群</th>
                                    <th>banner</th>
                                    <th>标题</th>
                                    <th style="width: 10%;">内容</th>
                                    <th>按钮文案|链接</th>
                                    <th>时间</th>
                                    <th>曝光量</th>
                                    <th>按钮点击量</th>
                                    <th>是否同步谷歌平台</th>
                                    <th style="width: 8%;" >操作  </th>
                                </tr>
                                </thead>
                                <tbody id="tbodys">
                                <c:forEach items="${json.homepageReminderList}" var="obj">
                                    <tr>
                                        <td class="id">${obj.id}</td>

                                        <td>
                                            <c:if test="${obj.platform !=null && obj.platform =='0' }">
                                                Android
                                            </c:if>
                                            <c:if test="${obj.platform !=null && obj.platform =='1' }">
                                                IOS
                                            </c:if>
                                        </td>
                                        <td width="15%">

                                            <script type="text/javascript">
                                                if ("${obj.userStatus}" != "-1") {
                                                    formatCardStatus("${obj.userStatus}")
                                                } else {
                                                    document.write(${obj.clientVer});
                                                }
                                            </script>
                                        </td>
                                        <td>
                                            <c:if test="${obj.pic !=null && obj.pic!=''}">
                                                <img src="${imageHost }${obj.pic}" width="80px" height="80px"/>
                                            </c:if>
                                        </td>
                                        <td>${obj.title}</td>
                                        <td>
                                                ${obj.content }
                                        </td>
                                        <td>     ${obj.buttonText} <br/>
                                                ${obj.link}</td>
                                        <td>
                                            <script>formatDate("${obj.startDate}");</script>
                                            ~
                                            <script>formatDate("${obj.endDate}");</script>
                                        </td>

                                        <td>
                                            <input type="hidden" id="id" name="id"
                                                   value="${obj.id },${obj.platform },v"/>

                                            <div id="clickNumDiv_${obj.id }"></div>
                                        </td>
                                        <td>
                                            <input type="hidden" id="id1" name="id1"
                                                   value="${obj.id },${obj.platform },c"/>

                                            <div id="clickNumDiv1_${obj.id }"></div>
                                        </td>
                                        <td>
                                            <c:if test="${obj.toGoogle==1}"><font color="green">已同步</font></c:if>
                                            <c:if test="${obj.toGoogle==0}"><font color="red">未同步</font></c:if>
                                        </td>
                                        <td>
                                            <pe:permission key="update">
                                                <a class="btn btn-success btn-small"
                                                   href="javascript:openModel('${BasePath}/homepageReminder/toEdit?id=${obj.id}','修改')">修改</a>
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
<jsp:include page="../include/bottom.jsp"/>


<script>
    $(function () {

        //异步统计曝光量
        $("input[name='id']").each(function () {
            var id = this.value;
            $.post('${BasePath}/homepageReminder/getClickNum', {'id': id}, function (data) {
                var obj = eval(data);
                if (obj.errno == 0) {
                    $("#clickNumDiv_" + id).html(data.totalClickNum ? data.totalClickNum :0 );
                }
            });
        });
        //异步统计点击量
        $("input[name='id1']").each(function () {
            var id = this.value;
            $.post('${BasePath}/homepageReminder/getClickNum', {'id': id}, function (data) {
                var obj = eval(data);
                if (obj.errno == 0) {
                    $("#clickNumDiv1_" + id).html(data.totalClickNum ? data.totalClickNum :0);
                }
            });
        });


        $(".del").bind('click', function () {

            if (!confirm('确定删除该条记录吗？')) {
                return false;
            }
            var uid = $(this).parent().parent().find(".id").text();
            var tr = $(this).parent().parent();
            $.post('${BasePath}/homepageReminder/delete', {
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