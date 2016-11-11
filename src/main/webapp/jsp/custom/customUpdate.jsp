<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

<jsp:include page="../include/top.jsp"/>
<!-- Body -->
<div class="container-fluid">
	<div class="row-fluid">
		<!-- Menu -->
		<jsp:include page="../include/menu.jsp"></jsp:include>
		<div class="span9" id="content">
			<jsp:include page="../include/location.jsp"></jsp:include>
			<div class="row-fluid">
				<div class="span9" id="content">
					<!-- morris stacked chart -->
					<div class="row-fluid">
						<!-- block -->
						<div class="block">
							<div class="navbar navbar-inner block-header">
								<div class="muted pull-left">添加URL</div>
							</div>
							
							<div class="alert alert-error" id="alertErr" style="display: none;">
							<button class="close" data-dismiss="alert">×</button>
							<strong>Error!</strong> <span id="errodesc">This is an error message.</span>
						</div>
							<div class="block-content collapse in">
								<div class="span12">
									<form class="form-horizontal" id="saveCustom" name="saveCustom"  action="${BasePath }/custom/save" method="post">
										<input type="hidden" id="type" name="type" value="${type }"/>
										<input type="hidden" id="itemId" name="itemId" value="${itemId }"/>
										<input type="hidden" id="uid" name="uid" value="${uid }"/>
										<fieldset>
											<legend>修改用户信息</legend>
											<div class="control-group">
												<label class="control-label" for="name" style="float: left;">昵称*</label>
												<div class="controls">
												  <input class="input-xlarge focused" name="nick" id="nick"  value="${nick }"  type="text" />
												</div>
                                            </div>
											
											  <div class="control-group">
                                              <label class="control-label" for="groupId" style="float: left;">用户组：</label>
                                              <div class="controls">
                                                  <select class="input-xlarge" id="group_id" name="group_id">
                                                  	<c:choose> <c:when test="${group_id=='0'}">
															<option value="0" selected="selected">普通</option>
													</c:when> <c:otherwise>
															<option value="0">普通</option>
													</c:otherwise></c:choose>
													<c:choose> <c:when test="${group_id=='1'}">
															<option value="1" selected="selected">官方</option>
													</c:when> <c:otherwise>
															<option value="1">官方</option>
													</c:otherwise></c:choose>
													<c:choose> <c:when test="${group_id=='2'}">
															<option value="2" selected="selected">监控</option>
													</c:when> <c:otherwise>
															<option value="2">监控</option>
													</c:otherwise></c:choose>
													<c:choose> <c:when test="${group_id=='3'}">
															<option value="3" selected="selected">VIP</option>
													</c:when> <c:otherwise>
															<option value="3">VIP</option>
													</c:otherwise></c:choose>
													<c:choose> <c:when test="${group_id=='10'}">
															<option value="10" selected="selected">美容控</option>
													</c:when> <c:otherwise>
															<option value="10">美容控</option>
													</c:otherwise></c:choose>
													<c:choose> <c:when test="${group_id=='11'}">
															<option value="11" selected="selected">美体狂人</option>
													</c:when> <c:otherwise>
															<option value="11">美体狂人</option>
													</c:otherwise></c:choose>
													<c:choose> <c:when test="${group_id=='12'}">
															<option value="12" selected="selected">知心MM</option>
													</c:when> <c:otherwise>
															<option value="12">知心MM</option>
													</c:otherwise></c:choose>
													<c:choose> <c:when test="${group_id=='13'}">
															<option value="13" selected="selected">占星师</option>
													</c:when> <c:otherwise>
															<option value="13">占星师</option>
													</c:otherwise></c:choose>
													<c:choose> <c:when test="${group_id=='14'}">
															<option value="14" selected="selected">健康达人</option>
													</c:when> <c:otherwise>
															<option value="14">健康达人</option>
													</c:otherwise></c:choose>
													<c:choose> <c:when test="${group_id=='15'}">
															<option value="15" selected="selected">超级妈咪</option>
													</c:when> <c:otherwise>
															<option value="15">超级妈咪</option>
													</c:otherwise></c:choose>
													<c:choose> <c:when test="${group_id=='16'}">
															<option value="16" selected="selected">灌水王</option>
													</c:when> <c:otherwise>
															<option value="16">灌水王</option>
													</c:otherwise></c:choose>
													<c:choose> <c:when test="${group_id=='17'}">
															<option value="17" selected="selected">关注中</option>
													</c:when> <c:otherwise>
															<option value="17">关注中</option>
													</c:otherwise></c:choose>
													<c:choose> <c:when test="${group_id=='18'}">
															<option value="18" selected="selected">两性</option>
													</c:when> <c:otherwise>
															<option value="18">两性</option>
													</c:otherwise></c:choose>
													</select>
                                              </div>
                                            </div>
											<div class="control-group">
                                              <label class="control-label" for="groupId" style="float: left;">性别：</label>
                                              <div class="controls">
                                                  <select class="input-xlarge" id="sex" name="sex">
                                                  		<c:choose> <c:when test="${sex=='1'}">
																<option value="1" selected="selected">男</option>
														</c:when> <c:otherwise>
																<option value="1">男</option>
														</c:otherwise></c:choose>
														<c:choose> <c:when test="${sex=='0'}">
																<option value="0" selected="selected">女</option>
														</c:when> <c:otherwise>
																<option value="0">女</option>
														</c:otherwise></c:choose>
													</select>
                                              </div>
                                            </div>
											<div class="control-group">
												<label class="control-label" for="name" style="float: left;">密码*：</label>
												<div class="controls">
												  <input class="input-xlarge focused" id="pass1" name="pass1"  type="password"  />
												</div>
                                            </div>
                                            <div class="control-group">
												<label class="control-label" for="name" style="float: left;">密码*：</label>
												<div class="controls">
												  <input class="input-xlarge focused" id="pass2" name="pass2"  type="password"  />
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
				</div>
			</div>
		</div>
	</div>
</div>
<script>
function saveCustom11(){
	 var nick=$("#nick").val();
	 var group_id=$("#group_id").val();
	 var pass1=$("#pass1").val();
	 var pass2=$("#pass2").val();
	 var remark=$("#remark").val();
	 var sex=$("#sex").val();
	 var uid=$("#uid").val();
	 
	 if(nick==""){
		 alert("昵称不能为空！");
		 return;
	 }
	 if(pass1=="" || pass2==""){
		 alert("密码不能为空！");
		 return;
	 }else if(pass1!=pass2){
		 alert("密码不一置！");
		 return;
	 }
	 
		$("#saveCustom").submit(function() {
			  alert($(this).serialize());
			  return false;
		});
		var path="${BasePath }/custom/update?uid="+uid+"&nick="+nick+"&group_id="+group_id+"&pass="+pass1+"&remark="+remark+"&sex="+sex;
		path=encodeURI(path);
		path=encodeURI(path); 
	  $.ajax({
          type:"POST",
        //  contentType: "application/x-www-form-urlencoded; charset=utf-8", 
          url:path,
          datatype: "json",
          success:function(data){
        	  if(data.errno==1){
        		  $("#alertErr").show();
        		  $("#errodesc").html(data.errdesc);
        	  }else{
        		  alert("修改用户成功");
       			 window.location.href="${BasePath}/custom/userList?type=4&itemId=20";
			 }
          } ,
          error: function(){
            alert("操作出错，请联系管理员！");
          }         
       });
	  }

</script>
<jsp:include page="../include/bottom.jsp"/>
