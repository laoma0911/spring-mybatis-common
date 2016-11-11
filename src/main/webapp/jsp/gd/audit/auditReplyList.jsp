<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="/permission" prefix="pe" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="e" uri="https://www.owasp.org/index.php/OWASP_Java_Encoder_Project" %>
<jsp:include page="${BasePath}/jsp/include/top.jsp"/>
<link href="${BasePath}/js/mediabox/css.css" rel="stylesheet" media="screen">
<!-- Body -->
<div class="container-fluid" onmousemove="initTrColor()">
	<div class="row-fluid">
		<!-- Menu -->
		<jsp:include page="${BasePath}/jsp/include/menu.jsp"/>
		<div class="span9" id="content">
			<jsp:include page="${BasePath}/jsp/include/location.jsp"/>
			<div class="row-fluid">
				<div class="span12">
					<div class="block">
						<div class="navbar navbar-inner block-header" style="border-bottom: none;">
							<form class="form-inline" id="myForm" name="myForm"
							      action="${BasePath}/meiyue/audit/replyList?${PublicParams}" method="post">
								UID: <input type="text" id="uid" name="uid" placeholder="uid" value="${uid }"/>
								<%--回复：<input type="text" id="title" name="title" placeholder="回复" value="${title}"/>--%>
								<select name="status" id="status">
									<option
											<c:if test="${status==-1 }">selected="selected" </c:if> value="-1">全部
									</option>
									<%--<option--%>
											<%--<c:if test="${status==0 }">selected="selected" </c:if> value="0">未删除--%>
									<%--</option>--%>
									<%--<option--%>
											<%--<c:if test="${status==1 }">selected="selected" </c:if> value="1">删除--%>
									<%--</option>--%>
                                    <option
                                            <c:if test="${status==2 }">selected="selected" </c:if> value="2">已审核
                                    </option>
									<option
											<c:if test="${status==3 }">selected="selected" </c:if> value="3">待审核
									</option>
								</select>
								<button type="button" onclick="submitForm()" class="btn btn-success btn-small">查询
								</button>
								<input type="hidden" name="start" id="start" value="${start }"/>
								<input type="hidden" name="limit" id="limit" value="${limit }"/>
								<input type="hidden" name="sign" id="sign"
										<c:choose>
											<c:when test="${sign==null }">
												value="1"
											</c:when>
											<c:otherwise>
												value="${sign }"
											</c:otherwise>
										</c:choose>
										/>
							</form>
						</div>
					</div>
				</div>
				<div id="fixedBar" class="navbar navbar-inner" style="clear:both;">
					<div class="muted pull-left inline">
						<button class="btn btn-success btn-small"  onclick="window.location.href=window.location.href; ">刷新</button>
						<button class="btn btn-success btn-small"  id="btnSelectAll" onclick="selectAll()">全选</button>
						<%--<pe:permission key="pass">--%>
							<button class="btn btn-success btn-small"  onclick="passAudit()">通过</button>
						<%--</pe:permission>--%>
                        <%--<pe:permission key="revoke">--%>
                        <button class="btn btn-success btn-small" onclick="revokeDelelt()">撤销删除
                        </button>
                        <%--</pe:permission>--%>
						<%--<pe:permission key="delete">--%>
							<button class="btn btn-success btn-small"  onclick="deleteAudit()">删除</button>
						<%--</pe:permission>--%>
                        <%--<pe:permission key="hiddenReply">--%>
                            <button class="btn btn-success btn-small" onclick="hiddenReply(1)">隐藏
                            </button>
                            <span class="badge badge-info"></span>
                            <button class="btn btn-success btn-small" onclick="hiddenReply(0)">取消隐藏
                            </button>
                        <%--</pe:permission>--%>
                        <%--<pe:permission key="ignore">--%>
                            <button class="btn btn-success btn-small"  onclick="ignoreReply()">忽略</button>
                        <%--</pe:permission>--%>
					</div>
				</div>
				<div class="block">
					<div class="navbar navbar-inner block-header">
						<div class="muted pull-left inline">回复列表</div>
					</div>
					<div class="block-content collapse in">
						<div class="span12">
							<table class="table">
								<thead>
								<tr>
									<th></th>
									<th>用户</th>
                                    <th width="12%">小组及标题</th>
									<th width="30%">回复内容</th>
									<th width="20%">回复图片</th>
                                    <th width="10%">发布时间</th>
									<th>操作</th>
								</tr>
								</thead>
								<tbody id="tbodys">
								<c:forEach items="${topicReplyList}" var="obj">
									<tr>
										<td>
											<input type="checkbox" name="id" id="id" value="${obj.id }"/>
										</td>
										<td class="uid">
											<font color="#08c">UID：</font><a href="${BasePath }/custom/userList?type=4&itemId=20&uid=${obj.uid}"  target="_black">${obj.uid }</a>
											<c:if test="${obj.banCount != 0}">
												<font style="color: #ff0000">[违规${obj.banCount}]</font>
											</c:if>
											<c:if test="${obj.groupId==2 }"><font color="red">[监控]</font></c:if><br>
											<font color="#08c">昵称：</font> ${obj.nick}<br>
											<a href="${BasePath }/meiyue/audit/topicList?uid=${obj.uid}&type=8&itemId=43&status=-1">她的全部话题</a><br>
											<a href="${BasePath }/meiyue/audit/replyList?uid=${obj.uid}&type=${type}&itemId=${itemId}&status=-1">她的全部回复</a>
										</td>
                                        <td>
                                            小组分类分类:${obj.catTitle}<br>
                                            小组:${obj.groupTitle}<br>
                                            标题:<a
                                                href="${BasePath}/meiyue/topic/topicDetail?topicId=${obj.topicId}&type=${type}&itemId=${itemId}"
                                                target="_blank"><e:forHtml value="${obj.topicTitle}"/></a>
                                            <c:if test="${obj.isdel == 1}"><font
                                                    style="color: #ff0000">[删]</font></c:if>
                                            <c:if test="${obj.islock == 1}"><font
                                                    style="color: #ff0000">[锁]</font></c:if>
                                            <c:if test="${obj.isdown == 1}"><font
                                                    style="color: #ff0000">[沉]</font></c:if>
                                            <c:if test="${obj.settop == 1}">
                                                <font style="color: #ff0000">[小组置顶]</font>
                                            </c:if>
                                            <c:if test="${obj.settop == 2}">
                                                <font style="color: #ff0000">[公告置顶]</font>
                                            </c:if>
                                            <c:if test="${obj.hidden == 1}"><font style="color: #ff0000">[已隐藏]</font></c:if>
                                        </td>
										<td>
											<br>
											回复：<e:forHtml value="${obj.content}"/>
											<c:if test="${obj.status==1 }">
												<font color="red">[删]</font>
											</c:if>
										</td>
										<td>
											<c:forEach items="${obj.picList}" var="pic">
												<a href="${pic.oriPic}" rel="lightbox[ostec]">
													<img src="${pic.oriPic}" style="width: 150px;height: 150px;">&nbsp;&nbsp;
												</a>
											</c:forEach>
										</td>
                                        <td style="vertical-align:middle">
                                            <script >formatTime("${obj.dateline}");</script>
                                        </td>
										<pe:permission key="banUser">
											<td style="vertical-align:middle">
											  <button class="btn btn-danger btn-small" onclick="openModel('${BasePath}/meiyue/audit/toBanUser?uid=${obj.uid}&replyId=${obj.id}&nick=${obj.nick}','封禁层主','45%','70%')">封禁层主</button>
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

<jsp:include page="${BasePath}/jsp/include/bottom.jsp"/>

<script type="text/javascript">
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
			url: "${BasePath}/meiyue/audit/passReply?ids=" + ids,
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
		if (confirm("确定要删除吗？")) {
			$.ajax({
				type: "POST",
				url: "${BasePath}/meiyue/audit/deleteReply?ids=" + ids,
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
	}

    //撤销删除
    function revokeDelelt() {
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
            url: "${BasePath}/meiyue/audit/revokeDelelt?replyIds=" + ids +"&topicIds=",
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

    // 隐藏帖子
    function hiddenReply(digest) {
        var ids = new Array();
        $("input[name='id']:checked").each(function () {
            var txt = $(this).val();
            ids.push(txt);
        });
        if (ids.length == 0) {
            alert("您还未选择要操作的数据？");
            return false;
        }
        var path = "${BasePath}/meiyue/topic/hiddenReply?replyIds=" + ids + "&digest=" + digest;
        qqAjax(path);
    }


    // 忽略审核
    function ignoreReply(){
        var ids = new Array();
        $("input[name='id']:checked").each(function () {
            var txt = $(this).val();
            ids.push(txt);
        });
        if (ids.length == 0) {
            alert("您还未选择要操作的数据？");
            return false;
        }

        var path = "${BasePath}/meiyue/audit/ignoreReply?replyIds=" + ids;
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

</script>


</script>