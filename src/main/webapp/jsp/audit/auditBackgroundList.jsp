<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="/permission" prefix="pe" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
                            <form class="form-inline" id="myForm" name="myForm"
                                  action="${BasePath}/audit/backgroundList?${PublicParams}"
                                  method="post">
                                小组分类:
                                <select name="catType" id="catType">
                                    <option value="0">全部分类</option>
                                    <c:forEach items="${tgcList}" var="obj">
                                        <option
                                                <c:if test="${catType == obj.id}">selected="selected" </c:if>
                                                value="${obj.id}">${obj.title}</option>
                                    </c:forEach>
                                </select>
                                小组ID: <input type="text" id="groupId" name="groupId" value="${groupId}">
                                状态:
                                <select name="status" id="status">
                                    <option
                                            <c:if test="${status==-1}">selected="selected" </c:if>
                                            value="-1">待审核
                                    </option>
                                    <option <c:if test="${status==0}">selected="selected" </c:if>
                                            value="0">正常
                                    </option>
                                    <option
                                            <c:if test="${status==1}">selected="selected" </c:if>
                                            value="1">已拒绝
                                    </option>

                                </select>
                                <input type="hidden" name="start" id="start" value="${start }"/>
                                <input type="hidden" name="limit" id="limit" value="${limit }"/>
                                <button type="button" onclick="submitForm()" class="btn btn-success btn-small">查询
                                </button>
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
                            <pe:permission key="agree">
                                <button class="btn btn-success btn-small" onclick="setBackgroundStatus(0)">
                                   通过
                                </button>
                            </pe:permission>
                            <span class="badge badge-info"></span>
                            <pe:permission key="refuse">
                                <button class="btn btn-danger btn-small" onclick="setBackgroundStatus(1)">
                                    拒绝
                                </button>
                            </pe:permission>
                        </div>
                    </div>

                <!--kaishi -->
                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <div class="muted pull-left">小组背景图审核</div>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table class="table table-hover">
                                <thead>
                                <%--小组ID、小组分类、小组信息、小组头像、组长、组长等级、已创建小组、小组状态、操作--%>
                                <tr>
                                    <th></th>
                                    <th>小组ID</th>
                                    <th>小组分类</th>
                                    <th width="15%">小组信息</th>
                                    <th>小组头像</th>
                                    <th>背景图</th>
                                    <th>组长</th>
                                    <th>组长等级</th>
                                    <th>已创建小组</th>
                                    <th width="10%">小组状态</th>
                                    <pe:permission key="operate">
                                        <th width="10%">操作</th>
                                    </pe:permission>
                                </tr>
                                </thead>
                                <tbody id="tbodys">
                                <c:forEach items="${json}" var="obj">
                                    <tr>
                                        <td>
                                            <input type="checkbox" name="id" id="id" value="${obj.id}"/>
                                        </td>
                                        <td class="id">${obj.id}</td>

                                        <td>${obj.catTitle}</td>

                                        <td>
                                            小组: <a href="${BasePath }/topic/allList?type=8&itemId=54&categorytitle=${obj.title}" target="_black">${obj.title}</a><br>
                                            简介:${obj.descs}
                                        </td>

                                        <td>
                                            <img alt="" src="${obj.pic}" height="20PX" width="60PX"/>
                                        </td>

                                        <td>
                                            <c:if test="${obj.backgroundStatus == 9}">
                                                <font color="red">无背景图</font>
                                            </c:if>
                                            <c:if test="${obj.backgroundStatus == -1}">
                                                <a href="${obj.background}" rel="lightbox[ostec]">
                                                    <img alt="" src="${obj.background}" height="150PX" width="150PX" />
                                                </a>
                                                <br>
                                            </c:if>
                                            <c:if test="${obj.backgroundStatus == 0}">
                                                <a href="${obj.background}" rel="lightbox[ostec]">
                                                    <img alt="" src="${obj.background}" height="150PX" width="150PX" />
                                                </a>
                                            </c:if>
                                            <c:if test="${obj.backgroundStatus == 1}">
                                                <a href="${obj.background}" rel="lightbox[ostec]">
                                                    <img alt="" src="${obj.background}" height="150PX" width="150PX" />
                                                </a>
                                                <br>
                                                <font color="red">已拒绝</font>
                                            </c:if>
                                        </td>

                                        <td>
                                            <a href="${BasePath }/custom/userList?type=4&itemId=20&uid=${obj.uid}"
                                               target="_black">${obj.uid }</a>
                                            <c:if test="${obj.userGroupId == 2}">
                                                <font style="color: #ff0000">[监控]</font>
                                            </c:if>
                                            <br>${obj.nick}
                                        </td>

                                        <td>
                                            Lv${obj.level}
                                        </td>

                                        <td>
                                                ${obj.hasNum}
                                        </td>

                                        <td>
                                            <c:if test="${obj.status == 0}">正常</c:if>
                                            <c:if test="${obj.status == 1}">被关闭
                                                <br>
                                                <br>
                                                <span class="time_wrap" value="${obj.countDown + 60 * 60 * 24 * 3}"
                                                      style="line-height:200%;color:#ff0000;"></span>
                                                <%--倒计时--%>
                                                <script type="text/javascript">
                                                    $(document).ready(function () {
                                                        setInterval(function () {
                                                            $(".time_wrap").each(function () {
                                                                var Obj = this;
                                                                var EndTime = new Date(parseInt($(Obj).attr('value')) * 1000);
                                                                var NowTime = new Date();
                                                                var nMS = EndTime.getTime() - NowTime.getTime();
                                                                var nD = Math.floor(nMS / (1000 * 60 * 60 * 24));
                                                                var nH = Math.floor(nMS / (1000 * 60 * 60)) % 24;
                                                                var nM = Math.floor(nMS / (1000 * 60)) % 60;
                                                                var nS = Math.floor(nMS / 1000) % 60;
                                                                if (nD >= 0) {
                                                                    var str = '<span> 删除倒计时:<br>' + nD + '天' + nH + '小时' + nM + '分' + nS + '秒';
                                                                    $(Obj).html(str);
                                                                }
                                                            });
                                                        }, 1000);
                                                    });
                                                </script>
                                            </c:if>
                                            <c:if test="${obj.status == 2}">未验证，未审核</c:if>
                                            <c:if test="${obj.status == 3}">已验证，未审核</c:if>
                                            <c:if test="${obj.status == 4}">审核不通过</c:if>
                                            <c:if test="${obj.status == 6}">被删除</c:if>
                                            <c:if test="${obj.status == 9}">信息修改审核</c:if>
                                        </td>


                                        <td style="vertical-align:middle">
                                            <c:if test="${obj.backgroundStatus == 1 || obj.backgroundStatus == -1}">
                                                <pe:permission key="agree">
                                                    <button class="btn btn-success btn-small"
                                                            onclick="setOneStatus(${obj.id},0)">
                                                        通过
                                                    </button>
                                                </pe:permission>
                                            </c:if>
                                            <c:if test="${obj.backgroundStatus != 1}">
                                                <pe:permission key="refuse">
                                                    <button class="btn btn-danger btn-small"
                                                            onclick="setOneStatus(${obj.id},1)">
                                                        拒绝
                                                    </button>
                                                </pe:permission>
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


<script>


    function setBackgroundStatus(status) {
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
            url: "${BasePath}/audit/setBackgroundStatus?ids=" + ids +"&status="+ status,
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

    function setOneStatus(id,status) {
        $.ajax({
            type: "POST",
            url: "${BasePath}/audit/setBackgroundStatus?ids=" + id +"&status="+ status,
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