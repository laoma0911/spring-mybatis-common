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
								<div class="muted pull-left">修改|新增</div>
							</div>
							
							<div class="alert alert-error" id="alertErr" style="display: none;">
							<button class="close" data-dismiss="alert">×</button>
							<strong>Error!</strong> <span id="errodesc">This is an error message.</span>
						</div>
							<div class="block-content collapse in">
								<div >
									<form class="form-horizontal" id="saveAti" name="saveAti" action="${BasePath }/calremind/save" method="post">
										<input type="hidden" id="id" name="id" value="${json.data.id }"/>
										<div class="control-group">
											<label class="control-label" for="title" style="float: left;">标题：</label>
											<div class="controls">
											 	 <input class="input-xlarge focused" name="title" id="title" value="${json.data.title }" type="text" />
											</div>
                                         </div>
                                         <div class="control-group">
											<label class="control-label" for="title" style="float: left;">链接：</label>
											<div class="controls">
											 	 <input class="input-xlarge focused" name="link" id="link" value="${json.data.link }" type="text" />
											</div>
                                         </div>
                                         <div class="control-group">
											<label class="control-label" for="title" style="float: left;">提醒时间：</label>
											<div class="controls">
											 	 <input type="text" class="Wdate" id="remindTime" name="remindTime"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',readOnly:'false'})" />
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

	$(document).ready(function(){
		setByIdFormatTime("remindTime",'${json.data.remindTime}');
	});

	function saveAT(){
		var title = $("#title").val();
		var link = $("#link").val();
		if(title==""){
			alert("活动标题不能为空！");
			return false;
		}
		if(link==""){
			alert("链接不能为空！");
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
