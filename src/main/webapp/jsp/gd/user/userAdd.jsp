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
								<div class="muted pull-left">高端用户新增</div>
							</div>

						<!-- block -->
							<div class="alert alert-error" id="alertErr" style="display: none;">
							<button class="close" data-dismiss="alert">×</button>
							<strong>Error!</strong> <span id="errodesc">This is an error message.</span>
						</div>
							<div class="block-content collapse in">
								<div class="span12">
									<form class="form-horizontal" id="myForm" name="myForm"  onsubmit="return false;" action="${BasePath }/meiyue/user/saveUser" method="post">
										<fieldset>
											<%--<legend>添加|修改 用户信息</legend>--%>
											<div class="control-group">
												<label class="control-label" for="nick" style="float: left;">昵称：</label>
												<div class="controls">
												  <input class="input-xlarge focused" name="nick" id="nick"   type="text"  value=""/>
												</div>
                                            </div>
											<div class="control-group">
												<label class="control-label" for="pass1" style="float: left;">密码：</label>
												<div class="controls">
												  <input class="input-xlarge focused" id="pass1" name="pass"  type="password"  />
												</div>
                                            </div>
                                            <div class="control-group">
												<label class="control-label" for="pass2" style="float: left;">密验：</label>
												<div class="controls">
												  <input class="input-xlarge focused" id="pass2" name="pass2"  type="password"  />
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
	 var nick=$("#nick").val();
	 var pass1=$("#pass1").val();
	 var pass2=$("#pass2").val();
     if(nick==""){
         alert("昵称不能为空！");
         return false;
     }
     if(pass1=="" || pass2==""){
         alert("密码不能为空！");
         return;
     }else if(pass1!=pass2){
         alert("密码不一置！");
         return;
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