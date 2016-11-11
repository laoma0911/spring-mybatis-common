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
							<form id="myForm" class="form-inline" name="myForm" action="${BasePath}/audit/replyList?${PublicParams}"
							      method="post">
								<table>
									<tr valign="middle">
										<td>UID：</td>
										<td><input type="text" name="uid" value="${uid }"/></td>
										<td>回复：</td>
										<td><input type="text" name="title" value="${title }"/></td>
										<td>
<!-- 											<select name="status" id="status"> -->
<!-- 												<option value="-1">未删除</option> -->
<!-- 												<option -->
<%-- 														<c:if test="${status==1 }">selected="selected" </c:if> --%>
<!-- 														value="1">删除 -->
<!-- 												</option> -->
<!-- 												<option -->
<%-- 														<c:if test="${status==2 }">selected="selected" </c:if> --%>
<!-- 														value="2">全部 -->
<!-- 												</option> -->
<!-- 											</select> -->
											
											<select name="status" id="status">
												<option value="-1">全部</option>
												<option  value="0">未删除</option>
												<option  value="1">删除</option>
												<option value="3" selected="selected">待审核</option>
											</select>
											
										</td>
										<td><input type="submit" value="查询" class="btn btn-success btn-small"/></td>
									</tr>
								</table>
<%-- 								<input type="hidden" name="start" id="start" value="${start }"/> --%>
<%-- 								<input type="hidden" name="limit" id="limit" value="${limit }"/> --%>
<!-- 								<input type="hidden" name="sign" value="2" id="sign"/> -->
							</form>
							<form id="hotMyForm" class="form-inline" name="hotMyForm"
							      action="${BasePath}/audit/hotReplyList?${PublicParams}" method="post">
								<input type="hidden" name="start" id="start" value="${start }"/>
								<input type="hidden" name="limit" id="limit" value="${limit }"/>
								<input type="hidden" name="sign" value="2" id="sign"/>
							</form>
						</div>
					</div>
					<div id="fixedBar" class="navbar navbar-inner" style="clear:both;">
						<div class="muted pull-left inline">
							<button class="btn btn-success btn-small" onclick="refrom()">刷新</button>
							<span class="badge badge-info"></span>
							<button class="btn btn-success btn-small" id="btnSelectAll" onclick="selectAll()">全选
							</button>
							<span class="badge badge-info"></span>
							<pe:permission key="pass">
								<button class="btn btn-success btn-small" onclick="passAudit()">通过</button>
								<span class="badge badge-info"></span>
							</pe:permission>
							<pe:permission key="delete">
								<button class="btn btn-success btn-small" onclick="deleteAudit()">删除</button>
								<span class="badge badge-info"></span>
							</pe:permission>
                            <pe:permission key="hiddenReply">
                                <button class="btn btn-success btn-small" onclick="hiddenReply(1)">隐藏
                                </button>
                                <span class="badge badge-info"></span>
                                <button class="btn btn-success btn-small" onclick="hiddenReply(0)">取消隐藏
                                </button>
                            </pe:permission>
						</div>
					</div>
					<div class="block">
						<div class="navbar navbar-inner block-header">
							<div class="muted pull-left inline">热帖回复列表</div>
						</div>
						<div class="block-content collapse in">
							<div class="span12">
								<table class="table">
									<thead>
									<tr>
										<th></th>
										<th>用户</th>
										<th>标题</th>
										<th width="30%">回复</th>
                                        <th width="10%">发布时间</th>
										<pe:permission key="banUser">
											<th>操作</th>
										</pe:permission>
									</tr>
									</thead>
									<tbody id="tbodys">
									<c:forEach items="${topicReplyList}" var="obj">
										<tr>
											<td>
												<input type="checkbox" name="id" id="id"
												       value="${obj.replyId }_${obj.uid}"/>
											</td>
											<td>
													<a href="${BasePath }/custom/userList?type=4&itemId=20&uid=${obj.uid}"  target="_black">${obj.uid }</a>
												<c:if test="${obj.banCount != 0}">
													<font style="color: #ff0000">[违规${obj.banCount}]</font>
												</c:if>
												<c:if test="${obj.isMonitor == 1}">
													<font style="color: #ff0000">(监控)</font>
												</c:if>
												<br>
													${obj.nick}
												<br>
												<a href="${BasePath }/audit/topicList?${PublicParams}&uid=${obj.uid}&status=-1">她的全部话题</a><br>
												<a href="${BasePath }/audit/replyList?${PublicParams}&uid=${obj.uid}&status=-1">她的全部回复</a>
											</td>
											<td>
<%-- 												<a href="javascript:onclick=openModel('${BasePath}/topic/topicDetail?topicId=${obj.topicId}&type=${type}&itemId=${itemId}','话题详情页')">${obj.title}</a> --%>
												<a href="${BasePath}/topic/topicDetail?topicId=${obj.topicId}&type=${type}&itemId=${itemId}" target="_blank"><e:forHtml value="${obj.title}"/></a>
												<c:if test="${obj.settop == 1}">
													<font style="color: #ff0000">[置顶]</font>
												</c:if>
												<c:if test="${obj.settop == 2}">
													<font style="color: #ff0000">[公告]</font>
												</c:if>
												<c:if test="${obj.isdown == 1}">
													<font style="color: #ff0000">[沉]</font>
												</c:if>
												<c:if test="${obj.lock == 1}">
													<font style="color: #ff0000">[锁]</font>
												</c:if>
												<c:if test="${obj.topicStatus == 1}">
													<font style="color: #ff0000">[删]</font>
												</c:if>
											</td>
											<td>
                                                <e:forHtml value="${obj.context}"/>
												<c:if test="${obj.status != 0}">
													<font style="color: #ff0000">[删]</font>
												</c:if>
                                                <c:if test="${obj.hidden != 0}">
													<font style="color: #ff0000">[已隐藏]</font>
												</c:if>
													<%--                                     		----------------这个得删掉回复id:${obj.replyId} --%>
											</td>
<!-- 											<td> -->
<%-- 												<c:forEach items="${obj.picList}" var="pic"> --%>
<%-- 													<a href="${pic.oriPic}" rel="lightbox[ostec]"> --%>
<%-- 														<img src="${pic.pic}" width="130px" height="130px">&nbsp; --%>
<!-- 													</a> -->
<%-- 												</c:forEach> --%>
<!-- 											</td> -->
                                            <td style="vertical-align:middle">
                                                <script >formatTime("${obj.dateline}");</script>
                                            </td>
											<pe:permission key="banUser">
												<td style="vertical-align:middle">
											       <button class="btn btn-danger btn-small" onclick="openModel('${BasePath}/audit/toBanUser?${PublicParams}&uid=${obj.uid}&replyId=${obj.replyId}&nick=${obj.nick}','封禁层主','45%','70%')">封禁层主</button>
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
											$("#hotMyForm").submit();
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

	<!--弹出窗-->
	<div id="myContainer" class="modal hide fade" role="dialog" aria-labelledby="myModalLabel"
	     aria-hidden="true">
		<form id="myDialogForm" name="myDialogForm">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h4 id="myModalLabel">
					封禁用户
				</h4>

				<div class="alert alert-error" id="alertErr" style="display: none;">
					<button class="close" data-dismiss="alert">×</button>
					<strong>Error!</strong> <span id="errodesc">This is an error message.</span>
				</div>
			</div>

			<div class="modal-body">
				<p>
					&nbsp;&nbsp;&nbsp;&nbsp;
					对用户<span id="nickSpan"></span>(<span id="uidSpan"></span>)的处理为:
				</p>

				<div>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<label class="checkbox inline">
						<input type="checkbox" name="isdel" id="isdel">删除该内容
					</label>
					<label class="checkbox inline">
						<input type="checkbox" name="isToMonitor" id="isToMonitor">监控楼主
					</label>

				</div>
				<div>
					<label class="checkbox inline">
						<input type="radio" name="identity" value="3" checked="checked"/>封禁3天
					</label>
					<label class="checkbox inline">
						<input type="radio" name="identity" value="30"/>封禁30天
					</label>
					<label class="checkbox inline">
						<input type="radio" name="identity" value="0" checked="checked"/>永久封禁
					</label>
					<label class="checkbox inline">
						<input type=checkbox checked="checked" name="isWithDevice" id="isWithDevice"/>带设备
					</label>

				</div>
				<div>
					&nbsp;&nbsp;&nbsp;&nbsp;
					快捷回复:
					<select name="menu1"
					        onchange="document.getElementById('out').value = ' ' + this.options[this.selectedIndex].value">
						<option selected>...</option>
						<option value="大姨吗社区严禁广告，此次处以禁言3天惩罚，下次将封禁账号，详情参阅全局置顶贴《新人入组必读》。">广告封禁3天</option>
						<option value="大姨吗社区严禁广告，此次处以禁言30天惩罚，下次将封禁账号，详情参阅全局置顶贴《新人入组必读》。">广告封禁30天</option>
						<option value="大姨吗社区严禁广告，您的账号已被永封禁，详情参阅全局置顶贴《新人入组必读》。">广告永久封禁</option>
						<option value="由于您言辞过当，此次处以禁言3天惩罚，详情参阅全局置顶贴《新人入组必读》。">骂人封禁3天</option>
						<option value="由于您言辞过当，此次处以禁言30天惩罚，详情参阅全局置顶贴《新人入组必读》。">骂人封禁30天</option>
						<option value="由于您言论涉及色情内容，此次处以禁言3天惩罚，详情参阅全局置顶贴《新人入组必读》。">色情封禁3天</option>
						<option value="由于您言论涉及色情内容，此次处以禁言30天惩罚，详情参阅全局置顶贴《新人入组必读》。">色情封禁30天</option>
						<option value="大姨吗社区仅限女性用户使用，您的账号已被永封禁。">男性用户永久封禁</option>
					</select>
				</div>
				<div>
					<textarea rows="4" id="out" style="margin: 0px 0px 10px; width: 514px; height: 80px;"></textarea>
				</div>
				<input type="hidden" name="replyId" id="replyId"/>
				<input type="hidden" name="uidId" id="uidId"/>

			</div>
		</form>
		<div class="modal-footer">
			<button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
			<button onclick="submitBanForm()" class="btn btn-primary">确定</button>
		</div>
	</div>
</div>


<jsp:include page="../include/bottom.jsp"/>


<script>
	function openMyModel(uid, nick, replyId) {
		$("#uidSpan").html(uid);
		$("#nickSpan").html(nick);
		$("#replyId").val(replyId);
		$("#uidId").val(uid);
		$("#myDialogForm")[0].reset();
		$("#alertErr").hide();
		$('#myContainer').modal({backdrop: 'static', keyboard: false});
		$('#myContainer').modal('show');
	}

	//封禁用户
	function submitBanForm() {
		$("#alertErr").hide();
		//封禁累类型 3:3天. 30:30天. 0:永久
		var banType = $("input[type='radio']:checked").val();
		//理由
		var reason = $("#out").val();

		//是否带设备
		var isWithDevice = 1;
		if ($('#isWithDevice').is(':checked')) {
			isWithDevice = 1;
		} else {
			isWithDevice = 0;
		}
		//是否删除
		var isdel = 0;
		if ($('#isdel').is(':checked')) {
			isdel = 1;
		} else {
			isdel = 0;
		}
		//是否监控
		var isToMonitor = 0;
		if ($('#isToMonitor').is(':checked')) {
			isToMonitor = 1;
		} else {
			isToMonitor = 0;
		}
		var uid = $("#uidId").val();
		var replyId = $("#replyId").val();
		if (reason.length == 0) {
			alert("请选择或填写理由!");
			return false;
		} else {
			reason = encodeURI(encodeURI(reason));
		}
		var path = "${BasePath}/audit/banUser?uid=" + uid + "&replyId=" + replyId + "&isdel=" + isdel + "&isToMonitor=" + isToMonitor + "&isWithDevice=" + isWithDevice + "&banType=" + banType + "&reasons=" + reason + "&type=${type}&itemId=${itemId}";
		$.ajax({
			type: "POST",
			url: path,
			datatype: "json",
			success: function (data) {
				if (data.errno == 1) {
					$("#alertErr").show();
					$("#errodesc").html(data.errdesc);
				} else {
					$('#myContainer').modal('hide');
					window.location.reload(true);
				}
			},
			error: function () {
				alert("操作出错，请联系管理员！");
			}
		});

	}

	//    tr选中checkbox效果
	//    $('#tbodys tr').click(function () {
	//        var chks = $(':checkbox', this);
	//        chks.prop('checked', !chks[0].checked);
	//    })

	function refrom() {
		$("#hotMyForm").submit();
	}

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
			url: "${BasePath}/audit/passHotReply?replyIds=" + ids,
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

    // 隐藏回复
    function hiddenReply(status) {
        var ids = new Array();
        $("input[name='id']:checked").each(function () {
            var txt = $(this).val();
            ids.push(txt);
        });
        if (ids.length == 0) {
            alert("您还未选择要操作的数据？");
            return false;
        }
        var path = "${BasePath}/audit/hiddenHotReply?replyIds=" + ids + "&status=" + status;
        qqAjax(path);
    }



	//删除
	function deleteAudit() {
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
			url: "${BasePath}/audit/delHotReply?replyIds=" + ids,
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

	function getStr200(val) {
		var str = val;
		if (val != null && val.length > 200) {
			str = val.substring(0, 200);
		}
		document.write(str);
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
	//    tr选中checkbox效果
	$('#tbodys tr').click(function () {
		var chks = $(':checkbox', this);
		chks.prop('checked', !chks[0].checked);
	});
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

    function qqAjax(path) {
        $.ajax({
            type: "POST",
            url: path,
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