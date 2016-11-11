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
							<form class="form-inline" id="myForm" name="myForm"
								action="${BasePath}/groupCategory/categoryList" method="post">
								小组分类: <select name="catType" id="catType">
									<option value="0">全部分类</option>
									<c:forEach items="${tgcList}" var="obj">
										<option
											<c:if test="${catType == obj.id}">selected="selected" </c:if>
											value="${obj.id}">${obj.title}</option>
									</c:forEach>
								</select> 小组类型: <select name="teamType" id="teamType">
									<c:forEach items="${staticCategoryList}" var="obj">
										<option
											<c:if test="${teamType == obj.id }">selected="selected" </c:if>
											value="${obj.id}">${obj.title}</option>
									</c:forEach>
								</select> 组长UID: <input type="text" id="uid" name="uid" value="${uid }">
								小组名称：<input type="text" id="title" name="title"
									value="${title }"> 排序: <select name="sort" id="sort">
									<option value="0">小组人数</option>
									<option <c:if test="${sort==1 }">selected="selected" </c:if>
										value="1">创建时间</option>
									<option <c:if test="${sort==2 }">selected="selected" </c:if>
										value="2">总话题数</option>
									<option <c:if test="${sort==3 }">selected="selected" </c:if>
										value="3">总回复数</option>
									<%--<option--%>
									<%--<c:if test="${sort==4 }">selected="selected" </c:if>--%>
									<%--value="4">最新发贴时间--%>
									<%--</option>--%>
								</select>
								<button type="button" onclick="submitForm()"
									class="btn btn-success btn-small">查询</button>
								<input type="hidden" name="start" id="start" value="${start }" />
								<input type="hidden" name="limit" id="limit" value="${limit }" />
								<input type="hidden" name="type" id="type" value="${type }" />
								<input type="hidden" name="itemId" id="itemId"
									value="${itemId }" />
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
                        <button class="btn btn-success btn-small" onclick="moveCategory()">
                            移动
                        </button>
                        <span class="badge badge-info"></span>
                        <button class="btn btn-danger btn-small" onclick="closeCategory()">
                            关闭
                        </button>
                        <span class="badge badge-info"></span>
                        <button class="btn btn-danger btn-small" onclick="deletcCategory()">
                            删除
                        </button>
                        
                          <span class="badge badge-info"></span>
                        <button class="btn btn-success btn-small" onclick="openGroupChat()">
                            开启群聊
                        </button>
                         <span class="badge badge-info"></span>
                        <button class="btn btn-success btn-small" onclick="closeGroupChat()">
                            关闭群聊
                        </button>
                        
                        </pe:permission>
                    </div>
                </div>
				<!--kaishi -->
				<div class="block">
					<div class="navbar navbar-inner block-header">
						<div class="muted pull-left">小组分类</div>
						<div class="pull-right">
							<pe:permission key="operate">
								<button class="btn btn-success btn-small"
									style="margin-top: -5px"
									onclick="openModel('/groupCategory/categoryToAdd','新增')">新增
								</button>
							</pe:permission>
							<span class="badge badge-info">${userCount}</span>
						</div>
					</div>
					<div class="block-content collapse in">
						<div class="span12">
							<table class="table table-hover">
								<thead>
									<%--ID、分类、小组名称、头像、小组类型、位置、小组组长、创建时间、小组人数、总话题数、总回复数、最新发帖时间、简介、链接】操作--%>
									<tr>
                                        <th></th>
										<th nowrap="true">ID</th>
										<th nowrap="true">分类</th>
										<th nowrap="true">小组名称</th>
										<th nowrap="true">头像</th>
										<th nowrap="true">背景图</th>
										<th nowrap="true">小组类型|排序值</th>
										<th nowrap="true">小组组长</th>
										<th nowrap="true">创建时间</th>
										<th nowrap="true">小组人数</th>
										<th nowrap="true">总话题数</th>
										<%--<th nowrap="true">总回复数</th>--%>
										<%--<th width="8%">最新发帖时间</th>--%>
										<th nowrap="true">简介</th>
										<th nowrap="true">链接</th>
										<pe:permission key="operate">
											<th nowrap="true">操作</th>
										</pe:permission>
									</tr>
								</thead>
								<tbody id="tbodys">
									<c:forEach items="${json}" var="obj">
										<tr>
                                            <td>
                                                <input type="checkbox" name="id" id="id" value="${obj.id}"/>
                                            </td>
											<td nowrap="true" class="id">${obj.id}</td>

											<td nowrap="true">${obj.catTitle}</td>

											<td style="width: 100px;">
                                                <a href="/topic/allList?type=8&itemId=54&categorytitle=${obj.title}" target="_black">${obj.title}</a>
                                            </td>

											<td nowrap="true">
                                                <img alt="" src="${obj.pic}" height="20PX" width="60PX" />
                                            </td>

                                            <td nowrap="true">
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

                                            <td nowrap="true"><c:if
                                                    test="${obj.teamType == 0 and obj.type ==0}">官方公开</c:if> <c:if
                                                    test="${obj.teamType == 0 and obj.type ==1}">官方私密</c:if> <c:if
                                                    test="${obj.teamType == 1 and obj.type ==0}">用户公开</c:if> <c:if
                                                    test="${obj.teamType == 1 and obj.type ==1}">用户私密</c:if> <c:if
                                                    test="${obj.type ==2}">虚小组</c:if>
                                                </br>
                                                    ${obj.catDisplayorder}-${obj.displayorder}
                                            </td>

                                            <td nowrap="true"><font color="#08c">${obj.nick}</font><br>[<a
												href="${BasePath }/custom/userList?type=4&itemId=20&uid=${obj.uid}"
												target="_black">${obj.uid }</a>]</td>

											<td nowrap="true"><script>
												formatTime("${obj.dateline}");
											</script></td>

											<td nowrap="true">${obj.membernum}</td>

											<td nowrap="true">${obj.num}</td>

											<td style="width: 200px" class="tdBreak">${obj.descs}</td>

											<td style="width: 120px;" class="tdBreak"><c:if
													test="${empty obj.link}">无</c:if> <c:if
													test="${obj.link != null}">${obj.link}</c:if>

                                            </td>
											<pe:permission key="operate">
												<td nowrap="true" style="vertical-align:middle">
                                                    <a class="btn btn-success btn-small"
													href="javascript:openModel('${BasePath}/groupCategory/toModifyCategory?id=${obj.id}','编辑')">编辑小组</a>
                                                    <br>

                                                    <c:if test="${obj.isChat == 0}">
                                                        <a class="btn btn-success btn-small"
                                                           href="javascript:openModel('${BasePath}/groupchatconfig/toGroupChatConfig?groupId=${obj.id}','开启群聊','40%','40%')">开启群聊</a>
                                                        <br>
                                                    </c:if>

                                                    <c:if test="${obj.isChat == 1}">
<%--                                                         <a class="btn btn-success btn-small" href="javascript:openModel('${BasePath}/groupchatconfig/toGroupChatConfig?groupId=${obj.id}','群聊设置','40%','40%')">群聊设置</a> --%>
<!--                                                <br> -->

                                                        <button class="btn del btn btn-danger btn-small" type="button" onclick="closeGroupChat(${obj.id})">关闭群聊</button>
                                                        <br>
                                                    </c:if>

                                                    <button class="btn del btn btn-danger btn-small" type="button" onclick="closeOneGroup(${obj.id})">关闭</button>
                                                </td>
											</pe:permission>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							<div class="pagination pagination-centered" id="pager"></div>
							<script type="text/javascript">
								var sign = 0;
								window.onload = function() {
									PAGER.initPager('${start}', ' ${total}',
											'${limit}', 8, 'pager', getData);
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


    function closeGroupChat(groupId) {
        var id = $(this).parent().parent().find(".id").text();
        if (!confirm('您确定要关闭小组聊天功能吗?')) {
            return false;
        }
        $.ajax({
            type: "POST",
            url: "${BasePath }/groupchatconfig/closeGroupChat?groupId=" + groupId,
            datatype: "json",
            success: function (data) {
                if (data.errno == 1) {
                    alert(data.errdesc);
                }else {
                    alert('操作成功');
                    window.location.reload(true);
                }
            },
            error: function () {
                alert("操作出错，请联系管理员！");
            }
        });
    }

    //关闭
    function closeCategory() {
        var ids = new Array();
        $("input[name='id']:checked").each(function () {
            var txt = $(this).val();
            ids.push(txt);
        });
        if (ids.length == 0) {
            alert("请选择需要操作的数据！");
            return false;
        }else if (!confirm('您确定要关闭小组吗？')) {
            return false;
        }
        $.ajax({
            type: "POST",
            url: "${BasePath}/groupCategory/closeCategory?ids=" + ids,
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


    //移动
    function moveCategory() {
        var ids = new Array();
        $("input[name='id']:checked").each(function () {
            var txt = $(this).val();
            ids.push(txt);
        });
        if (ids.length == 0) {
            alert("请选择需要操作的数据！");
            return false;
        }
        openModel('${BasePath}/groupCategory/toMoveList?ids='+ids,'移动','35%','35%');
    }


    //删除
    function deletcCategory() {
        var ids = new Array();
        $("input[name='id']:checked").each(function () {
            var txt = $(this).val();
            ids.push(txt);
        });
        if (ids.length == 0) {
            alert("请选择需要操作的数据！");
            return false;
        }else if (!confirm('您确定要删除小组吗?一旦删除,小组数据将会移动到小组回收站中')) {
            return false;
        }
        $.ajax({
            type: "POST",
            url: "${BasePath}/groupCategory/deleteCategory?ids=" + ids,
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

    function closeOneGroup(groupId) {
        var id = $(this).parent().parent().find(".id").text();
        if (!confirm('您确定要关闭小组吗?')) {
            return false;
        }
        $.ajax({
            type: "POST",
            url: "${BasePath }/groupCategory/closeCategory?ids=" + groupId,
            datatype: "json",
            success: function (data) {
                if (data.errno == 1) {
                    alert(data.errdesc);
                }else {
                    alert('操作成功');
                    window.location.reload(true);
                }
            },
            error: function () {
                alert("操作出错，请联系管理员！");
            }
        });
    }
    
    //批量开启群聊
    function openGroupChat(){
    	 var ids = new Array();
         $("input[name='id']:checked").each(function () {
             var txt = $(this).val();
             ids.push(txt);
         });
         if (ids.length == 0) {
             alert("请选择需要操作的数据！");
             return false;
         }
         openModel('${BasePath}/groupchatconfig/batchToGroupChatConfig?groupIds=' + ids,'群聊设置','40%','40%');
    }
    
    //批量关闭群聊
    function closeGroupChat(){
    	var ids = new Array();
        $("input[name='id']:checked").each(function () {
            var txt = $(this).val();
            ids.push(txt);
        });
        if (ids.length == 0) {
            alert("请选择需要操作的数据！");
            return false;
        }
        
        if (!confirm('您确定要关闭小组聊天功能吗?')) {
            return false;
        }
        $.ajax({
            type: "POST",
            url: "${BasePath }/groupchatconfig/batchCloseGroupChat?groupIds=" + ids,
            datatype: "json",
            success: function (data) {
                if (data.errno == 1) {
                    alert(data.errdesc);
                }else {
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