<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
					<div class="navbar navbar-inner block-header"  style="border-bottom: none;" >
							<form class="form-search" id="myForm"  name="myForm"  action="${BasePath}/ditui/userData" method="post">
								开始时间：
								<input type="text"  style="width: auto;" id="beginDate"  name="beginDate" value="${beginDate }" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:'false'})" class="Wdate" onClick="WdatePicker()" />
								结束时间：
								<input type="text"  style="width: auto;" id="endDate"  name="endDate" value="${endDate }" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:'false'})" class="Wdate" onClick="WdatePicker()" />
								<td style="vertical-align: middle;">手机号：</td>
								<td><input type="text" class="input-medium search-query inline" name="mobile" value="${mobile}"  /></td>
								渠道：
								<select name="channelId" id="channel">
									<option value="0">全部</option>
									<c:forEach items="${dituiOrgList}" var="org">
										<option value="${org.id}" <c:if test="${channelId==org.id}">selected</c:if>>${org.name}&nbsp;(${org.mobile})</option>
									</c:forEach>
								</select>
								<%--<td style="vertical-align: middle;">手机号：</td>
								<td><input type="text" class="input-medium search-query inline" name="mobile" value="${mobile}"  /></td>--%>
								<input type="hidden" id="type" name="type" value="${type }"/>
								<input type="hidden" id="itemId" name="itemId" value="${itemId }"/>
								<input type="hidden"  name="start" id="start" value="${start }"/>
								<input type="hidden"  name="limit" id="limit" value="${limit }"/>
  								<button type="submit" class="btn btn-small btn-success">查询</button>
							</form>
                           </div>
						</div>
					</div>
         
        <div class="block">
          <div class="navbar navbar-inner block-header">
            <div class="muted pull-left">用户数据列表</div>
            <div class="pull-right">
				<button class="btn btn-success btn-small" style="margin-top: -5px" onclick="exportCsv()">导出CSV</button>
            	<%--<pe:permission key="add">--%>
           		<button class="btn btn-success btn-small" style="margin-top: -5px" onclick="openModel('${BasePath}/ditui/batchMobile','批量导入')">批量导入</button>
            	<%--</pe:permission>--%>
				<span class="badge badge-info">${total}</span><br>
		    </div>
          </div>
          <div class="block-content collapse in">
            <div class="span12">
              <table class="table table-hover">
                <thead>
                  <tr>
                    <th>ID</th>
					  <th>手机号</th>
					  <th>渠道</th>
					  <th>设备号</th>
					  <th>UID</th>
					  <th>登录次数</th>
					  <th>注册时间</th>
					  <th>注册地</th>
					  <th>最后登录地</th>
					  <th>有效用户</th>
				  <%--<th>导入时间</th>--%>
					  <%--<th>备注</th>--%>
                  </tr>
                </thead>
                <tbody id="tbodys">
                  <c:forEach items="${json.data}" var="obj">
                    <tr >
                       <td class="uid">${obj.id}</td>
                       <%--<td>${obj.dituiName }</td>--%>
						<td>${obj.mobile }</td>
						<td>${obj.dituiName }</td>
						<td>${obj.device }</td>
						<td>${obj.uid }</td>
						<td>${obj.loginnum }</td>
						<td><c:if test="${not empty obj.regtime}">
							<script >formatTime("${obj.regtime}");</script>
						</c:if></td>
						<td>${obj.regcountry }</td>
						<td>${obj.lastlogincountry }</td>
						<td>
						<c:choose>
						<c:when test="${obj.status ==1}">初始化</c:when>
						<c:when test="${obj.status ==2}">是</c:when>
						<c:when test="${obj.status ==3}">否</c:when>
						<c:when test="${obj.status ==4}">否</c:when>
						<c:otherwise>未知</c:otherwise>
					</c:choose>
						</td>
					<%--<td><script >formatTime("${obj.dateline}");</script></td>--%>
						<%--<td>${obj.remark }</td>--%>
                    </tr>
                  </c:forEach>
                </tbody>
              </table>
                <div class="pagination pagination-centered" id="pager"></div>
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
var sign=0;
window.onload=function(){
	  //分页
	  PAGER.initPager('${start}',' ${total}','${limit}', 8, 'pager', getData);
	//分页
	function getData(currentPage,pageSize) {
	  if(sign>0){
	 	$("#start").val(currentPage);
	 	$("#limit").val(pageSize);
	 	$("#myForm").submit();
	  }
	  sign=1;
	} 
}
	function exportCsv() {
		$("#myForm").attr("action", "${BasePath}/ditui/exportUserData");
		$("#myForm").submit();
		$("#myForm").attr("action", "${BasePath}/ditui/userData");
	}
</script>
