<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="/permission" prefix="pe" %>

<jsp:include page="../include/top.jsp"/>
<!-- Body -->
<div class="container-fluid">
	<div class="row-fluid">
		<!-- Menu -->
		<jsp:include page="../include/menu.jsp" flush="true"></jsp:include>
		<div class="span9" id="content">
			<jsp:include page="../include/location.jsp"></jsp:include>
			<div class="row-fluid">
				<div class="span12">
					<!-- block -->
					<div class="block">
						<div class="navbar navbar-inner block-header">
							<div class="muted pull-left">深夜聊天推荐组列表</div>
							<div class="pull-right">
							 	 <pe:permission key="add">
								<button class="btn btn-small btn-success"  style="margin-top: -5px" onclick="openModel('${BasePath}/nighthotchat/addorupdate','新增','40%','38%')">新增</button>
								</pe:permission>
							</div>
						</div>
						<div class="block-content collapse in">
							<div class="span12">
								<table class="table">
									<thead>
									<tr>
										<th>ID</th>
										<th>小组id</th>
										<th>小组头像</th>
										<th>小组名称</th>
										<th>排序值</th>
										<th>操作</th>
									</tr>
									</thead>
									<tbody>
									<c:forEach items="${list}" var="obj">
									<tr>
										<td>${obj.id }</td>
										
										<c:if test="${obj.status == 0}">
											<td>${obj.groupId }</td>
											<td><img alt="" src="${obj.pic }" width="84px" height="40px" /></td>
											<td>${obj.title }</td>
										</c:if>
										<c:if test="${obj.status == 1}">
											<td></td>
											<td></td>
											<td><font color="red">小组非正常状态</font></td>
										</c:if>
										
										<td>${obj.displayorder }</td>
										<td>
												 <pe:permission key="update">
													<a class="btn btn-small btn-success" href="javascript:openModel('${BasePath}/nighthotchat/addorupdate?id=${obj.id}','修改','40%','38%')">修改</a> 
												 </pe:permission>
												<pe:permission key="delete">
													<button class="btn del btn-small btn-danger" onclick="del('${obj.id}')">删除</button>
												</pe:permission>
										</td>
									</tr>
									</c:forEach>
									</tbody>
								</table>
								<form id="myForm"  name="myForm"  action="${BasePath}/nighthotchat/list" method="post">
									<input type="hidden"  name="start" id="start" value="${start }"/>
									<input type="hidden"  name="limit" id="limit" value="${limit }"/>
									<input type="hidden"  name="type" id="type" value="${type }"/>
									<input type="hidden"  name="itemId" id="itemId" value="${itemId }"/>
							</form>
								<div class="pagination pagination-centered" id="pager"></div> 
				            <script type="text/javascript">
					            var sign=0;
			                    window.onload=function(){
			                        PAGER.initPager('${start}',' ${total}','${limit}', 8, 'pager', getData);
			                    }
			                    function getData(currentPage,pageSize) {
			                        if(sign>0){
			                            $("#start").val(currentPage);
			                            $("#limit").val(pageSize);
			                            window.location.href="${BasePath}/nighthotchat/list?start="+currentPage+"&limit="+pageSize+"&type=${type}&itemId=${itemId}";
			                        }
			                        sign=1;
			                    } 
				              </script>
							</div>
						</div>
					</div>
					<!-- /block -->
				</div>
			</div>
		</div>
	</div>
</div>

<jsp:include page="../include/bottom.jsp"/>

<script>

	function del(id){
		if(!confirm('确定删除？')){
	        return false;
	      }
		
		 $.post('${BasePath}/nighthotchat/del',{
		        'id':id
		      },function(data){
		        var obj = eval(data);
		        if(obj.errno==0){
		          alert('操作成功');
		          window.location.reload();
		        }else{
		          alert(obj.errdesc);
		        }
		      });
	}

</script>
