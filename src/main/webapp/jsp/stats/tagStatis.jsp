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
							<form class="form-search" name="myForm" id="myForm"
								action="${BasePath}/stats/tagStatis" method="post">
								时间：<input type="text" style="width: auto;" id="date" name="date"
									value="${date}"
									onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:'false'})"
									class="Wdate" onClick="WdatePicker()" /> <select
									name="platform" id="platform"
									class="input-medium search-query inline">
									<option value="-1">全部</option>
									<option value="0"
										<c:if test="${platform==0}">selected="selected" </c:if>>Android</option>
									<option value="1"
										<c:if test="${platform==1}">selected="selected" </c:if>>IOS</option>
									<option value="2"
										<c:if test="${platform==2}">selected="selected" </c:if>>WP</option>
								</select> <input type="hidden" name="type" id="type" value="${type }" />
								<input type="hidden" name="itemId" id="itemId"
									value="${itemId }" /> <input type="submit"
									class="btn btn-success" value="Search" />
							</form>
						</div>
					</div>
				</div>

				<div class="block">
					<div class="navbar navbar-inner block-header">
						<div class="muted pull-left">标签排序表</div>
					</div>

					<div class="block-content collapse in">
						<div class="span12">
							<table class="table">
								<thead>
									<tr>
										<th>标签/排序</th>
										<c:forEach items="${tagList}" var="tag">
											<th>${tag.tag}</th>
										</c:forEach>
									</tr>
								</thead>
								<tbody id="tbodys">
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
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<jsp:include page="../include/bottom.jsp" />