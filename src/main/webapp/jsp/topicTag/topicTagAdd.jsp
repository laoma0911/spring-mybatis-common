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
								<div class="muted pull-left">添加 | 修改 话题标签分类 </div>
							</div>
							<div class="alert alert-error" id="alertErr" style="display: none;">
							<button class="close" data-dismiss="alert">×</button>
							<strong>Error!</strong> <span id="errodesc">This is an error message.</span>
						</div>
							<div class="block-content collapse in">
								<div class="span12">
									<form class="form-horizontal" id="myForm" name="myForm"  action="${BasePath }/topicTag/save"   method="post">
										<input type="hidden" id="type" name="type" value="${type }"/>
										<input type="hidden" id="id" name="id" value="${obj.id }"/>
										<input type="hidden" id="itemId" name="itemId" value="${itemId }"/>
										<fieldset>
                                           <%--<div class="control-group" >--%>
												<%--<label class="control-label" for="groupId" style="float: left;">小组分类：</label>--%>
												<%--<div class="controls">--%>
												  <%--<select  onchange="getCategory(this)" >--%>
                                                      <%--<c:forEach items="${groupList}" var="group">--%>
                                                          <%--<option value="${group.id}" <c:if test="${categoryId==group.id}">selected="selected"</c:if>   >   ${group.title}</option>--%>
                                                      <%--</c:forEach>--%>
                                                  <%--</select>--%>
												<%--</div>--%>
                                           <%--</div>--%>
                                            <%--<div class="control-group"  >--%>
                                                <%--<label class="control-label" for="groupId" style="float: left;">小组：</label>--%>
                                                <%--<div class="controls">--%>
                                                    <%--<select id="groupId" name="groupId" >--%>
                                                        <%--<c:forEach items="${categoryList}" var="category">--%>
                                                            <%--<option value="${category.id}" <c:if test="${groupId==category.id}">selected="selected"</c:if> >${category.title}</option>--%>
                                                        <%--</c:forEach>--%>
                                                    <%--</select>--%>
                                                <%--</div>--%>
                                            <%--</div>--%>
                                               <div class="control-group">
                                                   <label class="control-label" for="groupId" style="float: left;">小组：</label>
                                                   <div class="controls">
                                                       <input type="text"  id="groupName" name="groupName"  value="${groupName}" onblur="getGroupId(this)" />
                                                       <input type="hidden"  id="groupId" name="groupId" value="${obj.groupId }"  />
                                                   </div>
                                               </div>

                                                <div class="control-group">
                                                    <label class="control-label" for="tag" style="float: left;">标签：</label>
                                                    <div class="controls">
                                                      <input type="text"  id="tag" name="tag" value="${obj.tag }"  />
                                                    </div>
                                                </div>
                                               <div class="control-group">
                                                   <label class="control-label" for="displayOrder" style="float: left;">排序值：</label>

                                                   <div class="controls">
                                                       <input type="text" id="displayOrder" name="displayOrder" value="${obj.displayOrder}"/>
                                                   </div>
                                               </div>
											<div class="form-actions">
												<button type="button" id="myBtn"  onclick="saveForm()" class="btn btn-primary">保存</button>
											</div>
										</fieldset>
									</form>
                                    <form class="form-horizontal" id="groupForm" name="groupForm"  action="${BasePath }/topicTag/getGroupId"   method="post">
                                        <input type="hidden" name="groupNameHidden" id="groupNameHidden"/>
                                    </form>
                                </div>
							</div>
						</div>
						<!-- /block -->
					</div>
<script>
    function getGroupId(obj){
        name=obj.value;
        $("#groupNameHidden").val(name);
        if(name!=""){
            $('#groupForm').ajaxSubmit(function(data){
                if(data.errno==1){
                    $("#alertErr").show();
                    $("#errodesc").html(data.errdesc);
                    $("#groupId").val("");
                }else{
                   $("#groupId").val(data.groupId);
                    $("#errodesc").html("");
                   $("#alertErr").hide();
                }
            });
        }
    }
function saveForm(){
    var groupId=$("#groupId").val();
    if(groupId==''){
        alert("小组不能为空！");
        return false;
    }
    var tag=$("#tag").val();
    if(tag.length>4){
        alert("标签不能超过4个字符！");
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

