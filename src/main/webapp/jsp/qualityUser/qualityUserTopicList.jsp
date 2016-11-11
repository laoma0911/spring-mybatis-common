<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="/permission" prefix="pe" %>
<%@ taglib prefix="e" uri="https://www.owasp.org/index.php/OWASP_Java_Encoder_Project" %>
<jsp:include page="../include/top.jsp"/>
<link href="${BasePath}/js/mediabox/css.css" rel="stylesheet" media="screen">
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
                            <form action="${BasePath}/qualityUser/topicList?${PublicParams}" method="post" id="myform" class="form-search">
                                UID：<input type="text" name="uid" id="uid" value="${uid}" class="input-small"/>
                                OR 用户等级：
                                <select name="level">
                                    <option selected="selected" >全部</option>
                                    <option <c:if test="${level=='A'}">selected="selected"</c:if> >A</option>
                                    <option <c:if test="${level=='B'}">selected="selected"</c:if> >B</option>
                                    <option <c:if test="${level=='C'}">selected="selected"</c:if> >C</option>
                                </select>
                                开始时间：
                                <input type="text" class="Wdate" id="startDate" name="startDate"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'endDate\')}',readOnly:'false'})" value="${startDate}"/>
                                结束时间：
                                <input type="text" class="Wdate" id="endDate" name="endDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'startDate\')}',maxDate:'%y-%M-%d',readOnly:'false'})" value="${endDate}" />
                                <input type="hidden" name="start" id="start" value="${start}"/>
                                <input type="hidden" name="limit" id="limit" value="${limit}"/>
                                <input type="submit" class="btn btn-small btn-success" value="查询"/>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <div class="muted pull-left">
                            潜在用户话题列表<br>
                        </div>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table class="table table-hover">
                                <thead>
                                <tr>
                                    <th>用户</th>
                                    <th>小组分类</th>
                                    <th>标题</th>
                                    <th>内容</th>
                                    <th>浏览量</th>
                                    <th>回复数</th>
                                    <th>发布时间</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody id="tbodys">
                                <c:forEach items="${data}" var="obj">
                                    <tr
                                            <c:choose>
                                                <c:when test="${obj.flag==1}">style="display:none"</c:when>
                                            </c:choose>>
                                        <td>
                                            UID:<a href="${BasePath }/custom/userList?type=4&itemId=20&uid=${obj.uid} " target="_black">${obj.uid }</a><br/>
                                            昵称：${obj.nick}<br/>
                                            <a href="${BasePath }/audit/topicList?uid=${obj.uid}&type=8&itemId=43&status=-1" target="_blank">她的全部话题</a><br>
                                            <a href="${BasePath }/audit/replyList?uid=${obj.uid}&type=8&itemId=44&status=-1" target="_blank">她的全部回复</a><br>
                                        </td>
                                        <td width="10%">${obj.topicGroupCategoryTitle}</td>
                                        <td width="20%">
                                             ${obj.id}<br>
                                            <c:choose>
                                                <c:when test="${obj.ban!=1}">
                                                    <a href="${BasePath}/topic/topicDetail?topicId=${obj.id}&type=${type}&itemId=${itemId}" target="_blank"><e:forHtml value="${obj.title}"/></a>
                                                </c:when>
                                                <c:otherwise>
                                                    <e:forHtml value="${obj.title}"/>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td width="20%">
                                            <e:forHtml value="${obj.content}"/><br>
                                            <c:forEach items="${obj.picList}" var="pic">
                                                <a href="${pic.oriPic}" rel="lightbox[ostec]">
                                                    <img src="${pic.pic}" width="130px" height="130px">&nbsp;
                                                </a>
                                            </c:forEach>
                                        </td>
                                        <td width="5%">${obj.viewnum}</td>
                                        <td width="5%">${obj.replynum}</td>
                                        <td width="15%">
                                            <script>formatTime("${obj.dateline}");</script>
                                        </td>

                                        <td>
                                                <%--<input type="button" class="btn btn-small btn-success"  onclick="toOpenModel(${obj.id})" value="推荐热门" />--%>
                                            <c:if test="${obj.hotSign==1}">
                                                <input type="button" class="btn btn-small btn-danger" onclick="cancelHot('${obj.id}','${obj.indexSign}')" value="取消推荐热门"/>
                                            </c:if>
                                            <c:if test="${obj.hotSign==0}">
                                                <input type="button" class="btn btn-small btn-success" onclick="openModel('${BasePaht}/topic/toRecommendTopic?topicId=${obj.id}','推荐到热门')" value="推荐热门"/>
                                            </c:if>

                                            <pe:permission key="edit">
                                                <a class="btn btn-small btn-success" href="${BasePath}/topic/updateTopic?${PublicParams}&topicId=${obj.id}" target="_blank">编辑</a>
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
                                        $("#myform").submit();
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
<script type="text/javascript">
    //取消推荐到热门
    function cancelHot(topicId, indexSign) {
        if (indexSign == 1) {
            if (confirm("该话题已经被推荐到首页，确定要取消吗？")) {
                var aj = $.ajax({
                    url: '${BasePath}/topic/cancelTagRecommend?topicId=' + topicId,
                    type: 'post',
                    cache: false,
                    dataType: 'json',
                    success: function (data) {
                        if (data.errno == 0) {
                            window.location.reload();
                        } else {
                            alert(data.errdesc);
                        }
                    },
                    error: function () {
                        alert("操作异常，请重试！");
                    }
                });
            }
        } else {
            if (confirm("确定要取消吗？")) {
                var aj = $.ajax({
                    url: '${BasePath}/topic/cancelTagRecommend?topicId=' + topicId,
                    type: 'post',
                    cache: false,
                    dataType: 'json',
                    success: function (data) {
                        if (data.errno == 0) {
                            window.location.reload();
                        } else {
                            alert(data.errdesc);
                        }
                    },
                    error: function () {
                        alert("操作异常，请重试！");
                    }
                });
            }
        }
    }
    //推荐热门
    function toOpenModel(topicId) {
        //1.$.ajax带json数据的异步请求
        var aj = $.ajax({
            url: '${BasePath}/topic/checkRecommend?topicId=' + topicId,
            type: 'post',
            cache: false,
            dataType: 'json',
            success: function (data) {
                if (data.errno == 0) {
                    openModel("${BasePaht}/topic/toRecommendTopic?topicId=" + topicId, "推荐到热门");
                } else {
                    alert(data.errdesc);
                }
            },
            error: function () {
                alert("操作异常，请重试！");
            }
        });
    }

    var xytzLive = true;//true隐藏推荐   false显示推荐

    function showRecommend(obj) {
        //$("#tbodys").empty();
        if (xytzLive) {
            xytzLive = false;
            $("input[name=flag]").each(function () {
                if ($(this).attr("checked")) {
                    $(this).parent().parent().parent().show();
                }
            });
            $(obj).val("隐藏已推荐");
        } else {
            xytzLive = true;
            $("input[name=flag]").each(function () {
                if ($(this).attr("checked")) {
                    $(this).parent().parent().parent().hide();
                }
            });
            $(obj).val("显示已推荐");
        }
    }


    function hottestOnChange(obj) {
        var val = obj.value.split(",");
        var topicId = val[0];
        var topicHottestId = val[1];
        var topicUid = val[2];
        var sod;
        if (obj.checked) {
            $(obj).attr("checked", true);
            if (xytzLive) {
                $(obj).parent().parent().parent().hide();
            }
            sod = 0;
        } else {
            $(obj).attr("checked", false);
            $(obj).parent().parent().parent().show();
            sod = 1;
        }
        var path = "${BasePath }/topic/hottestChange?topicId=" + topicId + "&sod=" + sod + "&topicHottestId=" + topicHottestId + "&topicUid=" + topicUid;
        $.ajax({
            async: false,
            type: "POST",
            url: path,
            datatype: "json",
            success: function (data) {
                if (data.error != null) {
                    alert(data.error);
                } else if (data.topicHottestId != null) {
                    obj.value = topicId + "," + topicId + "," + data.topicHottestId + "," + topicUid;
                } else {
                    obj.value = topicId + "," + topicId + ",''," + topicUid;
                }
            },
            error: function () {
                alert("操作出错，请联系管理员！");
            }
        });
    }

</script>
<script type="text/javascript">
    Mediabox.scanPage = function () {
        var links = $$("a").filter(function (el) {
            return el.rel && el.rel.test(/^lightbox/i);
        });
        $$(links).mediabox({/* Put custom options here */}, null, function (el) {
            var rel0 = this.rel.replace(/[[]|]/gi, " ");
            var relsize = rel0.split(" ");
            return (this == el) || ((this.rel.length > 8) && el.rel.match(relsize[1]));
        });
    };
    window.addEvent("domready", Mediabox.scanPage);
</script>
