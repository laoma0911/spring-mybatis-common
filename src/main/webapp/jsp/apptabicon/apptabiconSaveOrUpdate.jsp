<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<jsp:include page="../include/head.jsp"/>
	<script type="text/javascript" src="${BasePath }/js/kindeditor/kindeditor-min.js"></script>
	<script type="text/javascript" src="${BasePath }/js/kindeditor/lang/zh_CN.js"></script>
<!-- Body -->
<style>
    body{
        padding-top: 0px;
    }
</style>
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
									<form class="form-horizontal" id="saveAti" name="saveAti" action="${BasePath }/apptabicon/save" enctype="multipart/form-data" method="post">
										<input type="hidden" id="ativId" name="ativId" value="${ativ.id }"/>
										<div class="control-group">
											<label class="control-label" for="title" style="float: left;">标题：</label>
											<div class="controls">
											 	 <input class="input-xlarge focused" name="title" id="title" value="${ativ.title }" type="text" />
											</div>
                                         </div>

<!-- 										<div class="control-group"> -->
<!-- 											<label class="control-label" for="title" style="float: left;">icon：</label> -->
<!-- 											<div class="controls"> -->
<%-- 											 	 <input class="input-xlarge focused" name="icon" id="icon" value="${ativ.icon }" type="text" /> --%>
<!-- 											</div> -->
<!--                                          </div> -->
                                         
                                         <div class="control-group" id="uploadDiv" >
												<label class="control-label" for="name" style="float: left;">上传图片：</label>
												<div class="controls">
												  <input class="input-xlarge focused" name="icon" id="icon" value="${ativ.icon }"   type="file" />
												  <br>
												  <c:if test="${ativ.icon!=null && ativ.icon!=''}">
												  	<img alt="" src="${imageHost }${ativ.icon }">
												  </c:if>
												</div>
                                         </div>


                                         <div class="control-group">
											<label class="control-label" for="title" style="float: left;">链接：</label>
											<div class="controls">
											 	 <input class="input-xlarge focused" name="link" id="link" value="${ativ.link }" type="text" />
											</div>
                                         </div>

                                        <div class="control-group">
                                            <label class="control-label" for="startDate" style="float: left;">开始时间：</label>
                                            <div class="controls  form-inline">
                                                <input type="text" class="Wdate" id="startDate" name="startDate"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'endDate\')}',readOnly:'false'})" />
                                                至
                                                <input type="text" class="Wdate" id="endDate" name="endDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'startDate\')}',readOnly:'false'})" />
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
		var title = $("#title").val();
// 		var icon = $("#icon").val();
		var link = $("#link").val();
		if(title==""){
			alert("活动标题不能为空！");
			return false;
		}
// 		if(icon==""){
// 			alert("icon不能为空！");
// 			return false;
// 		}
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

    //格式化时间
    $(document).ready(function(){
        setByIdFormatTime("startDate",'${ativ.startTime}');
        setByIdFormatTime("endDate",'${ativ.endTime}');
    });

</script>
