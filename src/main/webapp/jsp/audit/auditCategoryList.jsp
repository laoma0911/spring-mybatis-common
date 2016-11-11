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
                            <form class="form-inline" id="myForm" name="myForm"
                                  action="${BasePath}/audit/categoryList?${PublicParams}"
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
                                组长UID: <input type="text" id="uid" name="uid" value="${uid }">
                                状态:
                                <select name="status" id="status">
                                    <option
                                            <c:if test="${status==3 }">selected="selected" </c:if>
                                            value="3">已验证，未审核
                                    </option>
                                    <option <c:if test="${status==2 }">selected="selected" </c:if>
                                            value="2">未验证，未审核
                                    </option>
                                    <option
                                            <c:if test="${status==9 }">selected="selected" </c:if>
                                            value="9">信息修改审核
                                    </option>
                                    <option
                                            <c:if test="${status==4 }">selected="selected" </c:if>
                                            value="4">审核不通过
                                    </option>
                                    <option
                                            <c:if test="${status==0 }">selected="selected" </c:if>
                                            value="0">正常
                                    </option>
                                    <option
                                            <c:if test="${status==1 }">selected="selected" </c:if>
                                            value="1">被关闭
                                    </option>
                                    <option
                                            <c:if test="${status==6 }">selected="selected" </c:if>
                                            value="6">被删除
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

                <c:if test="${status==1 }">
                    <div id="fixedBar" class="navbar navbar-inner" style="clear:both;">
                        <div class="muted pull-left inline">
                            <button class="btn btn-success btn-small" onclick="window.location.reload(true); ">刷新
                            </button>
                            <span class="badge badge-info"></span>
                            <button class="btn btn-success btn-small" id="btnSelectAll" onclick="selectAll()">全选
                            </button>
                            <span class="badge badge-info"></span>
                            <pe:permission key="deletcCategory">
                            <button class="btn btn-danger btn-small" onclick="deletcCategory()">
                                删除小组
                            </button>
                            </pe:permission>
                            <span class="badge badge-info"></span>
                            <pe:permission key="openCategory">
                            <button class="btn btn-danger btn-small" onclick="openCategory()">
                                打开小组
                            </button>
                            </pe:permission>
                        </div>
                    </div>
                </c:if>

                <!--kaishi -->
                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <div class="muted pull-left">小组审核</div>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table class="table table-hover">
                                <thead>
                                <%--小组ID、小组分类、小组信息、小组头像、组长、组长等级、已创建小组、通过验证时间、相关小组、小组状态、操作--%>
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
                                    <th>通过验证时间</th>
                                    <th width="12%">相关小组</th>
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
                                                <img alt="" src="${obj.background}" height="20PX" width="60PX" />
                                                <br>
                                                <a href="/audit/backgroundList?groupId=${obj.id}&type=8&itemId=109" style="color: red">未审核</a>
                                            </c:if>
                                            <c:if test="${obj.backgroundStatus == 0}">
                                                <img alt="" src="${obj.background}" height="20PX" width="60PX" />
                                            </c:if>
                                            <c:if test="${obj.backgroundStatus == 1}">
                                                <font color="red">已删除</font>
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
                                            <c:if test="${obj.verfityTime != 0}">
                                                <script>formatTime("${obj.verfityTime}");</script>
                                            </c:if>
                                        </td>

                                        <td>
                                            <c:forEach var="obj2" items="${obj.categories}">
                                                ${obj2.title}(${obj2.membernum})<br>
                                            </c:forEach>
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
                                            <%--<c:if test="${obj.status == 5}">转让中</c:if>--%>
                                            <c:if test="${obj.status == 6}">被删除</c:if>
                                            <c:if test="${obj.status == 9}">信息修改审核</c:if>
                                        </td>


                                        <pe:permission key="operate">
                                            <td style="vertical-align:middle">
                                                <c:if test="${obj.status == 3}">
                                                    <input class="btn del btn btn-primary btn-small"
                                                           type="button"
                                                           value="通过"
                                                           onclick="setCategory(${obj.id},'0','')"
                                                           style="margin-left: auto; margin-right: auto;margin-top: 5px; margin-bottom: 10px;"/>
                                                    <br>
                                                    <a class="btn del btn btn-danger btn-small"
                                                       style="margin-left: auto; margin-right: auto;margin-top: 5px; margin-bottom: 10px;"
                                                       href="javascript:openModel('${BasePath}/audit/toRefuseUser?uid=${obj.uid}&mark=&id=${obj.id}','拒绝','40%','40%')">拒绝</a>
                                                    <br>
                                                </c:if>

                                                <c:if test="${obj.status == 0}">
                                                    <input class="btn del btn btn-danger btn-small"
                                                           type="button"
                                                           value="关闭"
                                                           onclick="setCategory(${obj.id},'1','')"
                                                           style="margin-left: auto; margin-right: auto;margin-top: 5px; margin-bottom: 10px;"/>
                                                    <br>
                                                </c:if>

                                                <c:if test="${obj.status == 4}">
                                                    <input class="btn del btn btn-danger btn-small"
                                                           type="button"
                                                           value="通过"
                                                           onclick="setCategory(${obj.id},'0','')"
                                                           style="margin-left: auto; margin-right: auto;margin-top: 5px; margin-bottom: 10px;"/>
                                                    <br>
                                                </c:if>

                                                <c:if test="${obj.status == 1}">
                                                    <input class="btn del btn btn-danger btn-small"
                                                           type="button"
                                                           value="打开组"
                                                           onclick="setCategory(${obj.id},'0','')"
                                                           style="margin-left: auto; margin-right: auto;margin-top: 5px; margin-bottom: 10px;"/>
                                                    <br>
                                                    <c:if test="${obj.countDown + 60 * 60 * 24 * 3 < now || obj.countDown == null}">
                                                        <input class="btn del btn btn-danger btn-small"
                                                               type="button"
                                                               value="删除组"
                                                               onclick="setCategory(${obj.id},'6','')"
                                                               style="margin-left: auto; margin-right: auto;margin-top: 5px; margin-bottom: 10px;"/>
                                                        <br>
                                                    </c:if>
                                                </c:if>

                                                <c:if test="${obj.status == 9}">
                                                    <input class="btn del btn btn-danger btn-small"
                                                           type="button"
                                                           value="通过修改"
                                                           onclick="setCategory(${obj.id},'0','mark')"
                                                           style="margin-left: auto; margin-right: auto;margin-top: 5px; margin-bottom: 10px;"/>
                                                    <br>
                                                    <a class="btn del btn btn-danger btn-small"
                                                       style="margin-left: auto; margin-right: auto;margin-top: 5px; margin-bottom: 10px;"
                                                       href="javascript:openModel('${BasePath}/audit/toRefuseUser?uid=${obj.uid}&mark=mark&id=${obj.id}','拒绝修改','40%','40%')">拒绝修改</a>
                                                    <br>
                                                </c:if>
                                                <a class="btn btn-info btn-small"
                                                   style="margin-left: auto; margin-right: auto;margin-top: 5px; margin-bottom: 10px;"
                                                   href="javascript:openModel('${BasePath}/audit/toCategoryLog?id=${obj.id}','历史')">历史</a>
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

    /**
     * 设置小组状态
     * @param id
     */
    function setCategory(id, status, mark) {
        $.post('${BasePath}/audit/setCategory', {
            'ids': id, 'status': status, 'mark': mark
        }, function (data) {
            var obj = eval(data);
            if (obj.errno == 0) {
                window.location.reload();
            } else {
                alert(obj.errdesc);
            }
        });
    }


    //批量删除小组
    function deletcCategory() {
        var ids = new Array();
        $("input[name='id']:checked").each(function () {
            var txt = $(this).val();
            ids.push(txt);
        });
        if (ids.length == 0) {
            alert("请选择需要操作的数据！");
            return false;
        }else if (!confirm('您确定要删除这些小组吗?一旦删除,小组数据将会移动到小组回收站中')) {
            return false;
        }
        $.ajax({
            type: "POST",
            url: "${BasePath}/audit/setCategory?ids=" + ids + "&status=6&mark=",
            datatype: "json",
            success: function (data) {
                if (data.errno == 1) {
                    alert(data.errdesc);
                } else {
                    alert('操作成功');
                    window.location.reload(true);
                }
            },
            error: function () {
                alert("操作出错，请联系管理员！");
            }
        });
    }

     //批量打开小组
    function openCategory() {
        var ids = new Array();
        $("input[name='id']:checked").each(function () {
            var txt = $(this).val();
            ids.push(txt);
        });
        if (ids.length == 0) {
            alert("请选择需要操作的数据！");
            return false;
        }else if (!confirm('您确定要打开这些小组吗?')) {
            return false;
        }
        $.ajax({
            type: "POST",
            url: "${BasePath}/audit/setCategory?ids=" + ids + "&status=0&mark=",
            datatype: "json",
            success: function (data) {
                if (data.errno == 1) {
                    alert(data.errdesc);
                } else {
                    alert('操作成功');
                    window.location.reload(true);
                }
            },
            error: function () {
                alert("操作出错，请联系管理员！");
            }
        });
    }


</script>