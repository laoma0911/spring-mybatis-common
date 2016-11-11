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
								<div class="muted pull-left">美月图标 【新增】|【修改】 </div>
							</div>
							
							<div class="alert alert-error" id="alertErr" style="display: none;">
							<button class="close" data-dismiss="alert">×</button>
							<strong>Error!</strong> <span id="errodesc">This is an error message.</span>
						</div>
							<div class="block-content collapse in">
								<div class="span12">
									<form class="form-horizontal" id="myForm" name="myForm"  action="${BasePath }/mei/save"  enctype="multipart/form-data"   method="post">
										<input type="hidden" id="type" name="type" value="${type }"/>
										<input type="hidden" id="id" name="id" value="${json.data.id }"/>
										<input type="hidden" id="itemId" name="itemId" value="${itemId }"/>
										<fieldset>
                                                <div class="control-group" id="uploadDiv"   >
												<label class="control-label" for="picNo" style="float: left;">平台：</label>
												<div class="controls">
														<select name="platform"  id="platform" >
															  <option  value="0"   <c:if test="${json.data.platform==0 }">selected="selected"</c:if>  >Android</option>
															  <option  value="1"   <c:if test="${json.data.platform==1 }">selected="selected"</c:if>  >IOS</option>
														</select>
												</div>
                                           </div>
											<div class="control-group  form-inline">
												<label class="control-label" for="type" style="float: left;">同步到谷歌客户端：</label>
												<div class="controls">
													<label class="checkbox">
														<input type="checkbox" name="toGoogle" id="toGoogle" value="1"  <c:if test="${json.data.toGoogle==1 }">checked</c:if> >
													</label>
												</div>
											</div>
                                           <div class="control-group">
												<label class="control-label" for="name" style="float: left;">显示文案：</label>
												<div class="controls">
												  <input type="text"  id="title" name="title" value="${json.data.title }"  />
												</div>
                                            </div>
                                           <div class="control-group" id="uploadDiv"   >
												<label class="control-label" for="picNo" style="float: left;">未选中状态图片：</label>
												<div class="controls">
												  <input class="input-xlarge focused" name="picNo" id="picNo" value="${json.data.picNo }"   type="file" />IOS：100*100   Android:100*1000
												  <br>
												  <c:if test="${json.data.picNo!=null && json.data.picNo!=''}">
												  	<img alt="" src="${imageHost }${json.data.picNo }">
												  </c:if>
												</div>
                                           </div>
                                           
                                           <div class="control-group" id="uploadDiv"   >
												<label class="control-label" for="picOk" style="float: left;">选中状态图片：</label>
												<div class="controls">
												  <input class="input-xlarge focused" name="picOk" id="picOk" value="${json.data.picOk }"   type="file" />IOS：100*100   Android:100*100
												  <br>
												  <c:if test="${json.data.picOk!=null && json.data.picOk!=''}">
												  	<img alt="" src="${imageHost }${json.data.picOk }">
												  </c:if>
												</div>
                                           </div>
                                           	<div class="control-group">
													<label class="control-label" for="startDate" style="float: left;">在线时间：</label>
													<div class="controls  form-inline">
														<input type="text" class="Wdate" id="startDate" name="startDate"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'endDate\')}',readOnly:'false'})" />
														至<input type="text" class="Wdate" id="endDate" name="endDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'startDate\')}',readOnly:'false'})" />
													</div>
												</div>
                                            
											<div class="form-actions">
												<button type="button" id="myBtn"  onclick="saveForm()" class="btn btn-primary">保存</button>
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
   	var id=$("#id").val();
	 var picNo=$("#picNo").val();
	 var picOk=$("#picOk").val();
	 var title=$("#title").val();
	 var startDate=$("#startDate").val();
	 var endDate=$("#endDate").val();
	 
	 if(title==""){
		 alert("请输入提示文案！");
		 return false;
	 }else if(title.length>10){
		 alert("提示文案不能超过10个字符！");
		 return false;
	 } else  if(id=="" && picNo==""){
		 alert("请上传图片！");
		 return false;
	 }else if(id=="" && picOk==""){
		 alert("请上传图片！");
		 return false;
	 }
	if(startDate==""){
		alert("请输入开始时间！");
		return false;
	}
	if(endDate==""){
		alert("请输入结束时间！");
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
<script type="text/javascript">
$(document).ready(function(){
	setByIdFormatDate("startDate",'${json.data.startDate}');
	setByIdFormatDate("endDate",'${json.data.endDate}');
}); 
</script>

