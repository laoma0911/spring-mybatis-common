<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

<jsp:include page="../../include/head.jsp"/>
<!-- Body -->
<div class="container-fluid">
	
						<div class="block">
							<div class="navbar navbar-inner block-header">
								<div class="muted pull-left">添加封禁用户 </div>
							</div>
							
							<div class="alert alert-error" id="alertErr" style="display: none;">
							<button class="close" data-dismiss="alert">×</button>
							<strong>Error!</strong> <span id="errodesc">This is an error message.</span>
						</div>
							<div class="block-content collapse in">
								<div class="span12">
									<form class="form-horizontal" id="myForm" name="myForm"  action="${BasePath }/meiyue/user/banUserSave" method="post">
										<input type="hidden" id="type" name="type" value="${type }"/>
										<input type="hidden" id="itemId" name="itemId" value="${itemId }"/>
										<fieldset>
											<legend>添加封禁用户</legend>
											<div class="control-group">
												<label class="control-label" for="uids" style="float: left;">UID：</label>
												<div class="controls">
												  <input class="input-xlarge focused" name="uids" id="uids"  readonly="readonly"   type="text"  value="${uid }"/>
												</div>
                                            </div>
											  <div class="control-group">
                                              <label class="control-label" for="period" style="float: left;">时间：</label>
                                              <div class="controls">
                                                  <select class="input-xlarge" id="period" name="period">
													<option value="3">3天</option>
													<option value="7">7天</option>
													<option value="15">15天</option>
													<option value="30">30天</option>
													<option value="0">永久</option>
													</select>
                                              </div>
                                            </div>						
                                  	 	<div class="control-group">
												<label class="control-label" for="remark" style="float: left;">备注：</label>
												<div class="controls">
												  <textarea class="input-xlarge focused" id="remark" name="remark"></textarea>
												</div>
                                            </div>
											<div class="form-actions">
												<button type="button" id="btn"  onclick="submitForm()" class="btn btn-success btn-small">保存</button>
											</div>
										</fieldset>
									</form>

								</div>
							</div>
						</div>
					</div>
<script>
function submitForm(){
	 var remark=$("#remark").val();
	if(remark==""){
		 $("#alertErr").show();
		  $("#errodesc").html("备注信息不能为空！");
		  $("#btn").removeAttr("disabled");
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