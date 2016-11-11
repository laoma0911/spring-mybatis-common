<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../include/head.jsp"/>
<style>
    body {
        padding-top: 0px;
    }
</style>
<!-- Body -->
<div class="container-fluid">

    <!-- block -->
    <div class="block">
        <div class="navbar navbar-inner block-header">
            <div class="muted pull-left">导出自定义数据</div>
        </div>

        <div class="alert alert-error" id="alertErr" style="display: none;">
            <button class="close" data-dismiss="alert">×</button>
            <strong>Error!</strong> <span id="errodesc">This is an error message.</span>
        </div>
        <div class="block-content collapse in">
            <div class="span12">
                <form class="form-horizontal" id="saveCustom" name="saveCustom" action="${BasePath }/calendarusermerge/exportsoftFeedExcel" enctype="multipart/form-data" method="post">
                    <input type="hidden" id="type" name="type" value="${type }"/>
                    <input type="hidden" id="itemId" name="itemId" value="${itemId }"/>
                    <fieldset>
                        <div class="control-group">
                        
                        	<label class="control-label" for="name" style="float: left;">来源用户：</label>
                            <div class="controls">
                            	<input type="text" name="sourceUid" value="${sourceUid }"  id="sourceUid" />
                            </div>
                        	<br>
                        	<label class="control-label" for="name" style="float: left;">目标用户：</label>
                            <div class="controls">
                            	<input type="text" name="targetUid" value="${targetUid }"  id="targetUid" />
                            </div>
                            <br>
                            <label class="control-label" for="name" style="float: left;">导出的开始时间：</label>
                            <div class="controls">
                                <input type="text" class="Wdate" id="startDate" name="startDate" value="${startDate }"
                                       onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'endDate\')}',readOnly:'false'})" />
                            </div>
                            <br>
                            <label class="control-label" for="name" style="float: left;">导出的结束时间：</label>
                            <div class="controls">
                                <input type="text" class="Wdate" id="endDate" name="endDate"  value="${endDate }"
                                       onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'startDate\')}',readOnly:'false'})" />
                            </div>
                            <br>
                            <div class="controls">
                                 <c:if test="${mergeDb == 0 }">
									<input type="checkbox"  name="mergeDb" id="mergeDb"   />合并时保留上传时间较大的数据
								</c:if>
								<c:if test="${mergeDb == 1 }">
									<input type="checkbox"  name="mergeDb" id="mergeDb"  checked="checked"  />合并时保留上传时间较大的数据
								</c:if>
                            </div>
                        </div>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            下载后的csv文件 需要使用,来进行分列
                        <div class="form-actions">
                            <button type="button" id="myBtn" onclick="submitForm()" class="btn btn-primary">保存</button>
                        </div>
                    </fieldset>
                </form>
            </div>
        </div>
    </div>
    <!-- /block -->


</div>
<jsp:include page="../include/bottom.jsp"/>
<script>
    function submitForm() {
    	
    	var sourceUid = $("#sourceUid").val();
    	var targetUid = $("#targetUid").val();
    	var startDate = $("#startDate").val();
    	var endDate = $("#endDate").val();
    	if(sourceUid == "" || isNaN(sourceUid)){
    		alert("来源用户不可以为空且是数字!");
    		return ;
    	}
    	if(targetUid == "" || isNaN(targetUid)){
    		alert("目标用户不可以为空且是数字!");
    		return ;
    	}
    	if(startDate == ""){
    		alert("开始时间不能为空");
    		return ;
    	}
    	if(endDate == ""){
    		alert("结束时间不能为空");
    		return ;
    	}
    	
    	
    	
            document.getElementById("saveCustom").submit();

    }


</script>