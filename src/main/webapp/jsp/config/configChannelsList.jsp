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
						<div class="navbar navbar-inner block-header" style="border-bottom: none;">
							<form action="${BasePath}/configChannels/list?type=${type}&itemId=${itemId}" method="post" id="myform" class="form-search">
							
								名称： <input type="text" name="name" id="name" value="${name }"  /> 
								
									<input type="submit" class="btn btn-small btn-success" value="查询" />
								
									<input type="hidden"  name="start" id="start" value="${start }"/>
									<input type="hidden"  name="limit" id="limit" value="${limit }"/>
								
							</form>
						</div>
					</div>
				</div>
				<div class="block">
					<div class="navbar navbar-inner block-header">
		            <div class="muted pull-left">列表</div>
		            <div class="pull-right">
		             <pe:permission key="add">
		           		 <button class="btn btn-success btn-small" style="margin-top: -5px" onclick="openModel('${BasePath}/configChannels/toAdd','新增','40%','40%')">新增</button>
		            </pe:permission>
					  <br>
				    </div>
		          </div>
					
					<div class="block-content collapse in">
						<div class="span12">
							<table class="table table-hover">
								<thead>
									<tr>
										<th>ID</th>
										<th>名称</th>
										<th>初始时间</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody id="tbodys">
									<c:forEach items="${json.data}" var="obj">
													<tr >
														<td>${obj.id }</td>
														<td>${obj.name }</td>
														<td><script >formatTime("${obj.dateline }");</script></td>
														<td> <button  class="btn btn-success btn-small" onclick="window.location='${BasePath}/stats/user?channel=${obj.name}&type=6&itemId=33'">查看统计</button>  </td>
													</tr>
									</c:forEach>
								</tbody>
							</table>
							 <div class="pagination pagination-centered" id="pager"></div> 
					                 <script type="text/javascript">
								             var sign=0;
								              window.onload=function(){
								            	  PAGER.initPager('${start}',' ${json.total}','${limit}', 8, 'pager', getData);
								              }
								              function getData(currentPage,pageSize) {
								            	  if(sign>0){
								            	 	$("#start").val(currentPage);
								            	 	$("#limit").val(pageSize);
								            	 	$("#myform").submit();
								            	  }
								            	  sign=1;
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
