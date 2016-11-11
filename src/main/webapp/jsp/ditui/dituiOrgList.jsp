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
							<form class="form-search" id="myForm"  name="myForm"  action="${BasePath}/ditui/orgList" method="post">
								<td style="vertical-align: middle;">渠道：</td>
								<td><input type="text" class="input-medium search-query inline" name="name" value="${name}"  /></td>
								<td style="vertical-align: middle;">联系人：</td>
								<td><input type="text" class="input-medium search-query inline" name="linkman" value="${linkman}"  /></td>
								<input type="hidden" id="type" name="type" value="${type }"/>
								<input type="hidden" id="itemId" name="itemId" value="${itemId }"/>
								<input type="hidden"  name="start" id="start" value="${start }"/>
								<input type="hidden"  name="limit" id="limit" value="${limit }"/>
<%-- 								<input type="hidden"  name="name" id="name" value="${name }"/> --%>
  								<button type="submit" class="btn btn-small btn-success">查询</button>
					</form>
                           </div>
						</div>
					</div>
         
        <div class="block">
          <div class="navbar navbar-inner block-header">
            <div class="muted pull-left">地推团队列表</div>
            <div class="pull-right">
              <%--<pe:permission key="add">--%>
           		 <button class="btn btn-success btn-small" style="margin-top: -5px" onclick="openModel('${BasePath}/ditui/toAdd','新增')">新增</button>
              <%--</pe:permission>--%>
			  <span class="badge badge-info">${total}</span>
			  <br>
		    </div>
          </div>
          <div class="block-content collapse in">
            <div class="span12">
              <table class="table table-hover">
                <thead>
                  <tr>
                    <th>ID</th>
                    <th>渠道</th>
                    <th>联系人</th>
                    <th>联系电话</th>
                    <th>创建时间</th>
                    <th>操作</th>
                  </tr>
                </thead>
                <tbody id="tbodys">
                  <c:forEach items="${json.data}" var="obj">
                    <tr >
                       <td class="uid">${obj.id}</td>
					   <td>${obj.name }</td>
					   <td>${obj.linkman }</td>
					   <td>${obj.mobile }</td>
                      <td><script >formatTime("${obj.dateline}");</script></td>
                      <td>
                        <pe:permission key="update">
                      		<a class="btn btn-success btn-small" href="javascript:openModel('${BasePath}/ditui/toModify?id=${obj.id}','修改')">修改</a> 
                      	</pe:permission>
                      	<!--<pe:permission key="delete">
                      	   <button class="btn del btn-danger btn-small">删除</button> 
						 </pe:permission>-->
                      </td>
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
</script>
