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
                                  action="${BasePath}/audit/reportUserList?${PublicParams}" method="post">
                                用户:
                                <select name="status" id="status">
                                    <option
                                            <c:if test="${status==0}">selected="selected" </c:if> value="0">待审核
                                    </option>
                                    <option
                                            <c:if test="${status==-1}">selected="selected" </c:if> value="-1">已忽略
                                    </option>
                                    <option
                                            <c:if test="${status==1}">selected="selected" </c:if> value="1">已处理
                                    </option>
                                </select>

                                排序:
                                <select name="sort" id="sort">
                                    <option
                                            <c:if test="${sort== 'dateline'}">selected="selected" </c:if> value="dateline">最新举报时间
                                    </option>
                                    <option
                                            <c:if test="${sort== 'num'}">selected="selected" </c:if> value="num">举报次数
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
                        <pe:permission key="operate">
                            <button class="btn btn-success btn-small" onclick="ignore()">批量忽略
                            </button>
                        </pe:permission>
                    </div>
                </div>
                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <div class="muted pull-left inline">举报用户列表</div>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table class="table">
                                <thead>
                                <tr>
                                    <th width="1%"></th>
                                    <th width="10%">举报ID</th>
                                    <th width="20%">被举报用户</th>
                                    <th width="10%">被举报次数</th>
                                    <th width="20%">最新举报时间</th>
                                    <th width="20%">举报理由</th>
                                    <pe:permission key="operate">
                                        <th width="10%">操作</th>
                                    </pe:permission>
                                </tr>
                                </thead>
                                <tbody id="tbodys">
                                <c:forEach items="${reportUserList}" var="obj">
                                    <tr>
                                        <td id="clickId">
                                            <input type="checkbox" name="id" id="id" value="${obj.id}"/>
                                        </td>
                                        <td>
                                            ${obj.id}
                                        </td>
                                        <td>
                                            <a href="${BasePath }/custom/userList?type=4&itemId=20&uid=${obj.uid}"  target="_black">${obj.uid}</a>
                                            <c:if test="${obj.banCount != 0}">
                                                <font style="color: #ff0000">[违规${obj.banCount}]</font>
                                            </c:if>
                                            <c:if test="${obj.isMonitor == 1}">
                                                <font style="color: #ff0000">(监控)</font>
                                            </c:if>
                                            <br>
                                            <font color="#08c">昵称：</font>${obj.nick}
                                            <br>
                                            <a href="${BasePath }/audit/topicList?uid=${obj.uid}&type=${type}&itemId=${itemId}&status=-1">她的全部话题</a><br>
                                            <a href="${BasePath }/audit/replyList?uid=${obj.uid}&type=8&itemId=44&status=-1">她的全部回复</a>
                                        </td>
                                        <td style="vertical-align:middle">
                                            ${obj.num}
                                        </td>
                                        <td style="vertical-align:middle">
                                            <script >formatTime("${obj.dateline}");</script>
                                        </td>
                                        <td style="vertical-align:middle">
                                                ${obj.reason}
                                        </td>
                                        <pe:permission key="operate">
                                            <td style="vertical-align:middle">
                                                <c:if test="${obj.status == 0}">
                                                <input class="btn del btn btn-success btn-small" type="button" value="忽略"
                                                       onclick="ignore()"/>
                                                <button class="btn btn-danger btn-small"
                                                        onclick="openModel('${BasePath}/audit/toBanUser?uid=${obj.uid}&stamp=stamp&reportId=${obj.id}&nick=${obj.nick}','处理举报','45%','70%')">处理</button>
                                                </c:if>
                                                <c:if test="${obj.status == -1}">
                                                    <button class="btn btn-danger btn-small"
                                                            onclick="openModel('${BasePath}/audit/toBanUser?uid=${obj.uid}&stamp=stamp&reportId=${obj.id}&nick=${obj.nick}','处理举报','45%','70%')">处理</button>
                                                </c:if>
                                            </td>
                                        </pe:permission>
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


    //忽略
    function ignore() {
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
            url: "${BasePath}/audit/ignore?ids=" + ids,
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
</script>