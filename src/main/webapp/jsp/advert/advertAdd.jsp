<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<jsp:include page="../include/head.jsp"/>
<style>
body {
	padding-top: 0px;
}
</style>
<!-- Body -->
<div class="container-fluid">
						<!-- block -->
						<div class="block">
							<div class="navbar navbar-inner block-header">
								<div class="muted pull-left">话题管理添加|修改 </div>
							</div>
							
							<div class="alert alert-error" id="alertErr" style="display: none;">
							<button class="close" data-dismiss="alert">×</button>
							<strong>Error!</strong> <span id="errodesc">This is an error message.</span>
						</div>
							<div class="block-content collapse in">
								<div class="span12">
									<form class="form-horizontal" id="advertForm" name="advertForm"  action="${BasePath }/advert/save"  enctype="multipart/form-data" method="post">
										<input type="hidden" id="type" name="type" value="${type }"/>
										<input type="hidden" id="id" name="id" value="${json.data[0].id}"/>
										<input type="hidden" id="itemId" name="itemId" value="${itemId }"/>
										<input type="hidden" id="oldPic" name="oldPic" value="${json.data[0].picpath }"/>
										<fieldset>
										 <div class="control-group">
												<label class="control-label" for="name" style="float: left;">标题：</label>
												<div class="controls">
												 	 <input class="input-xlarge focused" name="title" id="title" value="${json.data[0].title}"   type="text" />
												</div>
                                          </div>
										
										<div class="control-group">
												<label class="control-label" for="name" style="float: left;">图片：</label>
												<div class="controls">
												  <input class="input-xlarge focused" name="pic" id="pic" value="${json.data[0].pic }"   type="file" /><font color="green">此处填入广告的图片，必须是正方形</font>
												  <br>
												  <c:if test="${json.data[0].picpath!=null && json.data[0].picpath!=''}">
												  	<img alt="" src="${json.data[0].picpath }">
												  </c:if>
												</div>
                                            </div>
										<div class="control-group">
												<label class="control-label" for="name" style="float: left;">文字说明：</label>
												<div class="controls">
												  <textarea class="input-xlarge focused" id="description" name="description" >${json.data[0].description }</textarea>
												</div>
                                            </div>
										<div class="control-group">
												<label class="control-label" for="name" style="float: left;">按钮文案：</label>
												<div class="controls">
												  <input class="input-xlarge focused" id="linktext" name="linktext" value="${json.data[0].linkText }" /><font color="green">不填写情况下不显示按钮</font>
												</div>
                                            </div>
										<div class="control-group">
												<label class="control-label" for="name" style="float: left;">链接指向：</label>
												<div class="controls">
												   <input class="input-xlarge focused" name="linkurl" id="linkurl" value="${json.data[0].linkUrl}"   type="text" />
												</div>
                                            </div>
										<div class="control-group">
												<label class="control-label" for="name" style="float: left;">曝光代码：</label>
												<div class="controls">
												  <input class="input-xlarge focused" name="exposure" id="exposure" value="${json.data[0].exposure}"   type="text" />
												</div>
                                            </div>
										 <div class="control-group">
												<label class="control-label" for="name" style="float: left;">在线时间：</label>
												<div class="controls">
													<input id="startDate" name="startDate" class="Wdate" type="text" onfocus="WdatePicker({minDate:'%y-%M-{%d}',readOnly:'false',maxDate:'#F{$dp.$D(\'endDate\')}'})"/>
													至
													<input id="endDate" name="endDate" class="Wdate" type="text" onfocus="WdatePicker({readOnly:'false',minDate:'#F{$dp.$D(\'startDate\')}'})"/>
												</div>
                                            </div>
                                            
 											<div class="control-group">
												<label class="control-label" for="name" style="float: left;">投放类型：</label>
												<div class="controls" >
												<label class="checkbox border-left:none;" >
													  <label class="radio inline"><input type="radio" name="advertType" id="type1" onclick="typeChange(this)" value="1"  <c:if test="${json.data[0].allPage==1 || json==null}">checked</c:if> >全部话题页面</label>
													   <label class="radio inline"><input type="radio" name="advertType" id="type1" onclick="typeChange(this)" value="2"   <c:if test="${json!=null &&  json.data[0].groupCatId !='' }">checked</c:if>>按小组分类投放</label>
													    <label class="radio inline"><input type="radio" name="advertType" id="type1" onclick="typeChange(this)" value="3"  <c:if test="${json != null  &&  json.data[0].keywords!=''  }">checked</c:if>>关键词投放</label>
												</label>
												</div>
                                            </div>
<!--  											<div class="control-group"  style="display: block;"> -->
<!-- 												<label class="control-label" for="name" style="float: left;">全部投放：</label> -->
<!-- 												<div class="controls" > -->
<!-- 												<label class="checkbox border-left:none;" > -->
<%-- 													<input type="checkbox"  onclick="checkAllPage(this)"  id="allpage"  <c:if test="${json.data[0].allPage==1 }">checked="checked" </c:if>  name="allpage" value="1"/>全部话题页面 --%>
<!-- 												</label> -->
<!-- 												</div> -->
<!--                                             </div> -->
 										
 											<div class="control-group" id="groupDiv"   
 											 <c:choose>
 											 	<c:when test="${json != null  &&  json.data[0].groupCatId!='' }">
											      	style="display: block;"
											    </c:when>
											    <c:otherwise>
											       	style="display: none;"
											    </c:otherwise>
											</c:choose>
 											>
												<label class="control-label" for="name" style="float: left;">按小组分类投放：</label>
												<div class="controls" >
	 											<table   style="width: 50%">
	 											<tr>
	 											  <td>
	 												<label class="checkbox"><input type="checkbox" id="group_1" name="groupIds" value="1"/>健康</label>
		                                          	<label class="checkbox"><input type="checkbox" id="group_2" name="groupIds" value="2"/>孕育</label>
		                                          	<label class="checkbox border-left:none;" ><input type="checkbox" id="group_3" name="groupIds" value="3"/>情感</label>
		                                          </td>
	 												<td>
	 													<label class="checkbox"><input type="checkbox" id="group_4" name="groupIds" value="4"/>美体护肤</label>
		                                          		<label class="checkbox"><input type="checkbox" id="group_5" name="groupIds" value="5"/>成长</label>
		                                          		<label class="checkbox"><input type="checkbox" id="group_6" name="groupIds" value="6"/>生活</label>
		                                          </td>
	 											  <td>
	 											  	<label class="checkbox"><input type="checkbox" id="group_7" name="groupIds" value="7"/>杂谈</label>
	 											    <label class="checkbox"><input type="checkbox" id="group_8" name="groupIds" value="8"/>购物</label>
	 											    <label class="checkbox"> <input type="checkbox" id="group_9" name="groupIds" value="9"/>其他</label>
	 											   </td>
	 											</tr>
	 											</table>
 											</div>
                                       </div>
											<div class="control-group" id="keyDiv"   
											<c:choose>
 											 	<c:when test="${json != null  &&  json.data[0].keywords!='' }">
											      	style="display: block;"
											    </c:when>
											    <c:otherwise>
											       	style="display: none;"
											    </c:otherwise>
											</c:choose>
											>
												<label class="control-label" for="name" style="float: left;">关键词投放：</label>
												<div class="controls">
												  <textarea class="input-xlarge focused" id="keywords" name="keywords" >${json.data[0].keywords}</textarea><font color="green">关键词以半角的逗号分隔（,）</font>
												</div>
                                            </div>
                                            <div class="control-group">
												<label class="control-label" for="name" style="float: left;">客户端平台：</label>
												<div class="controls">
													<label class="checkbox inline"> 
															<input type="checkbox" 	id="platform_android" name="platform" value="android" />Android
													</label> 
													<label class="checkbox inline"> 
														<input type="checkbox"	id="platform_iphone" name="platform" value="iphone" />IOS
													</label> 
													<label class="checkbox inline">
															 <input type="checkbox" id="platform_windowsphone" name="platform" value="windowsphone" />WP
													</label>
												</div>
											</div>

                                            <div class="control-group">
                                                <label class="control-label" for="toGoogle" style="float: left;">同步到谷歌客户端：</label>
                                                <div class="controls">
                                                    <input type="checkbox" name="toGoogle" id="toGoogle" value="1"  <c:if test="${json.data[0].toGoogle==1 }">checked</c:if> >
                                                </div>
                                            </div>

											<div class="form-actions">
												<button type="button" id="btn" name="btn"   class="btn btn-primary">保存</button>
											</div>
										</fieldset>
									</form>
								</div>
							</div>
						</div>
						<!-- /block -->
					</div>
<script>
//raido改变事件
function typeChange(obj){
	var id=obj.value;
	if(id==1){
		$("#groupDiv").hide();
		$("#keyDiv").hide();
	}else if(id==2){
		$("#groupDiv").show();
		$("#keyDiv").hide();
	}else if(id==3){
		$("#groupDiv").hide();
		$("#keyDiv").show();
	}
}


$(function () {
    $('#btn').click(function(){
    	var flag=checkForm();
    	if(flag){
    		 $("#btn").attr("disabled","disabled");
	        $('#advertForm').ajaxSubmit(function(data){
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
function checkAllPage(obj){
	if(obj.checked){
		$("input[name='groupIds']").each(function(){ 
        	$("#group_"+this.value).attr("checked",false);
        	$("#group_"+this.value).attr("disabled","disabled");
   		 });
		$("#keywords").val("");
		$("#keywords").attr("disabled","disabled");
	}else{
		$("input[name='groupIds']").each(function(){ 
			$("#group_"+this.value).removeAttr("disabled");
   		 });
		$("#keywords").removeAttr("disabled");
	}
	
}

function checkForm(){
	var title=$("#title").val();
	if(title==""){
		alert("标题不能为空！");
		return false;
	}
	var id=$("#id").val();
	var pic=$("#pic").val();
	if(id=="" && pic==""){
		alert("请上传图片");
		return  false;
	}
	var description=$("#description").val();
	if(description==""){
		alert("文案说明不能为空！");
		return false;
	}
// 	var linktext=$("#linktext").val();
// 	if(linktext==""){
// 		alert("按钮文案不能为空！");
// 		return false;
// 	}
	var linkurl=$("#linkurl").val();
	if(linkurl==""){
		alert("按钮指向不能为空！");
		return false;
	}
// 	var exposure=$("#exposure").val();
// 	if(exposure==""){
// 		alert("曝光代码不能为空！");
// 		return false;
// 	}
	var linkurl=$("#linkurl").val();
	if(linkurl==""){
		alert("按钮指向不能为空！");
		return false;
	}
	var startDate=$("#startDate").val();
	if(startDate=="") {
		alert("请输入在线开始时间！");
		return false;
	}
	var endDate=$("#endDate").val();
	if(endDate=="") {
		alert("请输入在线结束时间！");
		return false;
	}
	var type=$("input[name='advertType']:checked").val();
	if(type==3){
		var keywords=$("#keywords").val();
		if(keywords==""){
			alert("关键词不能为空！");
			return false;
		}else if(keywords.length>600){
			alert("关键词长度不能超过600字符！");
			return false;
		}
   }else if(type==2){
		var groupIds = new Array(); 
		$("input[name='groupIds']:checked").each(function(){ 
			var txt = $(this).val();
			groupIds.push(txt); 
	    });
		if(groupIds.length==0){
			alert("请选择小组分类！");
			return false;
			}
	   }
	var platformArry = new Array();
	$("input[name='platform']:checked").each(function() {
		var txt = $(this).val();
		platformArry.push(txt);
	});
	if (platformArry.length == 0) {
		alert("请选择推送的客户端！");
		return false;
	}
	return true;
}
</script>
<jsp:include page="../include/bottom.jsp"/>
<script type="text/javascript">
$(document).ready(function(){
	setCheckBoxValue("${json.data[0].groupCatId}", "group");	
	setByIdFormatDate("startDate","${json.data[0].fromDate}");
	setByIdFormatDate("endDate","${json.data[0].toDate}");
	
	var vals = "${json.data[0].platform}";
	if (vals == "") {
		$("input[name='platform']").each(function() {
			this.checked = true;
		});
	} else {
		var val = vals.split(",");
		for (var i = 0; i < val.length; i++) {
			$("#platform_" + val[i]).attr("checked", true);
		}
	}
	
	
    $("input[name='feature']").click(function (obj) {//全选
    	if(this.checked){
    		 if(this.checked){
    			 if(this.id=='feature_1'){
	    			  if(confirm("选择\"孕期用户\"后\"经期阶段\"将不能选择，确定吗？ ")){
			    				  $("input[name='period']").each(function(){ 
			    			        	$("#period_"+this.value).attr("checked",false);
			    			        	$("#period_"+this.value).attr("disabled","disabled");
			    			    });
	  		     	 } 
    		}
    		 else{
     		    	  	if ($("input[id='feature_1']:checked").val()!=1){
		     		    	  	$("input[name='period']").each(function(){ 
		    			        	$("#period_"+this.value).removeAttr("disabled");
		    			    });
     		    	  	}
    		 }
    		
    	}
    }else if(this.id=='feature_1'){
    	$("input[name='period']").each(function(){ 
        	$("#period_"+this.value).removeAttr("disabled");
    });
    }
    
    }); 
 
});  
</script>

