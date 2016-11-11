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
                            <form class="form-search" id="myForm" name="myForm"
                                  action="${BasePath}/topicBannerAd/list?${PublicParams}" method="post">
                                标题：
                                <input type="text" name="title" value="${title }"/>
                                <input type="hidden" name="start" id="start" value="${start }"/>
                                <input type="hidden" name="limit" id="limit" value="${limit }"/>
                                <input type="hidden" name="type" id="type" value="${type }"/>
                                <input type="hidden" name="itemId" id="itemId" value="${itemId }"/>
                                <button type="submit" class="btn btn-small btn-success">搜索</button>
                            </form>
                        </div>


                        <div class="navbar navbar-inner block-header" style="border-bottom: none;">
                            <div class="pull-right">
                                <form method="post" action="/topicBannerAd/toShow" target="_blank">
                                    <input type="radio" name="platform" value="0" checked="">Android
                                    <input type="radio" name="platform" value="1">IOS
                                    <input type="radio" name="platform" value="2">WP
                                    <input type="radio" name="platform" value="3">小米盒子
                                    <input id="todayDate" name="startDate" style="width:100px;" class="Wdate" type="text"
                                           onfocus="WdatePicker({readOnly:'false'})" value="${today}"/>
                                    <input type="submit" value="广告位预览">
                                </form>
                            </div>
                        </div>

                    </div>
                </div>

                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <div class="muted pull-left">姐妹说焦点图</div>
                        <div class="pull-right">

                            <pe:permission key="add">
                                <button class="btn btn-success btn-small" style="margin-top: -5px"
                                        onclick="openModel('${BasePath}/topicBannerAd/toAdd','新增','45%','70%')">新增
                                </button>
                            </pe:permission>
                            <span class="badge badge-info">${userCount}</span>
                            <br>
                        </div>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table class="table table-hover">
                                <thead>
                                <tr>
                                    <th>ID</th>
                                    <th nowrap="true">标题|链接|<br>Monitorlink</th>
                                    <th nowrap="true">图片</th>
                                    <th nowrap="true">起始时间及位置</th>
                                    <th nowrap="true">平台</th>
                                    <th nowrap="true">点击数|分享数|<br>今日点击数</th>
                                    <th nowrap="true">曝光数</th>
                                    <th nowrap="true">添加时间</th>
                                    <th nowrap="true">状态</th>
                                    <th nowrap="true">是否同步<br/>谷歌平台</th>
                                    <th nowrap="true">用户状态</th>
                                    <th nowrap="true">城市</th>
                                    <th nowrap="true">操作</th>
                                </tr>
                                </thead>
                                <tbody id="tbodys">
                                <c:forEach items="${data}" var="obj">
                                    <tr>
                                        <td style="width: 50px;vertical-align:middle" class="id">
                                                ${obj.id}
                                        </td>

                                        <td style="width: 190px;vertical-align:middle" class="tdBreak">
                                                ${obj.title}<br>
                                            <c:if test="${obj.linkurl != null}">${obj.linkurl}</c:if><br>
                                                ${obj.viewmonitorlink}
                                        </td>

                                        <td style="width: 210px;vertical-align:middle" class="tdBreak">
                                            <img alt="" src="${obj.adPictureUrl }" width="200" height="94px"/>
                                        </td>

                                        <td style="width: 220px;vertical-align:middle" class="tdBreak">
                                            <script>formatDate("${obj.start}");</script>
                                            ~
                                            <script>formatDate("${obj.end}");</script>
                                            &nbsp;&nbsp;位置${obj.position}
                                        </td>

                                        <td style="width: 80px;vertical-align:middle" class="tdBreak">
                                            <c:if test="${obj.targetPlatformAndroid != 0 }">Android</c:if><br>
                                            <c:if test="${obj.targetPlatformIos !=0 }">IOS</c:if><br>
                                            <c:if test="${obj.targetPlatformWp!=0}">WP</c:if><br>
                                            <c:if test="${obj.targetPlatformMibox!=0}">小米盒子</c:if>
                                        </td>

                                        <td style="width: 110px;vertical-align:middle" class="tdBreak">
                                            点击数:${obj.clicks}<br>
                                            分享数:${obj.sharecounts}<br>
                                            今日点击数:${obj.todayClick}
                                        </td>

                                        <td style="width: 100px;vertical-align:middle" class="tdBreak">
                                            <input type="hidden" id="id" name="id" value="${obj.id }"/>

                                            <div id="clickNumDiv_${obj.id }"></div>
                                        </td>

                                        <td style="width: 140px;vertical-align:middle" class="tdBreak">
                                            <script>formatTime("${obj.addTime}");</script>
                                        </td>

                                        <td style="width: 50px;vertical-align:middle">
                                            <c:if test="${now < obj.start}"><font color="red">未上线</font></c:if>
                                            <c:if test="${now > obj.end}"><font color="red">已结束</font></c:if>
                                            <c:if test="${now >= obj.start && now <= obj.end}"><font color="green">在线</font></c:if>
                                        </td>
                                        <td style="width: 30px;vertical-align:middle" class="tdBreak">
                                            <c:if test="${obj.toGoogle==1}"><font color="green">已同步</font></c:if>
                                            <c:if test="${obj.toGoogle==0}"><font color="red">未同步</font></c:if>
                                        </td>
                                        <td>
                                            <c:if test="${obj.userStatus==0}"> 全部 </c:if>
                                            <c:if test="${obj.userStatus==1}">记经期</c:if>
                                            <c:if test="${obj.userStatus==2}">备孕 </c:if>
                                            <c:if test="${obj.userStatus==3}">怀孕中</c:if>
                                            <c:if test="${obj.userStatus==4}">宝妈</c:if>
                                        </td>
                                        <td> ${obj.area}</td>
                                        <td style="vertical-align:middle">
                                            <pe:permission key="update">
                                                <a class="btn btn-success btn-small"
                                                   href="javascript:openModel('${BasePath}/topicBannerAd/toModify?id=${obj.id}','编辑','45%','80%')">编辑</a>
                                            </pe:permission>
                                            <pe:permission key="delete">
                                                <button class="btn del btn-danger btn-small">删除</button>
                                            </pe:permission>
                                            <pe:permission key="log">
                                                <a class="btn btn-info btn-small" href="javascript:openModel('${BasePath}/topicBannerAd/logList?id=${obj.id}','查看每日','50%','70%')">查看每日</a>
                                            </pe:permission>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                            <div class="pagination pagination-centered" id="pager"></div>
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
            var id = $(this).parent().parent().find(".id").text();
            $.post('${BasePath}/topicBannerAd/delete', {
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
        });
    });
    var sign = 0;
    window.onload = function () {
        //分页
        PAGER.initPager('${start}', ' ${total}', '${limit}', 8, 'pager', getData);
        //异步统计曝光率
        $("input[name='id']").each(function () {
            var id = this.value;
            $.post('${BasePath}/topicBannerAd/getView', {'id': id}, function (data) {
                var obj = eval(data);
                if (obj.errno == 0) {
                    var html = "总量:";
                    if (data.totalExposure != null) {
                        html += data.totalExposure;
                    } else {
                        html += "0";
                    }
                    html += "<br>Android:";
                    if (data.androidExposure != null) {
                        html += data.androidExposure;
                    } else {
                        html += "0";
                    }
                    html += "<br>IOS:";
                    if (data.iosExposure != null) {
                        html += data.iosExposure;
                    } else {
                        html += "0";
                    }
                    html += "<br>WP:";
                    if (data.wpExposure != null) {
                        html += data.wpExposure;
                    } else {
                        html += "0";
                    }
                    $("#clickNumDiv_" + id).html(html);
                }
            });
        });
    }
    //分页
    function getData(currentPage, pageSize) {
        if (sign > 0) {
            $("#start").val(currentPage);
            $("#limit").val(pageSize);
            $("#myForm").submit();
        }
        sign = 1;
    }
</script>