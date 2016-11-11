<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="/permission" prefix="pe" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
							<form id="myForm" class="form-inline" name="myForm" action="${BasePath}/calremind/list?${PublicParams}" method="post">
								标题： <input type="text" name="title" value="${title }"/>
								状态：<select name="status" id="status">
												<option <c:if test="${status==2 }">selected="selected" </c:if> value="2">全部</option>
												<option <c:if test="${status==0 }">selected="selected" </c:if> value="0">未删除</option>
												<option <c:if test="${status==1 }">selected="selected" </c:if> value="1">删除</option>
											</select>
								<input type="submit" value="查询" class="btn btn-success btn-small"/>
									
								<input type="hidden" name="start" id="start" value="${start }"/>
								<input type="hidden" name="limit" id="limit" value="${limit }"/>
								<input type="hidden" name="sign" value="2" id="sign"/>
							</form>
						</div>
					</div>
				</div>
				<div id="fixedBar" class="navbar navbar-inner" style="clear:both;">
					<div class="muted pull-left inline">
						<button class="btn btn-success btn-small" onclick="refrom()">刷新
						</button>
						<span class="badge badge-info"></span>
						<button class="btn btn-success btn-small" id="btnSelectAll" onclick="selectAll()">全选
						</button>
						<span class="badge badge-info"></span>
						<pe:permission key="add">
							<button class="btn btn-small btn-success" onclick="openModel('${BasePath}/calremind/toModify','新增','45%','70%')">新增
							</button>
							<span class="badge badge-info"></span>
						</pe:permission>
						<pe:permission key="delete">
							<button class="btn btn-danger btn-small" onclick="updateStatus(1)">删除
							</button>
							<span class="badge badge-info"></span>
							<button class="btn btn-success btn-small" onclick="updateStatus(0)">恢复
							</button>
							<span class="badge badge-info"></span>
						</pe:permission>
					</div>
				</div>
				<div class="block">
					<div class="navbar navbar-inner block-header">
						<div class="muted pull-left inline">日历待办事项列表&nbsp;&nbsp;&nbsp;</div>
					</div>
					<div class="block-content collapse in">
						<div class="span12">
							<table class="table">
								<thead>
								<tr>
									<th width="1%"></th>
									<th width="11%">标题</th>
									<th width="10%">链接</th>
									<th width="10%">提醒时间</th>
									<th width="10%">修改时间</th>
									<th width="10%">创建时间</th>
									<th width="5%">状态</th>
									<th  width="5%">操作</th>
								</tr>
								</thead>
								<tbody id="tbodys">
								<c:forEach items="${json.data}" var="obj">
									<tr>
										<td id="clickId">
											<input type="checkbox" name="id" id="id" value="${obj.id }"/>
										</td>
										<td>${obj.title }</td>
										<td>${obj.link }</td>
										<td><script >formatTime("${obj.remindTime }");</script></td>
										<td><script >formatTime("${obj.lastUpdate }");</script></td>
										<td><script >formatTime("${obj.createTime }");</script></td>
										<td>
											<c:if test="${obj.status==0 }">未删除</c:if>
											<c:if test="${obj.status==1 }">删除</c:if>
										</td>
										<td>
											<pe:permission key="delete">
													<c:if test="${obj.status==1 }">
														<input type="button" class="btn btn-small btn-success" id="changeBtn" onclick="updateStatusById(${obj.id},0)" value="恢复" />
													</c:if>
													<c:if test="${obj.status==0 }">
														<input type="button" class="btn btn-small btn-danger" id="changeBtn" onclick="updateStatusById(${obj.id},1)" value="删除" />
													</c:if>
												</pe:permission>
												<pe:permission key="update">
													<input type="button" class="btn btn-small btn-success" id="changeBtn" onclick="openModel('${BasePath}/calremind/toModify?&id=${obj.id}','修改','45%','70%')" value="修改" />
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
									PAGER.initPager('${start}', ' ${json.total}', '${limit}', 8, 'pager', getData);
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
	//    tr选中checkbox效果
	$('#tbodys tr').click(function () {
	//	var chks = $(':checkbox', this);
		var chks = $("input[name='id']", this);
		chks.prop('checked', !chks[0].checked);
	});
	
	
	function refrom() {
		$("#myForm").submit();
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

	//批量修改状态
	function updateStatus(status){
		var ids = new Array();
		$("input[name='id']:checked").each(function () {
			var txt = $(this).val();
			ids.push(txt);
		});
		if (ids.length == 0) {
			alert("您还未选择要操作的数据？");
			return false;
		}

		var path = "${BasePath}/calremind/updateStatus?ids=" + ids + "&status=" + status;
		qqAjax(path);
	}
	
	function updateStatusById(id,status){
		var path = "${BasePath}/calremind/updateStatus?ids=" + id + "&status=" + status;
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
					window.location.reload(true);
				}
			},
			error: function () {
				alert("操作出错，请联系管理员！");
			}
		});
	}
</script>