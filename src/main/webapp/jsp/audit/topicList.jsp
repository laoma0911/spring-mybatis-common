<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="/permission" prefix="pe" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<jsp:include page="../include/head.jsp"/>
<link href="${BasePath}/js/mediabox/css.css" rel="stylesheet" media="screen">
<!-- Body -->
<div class="container-fluid" onmousemove="initTrColor()">
	<div class="row-fluid">
		<!-- Menu -->
		<div class="span9" id="content">
			<div class="row-fluid">
				<div class="span12">
					<div class="block">
						<div class="navbar navbar-inner block-header" style="border-bottom: none;">
							<form class="form-inline" id="myForm" name="myForm" action="${BasePath}/audit/allTopicList"
							      method="post">
								UID: <input type="text" id="uid" name="uid" placeholder="uid" value="${uid }"
								            readonly="readonly">
								回复：<input type="text" id="content" name="content" placeholder="回复">
								<select name="status" id="status">
									<option value="-1">全部</option>
									<option
											<c:if test="${status==1 }">selected="selected" </c:if> value="1">未删除
									</option>
									<option
											<c:if test="${status==2 }">selected="selected" </c:if> value="2">删除
									</option>
								</select>
								<button type="submit" class="btn btn-success btn-small">查询</button>
								<input type="hidden" name="start" id="start" value="${start }"/>
								<input type="hidden" name="limit" id="limit" value="${limit }"/>
								<input type="hidden" name="type" id="type" value="${type }"/>
								<input type="hidden" name="itemId" id="itemId" value="${itemId }"/>
							</form>

						</div>
					</div>
				</div>

				<div class="block">
					<div class="navbar navbar-inner block-header">
						<div class="muted pull-left inline">话题列表</div>
						<div class="pull-right">
							<%-- 	            <pe:permission key="add"> --%>
							<%--            	 	<button class="btn btn-success btn-small" style="margin-top: -5px" onclick="openModel('${BasePath}/activity/toAdd','新增')">新增</button> --%>
							<%--     	        </pe:permission> --%>
						</div>
					</div>
					<div class="block-content collapse in">
						<div class="span12">
							<table class="table">
								<thead>
								<tr>
									<th>ID</th>
									<th>标题</th>
									<th>内容</th>
									<th>图片</th>
									<th>操作</th>
								</tr>
								</thead>
								<tbody id="tbodys">
								<c:forEach items="${topicList}" var="obj">
									<tr>
										<td class="id">
												${obj.id }
										</td>
										<td>
												${obj.title }
										</td>
										<td>
												${obj.content }
										</td>
										<td>
												<%--                          	<c:forEach items="${obj.picList}" var="pic"> --%>
												<%--                                     <a href="${pic.oriPic}" rel="lightbox[ostec]"> --%>
												<%--                                         <img src="${pic.oriPic}"  style="width: 150px;height: 150px;" >&nbsp;&nbsp; --%>
											<!--                                     </a> -->
												<%--                             </c:forEach> --%>
										</td>

										<td>
											<button class="btn btn-danger btn-small">封禁层主</button>
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
<script>
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

	$(function () {
		$(".del").bind('click', function () {
			if (!confirm('确定删除该条记录吗？')) {
				return false;
			}
			var uid = $(this).parent().parent().find(".uid").text();
			var tr = $(this).parent().parent();
			$.post('${BasePath}/activity/changStatus', {
				'id': uid, 'status': -1
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

		$(".up").bind('click', function () {
			var uid = $(this).parent().parent().find(".uid").text();
			var tr = $(this).parent().parent();
			$.post('${BasePath}/activity/changStatus', {
				'id': uid, 'status': 1
			}, function (data) {
				var obj = eval(data);
				if (obj.errno == 0) {
					alert('操作成功');
					window.location.reload();
				} else {
					alert(obj.errdesc);
				}
			});
		});

		$(".down").bind('click', function () {
			var uid = $(this).parent().parent().find(".uid").text();
			$.post('${BasePath}/activity/changStatus', {
				'id': uid, 'status': 0
			}, function (data) {
				var obj = eval(data);
				if (obj.errno == 0) {
					alert('操作成功');
					window.location.reload();
				} else {
					alert(obj.errdesc);
				}
			});
		});
	});
</script>