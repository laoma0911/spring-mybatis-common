<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<div class="span2" id="sidebar"  >
	<ul class="nav nav-list bs-docs-sidenav nav-collapse collapse">
		<c:forEach var="item" items="${sessionScope.USER_MENU.getPrivilegeList(type)}">
			<li <c:if test="${item.id==itemId}"> class="active" </c:if>>
				<a href="${BasePath}${item.link }?type=${item.categoryId }&itemId=${item.id}"><i class="icon-chevron-right"></i>${item.name}</a>
			</li>
		</c:forEach>
	</ul>
</div>