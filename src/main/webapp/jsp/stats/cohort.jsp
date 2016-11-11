<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="/permission" prefix="pe" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
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
					<div class="block"  >
						<div class="navbar navbar-inner block-header"><br>
							
							<c:if test="${empty t1Data }">
								No data!<br/>
							</c:if>
							<c:if test="${!empty t1Data }">
								<div style="border-bottom: none; overflow:scroll;" class="block-content collapse in">
								<table class="table table-striped table-bordered table-hover table-responsive">
									<!-- 1 -->
									<c:forEach var="t1Entry" items="${t1Data }" varStatus="outerStatus">
									<tr>
										<c:forEach var="oriMonthData" items="${t1Entry}" varStatus="innerStatus">
										<c:if test="${outerStatus.first || innerStatus.first }">
											<td style="text-align: center; font-weight: bold; padding: 3px; line-height:15px;">${oriMonthData}</td>
										</c:if>
										<c:if test="${!outerStatus.first && !innerStatus.first }">
											<td style="text-align: center; padding: 3px; line-height:15px;">${oriMonthData}</td>
										</c:if>
										</c:forEach>
									</tr>
									</c:forEach>
								</table>
								</div>
								<hr>
								<div style="border-bottom: none; overflow:scroll;" class="block-content collapse in">
								<table class="table table-striped table-bordered table-hover table-responsive">
									<!-- 2 -->
									<c:forEach var="t2Entry" items="${t2Data }"  varStatus="outerStatus">
									<tr>
										<c:forEach var="oriMonthData" items="${t2Entry}" varStatus="innerStatus">
										<c:if test="${outerStatus.first || innerStatus.first }">
											<td style="text-align: center; font-weight: bold; padding: 3px; line-height:15px;">${oriMonthData}</td>
										</c:if>
										<c:if test="${!outerStatus.first && !innerStatus.first }">
											<td style="text-align: center; padding: 3px; line-height:15px;">${oriMonthData}</td>
										</c:if>
										</c:forEach>
									</tr>
									</c:forEach>
								</table>
								</div>
							</c:if>
			
                		</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<jsp:include page="../include/bottom.jsp" />