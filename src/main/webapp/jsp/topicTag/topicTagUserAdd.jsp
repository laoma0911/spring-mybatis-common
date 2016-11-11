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
				<div class="muted pull-left">添加 | 修改 推荐用户 </div>
			</div>

			<div class="alert alert-error" id="alertErr" style="display: none;">
			<button class="close" data-dismiss="alert">×</button>
			<strong>Error!</strong> <span id="errodesc">This is an error message.</span>
		</div>
			<div class="block-content collapse in">
				<div class="span12">
					<form class="form-horizontal" id="myForm" name="myForm"  action="${BasePath }/topicTagUser/save"   method="post">
						<input type="hidden" id="type" name="type" value="${type }"/>
						<input type="hidden" id="id" name="id" value="${topicTagUser.id }"/>
						<input type="hidden" id="itemId" name="itemId" value="${itemId }"/>
						<fieldset>
							<div class="control-group">
								<label class="control-label" for="tagId" style="float: left;">标签：</label>
								<div class="controls">
									<select name="tagId" id="tagId">
                                        <option value="0" >全部</option>
										<c:forEach items="${topicTagList}" var="tag">
											<option value="${tag.id}" <c:if test="${tag.id==topicTagUser.tagId}">selected</c:if>>${tag.tag}</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="control-group">
								<label class="control-label" for="uid1" style="float: left;">第一位UID：</label>
								<div class="controls">
									<input type="text" id="uid1" name="uid1"
									       value="${topicTagUser.uid1}"/>
								</div>
							</div>
                            <div class="control-group">
                                <label class="control-label" for="uid2" style="float: left;">第二位UID：</label>
                                <div class="controls">
                                    <input type="text" id="uid2" name="uid2"
                                           value="${topicTagUser.uid2}"/>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="uid3" style="float: left;">第三位UID：</label>
                                <div class="controls">
                                    <input type="text" id="uid3" name="uid3"
                                           value="${topicTagUser.uid3}"/>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="startDate" style="float: left;">开始日期：</label>
                                <div class="controls">
                                    <input type="text" id="startDate" name="startDate"
                                           value="${topicTagUser.startDate}" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'%y-%M-%d',maxDate:'#F{$dp.$D(\'endDate\')}',readOnly:'false'})" />
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="endDate" style="float: left;">结束日期：</label>
                                <div class="controls">
                                    <input type="text" id="endDate" name="endDate"
                                           value="${topicTagUser.endDate}" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'startDate\')}',readOnly:'false'})" />
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="platform_0" style="float: left;">客户端平台：</label>
                                <div class="controls">
                                    <label class="checkbox inline">
                                        <input type="checkbox" <c:if test="${topicTagUser.platform=='0' || topicTagUser.platform=='0,1'}"> checked </c:if>	id="platform_0" name="platform" value="0" />Android
                                    </label>
                                    <label class="checkbox inline">
                                        <input type="checkbox" <c:if test="${topicTagUser.platform=='1' || topicTagUser.platform=='0,1'}"> checked </c:if>	id="platform_1" name="platform" value="1" />IOS
                                    </label>

                                </div>
                            </div>
							<div class="form-actions">
								<button type="button" id="myBtn" onclick="saveForm()" class="btn btn-primary">保存
								</button>
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
    var uid1=$("#uid1").val();
    var uid2=$("#uid2").val();
    var uid3=$("#uid3").val();
    if(uid1=="" || uid2=="" || uid3==""){
        alert("用户UID不能为空！");
        return false;
    }else if(uid1==uid2 || uid1==uid3 || uid2==uid3){
        alert("用户UID不能重复！");
        return false;
    }
    var startDate=$("#startDate").val();
    var endDate=$("#endDate").val();
    if(startDate==""){
        alert("开始时间不能为空！");
        return false;
    }else if(endDate==""){
        alert("结束时间不能为空！");
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
	setByIdFormatDate("startDate",'${topicTagUser.startDate}');
    setByIdFormatDate("endDate",'${topicTagUser.endDate}');
});
</script>

