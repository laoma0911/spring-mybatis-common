<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

<jsp:include page="../../include/head.jsp"/>
<!-- Body -->
<div class="container-fluid">
						<div class="block">
							<div class="navbar navbar-inner block-header">
								<div class="muted pull-left">添加封禁设备 </div>
							</div>
							<div class="alert alert-error" id="alertErr" style="display: none;">
							<button class="close" data-dismiss="alert">×</button>
							<strong>Error!</strong> <span id="errodesc">This is an error message.</span>
						</div>
							<div class="block-content collapse in">
								<div class="span12">
									<form class="form-horizontal" id="saveCustom" name="saveCustom"  action="${BasePath }/meiyue/user/save" method="post">
										<input type="hidden" id="type" name="type" value="${type }"/>
										<input type="hidden" id="itemId" name="itemId" value="${itemId }"/>
										<fieldset>
											<legend>添加封禁设备</legend>
											<div class="control-group">
												<label class="control-label" for="name" style="float: left;">设备：</label>
												<div class="controls">
												  <input class="input-xlarge focused" name="device" id="device"  readonly="readonly"  type="text"  value="${device }" />
												</div>
                                            </div>
											  <div class="control-group">
                                              <label class="control-label" for="groupId" style="float: left;">时间：</label>
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
												<label class="control-label" for="name" style="float: left;">备注：</label>
												<div class="controls">
												  <textarea class="input-xlarge focused" id="remark" name="remark"></textarea>
												</div>
                                            </div>
											<div class="form-actions">
												<button type="button"  onclick="saveCustom11()" class="btn btn-primary">保存</button>
											</div>
										</fieldset>
									</form>

								</div>
							</div>
						</div>
						<!-- /block -->
					</div>
<script>
function saveCustom11(){
	 var device=$("#device").val();
	 var period=$("#period").val();
	 var remark=$("#remark").val();
	 
	 if(device==""){
		 alert("设备不能为空！");
		 return;
	 }
	$("#saveCustom").submit(function() {
			  alert($(this).serialize());
			  return false;
		});
		var path="${BasePath }/meiyue/user/banDeviceSave?device="+device+"&period="+period+"&remark="+remark;
		path=encodeURI(path);
		path=encodeURI(path); 
	  $.ajax({
          type:"POST",
          url:path,
          datatype: "json",
          success:function(data){
        	  if(data.errno==1){
        		  $("#alertErr").show();
        		  $("#errodesc").html(data.errdesc);
        	  }else{
       			 window.location.reload(true);
			 }
          } ,
          error: function(){
            alert("操作出错，请联系管理员！");
          }         
       });
	}
</script>
<jsp:include page="../../include/bottom.jsp"/>
