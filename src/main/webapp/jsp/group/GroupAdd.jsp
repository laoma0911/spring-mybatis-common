<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

<jsp:include page="../include/head.jsp"/>
<!-- Body -->
<style>
body {
	padding-top: 0px;
}
</style>
<div class="container-fluid">
	
						<!-- block -->
						<div class="block">
							<div class="navbar navbar-inner block-header">
								<div class="muted pull-left">添加用户组</div>
							</div>
							<div class="alert alert-error" id="alertErr" style="display: none;">
							<button class="close" data-dismiss="alert">×</button>
							<strong>Error!</strong> <span id="errodesc">This is an error message.</span>
						</div>
							<div class="block-content collapse in"> 
								<div class="span12">
									<form class="form-horizontal" name="myForm"  id="myForm" action="${BasePath}/group/save" method="post">
										<input type="hidden" name="groupId" value="${editingGroup.id }" />
										<input type="hidden" name="type" value="${type }" />
										<input type="hidden" name="itemId" value="${itemId }" />
										<fieldset>
											<legend>用户组信息</legend>
											<div class="control-group">
												<label class="control-label" for="name">用户组</label>
												<div class="controls">
													<input class="input-xlarge focused" id="groupName" name="groupName"
													       type="text" value="${editingGroup.name }">
												</div>
											</div>
											<div class="form-actions">
												<button  id="btn" type="button" class="btn btn-primary"  onclick="submitForm()">保存</button>
											</div>
										</fieldset>
									</form>

								</div>
							</div>
						</div>
						<!-- /block -->
					</div>
<script type="text/javascript">
	function submitForm(){
		var groupName=$("#groupName").val();
		if(groupName==""){
			alert("用户组名不能为空！");
			return false;
		}
   	 	 $("#btn").attr("disabled","disabled");
        $('#myForm').ajaxSubmit(function(data){
          if(data.errno==0){
        	  alert("操作成功！");
        	  window.parent.closeModel();
          }else  if(data.errno==1){
        	  $("#alertErr").show();
       		  $("#errodesc").html(data.errdesc);
       		  $("#btn").removeAttr("disabled");
          }
        });
	}
</script>
<jsp:include page="../include/bottom.jsp"/>
