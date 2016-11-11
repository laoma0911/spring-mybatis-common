<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<jsp:include page="../include/head.jsp"/>
	<style>
		body{
			padding-top: 0px;
		}	
	</style>
<!-- Body -->
<div class="container-fluid">
						<div class="block">
							<div class="navbar navbar-inner block-header">
								<div class="muted pull-left">地推渠道 添加|修改 </div>
							</div>
							
							<div class="alert alert-error" id="alertErr" style="display: none;">
							<button class="close" data-dismiss="alert">×</button>
							<strong>Error!</strong> <span id="errodesc">This is an error message.</span>
						</div>
							<div class="block-content collapse in">
								<div>
									<form class="form-horizontal" id="myform" name="myform"   action="${BasePath }/ditui/save"  enctype="multipart/form-data" method="post">
										<input type="hidden" id="id" name="id" value="${json.data.id }"/>
										<fieldset>
	                                       <div class="control-group" id="topicDiv"  >
												<label class="control-label" for="name" style="float: left;">渠道名称：</label>
												<div class="controls">
												  <input class="input-xlarge focused" name="name" id="name" value="${json.data.name }" type="text" />
												</div>
												<label class="control-label" for="linkman" style="float: left;">联系人：</label>
												<div class="controls">
												  <input class="input-xlarge focused" name="linkman" id="linkman" value="${json.data.linkman }"   type="text" />
												</div>
												<label class="control-label" for="mobile" style="float: left;">联系电话：</label>
												<div class="controls">
												  <input class="input-xlarge focused" name="mobile" id="mobile" value="${json.data.mobile }"   type="text" />
												</div>
										   </div>
											<div class="form-actions">
												<button type="button" id="btn" name="btn" class="btn btn-primary">保存</button>
											</div>
										</fieldset>
									</form>
								</div>
							</div>
						</div>
						<!-- /block -->
					</div>
<script>
//ajax提交表单
$(function () {
    $('#btn').click(function(){
    	var flag=checkForm();
    	if(flag){
    		$("#btn").attr("disabled","disabled");
    	    $('#myform').ajaxSubmit(function(data){
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

//验证表单数据
function checkForm(){
	var name=$("#name").val();
	var linkman=$("#linkman").val();
	var mobile=$("#mobile").val();
	if(name.trim()==""){
		alert("请输入有效的组织名称");
		return false;
	}
	if(linkman.trim()==""){
		alert("请输入联系人");
		return false;
	}
	if(mobile.trim()==""){
		alert("请输入联系电话");
		return false;
		}else if(isNaN(mobile)){
			alert("联系电话请输入数字"); 
			return false;
	}
	return true;
}
</script>

