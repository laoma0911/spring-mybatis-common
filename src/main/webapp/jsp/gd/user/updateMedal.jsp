<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<jsp:include page="../../include/head.jsp"/>
<!-- Body -->
<style>
body {
	padding-top: 0px;
}
</style>
<div class="container-fluid">
						<!-- block -->
						<div class="block">
							<div class="navbar navbar-inner block-header">
								<div class="muted pull-left">编辑勋章信息</div>
							</div>

						<!-- block -->
							<div class="alert alert-error" id="alertErr" style="display: none;">
							<button class="close" data-dismiss="alert">×</button>
							<strong>Error!</strong> <span id="errodesc">This is an error message.</span>
						</div>
							<div class="block-content collapse in">
								<div class="span12">
									<form class="form-horizontal" id="myForm" name="myForm"  onsubmit="return false;" action="${BasePath }/meiyue/user/saveMedal" method="post">
										<input type="hidden" id="type" name="uid"  id="uid" value="${user.uid }"/>
										<fieldset>
											<div class="control-group">
												<label class="control-label"  style="float: left;">昵称</label>
												<div class="controls">
												  ${user.nick }
												</div>
                                            </div>
											
											  <div class="control-group">
                                              <label class="control-label" for="group_id" style="float: left;">用户组：</label>
                                              <div class="controls">
                                                  <select class="input-xlarge" id="group_id" name="group_id">
													<option value="0" <c:if test="${user.groupId==0}"> selected="selected" </c:if> >普通</option>
													<option value="1" <c:if test="${user.groupId==1}"> selected="selected" </c:if> >官方</option>
													<option value="2" <c:if test="${user.groupId==2}"> selected="selected" </c:if> >监控</option>
													<option value="3" <c:if test="${user.groupId==3}"> selected="selected" </c:if> >VIP</option>
													<option value="10" <c:if test="${user.groupId==10}"> selected="selected" </c:if> >美容控</option>
													<option value="11" <c:if test="${user.groupId==11}"> selected="selected" </c:if> >美体狂人</option>
													<option value="12" <c:if test="${user.groupId==12}"> selected="selected" </c:if> >知心MM</option>
													<option value="13" <c:if test="${user.groupId==13}"> selected="selected" </c:if> >占星师</option>
													<option value="14" <c:if test="${user.groupId==14}"> selected="selected" </c:if> >健康达人</option>
													<option value="15" <c:if test="${user.groupId==15}"> selected="selected" </c:if> >超级妈咪</option>
													<option value="16" <c:if test="${user.groupId==16}"> selected="selected" </c:if> >灌水王</option>
													<option value="17" <c:if test="${user.groupId==17}"> selected="selected" </c:if> >关注中</option>
													<option value="18" <c:if test="${user.groupId==18}"> selected="selected" </c:if> >两性</option>
                                                    <option value="19" <c:if test="${user.groupId==19}"> selected="selected" </c:if> >好评达人</option>
                                                    <option value="20" <c:if test="${user.groupId==20}"> selected="selected" </c:if> >优秀组长</option>
													</select>
                                              </div>
                                            </div>
                                            <div class="control-group">
                                              <label class="control-label"  style="float: left;">勋章：</label>
                                              <div class="controls form-inline">
                                              			<c:forEach  items="${medalList }"   var="obj">
                                          					  <label class="checkbox  ">
                                          							<input type="checkbox" id="medal_${obj.id }"     
                                          							
                                          							<c:forEach  items="${medalIds }"  var="id">
                                          									<c:if   test="${id==obj.id }">
                                          										checked="checked"
                                          									</c:if>
                                          							</c:forEach>
                                          						
                                          							 name="medal" value="${ obj.id}"/>${obj.name }
                                               				</label>
                                              			</c:forEach>
                                              </div>
                                              </div>
											<div class="form-actions">
												<button type="button"  id="btn" onclick="submitForm()" class="btn btn-primary">保存</button>
											</div>
										</fieldset>
									</form>

								</div>
							</div>
						</div>
						<!-- /block -->
					</div>
<script>
function submitForm(){
	var uid=$("#uid").val();
    var medalSe = new Array();
    $("input[name='medal']:checked").each(function(){
            var txt = $(this).val();
            medalSe.push(txt);
    });
    if(medalSe.length>4){
         alert("勋章最多可选4个！");
         return false;
    }
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
	 
// 		$("#saveCustom").submit(function() {
// 			  alert($(this).serialize());
// 			  return false;
// 		});
// 		var path="${BasePath }/meiyue/user/save?nick="+nick+"&group_id="+group_id+"&pass="+pass1+"&remark="+remark+"&sex="+sex;
// 		path=encodeURI(path);
// 		path=encodeURI(path); 
// 	  $.ajax({
//           type:"POST",
//         //  contentType: "application/x-www-form-urlencoded; charset=utf-8", 
//           url:path,
//           datatype: "json",
//           success:function(data){
//         	  if(data.errno==1){
//         		  $("#alertErr").show();
//         		  $("#errodesc").html(data.errdesc);
//         	  }else{
//         		  alert("添加用户成功");
//        			 window.location.href="${BasePath}/meiyue/user/userList?type=4&itemId=20";
// 			 }
//           } ,
//           error: function(){
//             alert("操作出错，请联系管理员！");
//           }         
//        });
	  
	  
// 	  }


// $(document).ready(function() { 
// 		function initUserMedal(){
// 			var medal='${medalIds}';
// 			if(medal!=""){
// 					var val = medal.split(",");
// 					for (var i = 0; i < val.length; i++) {
// 						if(val[i]!=""){
// 									$("medal_"+val[i]).checked=true;;
// 						}
// 					}
// 			}
// 		}
// }); 

</script>