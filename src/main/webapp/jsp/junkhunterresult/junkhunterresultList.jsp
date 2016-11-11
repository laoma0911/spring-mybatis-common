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
							<form class="form-inline" id="myForm" name="myForm" action="${BasePath}/junkhunterresult/list?${PublicParams}" method="post">
								<select name="status"  id="status" class="input-medium search-query inline" >
									<option value="0"   <c:if test="${status==0 }"> selected="selected"</c:if> >全部</option>
									<option value="1"   <c:if test="${status==1 }"> selected="selected"</c:if> >待处理</option>
									<option value="2"   <c:if test="${status==2 }"> selected="selected"</c:if> >已忽略</option>
									<option value="3"   <c:if test="${status==3 }"> selected="selected"</c:if> >已撤消删除</option>
								</select>
								
								<input type="submit" class="btn btn-small btn-success" value="查询" />
								<input type="hidden" name="start" id="start" value="${start }"/>
								<input type="hidden" name="limit" id="limit" value="${limit }"/>
							</form>
						</div>
					</div>
				</div>
				
				<div id="fixedBar" class="navbar navbar-inner" style="clear:both;">
					<div class="muted pull-left inline">
						<button class="btn btn-success btn-small"  onclick="window.location.href=window.location.href; ">刷新</button>
						<button class="btn btn-success btn-small"  id="btnSelectAll" onclick="selectAll()">全选</button>
						<pe:permission key="ignore">
							<button class="btn btn-success btn-small"  onclick="pass()">忽略</button>
						</pe:permission>
						<pe:permission key="rescindDelete">
							<button class="btn btn-success btn-small"  onclick="cxdelete()">撤消删除</button>
						</pe:permission>
					</div>
				</div>
				
<!-- 				<div class="navbar navbar-fixed-bottom navbar-inner"> -->
<!-- 					<div class="muted pull-right inline"> -->
<!-- 						<button class="btn btn-success btn-small"  onclick="window.location.href=window.location.href; ">刷新</button> -->
<!-- 						<button class="btn btn-success btn-small"  id="btnSelectAll" onclick="selectAll()">全选</button> -->
<%-- 						<pe:permission key="ignore"> --%>
<!-- 							<button class="btn btn-success btn-small"  onclick="pass()">忽略</button> -->
<%-- 						</pe:permission> --%>
<%-- 						<pe:permission key="rescindDelete"> --%>
<!-- 							<button class="btn btn-success btn-small"  onclick="cxdelete()">撤消删除</button> -->
<%-- 						</pe:permission> --%>
<!-- 					</div> -->
<!-- 				</div> -->
				
				<div class="block">
					<div class="navbar navbar-inner block-header">
						<div class="muted pull-left inline">广告猎手</div>
					</div>
					<div class="block-content collapse in">
						<div class="span12">
							<table class="table">
								<thead>
								<tr>
									<th width="2%"></th>
									<th width="5%">id</th>
									<th width="8%">组名</th>
									<th width="10%">uid</th>
									<th width="5%">类型</th>
									<th width="5%">备注</th>
									<th width="48%">内容</th>
									<th width="8%">创建时间</th>
									<th width="5%">重复数目</th>
									<th width="4%">状态</th>
								</tr>
								</thead>
								<tbody id="tbodys">
								<c:forEach items="${list}" var="obj">
									<tr>
										<td>
											<input type="checkbox" name="id" id="id" value="${obj.id }"/>
										</td>
										<td>${obj.id }</td>
										<td>${obj.title }</td>
										<td>${obj.nick }<br>(<a href="${BasePath }/custom/userList?type=4&itemId=20&uid=${obj.uid}"  target="_black">${obj.uid }</a>) ${obj.groupId }
											<c:if test="${obj.groupId == 2}">
												<font color="red">(监控)</font>
											</c:if>
										</td>
										<td>
											<c:if test="${obj.replyId > 0}">
												回复
											</c:if>
											<c:if test="${obj.replyId <= 0}">
												帖子
											</c:if>
											<br>
											<c:if test="${obj.topicstatus == 0}">
												未处理
											</c:if>
											<c:if test="${obj.topicstatus == 1}">
												<font color="red">已处理</font>
											</c:if>
										</td>
										<td>${obj.memo }</td>
										<td title="${obj.triggerContent}"><e:forHtml value="${obj.content}"/><br>
											<c:if test="${obj.replyId > 0}">
												<c:forEach items="${obj.topicReplyPicList}" var="pic">
												<a href="${pic.oriPic}" rel="lightbox[ostec]">
													<img src="${pic.oriPic}" style="width: 60px;height: 60px;">&nbsp;&nbsp;
												</a>
											</c:forEach>
											</c:if>
											<c:if test="${obj.replyId <= 0}">
												<c:forEach items="${obj.topicPicList}" var="pic">
												<a href="${pic.oriPic}" rel="lightbox[ostec]">
													<img src="${pic.oriPic}" style="width: 60px;height: 60px;">&nbsp;&nbsp;
												</a>
											</c:forEach>
											</c:if>
										</td>
										<td>${obj.dateline }</td>
										<td>${obj.num }</td>
										<td>
											<c:if test="${obj.status == 0}">待处理</c:if>
											<c:if test="${obj.status == 1}">已忽略</c:if>
											<c:if test="${obj.status == 2}">已撤消删除</c:if>
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

<jsp:include page="../include/bottom.jsp"/>

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
	//忽略
	function pass() {
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
			url: "${BasePath}/junkhunterresult/pass?${PublicParams}&ids=" + ids ,
			datatype: "json",
			success: function (data) {
				if (data.errno == 1) {
					alert(data.errdesc);
				} else {
					window.location.href = window.location.href;
				}
			},
			error: function () {
				alert("操作出错，请联系管理员！");
			}
		});
	}
	//忽略
	function cxdelete() {
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
			url: "${BasePath}/junkhunterresult/cancel?${PublicParams}&ids=" + ids,
			datatype: "json",
			success: function (data) {
				if (data.errno == 1) {
					alert(data.errdesc);
				} else {
					window.location.href = window.location.href;
				}
			},
			error: function () {
				alert("操作出错，请联系管理员！");
			}
		});
	}
</script>

