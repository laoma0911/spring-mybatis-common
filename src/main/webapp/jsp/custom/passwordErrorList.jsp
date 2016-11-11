<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<%@ taglib uri="/permission" prefix="pe"%>

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
							<form action="${BasePath}/custom/passwordErrorList?type=${type}&itemId=${itemId}" method="post" class="form-search">
								UID：<input type="text" name="uid" value="${uid }" /> 
								IP：<input type="text" name="ip" value="${ip }">
 										<input type="submit" value="查询" />
							</form>
						</div>
					</div>
				</div>
				<div class="block">
					<div class="navbar navbar-inner block-header">
						<div class="muted pull-left">列表</div>
						<div class="pull-right">
<%-- 							<button class="btn" style="margin-top: -5px"	onclick="window.location='${BasePath}/custom/toAdd?type=${type}&itemId=${itemId}'">新增</button> --%>
							<%--<span class="badge badge-info">${json.total}</span>--%>
						</div>
					</div>
					<div class="block-content collapse in">
						<div class="span12">
							<table class="table table-hover">
								<thead>
									<tr>
										<th>IP</th>
										<th>uid</th>
										<th>第一次</th>
										<th>最后一次</th>
										<th>尝试次数</th>
									</tr>
								</thead>
								<tbody id="tbodys">
									<c:forEach items="${json.data}" var="log">
										<tr>
											<td>${log.ip}</td>
											<td >${log.uid}</td>
											<td><script >formatTime("${log.first}");</script></td>
											<td><script >formatTime("${log.last}");</script></td>
											<td>${log.count}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
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
	$("#domainId")
			.bind(
					"change",
					function() {
						var domainId = $("#domainId").val();
						window.location.href = "${BasePath }/url/query?type=${type}&itemId=${itemId}&domainId="
								+ domainId;
					});

	$(function() {
		$(".del").bind('click', function() {

			if (!confirm('确定删除该条记录吗？')) {
				return false;
			}
			var uid = $(this).parent().parent().find(".id").text();
			var tr = $(this).parent().parent();
			$.post('${BasePath}/url/delete', {
				'id' : uid
			}, function(data) {
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