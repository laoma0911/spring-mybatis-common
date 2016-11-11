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
    <div class="block">
        <div class="navbar navbar-inner block-header">
            <div class="muted pull-left"><移动小组></移动小组></div>
        </div>

        <div class="alert alert-error" id="alertErr" style="display: none;">
            <button class="close" data-dismiss="alert">×</button>
            <strong>Error!</strong> <span id="errodesc">This is an error message.</span>
        </div>
        <div class="block-content collapse in">
            <div>
                <form class="form-horizontal" id="myform" name="myform" action="${BasePath }/groupCategory/moveCategory"
                      enctype="multipart/form-data" method="post">
                    <input type="hidden" id="type" name="type" value="${type }"/>
                    <input type="hidden" id="ids" name="ids" value="${ids}"/>
                    <input type="hidden" id="itemId" name="itemId" value="${itemId }"/>
                    <fieldset>
                        <div class="control-group">
                            <label class="control-label" for="name" style="float: left;">分类：</label>
                            <div class="controls">
                                <select name="newCatId" id="newCatId">
                                    <c:forEach items="${tgcList}" var="obj">
                                        <option value="${obj.id}">${obj.title}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="form-actions">
                            <button type="button" id="btn" name="btn" class="btn btn-primary" onclick="submitRefuseForm()">确定</button>
                        </div>
                    </fieldset>
                </form>
            </div>
        </div>
    </div>
    <!-- /block -->
</div>
<script>
    //ajax提交表单
    function submitRefuseForm() {
        $("#alertErr").hide();
        alert("Say Hi~");
        $('#myform').ajaxSubmit(function(data){
            if (data.errno == 1) {
                $("#alertErr").show();
                $("#errodesc").html(data.errdesc);
            } else {
                alert("操作成功!");
                window.parent.closeModel();
            }
        });
    }

</script>