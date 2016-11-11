<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<div class="row-fluid">
	<div class="navbar navbar-nobottom-margin">
		<div class="navbar-inner">
			<ul class="breadcrumb">
				<li class="icon-chevron-left hide-sidebar">
					<a href='#' title="Hide Sidebar" rel='tooltip'>&nbsp;</a>
				</li>
				<li class="icon-chevron-right show-sidebar" style="display:none;">
					<a href='#' title="Show Sidebar" rel='tooltip'>&nbsp;</a>
				</li>
				<li>
					<a href="${BasePath}/home">首页</a><span class="divider">/</span>
				</li>
				<li>
				<c:forEach var="obj" items="${sessionScope.USER_MENU.categoryList }">
						<c:if test="${obj.id==type}">
						<a href="${BasePath}/home?type=${obj.id}">${obj.name }</a><span class="divider">/</span>
						</c:if>
				</c:forEach>
				</li>
				<c:forEach var="item" items="${USER_MENU.getPrivilegeList(type) }">
					<c:if test="${itemId==item.id }">
					<li class="active">${item.name }</li>
					</c:if>
				</c:forEach>
			</ul>
		</div>
	</div>	
</div>