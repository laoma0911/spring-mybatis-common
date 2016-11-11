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
							<form id="myForm" name="myForm"
								action="${BasePath}/broadcast/list" method="post"
								class="form-inline">
								<table>
									<tr>
										<td style="vertical-align: middle;">主题：</td>
										<td><input type="text" id="title" name="title"
											value="${title}" /></td>
										<%--<td style="vertical-align: middle;">商家名称：</td>--%>
										<%--<td><input type="name" name="name" value="${name}"/></td>--%>
										<td>&nbsp;<input type="submit"
											class="btn btn-success btn-small" value="查询" /></td>
									</tr>
								</table>

								<input type="hidden" name="start" id="start" value="${start }" />
								<input type="hidden" name="limit" id="limit" value="${limit }" />
								<input type="hidden" name="type" id="type" value="${type }" /> <input
									type="hidden" name="itemId" id="itemId" value="${itemId }" />
							</form>
						</div>
					</div>
				</div>

				<div class="block">
					<div class="navbar navbar-inner block-header">
						<div class="muted pull-left">直播间管理列表</div>
						<div class="pull-right">
							<pe:permission key="add">
								<button class="btn btn-success btn-small"
									onclick="openModel('${BasePath}/broadcast/toAdd','新增')">新增</button>
							</pe:permission>
						</div>
					</div>
					<div class="block-content collapse in">
						<div class="span12">
							<table class="table table-hover">
								<thead>
									<tr>
										<th>ID</th>
										<th>主题</th>
										<th>活动图片</th>
										<th>在线时间</th>
										<th>自定义链接</th>
										<th>状态</th>
										<th>数据统计</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody id="tbodys">
									<c:forEach items="${list}" var="obj">
										<tr>
											<td class="id">${obj.id}</td>
											<td><a
												href="${LiveHost}/admin/liveroom/list?broadcastId=${obj.id}"
												target="_blank">${obj.broadcastName}</a></td>
											<td><img src="${imageHost }${obj.pic}" width="80px"
												height="80px" /></td>
											<td><span style="color: #008800">在线时间:</span> <script>formatTime("${obj.onlineBeginTime}");</script>
												至 <script>formatTime("${obj.onlineEndTime}");</script> <br>
											<span style="color: #008800">直播时间:</span> <script>formatTime("${obj.beginTime}");</script>
												至 <script>formatTime("${obj.endTime}");</script> <br></td>
											<td><textarea>${obj.clickUrl}</textarea></td>
											<td>
												<%--<c:if test="${currentTime<obj.onlineBeginTime}">--%> <%--<span style="color: red">未上线</span>--%>
												<%--</c:if>--%> <%--<c:if test="${obj.onlineBeginTime<=currentTime && currentTime<obj.onlineEndTime}">--%>
												<%--<span style="color: green">在线上</span>--%> <%--</c:if>--%>
												<%--<c:if test="${obj.onlineEndTime<currentTime}">--%> <%--<span style="color: #808080">已下线</span>--%>
												<%--</c:if>--%> <%--//0新建1可预约2直播中3完毕4废弃--%> <c:if
													test="${obj.stage==0}">
													<span style="color: greenyellow">新建</span>
												</c:if> <c:if test="${obj.stage==1}">
													<span style="color: goldenrod">可预约</span>
												</c:if> <c:if test="${obj.stage==2}">
													<span style="color: green">直播中</span>
												</c:if> <c:if test="${obj.stage==3}">
													<span style="color: red">完毕</span>
												</c:if> <c:if test="${obj.stage==4}">
													<span style="color: red">废弃</span>
												</c:if>

											</td>
											<td><span style="color: green">总人数：${obj.totalUser}</span><br>
												<span style="color: #ff0000">发言人数：${obj.sayUser}</span><br>
												<span style="color: gold">按钮点击数：</span></td>
											<td><pe:permission key="update">
													<c:if test="${obj.stage==2}">
													</c:if>
													<c:choose>
														<c:when test="${obj.stage<2}">
															<button class="btn btn-success btn-small"
																onclick="opeateBroadcast(${obj.id},1)">开启</button>
														</c:when>
														<c:when test="${obj.stage==2}">
															<button class="btn btn-warning btn-small"
																onclick="opeateBroadcast(${obj.id},2)">关闭</button>
														</c:when>
														<c:otherwise>

														</c:otherwise>
													</c:choose>

													<button class="btn btn-success btn-small"
														onclick="openModel('${BasePath}/broadcast/toModify?id=${obj.id}','修改')">修改</button>
												</pe:permission>
                                                <pe:permission key="lookDate">
                                                    <button class="btn btn-success btn-small" onclick="openModel('${BasePath}/broadcast/showData?id=${obj.id}','查看数据')">查看数据</button>
                                                </pe:permission>
												<pe:permission key="delete">
													<button class="btn del btn-danger btn-small">删除</button>
												</pe:permission>
												<pe:permission key="broadcastShareWapLog">
													<button class="btn btn-success btn-small" onclick="openModel('${BasePath}/broadcast/getStats?url=${obj.shareUrl}','wap分享统计')">wap分享统计</button>
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
    function opeateBroadcast(id,type){
        if (!confirm('确定操作该直播间吗？')) {
            return false;
        }
        $.post('${BasePath}/broadcast/opeateBroadcast', {'id': id,'type':type}, function (data) {
            var obj = eval(data);
            if (obj.errno == 0) {
                alert('操作成功');
                window.location.reload();
            } else {
                alert(obj.errdesc);
            }
        });
    }
    // 删除记录
    $(function () {
        $(".del").bind('click', function () {
            if (!confirm('确定删除该条记录吗？')) {
                return false;
            }
            var id = $(this).parent().parent().find(".id").text();
            var tr = $(this).parent().parent();
            $.post('${BasePath}/broadcast/delete', {
                'id': id
            }, function (data) {
                var obj = eval(data);
                if (obj.errno == 0) {
                    alert('操作成功');
                    tr.remove();
                } else {
                    alert(obj.errdesc);
                }
            });
        });
    });
</script>