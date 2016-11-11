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
                                  action="${BasePath}/privateMsg/officialList?${PublicParams}" method="post">
                                UID：
                                <input type="text" id="uid" name="uid" value="${uid}">
                                官方组：
                                <select name="officialUid" id="officialUid">
                                    <option
                                            <c:if test="${officialUid==-9}">selected="selected" </c:if> value="-9">全部
                                    </option>
                                    <c:forEach items="${uList}" var="user">
                                        <option
                                                <c:if test="${user.uid == officialUid}">selected="selected"</c:if> value="${user.uid}">${user.nick}
                                        </option>
                                    </c:forEach>
                                </select>
                                状态：
                                <select name="status" id="status">
                                    <option
                                            <c:if test="${status==1}">selected="selected" </c:if> value="1">已回复
                                    </option>
                                    <option
                                            <c:if test="${status==0 }">selected="selected" </c:if> value="0">未回复
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

                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <div class="muted pull-left inline">官方组私信管理</div>
                        <c:if test="${status == 0}">
                        <div class="pull-right">
                            <button class="btn btn-success btn-small" style="margin-top: -5px" id="btnSelectAll"
                                    onclick="selectAll()">全选
                            </button>
                            <pe:permission key="reply">
                                <button class="btn btn-success btn-small" style="margin-top: -5px" onclick="toReply()">
                                    回复
                                </button>
                            </pe:permission>
                        </div>
                    </div>
                    </c:if>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table class="table">
                                <thead>
                                <tr>
                                    <c:if test="${status == 0}">
                                        <th nowrap="true"></th>
                                    </c:if>
                                    <th nowrap="true">发送者</th>
                                    <th nowrap="true">接受者</th>
                                    <th nowrap="true">私信内容</th>
                                    <th nowrap="true">私信图片</th>
                                    <th nowrap="true">发送时间</th>
                                </tr>
                                </thead>
                                <tbody id="tbodys">
                                <c:forEach items="${data}" var="obj">
                                    <tr>
                                        <c:if test="${status == 0}">
                                            <td nowrap="true" id="clickId">
                                                <input type="checkbox" name="id" id="id" value="${obj.id}"/>
                                            </td>
                                        </c:if>
                                        <td nowrap="true" style="vertical-align:middle">
                                            UID：
                                            <a href="${BasePath }/custom/userList?type=4&itemId=20&uid=${obj.uid}"
                                               target="_black">${obj.uid}</a>
                                            <br>
                                            <font color="#08c">昵称：${obj.uidNick}</font>
                                        </td>
                                        <td nowrap="true" style="vertical-align:middle">
                                            UID：
                                            <a href="${BasePath }/custom/userList?type=4&itemId=20&uid=${obj.dymUid}"
                                               target="_black">${obj.dymUid}</a>
                                            <br>
                                            <font color="#08c">昵称：${obj.dymUidNick}</font>
                                        </td>
                                        <td style="width: 350px;vertical-align:middle" class="tdBreak">
                                            <c:if test="${obj.messageType == 1}">
                                                ${obj.message}
                                            </c:if>
                                        </td>

                                        <td style="width: 200px;vertical-align:middle" class="tdBreak">
                                            <c:if test="${obj.messageType == 2}">
                                                <a href="${obj.message}" rel="lightbox[ostec]">
                                                    <img src="${obj.message}" width="120px" height="120px">
                                                </a>
                                            </c:if>
                                        </td>

                                        <td nowrap="true" style="vertical-align:middle">
                                            <script>formatTime("${obj.dateline}");</script>
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
<jsp:include page="../include/bottom.jsp"/>


<script>

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


    function submitForm() {
        $("#myForm").submit();
    }

    function toReply() {
        var ids = new Array();
        $("input[name='id']:checked").each(function () {
            var txt = $(this).val();
            ids.push(txt);
        });
        if (ids.length == 0) {
            alert("您还未选择要回复的用户？");
            return false;
        }
        openModel('${BasePath}/privateMsg/toSend?ids='+ids,'回复','40%','60%');
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