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
								<div class="muted pull-left">姐妹说推荐 添加|修改 </div>
							</div>
							
							<div class="alert alert-error" id="alertErr" style="display: none;">
							<button class="close" data-dismiss="alert">×</button>
							<strong>Error!</strong> <span id="errodesc">This is an error message.</span>
						</div>
							<div class="block-content collapse in">
								<div>
									<form class="form-horizontal" id="myform" name="myform"   action="${BasePath }/sisterPush/save"  enctype="multipart/form-data" method="post">
										<input type="hidden" id="type" name="type" value="${type }"/>
										<input type="hidden" id="id" name="id" value="${json.data.id }"/>
										<input type="hidden" id="itemId" name="itemId" value="${itemId }"/>
										<input type="hidden" id="oldPic" name="oldPic" value="${json.data.pic }"/>
										<fieldset>
<!-- 											<legend>添加精准Push</legend> -->

				                        <div class="control-group">
													<label class="control-label" for="name" style="float: left;">用户状态：</label>
													<div class="controls">
 														<label class="checkbox inline"><input type="checkbox" id="period_5"  name="period" value="5"/>通用</label>
                                               		  	<label class="checkbox inline"><input type="checkbox" id="period_0" name="period" value="0"/>记经期</label>
                                               		  	<label class="checkbox inline"><input type="checkbox" id="period_1" name="period" value="1"/>备孕</label>
                                               			<label class="checkbox inline"><input type="checkbox" id="period_2" name="period" value="2"/>怀孕中</label>
                                               		   <label class="checkbox inline"><input type="checkbox" id="period_3" name="period" value="3" />宝妈</label>
                                               		   <label class="checkbox inline"><input type="checkbox" id="period_4" name="period" value="4" />魔瘦</label>
													</div>
	                                        </div>
										<div class="control-group">
													<label class="control-label" for="name" style="float: left;">推荐位置：</label>
													<div class="controls">
													 	 <select name="place" id="place" onchange="placeChange(this)">
															  <option value="1"  <c:if test="${json.data.place==1 }">selected="selected" </c:if>  >位置1</option>
															  <option value="2"  <c:if test="${json.data.place==2 }">selected="selected" </c:if>>位置2</option>
															  <option value="3" <c:if test="${json.data.place==3 }">selected="selected" </c:if>> 位置3</option>
															</select>
													</div>
	                                        </div>
	                                    
										<div class="control-group" id="uploadDiv"  <c:if test="${json.data.place!=null &&  json.data.place!=1}">style="display: none;"</c:if>  >
												<label class="control-label" for="name" style="float: left;">上传图片：</label>
												<div class="controls">
												  <input class="input-xlarge focused" name="pic" id="pic" value="${json.data.pic }"   type="file" />图片规格：640*300
												  <br>
												  <c:if test="${json.data.pic!=null && json.data.pic!=''}">
												  	<img alt="" src="${imageHost }${json.data.pic }">
												  </c:if>
												</div>
                                            </div>
                                              <div class="control-group">
													<label class="control-label" for="name" style="float: left;">类型：
													</label>
													<div class="controls">
													<label class="radio inline"><input type="radio" name="pushType" id="type1" onclick="typeChange(this)" value="1" checked>话题</label>
													
													<label class="radio inline" id="activityRadio"> <input type="radio" name="pushType" id="type2" onclick="typeChange(this)" value="2"  <c:if test="${json.data.topicId==0 }">checked</c:if> >活动</label>
													</div>
	                                        </div>
	                                       <div class="control-group" id="topicDiv" <c:if test="${json.data.topicId!=null &&  json.data.topicId==0 }">style="display: none;"</c:if> >
												<label class="control-label" for="name" style="float: left;">Topic ID：</label>
												<div class="controls">
												  <input class="input-xlarge focused" name="topicId" id="topicId" value="${json.data.topicId }" onblur="getTopic()"   type="text" />
												</div>
                                            </div>
                                            <div class="control-group"  >
												<label class="control-label" for="name" style="float: left;">标题：</label>
												<div class="controls">
												  <input class="input-xlarge focused"  name="title" id="title"  <c:if test="${json==null || json.data.topicId>0 }">readonly</c:if> value="${json.data.title }"   type="text" />
												</div>
											</div>
                                             <div class="control-group"  id="linkDiv" 
                                              <c:choose>
											    <c:when test="${json == null || json.data.topicId > 0}">
											      	style="display:none;"
											    </c:when>
											    <c:otherwise>
											       	style="display: block;"
											    </c:otherwise>
											</c:choose>
                                             >
												<label class="control-label" for="name" style="float: left;">活动链接：</label>
												<div class="controls">
												  <input class="input-xlarge focused" name="link" id="link" value="${json.data.link }"   type="text" />
												</div>
                                            </div>
	                                     
	                                     
	                                     <div class="control-group">
												<label class="control-label" for="name" style="float: left;">客户端平台：</label>
												<div class="controls">
												<label class="checkbox inline"><input type="checkbox" id="platform_1" name="platform" value="1" />IOS</label>
												<label class="checkbox inline"><input type="checkbox" id="platform_0" name="platform" value="0" />Android</label>
												<label class="checkbox inline"><input type="checkbox" id="platform_2" name="platform" value="2" />WP</label>
												</div>
                                            </div>
                                            
                                            <div class="control-group">
												<label class="control-label" for="name" style="float: left;">同步到谷歌客户端：</label>
												<div class="controls">
													<input type="checkbox" id="toGoogle" name="toGoogle"  value="0" onchange="toGoogleChange(this)"/>
												</div>
											</div>
                                            
	                                     <div class="control-group">
												<label class="control-label" for="name" style="float: left;"></label>
												<div class="controls">
												<label class="checkbox inline"><input type="checkbox" id="flag" name="flag"  <c:if test="${json.data.flag==1 || json==null }"> checked="checked" </c:if> value="1" />同步到最热话题</label>
												</div>
                                            </div>
	                                     
										<div class="control-group">
												<label class="control-label" for="name" style="float: left;">上线时间：</label>
												<div class="controls">
												<input type="text"  class="Wdate"  id="upTime"  name="upTime"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'%y-%M-%d %H:%m:%s',readOnly:'false'})" />
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
function placeChange(obj){
	var id=obj.value;
	if(id!=1){
		$("#uploadDiv").hide();
		$("#activityRadio").hide();
		$("#type1").attr("checked",'checked');
	}else{
		$("#uploadDiv").show();
		$("#activityRadio").show();
	}
}
function typeChange(obj){
	var id=obj.value;
	if(id==1){
		$("#topicDiv").show();
		$("#linkDiv").hide();
		$("#title").attr("readonly","true");
		$("#flag").attr("checked",false);
    	$("#flag").removeAttr("disabled");
	}else{
		$("#topicDiv").hide();
		$("#linkDiv").show();
		$("#title").removeAttr("readonly");
		$("#flag").attr("checked",false);
    	$("#flag").attr("disabled","disabled");
	}
}

//验证表单数据
function checkForm(){
	var periodArry = new Array(); 
	$("input[name='period']:checked").each(function(){ 
        	var txt = $(this).val();
        	periodArry.push(txt); 
    });
	if(periodArry.length==0){
		alert("请选用户状态！");
		return false;
	}
	var oldPic=$("#oldPic").val();
	var place=$("#place").val();
	var file=$("#pic").val();
	if(place==1 && oldPic=="" &&  file==""){
		alert("请上传图片！");
		return false;
	}
	
	var pushType=$("input[name='pushType']:checked").val();
	var title=$("#title").val();
	var topicId=$("#topicId").val();
	var link=$("#link").val();
	if(title==""){
		alert("标题不能为空！");
		return false;
	}
	if(pushType==1){
		if(topicId==""){
		alert("topicId不能为空！");
		return false;
		}else if(isNaN(topicId)){
			alert("TopicId请输入数字"); 
			return false;
		}
	}

	if(pushType==2 && link==""){
		alert("活动链接不能为空！");
		return false;
	}
	var platformArry = new Array(); 
	$("input[name='platform']:checked").each(function(){ 
        	var txt = $(this).val();
        	platformArry.push(txt); 
    });
	if(platformArry.length==0){
		alert("请选择推送的客户端！");
		return false;
	}
	var startDate=$("#upTime").val();
	if(startDate=="") {
		alert("请输入上线时间！");
		return false;
	}
	return true;
}
</script>
<script >
$(function() {
	
	//setCheckBoxValue("${json.data.userStatus}", "period");	
	
	var vals="${json.data.userStatus}";
	var val = vals.split(",");
		for(var i=0;i<val.length;i++){
			$("#period_" + val[i]).attr("checked", true);
	}
	
	
	setByIdFormatTime("upTime","${json.data.startTime}");
		
	//初始化平台
	var vals="${json.data.platform}";
	if(vals!=""){
		var val = vals.split(",");
		for(var i=0;i<val.length;i++){
			$("#platform_" + val[i]).attr("checked", true);		
		}
	}
	
	$("input[name='period']").click(function (obj) {//全选
    	if(this.checked){
    			 if(this.id=='period_5'){
    				$("input[name='period']").each(function(){ 
    						if(this.id!='period_5'){
    			        	this.checked=false;
    						}
    			    });
    			} else{
     		    	  	$("input[name='period']").each(function(){ 
     		    	  		if(this.id=='period_5'){
        			        	this.checked=false;
        						}
    			      });
    		 }
    		
    	}
	});
	
	

	var toGoogle = "${json.data.toGoogle}";
	if(toGoogle == 1){
		$("#toGoogle").attr("checked", true);
		$("#toGoogle").val("1");
	}
	
});
function checkTips(obj){
	if(obj.checked){
	$('#tips').attr("disabled",false);
	}else{
		$('#tips').attr("disabled",true);
	}
	
}
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


function toGoogleChange(obj){
	if (obj.checked) {
		$("#toGoogle").val("1");
	} else {
		$("#toGoogle").val("0");
	}
}

</script>