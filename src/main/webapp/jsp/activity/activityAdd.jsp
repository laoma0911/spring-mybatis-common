<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:include page="../include/head.jsp" />
<style>
body {
	padding-top: 0px;
}
</style>
<!-- Body -->
<div class="container-fluid">
	<div class="block">
		<div class="navbar navbar-inner block-header">
			<div class="muted pull-left">添加 最新活动</div>
		</div>

		<div class="alert alert-error" id="alertErr" style="display: none;">
			<button class="close" data-dismiss="alert">×</button>
			<strong>Error!</strong> <span id="errodesc">This is an error
				message.</span>
		</div>
		<div class="block-content collapse in">
			<div class="span12">
				<form class="form-horizontal" id="myForm" name="myForm" action="${BasePath }/activity/save" enctype="multipart/form-data"  method="post">
					<input  	type="hidden" id="type" name="type" value="${type }" /> 
					<input		type="hidden" id="id" name="id" value="${json.data.id }" /> 
					<input		 type="hidden" id="itemId" name="itemId" value="${itemId }" /> 
					<input		type="hidden" id="oldPic" name="oldPic" value="${json.data.pic }" />
					<fieldset>
						<!--<legend>添加精准Push</legend> -->
						<div class="control-group">
							<label class="control-label" for="name" style="float: left;">活动标题：</label>
							<div class="controls">
								<input class="input-xlarge focused" name="title" id="title"
									value="${json.data.title}" type="text" />
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="name" style="float: left;">banner上线时间：</label>
							<div class="controls">
								<input type="text" class="Wdate" id="upTime" name="upTime"
									onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'%y-%M-%d %H:%m:%s',maxDate:'#F{$dp.$D(\'downTime\')}',readOnly:'false'})" />
							</div>
							<label class="control-label" for="name" style="float: left;">banner下线时间：</label>
							<div class="controls">
								<input type="text" class="Wdate" id="downTime" name="downTime"
									onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'upTime\')}',readOnly:'false'})" />
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="name" style="float: left;">开始时间：</label>
							<div class="controls">
								<input type="text" class="Wdate" id="startDate" name="startDate"
									onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'upTime\')}',maxDate:'#F{$dp.$D(\'downTime\')}',readOnly:'false'})" />
							</div>
							<label class="control-label" for="name" style="float: left;">结束时间：</label>
							<div class="controls">
								<input type="text" class="Wdate" id="endDate" name="endDate"
									onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'startDate\')}',maxDate:'#F{$dp.$D(\'downTime\')}',readOnly:'false'})" />
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="name" style="float: left;">推广图片：</label>
							<div class="controls">
								<input class="input-xlarge focused" name="pic" id="pic"
									value="${json.data.pic }" type="file" />图片规格：580*290，.jpg格式 <br>
								<c:if test="${json.data.pic!=null && json.data.pic!=''}">
									<img alt="" src="${imageHost }${json.data.pic }">
								</c:if>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="name" style="float: left;">活动链接：</label>
							<div class="controls">
								<input class="input-xlarge focused" name="link" id="link"
									value="${json.data.link }" type="text" />
							</div>
						</div>

						<div class="control-group">
							<label class="control-label" for="name" style="float: left;">客户端平台：</label>
							<div class="controls">
								<label class="checkbox inline"> <input type="checkbox"
									id="platform_1" name="platform" value="1" />IOS
								</label> <label class="checkbox inline"> <input type="checkbox"
									id="platform_0" name="platform" value="0" />Android
								</label> <label class="checkbox inline"> <input type="checkbox"
									id="platform_2" name="platform" value="2" />WP
								</label>
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label" for="name" style="float: left;">同步到谷歌客户端：</label>
							<div class="controls">
								<input type="checkbox" id="toGoogle" name="toGoogle"  value="0" onchange="toGoogleChange(this)"/>
							</div>
						</div>

						<!--                                            <div class="control-group"> -->
						<!-- 												<label class="control-label" for="name" style="float: left;"> -->

						<%-- 												<input type="checkbox"  id="tipsSign"  onclick="checkTips(this)" name="tipsSign" <c:if test="${json.data.tips!=null && json.data.tips !='' }"> checked="checked" </c:if>  value="1"/>未开始提示</label> --%>

						<!-- 												<div class="controls"> -->
						<%-- 												<c:choose> --%>
						<%-- 												<c:when test="${json.data.tips!=null && json.data.tips!='' }"> --%>
						<%-- 													<input class="input-xlarge focused" name="tips" id="tips" value="${json.data.tips }"  disabled="disabled"  type="text" /> --%>
						<%-- 													</c:when> --%>
						<%-- 												<c:otherwise> --%>
						<!-- 													<input class="input-xlarge focused" name="tips" id="tips" value="活动暂未开始，到时间再来吧。"  disabled="disabled"  type="text" /> -->
						<%-- 												</c:otherwise> --%>
						<%-- 												</c:choose> --%>
						<!-- 												</div> -->
						<!--                                             </div> -->
						<div class="form-actions">
							<!-- 												<button type="button"  onclick="saveCustom11()" class="btn btn-primary">保存</button> -->
							<button type="button" id="myBtn"  class="btn btn-primary" onclick="submitForm()">保存</button>
						</div>
					</fieldset>
				</form>
			</div>
		</div>
	</div>
	<!-- /block -->
</div>
<script>
	//提交表单
	function submitForm(){
		var flag=checkForm();
    	if(flag){
    		$("#myBtn").attr("disabled","disabled");
	        $('#myForm').ajaxSubmit(function(data){
	          if(data.errno==0){
	        	  alert("操作成功！");
	        	  window.parent.closeModel();
	          }else  if(data.errno==1){
	        	  $("#myBtn").removeAttr("disabled");
	        	  $("#alertErr").show();
        		  $("#errodesc").html(data.errdesc);
	          }
	        });
    	}
	}
	function checkForm() {
		var title = $("#title").val();
		if (title == "") {
			alert("活动标题不能为空！");
			return false;
		}
		var startDate = $("#startDate").val();
		if (startDate == "") {
			alert("请输入开始时间！");
			return false;
		}
		var endDate = $("#endDate").val();
		if (endDate == "") {
			alert("请输入结束时间！");
			return false;
		}

		var upTime = $("#upTime").val();
		if (upTime == "") {
			alert("请输入上线时间！");
			return false;
		}
		var downTime = $("#downTime").val();
		if (downTime == "") {
			alert("请输入下线时间！");
			return false;
		}
		var id = $("#id").val();

		var pic = $("#pic").val();
		if (id == "" && pic == "") {
			alert("请上传图片");
			return false;
		}
		var link = $("#link	").val();
		if (link == "") {
			alert("请输入活动链接地址！");
			return false;
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
		var tipsSign = new Array();
		$("input[name='tipsSign']:checked").each(function() {
			var txt = $(this).val();
			tipsSign.push(txt);
		});
		return true;
		// 	 var path="${BasePath }/activity/save?title="+title+"&startDate=" +startDate+"&endDate="+endDate+"&pic="+pic+"&link="+link
		// 			 +"&platform="+platformArry+"&tipsSign="+tipsSign;
		// 	var id=$("#id").val();
		// 	if(id!=""){
		// 		path+="&id="+id;
		// 	}
		// 		path=encodeURI(path);
		// 		path=encodeURI(path); 
		// 	  $.ajax({
		//           type:"POST",
		//           url:path,
		//           datatype: "json",
		//           success:function(data){
		//         	  if(data.errno==1){
		//         		  $("#alertErr").show();
		//         		  $("#errodesc").html(data.errdesc);
		//         	  }else{
		//        			 window.location.href="${BasePath}/activity/list?type=${type}&itemId=${itemId}";
		// 			 }
		//           } ,
		//           error: function(){
		//             alert("操作出错，请联系管理员！");
		//           }         
		//        });
	}
	
	function toGoogleChange(obj){
		if (obj.checked) {
			$("#toGoogle").val("1");
		} else {
			$("#toGoogle").val("0");
		}
	}
</script>
<jsp:include page="../include/bottom.jsp" />
<script>
	$(function() {
		setCheckBoxValue("${json.data.period}", "period");
		setCheckBoxValue("${json.data.groups}", "group");
		setCheckBoxValue("${json.data.age}", "age");
		setCheckBoxValue("${json.data.feature}", "feature");
		setCheckBoxValue("${json.data.area}", "area");
		setByIdFormatTime("startDate", "${json.data.startTime}");
		setByIdFormatTime("endDate", "${json.data.endTime}");
		setByIdFormatTime("upTime", "${json.data.upTime}");
		setByIdFormatTime("downTime", "${json.data.downTime}");

		var vals = "${json.data.platform}";
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
		
		var toGoogle = "${json.data.toGoogle}";
		if(toGoogle == 1){
			$("#toGoogle").attr("checked", true);
			$("#toGoogle").val("1");
		}
		
	});
	function checkTips(obj) {
		if (obj.checked) {
			$('#tips').attr("disabled", false);
		} else {
			$('#tips').attr("disabled", true);
		}

	}
</script>