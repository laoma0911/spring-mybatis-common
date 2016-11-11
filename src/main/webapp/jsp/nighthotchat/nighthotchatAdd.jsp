<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<jsp:include page="../include/head.jsp"/>
	<script type="text/javascript" src="${BasePath }/js/kindeditor/kindeditor-min.js"></script>
	<script type="text/javascript" src="${BasePath }/js/kindeditor/lang/zh_CN.js"></script>
<!-- Body -->
<div class="container-fluid">
						<div class="block">
							<div class="navbar navbar-inner block-header">
								<div class="muted pull-left">新增 | 修改</div>
							</div>
							<div class="alert alert-error" id="alertErr" style="display: none;">
							<button class="close" data-dismiss="alert">×</button>
							<strong>Error!</strong> <span id="errodesc">This is an error message.</span>
						</div>
							<div class="block-content collapse in">
								<div >
									<form class="form-horizontal" id="saveAti" name="saveAti" action="${BasePath }/nighthotchat/save" method="post">
									
										<input type="hidden" name="id" id="id" value="${map.id }">
									
										<input type="hidden" name="groupStatus" id="groupStatus" value="${map.status }">
									
										<div class="control-group">
											<label class="control-label" for="title" style="float: left;">小组名称：</label>
											<div class="controls">
											 	 <input class="input-xlarge focused" name="title" id="title" value="${map.title }"  type="text" <c:if test="${map.id != null}">readonly</c:if> />
											</div>
                                         </div>
                                         
                                         <div class="control-group">
											<label class="control-label" for="title" style="float: left;">排序值：</label>
											<div class="controls">
											 	 <input class="input-xlarge focused" name="displayOrder" id="displayOrder" value="${map.displayorder }"  type="text" />
											 	 (排序值越大越靠前)
											</div>
                                         </div>

										<div class="form-actions">
											<input type="button" id="btn" class="btn btn-primary" onclick="saveAT()" value="保存" />
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
<script type="text/javascript">
	function saveAT(){
		var title = $("#title").val().trim();
		var displayOrder = $("#displayOrder").val().trim();
		var groupStatus = $("#groupStatus").val().trim();
		
		if(groupStatus == 1){
			alert("小组非正常状态");
			return false;
		}
		
		if(title==""){
			alert("小组名称不能为空！");
			return false;
		}
		if(displayOrder=="" || isNaN(displayOrder)){
			alert("排序值不能为空且必须为数值！");
			return false;
		}
		
		if(displayOrder <= 0){
			alert("排序值必须大于0！");
			return false;
		}
		
		$("#btn").attr("disabled","disabled");
	       $('#saveAti').ajaxSubmit(function(data){
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
