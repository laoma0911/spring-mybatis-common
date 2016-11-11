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
							<div class="muted pull-left">用户组列表</div>
							<div class="pull-right">
							 	 <pe:permission key="add">
								<button class="btn btn-small btn-success"  style="margin-top: -5px" onclick="openModel('${BasePath}/group/toAdd','新增')">新增</button>
								</pe:permission>
							</div>
						</div>
						<div class="block-content collapse in">
							<div class="span12">
								<table class="table">
									<thead>
									<tr>
										<th>#</th>
										<th>组名</th>
										<th>操作</th>
									</tr>
									</thead>
									<tbody>
									<c:forEach items="${groupList}" var="group">
									<tr>
										<td class="groupId">${group.id}</td>
										<td>${group.name}</td>
										<td>
										 <pe:permission key="update">
											<a class="btn btn-small btn-success" href="javascript:openModel('${BasePath}/group/toModify?groupId=${group.id}','修改')">修改</a> 
											</pe:permission>
											 <pe:permission key="delete">
											<button class="btn del btn-small btn-danger">删除</button>
											</pe:permission>
											 <pe:permission key="grant">
											<button class="btn btn-small btn-success" onclick="window.location='${BasePath}/group/toPermission?groupId=${group.id}&type=${type}&itemId=${itemId}'">权限</button>
											</pe:permission>
											</td>
									</tr>
									</c:forEach>
									</tbody>
								</table>
								<form id="myForm"  name="myForm"  action="${BasePath}/group/list" method="post">
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
						            	 	$("#myForm").submit();
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
  $(function(){
    $(".del").bind('click',function(){
      $(this).unbind();
      if(!confirm('确定删除该组么？')){
        return false;
      }
      var groupId = $(this).parent().parent().find(".groupId").text();
      var tr = $(this).parent().parent();
      $.post('${BasePath}/group/del',{
        'groupId':groupId
      },function(data){
        var obj = eval(data);
        if(obj.errno==0){
          alert('操作成功');
          tr.remove();
        }else{
          alert(obj.errdesc);
        }
      });
      
    });
    
    //
  });
</script>
