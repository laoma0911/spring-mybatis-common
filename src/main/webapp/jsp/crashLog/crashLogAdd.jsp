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
            <div class="muted pull-left">小组分类 添加|修改</div>
        </div>

        <div class="alert alert-error" id="alertErr" style="display: none;">
            <button class="close" data-dismiss="alert">×</button>
            <strong>Error!</strong> <span id="errodesc">This is an error message.</span>
        </div>
        <div class="block-content collapse in">
            <div class="span12">
                <form class="form-horizontal" id="saveCustom" name="saveCustom" action="${BasePath }/crashLog/save"
                      enctype="multipart/form-data" method="post">
                    <input type="hidden" id="type" name="type" value="${type }"/>
                    <input type="hidden" id="id" name="id" value="${json.id}"/>
                    <input type="hidden" id="itemId" name="itemId" value="${itemId }"/>
                    <fieldset>

                        <div class="control-group">
                            <label class="control-label" for="uid"
                                   style="float: left;">uid：</label>

                            <div class="controls">
                                <input class="input-xlarge focused" name="uid" id="uid"
                                       value="${json.uid}" type="text"/>
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" for="dervice"
                                   style="float: left;">dervice：</label>

                            <div class="controls">
                                <input class="input-xlarge focused" name="dervice" id="dervice"
                                       value="${json.dervice}" type="text"/>
                                <font color="red">此项必填</font>
                            </div>
                        </div>

                        <input type="checkbox" name="flag" id="flag" checked="checked" style="display:none">

                            <div class="form-actions">
                            <button type="button"  id="myBtn" onclick="submitForm()" class="btn btn-primary">保存</button>
                        </div>
                    </fieldset>
                </form>
            </div>
        </div>
    </div>
    <!-- /block -->


</div>
<script>
    function checkForm() {
        var uid = $("#uid").val();
        if (uid != "" && isNaN(uid)) {
            alert("uid只允许填写数字!");
            return false;
        }

        var dervice = $("#dervice").val();
        if (dervice == "" ) {
            alert("请填写设备!");
            return false;
        }
        return true;
    }
</script>
<script>
    function submitForm() {
        var flag = checkForm();
        if (flag) {
            $("#myBtn").attr("disabled","disabled");
            $('#saveCustom').ajaxSubmit(function (data) {
                if (data.errno == 0) {
                    alert("操作成功！");
                    window.parent.closeModel();
                } else if (data.errno == 1) {
                    $("#alertErr").show();
                    $("#errodesc").html(data.errdesc);
                    $("#myBtn").removeAttr("disabled");
                }
            });
        }
    }
</script>