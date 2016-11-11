<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

<jsp:include page="../include/head.jsp"/>
<!-- Body -->
<div class="container-fluid">
	
						<div class="block">
							<div class="alert alert-error" id="alertErr" style="display: none;">
							<button class="close" data-dismiss="alert">×</button>
							<strong>Error!</strong> <span id="errodesc">This is an error message.</span>
						</div>
							<div class="block-content collapse in">
								<div class="span12">
									<form class="form-horizontal" id="myForm" name="myForm"  action="${BasePath }/custom/saveBanUserDev" method="post">
										<fieldset>
											<div class="control-group">
												<label class="control-label" for="uids" style="float: left;">UID：</label>
												<div class="controls">
												  <input class="input-xlarge focused" name="uids" id="uids"  readonly="readonly"   type="text"  value="${uid }"/>
												</div>
                                            </div>
											  <div class="control-group">
                                              <label class="control-label" for="period" style="float: left;">时间：</label>
                                              <div class="controls">
                                                  <select class="input-xlarge" id="period" name="period">
													<option value="3">3天</option>
													<option value="7">7天</option>
													<option value="15">15天</option>
													<option value="30">30天</option>
													<option value="0">永久</option>
													</select>
                                              </div>
                                            </div>						
                                  	 	<div class="control-group">
												<label class="control-label" for="remark" style="float: left;">备注：</label>
												<div class="controls">
												  <textarea class="input-xlarge focused" id="remark" name="remark"></textarea>
												</div>
                                            </div>
                                           	<div class="form-actions">
												<button type="button" id="btn"  onclick="submitForm()" class="btn btn-success btn-small">保存</button>
											</div>
                                             <table class='table table-hover'>
                                <thead>
                                <tr>
                                    <td>
                                    	<input type="button"   id="btnSelectAll"   name="btnSelectAll" value="全选"   onclick="selectAll()"  />
                                    </td>
                                    <td>device</td>
                                    <td>总数</td>
                                    <td>model</td>
                                </tr>
                                </thead>
                                <tbody>
                                   <c:forEach items="${data}" var="obj">
                                        <tr>
                                            <td>
                                                <input type="checkbox" name="deviceId" id="deviceId" value="${obj.key2}"/>
                                            </td>
                                            <td>${obj.key2}</td>
                                            <td>${obj.count}</td>
                                            <td>${obj.model}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table> 

										</fieldset>
										  <input type="hidden" name="devicess" id="devicess" value=""/>
									</form>

								</div>
							</div>
						</div>
					</div>
<script>
//全选
function selectAll() {
	$("input[name='deviceId']").each(function () {
		this.checked = true;
	});
	$("#btnSelectAll").val("取消全选");
	$("#btnSelectAll").attr("onclick", "cancelSelectAll()");
}
//取消全选
function cancelSelectAll() {
	$("input[name='deviceId']").each(function () {
		this.checked = false;
	});
	$("#btnSelectAll").val("全选");
	$("#btnSelectAll").attr("onclick", "selectAll()");
}

function submitForm(){
	 var remark=$("#remark").val();
	if(remark==""){
		 $("#alertErr").show();
		  $("#errodesc").html("备注信息不能为空！");
		return false;
	}
	var deviceArray = new Array(); 
	$("input[name='deviceId']:checked").each(function(){ 
        	var txt = $(this).val();
        	deviceArray.push(txt); 
    });
	$("#devicess").val(deviceArray);
	
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