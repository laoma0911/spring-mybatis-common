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
							      action="${BasePath}/audit/topicList?${PublicParams}" method="post">
								UID: <input type="text" id="uid" name="uid" value="${uid }">
								标题：<input type="text" id="title" name="title" value="${title }">
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
						<button class="btn btn-success btn-small" onclick="window.location.reload(true); ">刷新
						</button>
						<span class="badge badge-info"></span>
						<button class="btn btn-success btn-small" id="btnSelectAll" onclick="selectAll()">全选
						</button>
						<span class="badge badge-info"></span>
						<pe:permission key="pass">
							<button class="btn btn-success btn-small" onclick="passAudit()">通过
							</button>
						</pe:permission>
                        <span class="badge badge-info"></span>
                        <%--<pe:permission key="revoke">--%>
                            <button class="btn btn-success btn-small" onclick="revokeDelelt()">撤销删除
                            </button>
                        <%--</pe:permission>--%>
						<span class="badge badge-info"></span>
						<pe:permission key="delete">
							<button class="btn btn-success btn-small" onclick="deleteAudit()">
								删除
							</button>
						</pe:permission>
						<span class="badge badge-info"></span>
						<pe:permission key="down">
							<button id="down" class="btn btn-small btn-success" onclick="down()">
								下沉
							</button>
							<button id="down" class="btn btn-small btn-success" onclick="setIsdown(0)">
								取消下沉
							</button>
						</pe:permission>
						<span class="badge badge-info"></span>
						<pe:permission key="lock">
							<button id="lock" class="btn btn-small btn-success" onclick="lock()">
								锁定
							</button>
							<button id="lock" class="btn btn-small btn-success" onclick="lockSt(0)">
								解锁
							</button>
						</pe:permission>
                        <pe:permission key="hidden">
                            <button class="btn btn-success btn-small" onclick="hiddenTopic(1)">隐藏
                            </button>
                            <span class="badge badge-info"></span>
                            <button class="btn btn-success btn-small" onclick="hiddenTopic(0)">取消隐藏
                            </button>
                        </pe:permission>
                        <pe:permission key="ignore">
                            <button id="lock" class="btn btn-small btn-success" onclick="ignoreTopic()">忽略</button>
                        </pe:permission>
						<span class="badge badge-info"></span>
					</div>
				</div>
				<div class="block">
					<div class="navbar navbar-inner block-header">
						<div class="muted pull-left inline">话题列表</div>
					</div>
					<div class="block-content collapse in">
						<div class="span12">
							<table class="table">
								<thead>
								<tr>
									<th nowrap="true"></th>
									<th nowrap="true">用户</th>
									<th nowrap="true">小组分类|小组|标题</th>
									<th nowrap="true">头图</th>
									<th nowrap="true">内容</th>
									<th nowrap="true">发布时间</th>
									<pe:permission key="banUser">
										<th nowrap="true">操作</th>
									</pe:permission>
								</tr>
								</thead>
								<tbody id="tbodys">
								<c:forEach items="${autidList}" var="obj">
									<tr>
										<td nowrap="true" id="clickId">
											<input type="checkbox" name="id" id="id" value="${obj.topicId }"/>
										</td>
										<td nowrap="true">
												<a href="${BasePath }/custom/userList?type=4&itemId=20&uid=${obj.uid}"  target="_black">${obj.uid }</a>
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
                                        <td nowrap="true">
                                            小组分类:${obj.catTitle}<br>
                                            小组:${obj.groupTitle}<br>
                                            <a href="${BasePath}/topic/topicDetail?topicId=${obj.topicId}&type=${type}&itemId=${itemId}"
                                               target="_blank">标题:<e:forHtml value="${obj.title}"/></a>
                                            <c:if test="${obj.isdel == 1}"><font style="color: #ff0000">[删]</font></c:if>
                                            <c:if test="${obj.islock == 1}"><font style="color: #ff0000">[锁]</font></c:if>
                                            <c:if test="${obj.isdown == 1}"><font style="color: #ff0000">[沉]</font></c:if>
                                            <c:if test="${obj.settop == 1}"><font style="color: #ff0000">[小组置顶]</font></c:if>
                                            <c:if test="${obj.settop == 2}"><font style="color: #ff0000">[公告置顶]</font></c:if>
                                            <c:if test="${obj.hidden == 1}"><font style="color: #ff0000">[已隐藏]</font></c:if>
                                            <br>
                                        </td>
                                        <td nowrap="true" style="vertical-align:middle">
                                                <%--头图--%>
                                            <c:forEach items="${obj.picList}" var="pic">
                                                <c:if test="${pic.picOrder == 0}">
                                                    <a href="${pic.oriPic}" rel="lightbox[ostec]">
                                                        <img src="${pic.pic}" width="120px" height="120px">&nbsp;
                                                    </a>
                                                </c:if>
                                            </c:forEach>
                                            <c:if test="${obj.hasPicHead != 0}">
                                                <font color="red">无头图</font>
                                            </c:if>
                                        </td>
                                        <td style="width: 650px" class="tdBreak">
                                            <e:forHtml value="${obj.content}"/>
                                            <br>
                                            <c:forEach items="${obj.picList}" var="pic">
                                                <c:if test="${pic.picOrder != 0 && pic.picOrder != -1}">
                                                    <a href="${pic.oriPic}" rel="lightbox[ostec]">
                                                        <img src="${pic.pic}" width="120px" height="120px">&nbsp;
                                                    </a>
                                                </c:if>
                                            </c:forEach>
                                        </td>
                                        <td nowrap="true" style="vertical-align:middle">
                                            <script >formatTime("${obj.dateline}");</script>
                                        </td>
										<pe:permission key="banUser">
											<td nowrap="true" style="vertical-align:middle">
                                                <button class="btn btn-danger btn-small" onclick="openModel('${BasePath}/audit/toBanUser?uid=${obj.uid}&topicId=${obj.topicId}&nick=${obj.nick}','封禁楼主','45%','70%')">封禁楼主</button>
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
		$("#sign").val("2");
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
			url: "${BasePath}/audit/pass?topicIds=" + ids,
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
		$.ajax({
			type: "POST",
			url: "${BasePath}/audit/deleteTopic?topicIds=" + ids,
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
			url: "${BasePath}/audit/revokeDelelt?topicIds=" + ids+"&replyIds=",
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

	//下沉
	function down() {
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
			url: "${BasePath}/audit/down?topicIds=" + ids,
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

	//锁定
	function lock() {
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
			url: "${BasePath}/audit/lock?topicIds=" + ids,
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

	
	function setIsdown(isdown){
		var ids = new Array();
		$("input[name='id']:checked").each(function () {
			var txt = $(this).val();
			ids.push(txt);
		});
		if (ids.length == 0) {
			alert("您还未选择要操作的数据？");
			return false;
		}

		var path = "${BasePath}/topic/shIsdownTopic?topicIds=" + ids + "&isdown=" + isdown;
		qqAjax(path);
	}
	
	function lockSt(lock) {
		var ids = new Array();
		$("input[name='id']:checked").each(function () {
			var txt = $(this).val();
			ids.push(txt);
		});
		if (ids.length == 0) {
			alert("您还未选择要操作的数据？");
			return false;
		}

		var path = "${BasePath}/topic/shLockTopic?topicIds=" + ids + "&lock=" + lock;
		qqAjax(path);
	}

    // 隐藏帖子
    function hiddenTopic(digest) {
        var ids = new Array();
        $("input[name='id']:checked").each(function () {
            var txt = $(this).val();
            ids.push(txt);
        });
        if (ids.length == 0) {
            alert("您还未选择要操作的数据？");
            return false;
        }

        var path = "${BasePath}/topic/hiddenTopic?topicIds=" + ids + "&digest=" + digest;
        qqAjax(path);
    }

    // 忽略审核
    function ignoreTopic(){
        var ids = new Array();
        $("input[name='id']:checked").each(function () {
            var txt = $(this).val();
            ids.push(txt);
        });
        if (ids.length == 0) {
            alert("您还未选择要操作的数据？");
            return false;
        }

        var path = "${BasePath}/audit/ignoreTopic?topicIds=" + ids;
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


</script>