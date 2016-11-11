<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<jsp:include page="include/top.jsp" flush="true" />
<script>
<c:if test="${CHECKUSER==false }">
	alert("用户没有登录，请登录！");
	window.location.href="${BasePath}";
</c:if>
<c:if test="${MSG!=null}">
	alert("${MSG}");
	window.location="${BasePath}/user/toUpdatePass";
</c:if>
</script>

<!-- Body -->
<div class="container-fluid">
	<div class="row-fluid">
		<!-- Menu -->
		<jsp:include page="include/menu.jsp" flush="true" />
		<div class="span9" id="content">
			<jsp:include page="include/location.jsp" />
			<div class="row-fluid">
				<div class="span12">

					<div class="block">
						<div class="navbar navbar-inner block-header"
							style="border-bottom: none;">
							<div class="span12">
							欢迎登录！当前时间${thisdate }
							
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		</div>
		</div>
		<hr>
		<jsp:include page="include/bottom.jsp" />