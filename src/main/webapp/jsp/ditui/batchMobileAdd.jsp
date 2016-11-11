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
								<div class="muted pull-left">批量导入</div>
							</div>
							
							<div class="alert alert-error" id="alertErr" style="display: none;">
							<button class="close" data-dismiss="alert">×</button>
							<strong>Error!</strong> <span id="errodesc">This is an error message.</span>
						</div>
							<div class="block-content collapse in">
								<div>
									<form class="form-horizontal" id="myform" name="myform"   action="${BasePath }/ditui/saveMobile"  enctype="multipart/form-data" method="post">
										<input type="hidden" id="type" name="type" value="${type }"/>
										<input type="hidden" id="itemId" name="itemId" value="${itemId }"/>
										<fieldset>
	
										<div class="control-group">
			                                <label class="control-label" for="id" style="float: left;">渠道名称：</label>
													<div class="controls">
													 	   <select name="id"  id="id"  >
							                                    <c:forEach items="${dituiOrgList}" var="org">
							                                        <option  value="${org.id}">${org.name}(${org.mobile})</option>
							                                    </c:forEach>
			                                				</select>
													</div>
		                                </div>
										<div class="control-group" id="uploadDiv"   >
												<label class="control-label" for="file" style="float: left;">上传文件：</label>
												<div class="controls">
												  <input class="input-xlarge focused" name="file" id="file" value="${json.data.file }" type="file" />
													<div class="alert-info">文本文件TXT(每行一条手机号)</div>
												  <br>
												 <!--  <c:if test="${json.data.file!=null && json.data.file!=''}">
												  	<img alt="" src="${imageHost }${json.data.file }">
												  </c:if> -->
												</div>
                                            </div>
	                                     
	                                     
											<div class="form-actions">
												<button type="button" id="btn" name="btn"   class="btn btn-primary">保存</button>
<!-- 												<button type="submit"   class="btn btn-primary">保存</button> -->
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
	
	var file=$("#file").val();
	if(file==""){
		alert("请上传文件！");
		return false;
	}
	

	
	return true;
}
</script>
<script >
$(function() {
	
	
	
});
//根据Topic id获取Titile
function getTopic(){
		var id=$("#topicId").val();
			if(id==""){
				$("#alertErr").show();
				  $("#title").val("");
				  $("#errodesc").html("topicId不能为空！");
				return false;
			}else if(isNaN(id)){
				$("#alertErr").show();
				  $("#title").val("");
				  $("#errodesc").html("TopicId请输入数字!");
				return false;
			}
		$.ajax({
		 type:"POST",
		 url:"${BasePath }/sisterPush/getTopic?id="+id,
		 datatype: "json",
		 success:function(data){
			  if(data.errno==1){
				  $("#alertErr").show();
				  $("#title").val("");
				  $("#errodesc").html(data.errdesc);
			  }else{
				  if(data.data.title==null || data.data.title==""){
					  $("#alertErr").show();
					  $("#title").val("");
					  $("#errodesc").html("话题的标题为空！");
				  }else{
					  $("#alertErr").hide();
				  $("#title").val(data.data.title);
				  }
			 }
		 } ,
		 error: function(){
		   alert("操作出错，请联系管理员！");
		 }         
		});
}

</script>
