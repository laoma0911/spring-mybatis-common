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
								<div class="muted pull-left">推广卡片 【新增】|【修改】 </div>
							</div>
							
							<div class="alert alert-error" id="alertErr" style="display: none;">
							<button class="close" data-dismiss="alert">×</button>
							<strong>Error!</strong> <span id="errodesc">This is an error message.</span>
						</div>
							<div class="block-content collapse in">
								<div class="span12">
									<form class="form-horizontal" id="myForm" name="myForm"  action="${BasePath }/card/save"  enctype="multipart/form-data"   method="post">
										<input type="hidden" id="type" name="type" value="${type }"/>
										<input type="hidden" id="id" name="id" value="${json.data.id }"/>
										<input type="hidden" id="itemId" name="itemId" value="${itemId }"/>
										<fieldset>
                                        <div class="control-group  form-inline">
												<label class="control-label" for="status1" style="float: left;">  
													<label class="checkbox">
												   		 <input type="checkbox"  name="status"   id="status_0"  value="0" >全部
												  </label>
												  </label>
												<div class="controls">
												 
												  <label class="checkbox" >
												   		 <input type="checkbox"   name="status"   id="status_1"  value="1">记经期
												  </label>
												   <label class="checkbox">
												   		 <input type="checkbox"  name="status"   id="status_2"  value="2" >备孕
												  </label>
												  <label class="checkbox">
												   		 <input type="checkbox"   name="status"   id="status_3"  value="3">怀孕中
												  </label>												  
												   <label class="checkbox">
												   		 <input type="checkbox"   name="status"   id="status_4"  value="4">宝妈
												  </label>
												  <label class="checkbox">
												   		 <input type="checkbox" name="status"   id="status_5"  value="5">魔瘦
												  </label>												 	 
												</div>
                                            </div>
                                            
                                            <div class="control-group  form-inline">
												<label class="control-label" for="status1" style="float: left;">
												  <label class="checkbox">
												   		 <input type="checkbox"  name="age"   id="age_0"  value="0" >全部
												  </label>
												  </label>
												<div class="controls">
												 
												  <label class="checkbox" >
												   		 <input type="checkbox"   name="age"   id="age_1"  value="1">14-21岁
												  </label>
												   <label class="checkbox">
												   		 <input type="checkbox"  name="age"   id="age_2"  value="2" >22-28岁
												  </label>
												  <label class="checkbox">
												   		 <input type="checkbox"   name="age"   id="age_3"  value="3">29-35岁
												  </label>												  
												   <label class="checkbox">
												   		 <input type="checkbox"   name="age"   id="age_4"  value="4">36岁以上
												  </label>
												</div>
                                            </div>
                                           <div class="control-group" id="uploadDiv"   >
												<label class="control-label" for="pic" style="float: left;">上传图片：</label>
												<div class="controls">
												  <input class="input-xlarge focused" name="pic" id="pic" value="${json.data.pic }"   type="file" />图片规格：500*500
												  <br>
												  <c:if test="${json.data.pic!=null && json.data.pic!=''}">
												  	<img alt="" src="${imageHost }${json.data.pic }"  width="80px"  height="80px">
												  </c:if>
												</div>
                                           </div>
                                            
										<div class="control-group">
												<label class="control-label" for="name" style="float: left;">软件名称：</label>
												<div class="controls">
												  <input type="text"  id="name" name="name" value="${json.data.name }"  />
												</div>
                                            </div>
											<div class="control-group">
												<label class="control-label" for="content" style="float: left;">软件说明：</label>
												<div class="controls">
												 <textarea class="input-xlarge focused"  name="content"  id="content">${json.data.content }</textarea>
												</div>
                                            </div>
                                           <div class="control-group">
												<label class="control-label" for="linkText" style="float: left;">按钮文案：</label>
												<div class="controls">
												 <input type="text"  id="linkText" name="linkText" value="${json.data.linkText }"  />
												</div>
                                            </div>
                                             <div class="control-group"   >
												<label class="control-label" for="type" style="float: left;">链接类型：</label>
												<div class="controls">
														<select name="typeBtn"  id="typeBtn" >
															  <option  value="1"   <c:if test="${json.data.type==1 }">selected="selected"</c:if>  >下载</option>
															   <option  value="0"   <c:if test="${json.data.type==0 }">selected="selected"</c:if>  >网页</option>
														</select>
												</div>
                                           </div>
                                           <div class="control-group">
												<label class="control-label" for="iosUrl" style="float: left;">IOS链接：</label>
												<div class="controls">
												<input type="text"  id="iosUrl"  name="iosUrl" value="${json.data.iosUrl}"  />
												</div>
                                            </div>
                                            
                                             <div class="control-group">
												<label class="control-label" for="androidUrl" style="float: left;">Android链接：</label>
												<div class="controls">
												<input type="text"  id="androidUrl"  name="androidUrl" value="${json.data.androidUrl}"  />
												</div>
                                            </div>

                                            <div class="control-group">
                                                <label class="control-label" for="toGoogle" style="float: left;">同步到谷歌客户端：</label>
                                                <div class="controls">
                                                    <input type="checkbox" name="toGoogle" id="toGoogle" value="1"  <c:if test="${json.data.toGoogle==1}">checked</c:if> >
                                                </div>
                                            </div>

                                           	<div class="control-group">
													<label class="control-label" for="startDate" style="float: left;">开始时间：</label>
													<div class="controls  form-inline">
														<input type="text" class="Wdate" id="startDate" name="startDate"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'endDate\')}',readOnly:'false'})" />
													</div>
													<label class="control-label" for="name" style="float: left;">结束时间：</label>
													<div class="controls  form-inline">
														<input type="text" class="Wdate" id="endDate" name="endDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'startDate\')}',readOnly:'false'})" />
													</div>
												</div>
                                            
											<div class="form-actions">
												<button type="button" id="myBtn"  onclick="saveForm()" class="btn btn-primary">保存</button>
											</div>
										</fieldset>
										<input type="hidden"   name="statusForm" id="statusForm"  value=""/>
										<input type="hidden"   name="ageForm" id="ageForm"  value=""/>
										
										
									</form>
								</div>
							</div>
						</div>
						<!-- /block -->
					</div>
<script>
function saveForm(){
	//用户状态
	var targetUserTime = new Array(); 
	var flagPeriod=false;
	$("input[name='status']:checked").each(function(){ 
        	var txt = $(this).val();
        	if(txt==0){
        		targetUserTime = new Array(); 
        		targetUserTime.push(0); 
        		flagPeriod=true;
        	}else if(flagPeriod==false){
        		targetUserTime.push(txt); 
        	}
    });
	if(targetUserTime.length==0){
		alert("请选择用户状态！");
		return false;
	}

	var targetUserAge = new Array(); 
	var flagAge=false;
	$("input[name='age']:checked").each(function(){ 
        	var txt = $(this).val();
        	if(txt==0){
        		targetUserAge= new Array(); 
        		targetUserAge.push(0); 
        		flagAge=true;
        	}else if(flagAge==false){
        		targetUserAge.push(txt); 
        	}
    });
	if(targetUserAge.length==0){
		alert("请选择年龄阶段！");
		return false;
	}
	$("#statusForm").val(targetUserTime);
	$("#ageForm").val(targetUserAge);
	
   	var id=$("#id").val();
	 var pic=$("#pic").val();
	 var name=$("#name").val();
	 var content=$("#content").val();
	 var startDate=$("#startDate").val();
	 var endDate=$("#endDate").val();
	 var androidUrl=$("#androidUrl").val();
	 var iosUrl=$("#iosUrl").val();
	 var linkText=$("#linkText").val();
	 var type=$("#typeBtn").val();
	 if(id=="" && pic==""){
		 alert("请上传图片！");
		 return false;
	 }
	 if(name==""){
		 alert("请输入软件名称！");
		 return false;
	 }
	 if(content==""){
		 alert("请输入软件描述！");
		 return false;
	 }else if(content.length>30){
		 alert("软件描述信息不能超过30个字！");
		 return false;
	 }

    if(linkText==""){
        alert("按钮文案不能为空！");
        return false;
    }else if(linkText.length>10){
        alert("按钮文案不能超过10个字符！");
        return false;
    }
	if(androidUrl=="" && iosUrl==""){
		alert("请输入软件下载地址！");
		return false;
	}else if(androidUrl.length>1000  || iosUrl.length>1000){
		alert("链接地址不能超过1000字符！");
		return false;
	}
    if(iosUrl!=""){
        if(type==1) {
            if(iosUrl.length>12) {
                if (iosUrl.substring(0, 12) != 'itms-apps://') {
                    alert("请提供“itms-apps://”开头的下载链接!");
                    return false;
                }
            }else{
                alert("请提供“itms-apps://”开头的下载链接!");
                return false;
            }
        }
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
	setCheckBoxValue("${json.data.status}", "status");	
	setCheckBoxValue("${json.data.age}", "age");	
	setByIdFormatTime("startDate",'${json.data.startTime}');
	setByIdFormatTime("endDate",'${json.data.endTime}');


    
  //年龄阶段
    $("input[name='age']").click(function (obj) {//全选  
    	if(this.id=='age_0'){
    		var flag=this.checked;
    		$("input[name='age']").each(function(){ 
    			this.checked=flag; 		
	    	});
    	}else{
    		 var flag=this.checked;
  		    if(flag){
  		    	var sign=true;
  		    	$("input[name='age']").each(function(){
  		    		if(this.id !='age_0' && this.checked==false){
  		    			sign=false;
  		    		}
  		    	});
  		    	if(sign){
  		    		$("input[name='age']").each(function(){
  	  		    		if(this.id =='age_0'){
  	  		    		this.checked=true;
  	  		    		}
  	  		    	});
  		    	}else{
  		    		$("#age_0").attr("checked",false);
  		    	}
  		    }else{
  		    	$("#age_0").attr("checked",false);
  		    }
    	}
    });

    //年龄阶段
    $("input[name='status']").click(function (obj) {//全选  
    	if(this.id=='status_0'){
    		var flag=this.checked;
    		$("input[name='status']").each(function(){ 
    			this.checked=flag; 		
	    	});
    	}else{
    		 var flag=this.checked;
  		    if(flag){
  		    	var sign=true;
  		    	$("input[name='status']").each(function(){
  		    		if(this.id !='status_0' && this.checked==false){
  		    			sign=false;
  		    		}
  		    	});
  		    	if(sign){
  		    		$("input[name='status']").each(function(){
  	  		    		if(this.id =='status_0'){
  	  		    		this.checked=true;
  	  		    		}
  	  		    	});
  		    	}else{
  		    		$("#status_0").attr("checked",false);
  		    	}
  		    }else{
  		    	$("#status_0").attr("checked",false);
  		    }
    	}
    });
    
}); 
</script>

