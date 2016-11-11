<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
							<form action="${BasePath}/custom/manList" method="post" id="myform" name="myform">
								UID：<input type="text" id="uid" name="uid" value="${uid}" />
								昵称：<input type="text" name="nick" value="${nick }" />
                                女友昵称：<input type="text" name="nvNick" value="${nvNick }" />
                                	 排序：<select name="order">
									 <c:choose>
										<c:when test="${order=='uid'}">
											<option value="uid" selected="selected">uid</option>
										</c:when>
										<c:otherwise>
											<option value="uid">uid</option>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${order=='regtime'}">
											<option value="regtime" selected="selected">注册时间</option>
										</c:when>
										<c:otherwise>
											<option value="regtime">注册时间</option>
										</c:otherwise>
									</c:choose>

									<c:choose>
										<c:when test="${order=='loginnum'}">
											<option value="loginnum" selected="selected">登陆次数</option>
										</c:when>
										<c:otherwise>
											<option value="loginnum">登陆次数</option>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${order=='lastlogin'}">
											<option value="lastlogin" selected="selected">最后登录时间</option>
										</c:when>
										<c:otherwise>
											<option value="lastlogin">最后登录时间</option>
										</c:otherwise>
									</c:choose>

								</select>
                                <select name="asc">
									<c:choose>
										<c:when test="${asc=='desc'}">
											<option value="desc" selected="selected">倒序</option>
										</c:when>
										<c:otherwise>
											<option value="desc">倒序</option>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${asc=='asc'}">
											<option value="asc" selected="selected">正序</option>
										</c:when>
										<c:otherwise>
											<option value="asc">正序</option>
										</c:otherwise>
									</c:choose>
								</select>
								<input type="hidden"  name="start" id="start" value="${start }"/>
								<input type="hidden"  name="limit" id="limit" value="${limit }"/>
								<input type="hidden"  name="type" id="type" value="${type }"/>
								<input type="hidden"  name="itemId" id="itemId" value="${itemId }"/>
								<input type="submit" value="查询" onclick="find()" />

								<script type="text/javascript">
									function find() {
										var uid = $("#uid").val().trim();
										if (isNaN(uid)) {
											alert("uid只能是数字!");
											$("#uid").val('0');
											return;
										}
										$("#myform").submit();
									}
								</script>

							</form>
						</div>
					</div>
				</div>

				<div class="block">
					<div class="navbar navbar-inner block-header">
						<div class="muted pull-left">男性用户数据列表</div>
						<div class="pull-right">
						<pe:permission key="add">
							<button class="btn btn-samll btn-success"   onclick="openModel('${BasePath}/custom/toAdd','新增')">新增</button>
						</pe:permission>
							<%-- 			  <span class="badge badge-info">${json.total}</span> --%>
						</div>
					</div>
					<div class="block-content collapse in">
						<div class="span12">
							<table class="table table-hover">
								<thead>
									<tr>
										<th>UID</th>
										<th>昵称</th>
                                        <th>关联女生</th>
										<th>登录次数</th>
										<th>最后登录时间</th>
                                        <th>最后登录IP</th>
										<th>注册时间</th>
                                        <th>注册IP</th>
										<th>注册平台</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody id="tbodys">
									<c:forEach items="${boyUserList}" var="obj">
										<tr>
											<td class="id" style="width: 5%;">${obj.uid}</td>
											<td style="width: 5%;">${obj.nick }</td>
											<td style="width: 10%;">
                                                <a href="${BasePath }/custom/userList?type=4&itemId=20&uid=${obj.dymuid} "  target="_black">${obj.dymNick }</a>
                                                <c:if test="${obj.dymuid!=null && obj.dymuid>0}">
                                                    (${obj.dymuid})
                                                </c:if>
                                            </td>
											<td style="width: 5%;">${obj.loginnum }</td>
											<td ><script>formatTime("${obj.lastlogin }");</script></td>
                                            <td>${obj.lastloginip}</td>
                                            <td><script>formatTime("${obj.regtime }");</script></td>
                                            <td>${obj.regip}</td>
                                            <td >
                                                <c:if test="${obj.platform==0}">android</c:if>
                                                <c:if test="${obj.platform==1 }">iPhone</c:if>
                                                <c:if test="${obj.platform==2 }">wp</c:if>
                                            </td>
											<td style="width: 10%;">
                                                <pe:permission key="update">
                                                    <button class="btn btn-success btn-small" onclick="openModel('${BasePath}/custom/toModifyBoyUser?uid=${obj.uid }','重置密码')">重置密码</button>
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
									PAGER.initPager('${start}', '${total}', '${limit}', 8, 'pager', getData);
								}
								function getData(currentPage, pageSize) {
									if (sign > 0) {
										$("#start").val(currentPage);
										$("#limit").val(pageSize);
										$("#myform").submit();
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
<jsp:include page="../include/bottom.jsp" />