<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<jsp:include page="../include/head.jsp"/>
<style>
body {
	padding-top: 0px;
}
</style>
<!-- Body -->
<div class="container-fluid">
						<!-- block -->
						<div class="block">
							<div class="navbar navbar-inner block-header">
								<div class="muted pull-left">API配置 </div>
							</div>
							
							<div class="alert alert-error" id="alertErr" style="display: none;">
							<button class="close" data-dismiss="alert">×</button>
							<strong>Error!</strong> <span id="errodesc">This is an error message.</span>
						</div>
							<div class="block-content collapse in">
								<div>
									<form class="form-horizontal" id="myForm" name="myForm"  action="${BasePath }/configApis/save"   method="post">
										<input type="hidden" id="type" name="type" value="${type }"/>
										<input type="hidden" id="id" name="id" value="${json.data[0].id}"/>
										<input type="hidden" id="itemId" name="itemId" value="${itemId }"/>
										<input type="hidden" id="oldPic" name="oldPic" value="${json.data[0].picpath }"/>
										<fieldset>
										 <div class="control-group">
												<label class="control-label" for="project" style="float: left;">项目名：</label>
												<div class="controls">
												 	 <input class="input-xlarge focused" name="project" id="project" value="${obj.project}"   type="text" />
												</div>
                                          </div>
										<div class="control-group">
												<label class="control-label" for="name" style="float: left;">名字：</label>
												<div class="controls">
												 	 <input class="input-xlarge focused" name="name" id="name" value="${obj.name}"   type="text" />
												</div>
                                          </div>
											<div class="form-actions">
												<button type="button" id="btn" name="btn"   class="btn btn-primary">保存</button>
											</div>
										</fieldset>
									</form>
								</div>
							</div>
						</div>
						<!-- /block -->
					</div>
<script>
$(function () {
    $('#btn').click(function(){
    	var flag=checkForm();
    	if(flag){
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
});
});			
//检查表单
function checkForm(){
	var project=$("#project").val();
	if(project==""){
		alert("项目不能为空！");
		return false;
	}
	var name=$("#name").val();
	if(name==""){
		alert("名字不能为空！");
		return false;
	}
	return true;
}
	
</script>
