<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<jsp:include page="../include/head.jsp"/>
	<script type="text/javascript" src="${BasePath }/js/kindeditor/kindeditor-min.js"></script>
	<script type="text/javascript" src="${BasePath }/js/kindeditor/lang/zh_CN.js"></script>
<!-- Body -->
<div class="container-fluid">
						<div class="block">
							<div class="navbar navbar-inner block-header">
								<div class="muted pull-left">添加金币</div>
							</div>
							<div class="alert alert-error" id="alertErr" style="display: none;">
							<button class="close" data-dismiss="alert">×</button>
							<strong>Error!</strong> <span id="errodesc">This is an error message.</span>
						</div>
							<div class="block-content collapse in">
								<div >
									<form class="form-horizontal" id="saveAti" name="saveAti" action="${BasePath }/coins/save" method="post">
										<div class="control-group">
											<label class="control-label" for="title" style="float: left;">用户uid：</label>
											<div class="controls">
											 	 <textarea class="input-xlarge focused" name="uids" id="uids"></textarea>
											 	 <span style="color:#f00">（请使用英文逗号隔开UID，单次最多500个）</span>
											</div>
                                         </div>
                                         <div class="control-group">
											<label class="control-label" for="title" style="float: left;">奖励/惩罚：</label>
											<div class="controls">
													 <select name="result" id="result">
													 	<option value="REWARD">奖励</option>
													 	<option value="PUNISH">惩罚</option>
													 </select>
											</div>
                                         </div>
                                         
										<div class="control-group">
											<label class="control-label" for="title" style="float: left;">金币：</label>
											<div class="controls">
											 	 <input class="input-xlarge focused" name="coins" id="coins" type="text" />
											 	 <span style="color:#f00">（奖励分数值必须为正数，惩罚分数值必须为负数）</span>
											</div>
                                         </div>
                                         
                                         <div class="control-group">
											<label class="control-label" for="title" style="float: left;">备注缘由：</label>
											<div class="controls">
											 	 <input class="input-xlarge focused" name="memo" id="memo" type="text" />
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
		var uids = $("#uids").val();
		var coins = $("#coins").val();
		var memo = $("#memo").val();
		var result = $("#result").val();
		if(uids==""){
			alert("用户uid不能为空！");
			return false;
		}
		if(uids.indexOf('，') > 0){
			alert("uid不能包含中文逗号！");
			return false;
		}
		if(coins=="" || isNaN(coins)){
			alert("金币不能为空！");
			return false;
		}
		if(coins > 5000){
			alert("上限5000金币");
			return false;
		}
		if(memo==""){
			alert("备注缘由不能为空！");
			return false;
		}
		
		if(result == "REWARD"){
			if(coins <= 0){
				alert("奖励值必须为正值");
				return false;
			}
		} else {
			if(coins >= 0){
				alert("惩罚值必须为负值");
				return false;
			}
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

</script>
