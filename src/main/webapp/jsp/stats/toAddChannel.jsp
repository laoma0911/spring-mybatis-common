<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%--
  ~ /**
  ~  *dashan
  ~  */
  --%>

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
								<div class="muted pull-left">新增</div>
							</div>
							<div class="alert alert-error" id="alertErr" style="display: none;">
							<button class="close" data-dismiss="alert">×</button>
							<strong>Error!</strong> <span id="errodesc">This is an error message.</span>
						</div>
							<div class="block-content collapse in">
								<div class="span12">
									<form class="form-horizontal" id="myForm" name="myForm"  action="${BasePath}/stats/saveChannel"  method="post">
										<input type="hidden" id="type" name="type" value="${type }"/>
										<input type="hidden" id="id" name="id" value="${json.data.id }"/>
										<input type="hidden" id="itemId" name="itemId" value="${itemId }"/>
										<fieldset>
                                           <div class="control-group" id="uploadDiv"   >
												<label class="control-label" for="channel" style="float: left;"> 渠道：</label>
												<div class="controls">
                                                    <select name="channel" id="channel">
                                                        <%--<option value="">全部</option>--%>
                                                        <c:forEach items="${channelsList}" var="obj">
                                                            <option value="${obj.name }"  <c:if test="${obj.name==channel }">selected="selected"</c:if>  >${obj.name }</option>
                                                        </c:forEach>
                                                    </select>
												</div>
                                           </div>
                                            
										<div class="control-group">
												<label class="control-label" for="regStart" style="float: left;">注册时间：</label>
												<div class="controls">
                                                    <input type="text" style="width: auto;" id="regStart" name="regStart" value="${regStart }" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-%d',readOnly:'false'})" class="Wdate" onClick="WdatePicker()"/>
                                                    ～
                                                    <input type="text" style="width: auto;" id="regEnd" name="regEnd" value="${regEnd}" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-%d',readOnly:'false'})" class="Wdate" onClick="WdatePicker()"/>
												</div>
                                            </div>
											<div class="control-group">
												<label class="control-label" for="statsStart" style="float: left;">统计时间：</label>
												<div class="controls">
                                                    <input type="text" style="width: auto;" id="statsStart" name="statsStart" value="${statsStart }" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-%d',readOnly:'false'})" class="Wdate" onClick="WdatePicker()"/>
                                                    ～
                                                    <input type="text" style="width: auto;" id="statsEnd" name="statsEnd" value="${statsEnd }" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-%d',readOnly:'false'})" class="Wdate" onClick="WdatePicker()"/>
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
	 var regStart=$("#regStart").val();
	 var regEnd=$("#regEnd").val();
	 var statsStart=$("#statsStart").val();
	 var statsEnd=$("#statsEnd").val();
	 if(regStart=="" || regEnd=="" || statsStart=="" || statsEnd==""){
		 alert("时间不能为空！");
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

