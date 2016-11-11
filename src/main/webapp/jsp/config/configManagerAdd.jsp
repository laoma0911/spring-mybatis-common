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
								<div class="muted pull-left">配置管理</div>
							</div>
							
							<div class="alert alert-error" id="alertErr" style="display: none;">
							<button class="close" data-dismiss="alert">×</button>
							<strong>Error!</strong> <span id="errodesc">This is an error message.</span>
						</div>
							<div class="block-content collapse in">
								<div>
									<form class="form-horizontal" id="myForm" name="myForm"  action="${BasePath }/meiyue/configManager/save"   method="post">
										<input type="hidden" id="id" name="id" value="${obj.id}"/>
										<fieldset>
										 <div class="control-group">
												<label class="control-label" for="keyName" style="float: left;">名称：</label>
												<div class="controls">
												 	 <input class="input-xlarge focused" name="keyName" id="keyName" value="${obj.keyName}"   type="text" />
													<input class="input-xlarge focused"  disabled name="keyName1" id="keyName1" value="${obj.keyName}"   type="text" />
												</div>
                                          </div>
										<div class="control-group">
												<label class="control-label" for="keyValue" style="float: left;">值：</label>
												<div class="controls">
												 	 <input class="input-xlarge focused" name="keyValue" id="keyValue" value="${obj.keyValue}"   type="text" />
												</div>
                                          </div>
											<div class="control-group">
												<label class="control-label" for="remark" style="float: left;"> 备注：</label>
												<div class="controls">
													<input class="input-xlarge focused" name="remark" id="remark" value="${obj.remark}"   type="text" />
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

	if("${obj.id}"!=""){
	//	$("#keyName").attr("disabled","disabled");
	/*	$("#keyName").attr("disabled", true);*/
	//	$("#keyName").attr("disabled", "true");
		$("#keyName").hide();
		$("#keyName1").show();

	}else{
		$("#keyName1").hide();
		$("#keyName").show();
	}


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
	var keyName=$("#keyName").val();
	if(keyName==""){
		alert("名称不能为空！");
		return false;
	}
	var keyValue=$("#keyValue").val();
	if(keyValue==""){
		alert("值不能为空！");
		return false;
	}
	return true;
}
	
</script>
