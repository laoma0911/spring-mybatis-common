<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

<jsp:include page="../include/head.jsp"/>
<!-- Body -->
<style>
body {
	padding-top: 0px;
}
</style>
<div class="container-fluid">
						<div class="block">
							<div class="navbar navbar-inner block-header">
								<div class="muted pull-left">添加用户</div>
							</div>
							<div class="alert alert-error" id="alertErr" style="display: none;">
							<button class="close" data-dismiss="alert">×</button>
							<strong>Error!</strong> <span id="errodesc">This is an error message.</span>
						</div>
							<div class="block-content collapse in">
								<div class="span12">
									<form class="form-horizontal" id="myForm" name="myForm" action="${BasePath}/user/add" method="post">
										<input type="hidden" name="uid" value="${editingUser.id }" />
										<fieldset>
											<div class="control-group">
												<label class="control-label" for="name" style="float: left;" >用户名：</label>
												<div class="controls">
												  <input class="input-xlarge focused" id="name" name="name"   type="text" value="${editingUser.name }" />
												</div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="password" style="float: left;">密码：</label>
                                                <div class="controls">
                                                  <input class="input-xlarge" id="password" name="password"
                                                         type="password" value="${editingUser.password }" />
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="nick" style="float: left;" >昵称：</label>
                                                <div class="controls">
                                                  <input class="input-xlarge" id="nick" name="nick"
                                                         type="text" value="${editingUser.nick }" />
                                                </div>
											</div>
                                            <div class="control-group">
                                              <!-- Select Basic -->
                                              <label class="control-label" for="groupId" style="float: left;">用户所属组：</label>
                                              <div class="controls">
                                                  <select class="input-xlarge" id="groupId" name="groupId">
                                                  <c:forEach items="${groupList}" var="group">
                                                      <c:choose>
                                                      	  <c:when test="${group.id == editingUser.groupId}">
                                                      	      <option value="${group.id}" selected="selected">${group.name}</option>
                                                      	  </c:when>
                                                          <c:otherwise>
                                                              <option value="${group.id}">${group.name}</option>
                                                          </c:otherwise>
                                                      </c:choose>
                                                  </c:forEach>                                                
                                                  </select>
                                              </div>
                                            </div>

                                            <div class="control-group">
                                                <label class="control-label" for="uids" style="float: left;" >大姨吗UID：</label>
                                                <div class="controls">
                                                    <input class="input-xlarge" id="uids" name="uids"   type="text" value="${editingUser.uids }" /><font color="#dc143c"> * 多个UID请用英文状态下的","隔开</font>
                                                </div>
                                            </div>

											<div class="form-actions">
												<button type="button" class="btn btn-primary"  onclick="submitForm()">保存</button>
											</div>
										</fieldset>
									</form>
								</div>
							</div>
						</div>
						<!-- /block -->
					</div>
<script type="text/javascript">
	function submitForm(){

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
<jsp:include page="../include/bottom.jsp"/>
