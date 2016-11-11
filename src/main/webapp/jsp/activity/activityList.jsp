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
                <div class="span12">
                    <div class="block">
                        <div class="navbar navbar-inner block-header" style="border-bottom: none;">
                            <form id="myForm" name="myForm" action="${BasePath}/activity/list" method="post">
                                <table>
                                    <tr valign="middle">
                                        <td>活动标题：</td>
                                        <td><input type="text" name="title" value="${title }"/></td>
                                        <!-- 											<td> -->
                                        <!-- 											<select name="platform"  id="platform" > -->
                                        <!-- 												<option value="-1">全部设备</option> -->
                                        <!-- 												<option  value="0">Android</option> -->
                                        <!-- 												<option value="1" >IOS</option> -->
                                        <!-- 												<option value="2">WP</option> -->
                                        <!-- 											</select> -->
                                        <!-- 											</td> -->
                                        <td>
                                            <select name="status" id="status">
                                                <option value="-1">全部</option>
                                                <option
                                                        <c:if test="${status==1 }">selected="selected" </c:if> value="1">未开始
                                                </option>
                                                <option
                                                        <c:if test="${status==2 }">selected="selected" </c:if> value="2">进行中
                                                </option>
                                                <option
                                                        <c:if test="${status==3 }">selected="selected" </c:if> value="3">已结束
                                                </option>
                                            </select>
                                        </td>
                                        <td><input type="submit" value="查询"/></td>
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
                        <div class="muted pull-left">活动列表</div>
                        <div class="pull-right">
                            <a class="btn btn-info btn-small" style="margin-top: -5px" href="javascript:openModel('${BasePath}/activity/getCoinsInfo?id=${obj.id}','查看金币数据')">查看金币数据</a>
                            <pe:permission key="add">
                                <button class="btn btn-success btn-small" style="margin-top: -5px" onclick="openModel('${BasePath}/activity/toAdd','新增')">新增</button>
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
                                    <th width="15%">活动名称</th>
                                    <th>上下线时间</th>
                                    <!--                       <th>状态</th> -->
                                    <th>开始结束时间</th>
                                    <th>活动状态</th>
                                    <th>平台</th>
                                    <th>活动缩略图</th>
                                    <th width="10%">活动链接</th>
                                    <!--                     <th>是否提醒</th> -->
                                    <th>点击数量</th>
                                    <th>定制数量</th>
                                    <th>同步谷歌</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody id="tbodys">
                                <c:forEach items="${json.data}" var="obj">
                                    <tr>
                                        <td class="uid">${obj.id}</td>
                                        <td>${obj.title }</td>
                                        <td>
                                            <script>formatTime("${obj.upTime}");</script>
                                            <br>
                                            <script>formatTime("${obj.downTime}");</script>
                                        </td>

                                        <!--                       <td> -->
                                            <%--                      <c:choose> --%>
                                            <%-- 	                     <c:when test="${obj.upTime<=nowDate && obj.downTime>nowDate}"> --%>
                                        <!-- 	                      			<font color="green">上线</font> -->
                                            <%-- 	                      </c:when> --%>
                                            <%-- 	                      <c:otherwise> --%>
                                        <!-- 	                      			<font color="red">下线</font> -->
                                            <%-- 	                      	</c:otherwise> --%>
                                            <%--                       	</c:choose> --%>
                                        <!--                      </td> -->

                                        <td>
                                            <script>formatTime("${obj.startTime}");</script>
                                            <br>
                                            <script>formatTime("${obj.endTime}");</script>
                                        </td>
                                        <td>
                                            <c:if test="${obj.startTime >nowDate }">
                                                <font color="#787878">未开始</font>
                                            </c:if>
                                            <c:if test="${obj.startTime <= nowDate && obj.endTime>=nowDate }">
                                                <font color="green">进行中</font>
                                            </c:if>
                                            <c:if test="${obj.endTime<nowDate }">
                                                <font color="red">已结束</font>
                                            </c:if>
                                        </td>
                                        <td>
                                            <script type="text/javascript">formatPlatform('${obj.platform}');</script>
                                        </td>
                                        <td><img alt="" src="${imageHost }${obj.pic}" height="20PX" width="60PX"/></td>
                                        <td><a href="${obj.link}" target="_Blank">${obj.link}</a></td>
                                        <%--<td>${obj.clickCount }</td>--%>
                                        <td>
                                            <input type="hidden" id="id" name="id" value="${obj.id }"/>
                                            <div id="clickNumDiv_${obj.id }"></div>
                                        </td>
                                        <td>${obj.remindCount}</td>
                                        <td>
                                            <c:if test="${obj.toGoogle == 0 }">
                                                不同步
                                            </c:if>
                                            <c:if test="${obj.toGoogle == 1 }">
                                                同步
                                            </c:if>
                                        </td>
                                        <td>
                                            <pe:permission key="update">
                                                <a class="btn btn-success btn-small" href="javascript:openModel('${BasePath}/activity/toModify?id=${obj.id}','修改')">修改</a>
                                            </pe:permission>
                                            <pe:permission key="delete">
                                                <button class="btn del btn-danger btn-small">删除</button>
                                            </pe:permission>
                                            <pe:permission key="log">
                                                <a class="btn btn-info btn-small" href="javascript:openModel('${BasePath}/activity/toActivityLog?id=${obj.id}','查看每日')">查看每日</a>
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
                                    //异步统计点击数
                                    $("input[name='id']").each(function (){
                                        var id=this.value;
                                        $.post('${BasePath}/activity/getClickNum',{ 'id':id },function(data){
                                            var obj = eval(data);
                                            if(obj.errno==0){
                                                $("#clickNumDiv_"+id).html(data.clickNum);
                                            }
                                        });
                                    });
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
        $(".del").bind('click', function () {
            if (!confirm('确定删除该条记录吗？')) {
                return false;
            }
            var uid = $(this).parent().parent().find(".uid").text();
            var tr = $(this).parent().parent();
            $.post('${BasePath}/activity/changStatus', {
                'id': uid, 'status': -1
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

        $(".up").bind('click', function () {
            var uid = $(this).parent().parent().find(".uid").text();
            var tr = $(this).parent().parent();
            $.post('${BasePath}/activity/changStatus', {
                'id': uid, 'status': 1
            }, function (data) {
                var obj = eval(data);
                if (obj.errno == 0) {
                    alert('操作成功');
                    window.location.reload();
                } else {
                    alert(obj.errdesc);
                }
            });
        });

        $(".down").bind('click', function () {
            var uid = $(this).parent().parent().find(".uid").text();
            $.post('${BasePath}/activity/changStatus', {
                'id': uid, 'status': 0
            }, function (data) {
                var obj = eval(data);
                if (obj.errno == 0) {
                    alert('操作成功');
                    window.location.reload();
                } else {
                    alert(obj.errdesc);
                }
            });
        });
    });
</script>