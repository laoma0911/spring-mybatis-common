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
						<!-- block -->
						<div class="block">
							<div class="navbar navbar-inner block-header">
								<div class="muted pull-left">添加 | 修改 用户 </div>
							</div>
							<div class="alert alert-error" id="alertErr" style="display: none;">
							<button class="close" data-dismiss="alert">×</button>
							<strong>Error!</strong> <span id="errodesc">This is an error message.</span>
						</div>
							<div class="block-content collapse in">
								<div class="span12">
									<form class="form-horizontal" id="myForm" name="myForm"  action="${BasePath }/koluser/save"   method="post">
										<input type="hidden" id="type" name="type" value="${type }"/>
										<input type="hidden" id="id" name="id" value="${obj.id }"/>
										<input type="hidden" id="itemId" name="itemId" value="${itemId }"/>
										<fieldset>
                                               <div class="control-group">
                                                   <label class="control-label"  style="float: left;">用户名：</label>
                                                   <div class="controls">
                                                       <input type="text"  id="nick" name="nick"  value="${obj.nick}"/>
                                                   </div>
                                               </div>
                                               
                                               <div class="control-group">
                                                   <label class="control-label"  style="float: left;">密码：</label>
                                                   <div class="controls">
                                                       <input type="text"  id="password" name="password"  value="${obj.password}"/>
                                                   </div>
                                               </div>
                                               
                                               <div class="control-group">
                                                   <label class="control-label"  style="float: left;">公众号：</label>
                                                   <div class="controls">
                                                       <input type="text"  id="publicNum" name="publicNum"  value="${obj.publicNum}"/>
                                                   </div>
                                               </div>
                                               
                                               <div class="control-group">
                                                   <label class="control-label"  style="float: left;">绑定UID：</label>
                                                   <div class="controls">
                                                       <input type="text"  id="bindUid" name="bindUid"  value="${obj.bindUid}"/>
                                                   </div>
                                               </div>
                                               
                                               <div class="control-group">
                                                   <label class="control-label"  style="float: left;">绑定小组ID：</label>
                                                   <div class="controls">
                                                       <input type="text"  id="bindGroupId" name="bindGroupId"  value="${obj.bindGroupId}"/>
                                                   </div>
                                               </div>

											<div class="form-actions">
												<button type="button" id="myBtn"  onclick="saveForm()" class="btn btn-primary">确定</button>
											</div>
										</fieldset>
									</form>
                                </div>
							</div>
						</div>
						<!-- /block -->
					</div>
<script>
function saveForm(){
    var nick=$("#nick").val();
    var password=$("#password").val();
    var publicNum=$("#publicNum").val();
    var bindUid=$("#bindUid").val();
    var bindGroupId=$("#bindGroupId").val();
    
    if(nick.trim()==''){
        alert("用户名不能为空！");
        return false;
    }
    if(password.trim()==''){
        alert("密码不能为空！");
        return false;
    }
    if(publicNum.trim()==''){
        alert("公众号不能为空！");
        return false;
    }
    if (bindUid.trim == "" || isNaN(bindUid)) {
        alert("绑定UID不能为空且必须为数字！");
        return false;
    }
    if (bindGroupId.trim == "" || isNaN(bindGroupId)) {
        alert("绑定小组ID不能为空且必须为数字！");
        return false;
    }
    
	 $("#myBtn").attr("disabled","disabled");
     $('#myForm').ajaxSubmit(function(data){
    	 if(data.errno==1){
	   		  $("#alertErr").show();
	   		  $("#errodesc").html(data.errdesc);
	   		  $("#myBtn").removeAttr("disabled");
   	 	 }else{
			 alert("操作成功！");
			 window.parent.closeModel();
		 }
     });
 }
</script>

