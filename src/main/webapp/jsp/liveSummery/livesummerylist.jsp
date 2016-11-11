<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<%@ taglib uri="/permission" prefix="pe"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<jsp:include page="../include/head.jsp" />
<style>
    body{
        padding-top: 0px;
    }
</style>
<!-- Body -->
<div class="container-fluid">
				<div class="span12" style="overflow-x: auto;">
					<div class="block">
						<div class="navbar navbar-inner block-header"
							style="border-bottom: none;">
							<form id="myForm" name="myForm"
								action="${BasePath}/broadcast/search" method="post">
								<table>
									<tr valign="middle">
										<td>日期:</td>
										<td><input type="text" class="Wdate" id="startDate"
											name="startDate" value="${startDate }"
											onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'endDate\')}',readOnly:'false'})" /></td>
										<td>至:</td>
										<td><input type="text" class="Wdate" id="endDate"
											name="endDate" value="${endDate }"
											onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'startDate\')}',readOnly:'false'})" /></td>
										<td><select name="dateType" id="dateType"
											class="input-medium search-query inline">
												<option value="1">10分钟</option>
												<option value="2">小时</option>
												<option value="3">日</option>
										</select></td>
										<td><select name="platform" id="platform"
											class="input-medium search-query inline"
											onchange="changeFlatform(this)">
												<option value="-1">全部</option>
												<option value="0">Android</option>
												<option value="1">IOS</option>
												<option value="2">WP</option>
										</select></td>
										<td><input type="button" onclick="btnSubmit()" value="查询" /></td>
									</tr>

								</table>
								<input type="hidden" name="lid" id="lid" value="${lid}" /> 
								<input type="hidden" name="type" id="type" value="${type}" /> 
								<input type="hidden" name="page" id="page" value="${page}" /> 
								<input type="hidden" name="itemId" id="itemId" value="${itemId}" />
							</form>
						</div>
					</div>
				</div>


				<div class="block">
					<div class="navbar navbar-inner block-header">
						<div class="muted pull-left">直播间统计 : ${name}</div>
						<div class="pull-right"></div>
					</div>
					<table class="table">
						<thead>
							<tr>
								<th style='text-align:center;'>时间</th>
								<th style='text-align:center;'>点击pv</th>
								<th style='text-align:center;'>点击uv</th>
								<th style='text-align:center;'>发言pv</th>
								<th style='text-align:center;'>发言uv</th>
							</tr>
						</thead>
						<tbody id="tbodys">
					<!-- 
							<c:forEach items="1,2,3,4,5,6,7,8,9,10" var="i">
								<tr>
									<td>${i}</td>
									<c:forEach items="${tagList}" var="tag">
										<c:forEach items="${orderList}" var="vo">
											<c:if test="${tag.id==vo.tagId && vo.order==i}">
												<td>${vo.count}</td>
											</c:if>
										</c:forEach>
									</c:forEach>
								</tr>
							</c:forEach>
					 -->
						</tbody>
					</table>
				</div>

			</div>
</div>
<hr>
<script>
	function btnSubmit() {

		var startDate = $("#startDate").val();
		var endDate = $("#endDate").val();

		if (startDate == "" || endDate == "") {
			alert("日期不能为空");
			return;
		}

		$("#tbodys tr").remove();//清理掉原来的数据
		$('#myForm').ajaxSubmit(function(data) {
			showData(data);
		});
	}

	function showData(data) {
		var json = eval('(' + data + ')');
		for (var i = 0; i < json.length; i++) {
			var data = json[i];
			var dataArr = data.split(",");
			var html = "<tr>";
			for (var j = 0; j < dataArr.length; j++) {
				html = html + "<td style='text-align:center;'>" + dataArr[j] + "</td>";
			}
			html = html + "</tr>";
			$("#tbodys").append(html);
		}
	}
</script>
