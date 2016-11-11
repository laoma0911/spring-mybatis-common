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
								<div class="muted pull-left">渠道配置 添加</div>
							</div>
							
							<div class="alert alert-error" id="alertErr" style="display: none;">
							<button class="close" data-dismiss="alert">×</button>
							<strong>Error!</strong> <span id="errodesc">This is an error message.</span>
						</div>
							<div class="block-content collapse in">
								<div >
									<form class="form-horizontal" id="myform" name="myform"   action="${BasePath }/configChannels/save"  enctype="multipart/form-data" method="post">
										<input type="hidden" id="type" name="type" value="${type }"/>
										<input type="hidden" id="itemId" name="itemId" value="${itemId }"/>
										<fieldset>

	                                    
	                                       <div class="control-group" id="topicDiv" >
												<label class="control-label" for="name" style="float: left;">名称：</label>
												<div class="controls">
													<input class="input-xlarge focused" name="name" id="name" value=""   type="text" />
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
//ajax提交表单
$(function () {
    $('#btn').click(function(){
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
});
});	
</script>
