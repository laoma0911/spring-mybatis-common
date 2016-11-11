<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<%@ taglib uri="/permission" prefix="pe"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<jsp:include page="../include/top.jsp" />
<!-- Body -->
<div class="container-fluid">
    <div class="row-fluid">
        <!-- Menu -->
        <jsp:include page="../include/menu.jsp" />
        <div class="span9" id="content">
            <jsp:include page="../include/location.jsp" />
            <div class="row-fluid">

                <div class="span12">
                    <div class="block">
                        <div class="navbar navbar-inner block-header"
                             style="border-bottom: none;">
                            <form class="form-inline" id="myForm" name="myForm" action="${BasePath}/topgroups/list" method="post">
                                时间:
                                <input type="text"  style="width: auto;" id="duration"  name="duration" value="${duration}" onfocus="WdatePicker({dateFmt:'yyyy-MM',readOnly:'false'})" class="Wdate" onClick="WdatePicker()" />
                                排序:
                                <select name="orderBy" id="orderBy">
                                    <option <c:if test="${orderBy == 'credit'}">selected="selected"</c:if> value="credit">分数值</option>
                                    <option <c:if test="${orderBy == 'topicNum'}">selected="selected"</c:if> value="topicNum">发帖数量</option>
                                    <option <c:if test="${orderBy == 'replyNum'}">selected="selected"</c:if> value="replyNum">回复数量</option>
                                    <option <c:if test="${orderBy == 'memNum'}">selected="selected"</c:if> value="memNum">组员数量</option>
                                </select>
                                小组名称:<input type="text" id="groupName" name="groupName" value="${groupName}">
                                <button type="button" onclick="submitForm()" class="btn btn-success btn-small">查询</button>
                                <input type="hidden" name="start" id="start" value="${start }" />
                                <input type="hidden" name="limit" id="limit" value="${limit }" />
                                <input type="hidden" name="type" id="type" value="${type }" />
                                <input type="hidden" name="itemId" id="itemId" value="${itemId }" />
                            </form>

                        </div>
                    </div>
                </div>

                <div id="fixedBar" class="navbar navbar-inner" style="clear:both;">
                    <div class="muted pull-left inline">
                        <button class="btn btn-success btn-small" onclick="window.location.reload(true); ">刷新</button>
                        <span class="badge badge-info"></span>
                        <button class="btn btn-success btn-small" id="btnSelectAll" onclick="selectAll()">全选</button>
                        <span class="badge badge-info"></span>
                        <pe:permission key="addPoints">
                            <button class="btn btn-success btn-small" onclick="addPointForLeader()">给优秀组长加5金币</button>
                        </pe:permission>
                        <span class="badge badge-info"></span>
                        <pe:permission key="online">
                            <button class="btn btn-success btn-small" onclick="setOnline()">本月优秀组长榜单可以线上展示</button>
                        </pe:permission>
                        <span class="badge badge-info"></span>
                    </div>
                </div>
                <!--kaishi -->
                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <div class="muted pull-left">优秀组长列表</div>
                        <div class="pull-right">
                            <span class="badge badge-info">${userCount}</span>
                        </div>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table class="table table-hover">
                                <thead>
                                <%--排名、小组信息、小组头像、小组简介、小组月话题量/回复量、小组人数、组长信息、组长头像、组长月话题量、组长最后登陆时间、小组分数值、调整值、操作--%>
                                <tr>
                                    <th></th>
                                    <th nowrap="true">排名</th>
                                    <th nowrap="true">小组信息</th>
                                    <th nowrap="true">小组头像</th>
                                    <th nowrap="true">小组简介</th>
                                    <th nowrap="true">小组月话题量/回复量</th>
                                    <th nowrap="true">小组人数</th>
                                    <th nowrap="true">组长信息</th>
                                    <th nowrap="true">组长头像</th>
                                    <th nowrap="true">组长月话题量</th>
                                    <th nowrap="true">组长最后登陆时间</th>
                                    <th nowrap="true">小组分数值</th>
                                    <th nowrap="true">调整值</th>
                                    <pe:permission key="adjust">
                                        <th nowrap="true">操作</th>
                                    </pe:permission>
                                </tr>
                                </thead>
                                <tbody id="tbodys">
                                <c:forEach items="${data}" var="obj" varStatus="index">
                                    <tr>
                                        <td class="id">
                                            <input type="checkbox" name="id" id="id" value="${obj.id}"/>
                                        </td>
                                        <td nowrap="true">${obj.rank}</td>

                                        <td nowrap="true">
                                            ${obj.id}<br>
                                            <a href="${BasePath }/topic/allList?type=8&itemId=54&categorytitle=${obj.groupName}" target="_black">${obj.groupName}</a>
                                        </td>

                                        <td nowrap="true">
                                            <img alt="" src="${obj.groupAvatar}" height="20PX" width="60PX" />
                                        </td>

                                        <td style="width: 260px" class="tdBreak">
                                                ${obj.groupDesc}
                                        </td>

                                        <td style="width: 100px;">
                                                ${obj.topicNum}/${obj.replyNum}
                                        </td>

                                        <td nowrap="true">
                                                ${obj.memNum}
                                        </td>

                                        <td nowrap="true">
                                            <a href="${BasePath }/custom/userList?type=4&itemId=20&uid=${obj.leaderUid}"
                                               target="_black">${obj.leaderUid}</a>
                                            <br>
                                                ${obj.leaderNick}
                                        </td>

                                        <td nowrap="true">
                                            <img alt="" src="${obj.leaderAvatar}" height="20PX" width="60PX" />
                                        </td>

                                        <td nowrap="true">
                                                ${obj.topicNumThisMonth}
                                        </td>

                                        <td nowrap="true">
                                            <script>
                                                formatTime("${obj.leaderLastLogin}");
                                            </script>
                                        </td>

                                        <td nowrap="true">
                                                ${obj.credit}
                                        </td>

                                        <td nowrap="true">
                                                ${obj.adjustment}
                                        </td>

                                        <pe:permission key="adjust">
                                            <td nowrap="true" style="vertical-align:middle">
                                                <input type="hidden" class="creditId" value="${obj.id}"/>
                                                <input class="input-xlarge focused mod_points" name="adjustment" id="adjustment" type="text" value="" style="WIDTH: 50PX;"/>
                                                <button type="button" id="btn" name="btn" class="btn btn-primary btn-small mod_points_button" style="MARGIN-TOP: -10PX;">调整</button>
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

<jsp:include page="../include/bottom.jsp" />


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
        // $("#sign").val("2");
        $("#myForm").submit();
    }


    $(function(){
        //调整积分
        $('.mod_points_button').click(function(){
            var mod_points = $(this).parents('td').children('.mod_points').val();
            if (mod_points == null || mod_points == ''){
                alert("请填写分数!")
                return false;
            }
            if (!/^(\+|-)?\d+($|\.\d+$)/.test(mod_points)){
                alert("只能填写数字!负数前面加-");
                return false;
            }
            var id = $(this).parents('td').children('.creditId').val();
            $.ajax({
                type:"post",
                url:"${BasePath}/topgroups/adjust?id="+id+"&adjustment="+mod_points,
                datatype: "json",
                success: function (data) {
                    if (data.errno == 1) {
                        alert(data.errdesc);
                    } else {
                        alert("操作成功!");
                        window.location.reload(true);
                    }
                },
                error: function () {
                    alert("操作出错，请联系管理员！");
                }
            })
        })
    })



    function setOnline(){
        var duration = $("#duration").val();
        $.ajax({
            type:"post",
            url:"${BasePath}/topgroups/online?duration="+duration,
            datatype: "json",
            success: function (data) {
                if (data.errno == 1) {
                    alert(data.errdesc);
                } else {
                    alert("操作成功!");
                    window.location.reload(true);
                }
            },
            error: function () {
                alert("操作出错，请联系管理员！");
            }
        })
    }


    function addPointForLeader(){
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
            type:"post",
            url:"${BasePath}/topgroups/addPoints?ids="+ids,
            datatype: "json",
            success: function (data) {
                if (data.errno == 1) {
                    alert(data.errdesc);
                } else {
                    alert("操作成功!");
                    window.location.reload(true);
                }
            },
            error: function () {
                alert("操作出错，请联系管理员！");
            }
        })
    }
</script>