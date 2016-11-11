<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="/permission" prefix="pe" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="e" uri="https://www.owasp.org/index.php/OWASP_Java_Encoder_Project" %>
<jsp:include page="../include/top.jsp"/>
<link href="${BasePath}/js/mediabox/css.css" rel="stylesheet" media="screen">
<!-- Body -->
<div class="container-fluid" onmousemove="initTrColor()">
    <div class="row-fluid">
        <!-- Menu -->
        <jsp:include page="../include/menu.jsp"/>
        <div class="span9" id="content">
            <jsp:include page="../include/location.jsp"/>
            <div class="row-fluid">
                <div class="span12">
                    <div class="block">
                        <div class="navbar navbar-inner block-header" style="border-bottom: none;">
                            <form class="form-inline" id="myForm" name="myForm"
                                  action="${BasePath}/topic/softFeedList?${PublicParams}" method="post">
                                topicId: <input type="text" id="topicId" name="topicId" value="${topicId}">

                                发布时间：
                                <input type="text" style="width: auto;" id="startDate" name="startDate" value="${startDate}"
                                       onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:'false'})" class="Wdate" onClick="WdatePicker()"/>

                                至
                                <input type="text" style="width: auto;" id="endDate" name="endDate" value="${endDate}"
                                       onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:'false'})"    class="Wdate" onClick="WdatePicker()" />

                                状态:<select name="status" id="status">
                                    <option
                                            <c:if test="${status==9 }">selected="selected" </c:if> value="9">全部
                                    </option>
                                    <option
                                            <c:if test="${status==0 }">selected="selected" </c:if> value="0">待处理
                                    </option>
                                    <option
                                            <c:if test="${status==1 }">selected="selected" </c:if> value="1">已处理
                                    </option>
                                </select>
                                排序:<select name="sort" id="sort">
                                <option
                                        <c:if test="${sort==1}">selected="selected" </c:if> value="1">发布时间
                                </option>
                                <option
                                        <c:if test="${sort==0}">selected="selected" </c:if> value="0">最后回复时间
                                </option>
                            </select>
                                <button type="button" onclick="submitForm()" class="btn btn-success btn-small">查询
                                </button>
                                <input type="hidden" name="start" id="start" value="${start }"/>
                                <input type="hidden" name="limit" id="limit" value="${limit }"/>
                            </form>

                        </div>
                    </div>
                </div>
                <div id="fixedBar" class="navbar navbar-inner" style="clear:both;">
                    <div class="muted pull-left inline">
                        <button class="btn btn-success btn-small" onclick="window.location.reload(true); ">刷新
                        </button>
                        <span class="badge badge-info"></span>
                        <button class="btn btn-success btn-small" id="btnSelectAll" onclick="selectAll()">全选
                        </button>
                        <span class="badge badge-info"></span>
                        <pe:permission key="pass">
                            <button class="btn btn-success btn-small" onclick="passAudit()">标记为已处理
                            </button>
                        </pe:permission>
                        <pe:permission key="download">
                            <a class="btn cancel btn btn-primary btn-small"
                               href="javascript:openModel('${BasePath}/topic/toExportFeedback','导出软件反馈帖子','45%','45%')">导出软件反馈帖子</a>
                        </pe:permission>
                        <pe:permission key="moveTopic">
                            <button class="btn btn-success btn-small" onclick="moveTopics()">
                                批量移动
                            </button>
                        </pe:permission>
                        <span class="badge badge-info"></span>
                    </div>
                    <div class="pull-right">
                        <h4>
                            ${startDate}-${endDate}完成：${todayratio}% - 总计完成：${ratio}%
                        </h4>
                    </div>
                </div>
                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <div class="muted pull-left inline">软件反馈任务列表</div>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table class="table">
                                <thead>
                                <tr>
                                    <th width="1%"></th>
                                    <th width="12%">话题信息</th>
                                    <th width="45%">话题内容</th>
                                    <th width="10%">发布时间</th>
                                    <th width="10%">最后回复</th>
                                    <th width="10%">操作人</th>
                                    <th width="10%">状态</th>
                                </tr>
                                </thead>
                                <tbody id="tbodys">
                                <c:forEach items="${data}" var="obj">
                                    <tr>
                                        <td id="clickId">
                                            <input type="checkbox" name="id" id="id" value="${obj.topicId}"/>
                                        </td>
                                        <td style="vertical-align:middle">
                                            topicID:${obj.topicId}<br>
                                            UID:<a href="${BasePath}/custom/userList?type=4&itemId=20&uid=${obj.uid}"  target="_black">${obj.uid }</a>
                                            <c:if test="${obj.banCount != 0}">
                                                <font style="color: #ff0000">[违规${obj.banCount}]</font>
                                            </c:if>
                                            <c:if test="${obj.isMonitor == 1}">
                                                <font style="color: #ff0000">(监控)</font>
                                            </c:if>
                                            <br>
                                            <font color="#08c">昵称：</font>${obj.nick}
                                        </td>
                                        <td style="vertical-align:middle">
                                            <a href="${BasePath}/topic/topicDetail?topicId=${obj.topicId}&type=${type}&itemId=${itemId}"
                                               target="_blank">标题:<e:forHtml value="${obj.title}"/></a>
                                            <br>
                                            <e:forHtml value="${obj.content}"/>
                                            <br>
                                            <c:forEach items="${obj.picList}" var="pic">
                                                <a href="${pic.oriPic}" rel="lightbox[ostec]">
                                                    <img src="${pic.pic}" width="130px" height="130px">&nbsp;
                                                </a>
                                            </c:forEach>
                                        </td>
                                        <td style="vertical-align:middle">
                                            <script >formatTime("${obj.dateline}");</script>
                                        </td>
                                        <td style="vertical-align:middle">
                                            ${obj.lastReplyName}
                                            <c:if test="${not empty obj.lastReplyName}"><br></c:if>
                                            <script >formatTime("${obj.lastReplyTime}");</script>
                                        </td>
                                        <td style="vertical-align:middle">
                                            ${obj.adminName}
                                        </td>
                                        <td style="vertical-align:middle">
                                            <c:if test="${obj.status == 0}">待处理</c:if>
                                            <c:if test="${obj.status == 1}">已处理</c:if>
                                        </td>

                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                            <div class="pagination pagination-centered" id="pager"></div>
                            <script type="text/javascript">
                                var sign = 0;
                                window.onload = function () {
                                    PAGER.initPager('${start}', '${total}', '${limit}', 8, 'pager', getData);
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
    //选中后改变背景颜色
    function initTrColor() {
        $("input[name='id']").each(function () {
            if (this.checked) {
                this.parentNode.parentNode.style.backgroundColor = "#D7E8D8";
            } else {
                this.parentNode.parentNode.style.backgroundColor = "#ffffff";
            }
        });
    }
    function submitForm() {
        $("#sign").val("2");
        $("#myForm").submit();
    }


    //    tr选中checkbox效果
    $("#tbodys tr").click(function () {
        var chks = $(':checkbox', this);
        chks.prop('checked', !chks[0].checked);
    });

    //全选
    function selectAll() {
        $("input[name='id']").each(function () {
            this.checked = true;
        });
        $("#btnSelectAll").html("取消全选");
        $("#btnSelectAll").attr("onclick", "cancelSelectAll()");
    }
    //取消全选
    function cancelSelectAll() {
        $("input[name='id']").each(function () {
            this.checked = false;
        });
        $("#btnSelectAll").html("全选");
        $("#btnSelectAll").attr("onclick", "selectAll()");
    }


    //通过
    function passAudit() {
        var ids = new Array();
        $("input[name='id']:checked").each(function () {
            var txt = $(this).val();
            ids.push(txt);
        });
        if (ids.length == 0) {
            alert("您还未选择要操作的数据？");
            return false;
        }
        $.ajax({
            type: "POST",
            url: "${BasePath}/topic/opFeedbackAudit?ids=" + ids,
            datatype: "json",
            success: function (data) {
                if (data.errno == 1) {
                    alert(data.errdesc);
                } else {
                    window.location.reload(true);
                }
            },
            error: function () {
                alert("操作出错，请联系管理员！");
            }
        });
    }

    //移动
    function moveTopics() {
        var ids = new Array();
        $("input[name='id']:checked").each(function () {
            var txt = $(this).val();
            ids.push(txt);
        });
        if (ids.length == 0) {
            alert("请选择需要操作的数据！");
            return false;
        }
        openModel('${BasePath}/topic/toMoveTopics?ids='+ids,'批量移动帖子','40%','40%');
    }

    //图片弹出
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