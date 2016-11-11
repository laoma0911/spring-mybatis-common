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
            <div class="muted pull-left">批量移动帖子</div>
        </div>

        <div class="alert alert-error" id="alertErr" style="display: none;">
            <button class="close" data-dismiss="alert">×</button>
            <strong>Error!</strong> <span id="errodesc">This is an error message.</span>
        </div>
        <div class="block-content collapse in">
            <div class="span12">
                <form class="form-horizontal" id="myForm" name="myForm" action="${BasePath }/topic/moveTopicsToGroup"
                      enctype="multipart/form-data" method="post">
                    <input type="hidden" id="type" name="type" value="${type }"/>
                    <input type="hidden" id="itemId" name="itemId" value="${itemId }"/>
                    <input type="hidden" id="ids" name="ids" value="${ids }"/>
                    <fieldset>
                        移动到(小组id):
                        	<input type="text" name="catId" id="catId" value="${catId }"/>
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
        $('#myForm').ajaxSubmit(function(data){
            if(data.errno==1){
                $("#alertErr").show();
                $("#errodesc").html(data.errdesc);
            }else{
                alert("操作成功！");
                window.parent.closeModel();
            }
        });
    }

</script>