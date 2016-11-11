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
                                  action="${BasePath}/chatReportImage/list?${PublicParams}" method="post">
                                小组名称: <input type="text" id="title" name="title" value="${title}"/>
                                UID: <input type="text" id="uid" name="uid" value="${uid}"/>
                                <select name="status" id="status">
                                    <%--<option--%>
                                            <%--<c:if test="${status==9}">selected="selected" </c:if> value="9">全部--%>
                                    <%--</option>--%>

                                        <option
                                                <c:if test="${status=='' || status==1}">selected="selected" </c:if> value="1">待审核
                                        </option>
                                       <option
                                                <c:if test="${status!=1}">selected="selected" </c:if> value="2">已审核
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
<c:if test="${status==1}">
                <div id="fixedBar" class="navbar navbar-inner" style="clear:both;">
                    <div class="muted pull-left inline">
                        <button class="btn btn-success btn-small"  onclick="window.location.href=window.location.href; ">刷新</button>
                        <button class="btn btn-success btn-small"  id="btnSelectAll" onclick="selectAll()">全选</button>
                        <pe:permission key="pass">
                            <button class="btn btn-success btn-small"  onclick="setAdutiStatus(4)">通过</button>
                        </pe:permission>
                        <pe:permission key="delete">
                            <button class="btn btn-success btn-small"  onclick="setAdutiStatus(5)">删除</button>
                        </pe:permission>
                    </div>
                </div>
    </c:if>
                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <div class="muted pull-left inline">聊天室图片审核列表</div>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table class="table">
                                <thead>
                                <tr>
                                    <th></th>
                                    <th>用户</th>
                                    <th nowrap="true">图片</th>
                                    <th nowrap="true">小组名称</th>
                                    <th nowrap="true">发送时间</th>
                                    <th nowrap="true">操作</th>
                                </tr>
                                </thead>
                                <tbody id="tbodys">
                                <c:forEach items="${json}" var="obj">
                                    <tr>
                                        <td>
                                            <input  <c:if test="${status!=1}">type="hidden"</c:if> <c:if test="${status==1}">type="checkbox"</c:if>    name="id" id="id" value="${obj.id }"/>
                                        </td>
                                        <td  nowrap="true" class="uid">
                                            <font color="#08c">UID：</font><a href="${BasePath }/custom/userList?type=4&itemId=20&uid=${obj.uid}"  target="_black">${obj.uid }</a>
                                            <br>
                                            <font color="#08c">昵称：</font> ${obj.nick}<br>
                                            <a href="${BasePath }/chatReportImage/list?uid=${obj.uid}&type=8&itemId=148">她的全部图片信息</a><br>
                                        </td>
                                        <td nowrap="true">
                                            <c:if test="${obj.content !=null && obj.content!=''}">
                                            <c:if test="${(obj.contentType !=null && obj.contentType!='') && obj.contentType==1 }">
                                                <a  target="_blank">${imageHost }${obj.content.url} </a> /${obj.content.time}</td>
                                        </c:if>
                                        <c:if test="${(obj.contentType !=null && obj.contentType!='') && obj.contentType==2 }">
                                           <%-- <img src="${obj.content.url}" width="80px" height="80px"/>--%>

                                            <a href="${obj.content.url}" rel="lightbox[ostec]">
                                                <img alt="" src="${obj.content.url}" height="80PX" width="80PX" />
                                            </a>
                                        </c:if>
                                            </c:if>


                                        </td>
                                        <td nowrap="true">
                                            <a href="${BasePath }/groupchatconfig/groupChatRoom?groupId=${obj.groupId}&conversationId=${obj.conversationId}&type=8&itemId=54" target="_black">${obj.title}</a>


                                        </td>
                                   <%--     <td style="width: 300px" class="tdBreak">
                                            <c:if test="${obj.messageType != 1}">
                                                <e:forHtml value="${obj.message}"/>
                                            </c:if>
                                        </td>
                                        <td style="width: 200px" class="tdBreak">
                                            <c:if test="${obj.messageType == 1}">
                                                <a href="${obj.message}" rel="lightbox[ostec]">
                                                    <img src="${obj.message}" style="width: 150px;height: 150px;">&nbsp;&nbsp;
                                                </a>
                                            </c:if>
                                        </td>--%>
                                        <td nowrap="true" >
                                            <script >formatTime("${obj.dateline}");</script>
                                        </td>


                                        <td nowrap="true" style="vertical-align:middle">
                                            <c:if test="${status==1}">
                                                <pe:permission key="prohibitionSpeak">
                                                    <button class="btn btn-success btn-small" onclick="prohibitionSpeak(${obj.uid})">禁言此人</button>
                                                </pe:permission>
                                                <pe:permission key="banUser">
                                                    <button class="btn btn-danger btn-small" onclick="openModel('${BasePath}/chatReportImage/toBanUser?uid=${obj.uid}&nick=${obj.nick}&id=${obj.id}','封禁用户','45%','70%')">封禁用户</button>
                                                </pe:permission>
                                            </c:if>
                                            <c:if test="${obj.status==3}">
                                                已封禁
                                            </c:if>
                                            <c:if test="${obj.status==4}">
                                                已通过

                                            </c:if>
                                            <c:if test="${obj.status==5}">
                                                已删除
                                            </c:if>
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

<script type="text/javascript">

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
    $('#tbodys tr').click(function () {
        var chks = $(':checkbox', this);
        chks.prop('checked', !chks[0].checked);
    });
    //浏览图片
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

    //通过or删除
    function setAdutiStatus(status) {
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
            url: "${BasePath}/chatReportImage/setAdutiStatus?ids=" + ids + "&status=" + status,
            datatype: "json",
            success: function (data) {
                if (data.errno == 1) {
                    alert(data.errdesc);
                } else {
                    submitForm();
                }
            },
            error: function () {
                alert("操作出错，请联系管理员！");
            }
        });
    }

    // 禁言
    function prohibitionSpeak(uid) {
        var path = "${BasePath}/chatReport/prohibitionSpeak?uid=" + uid;
        qqAjax(path);
    }


    function qqAjax(path) {
        $.ajax({
            type: "POST",
            url: path,
            datatype: "json",
            success: function (data) {
                if (data.errno == 1) {
                    alert(data.errdesc);
                } else {
                    submitForm();
                }
            },
            error: function () {
                alert("操作出错，请联系管理员！");
            }
        });
    }
    //浏览图片
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