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
								<div class="muted pull-left">回复加点赞</div>
							</div>
							
							<div class="alert alert-error" id="alertErr" style="display: none;">
							<button class="close" data-dismiss="alert">×</button>
							<strong>Error!</strong> <span id="errodesc">This is an error message.</span>
						</div>
							<div class="block-content collapse in">
								<div class="span12">
									<form class="form-horizontal" id="myForm" name="myForm"  action="${BasePath }/topic/replyLike" method="post">
										<input type="hidden" id="type" name="type" value="${type }"/>
										<input type="hidden" id="itemId" name="itemId" value="${itemId }"/>
										<fieldset>
											<legend>点赞</legend>
									<div class="control-group">
											<label class="control-label" for="majiaNick" style="float: left;">点赞者：</label>
											<div class="controls">
												<select   id="uidS"  name="uidS">
														<option  value="-1">   </option>
														<c:forEach items="${userList }" var="user">
																<c:if test="${user.nick!=null && user.nick!='' }">
																	<option  value="${user.uid}">${user.nick }</option>
																</c:if>
														</c:forEach>
												</select>   or   UID： <input class="input-xlarge focused" name="uid" id="uid"   type="text" />
											</div>
                                         </div>
                                         <div class="control-group">
												<label class="control-label" for="replyId" style="float: left;">被点赞楼层ID：</label>
												<div class="controls">
												  <input class="input-xlarge focused" name="replyId" id="replyId"   type="text"  value="${replyId }"/>
												</div>
                                            </div>
                                            
                                              <div class="control-group">
												<label class="control-label" for="num" style="float: left;">点赞数：</label>
												<div class="controls">
												  <input class="input-xlarge focused" name="num" id="num"   type="text"  />
												</div>
                                            </div>
											<div class="form-actions">
											<input type="hidden"  name="topicId"  value="${topicId }" />
											<button type="button"  onclick="submitForm()" class="btn btn-primary">保存</button>
											</div>
										</fieldset>
									</form>
								</div>
							</div>
						</div>
						<!-- /block -->
					</div>
<script>
	function submitForm(){
		var replyId=$("#replyId").val();
		var num=$("#num").val();
		if(replyId==""  ||  isNaN(replyId)){
			alert("被点赞者楼层ID不能为空！");
			return false;
		}else if(num==""  ||  isNaN(num)){
			alert("点赞数必须为数字！");
			return false;
		}
		 $('#myForm').ajaxSubmit(function(data){
	      	 if(data.errno==1){
				  $("#alertErr").show();
				  $("#errodesc").html(data.errdesc);
			  }else{
				  alert("操作成功！");
				 window.parent.closeModel();
			 }
	      });
		
	}
</script>
<jsp:include page="../include/bottom.jsp"/>
