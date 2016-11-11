<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

<jsp:include page="../include/head.jsp"/>
<!-- Body -->
<div class="container-fluid">
						<div class="block">
							<div class="navbar navbar-inner block-header">
								<div class="muted pull-left">添加域名</div>
							</div>
														<div class="alert alert-error" id="alertErr" style="display: none;">
							<button class="close" data-dismiss="alert">×</button>
							<strong>Error!</strong> <span id="errodesc">This is an error message.</span>
						</div>
							<div class="block-content collapse in">
								<div >
									<form class="form-horizontal"  method="post">
										<input type="hidden" id="id" name="id" value="${json.data.id }" />
										<input type="hidden" id="type" name="type" value="${type }"/>
										<input type="hidden" id="itemId" name="itemId" value="${itemId }"/>
										<fieldset>
											<legend>域名信息</legend>
											<div class="control-group">
												<label class="control-label" for="name" style="float: left;">域名</label>
												<div class="controls">
												  <input class="input-xlarge focused" id="domain" name="domain" type="text" value="${json.data.domain }" />
												</div>
                                            </div>
											<div class="form-actions">
												<button type="button" class="btn btn-primary"  onclick="saveDomain()">保存</button>
											</div>
										</fieldset>
									</form>

								</div>
							</div>
						</div>
						<!-- /block -->
					</div>
<script>
function saveDomain(){
	 var id = $("#id").val();
	 var domain=$("#domain").val();
	 if(domain==""){
		 alert("域名不能为空！");
		 return;
	 }
	  $.ajax({
          type:"POST",
          url:"${BasePath }/domain/save?domain="+domain+"&id="+id,
          datatype: "json",
          success:function(data){
        	  if(data.errno==1){
        		  $("#alertErr").show();
        		  $("#errodesc").html(data.errdesc);
        	  }else if(data.errno==0){
        		  alert("操作成功！");
        	  }
          } ,
          error: function(){
            alert("操作出错，请联系管理员！");
          }         
       });
	  }


</script>