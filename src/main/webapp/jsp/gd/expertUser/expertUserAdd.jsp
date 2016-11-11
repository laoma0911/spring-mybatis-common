<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../../include/head.jsp"/>
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
            <div class="muted pull-left">专家信息新增|修改</div>
        </div>

        <div class="alert alert-error" id="alertErr" style="display: none;">
            <button class="close" data-dismiss="alert">×</button>
            <strong>Error!</strong> <span id="errodesc">This is an error message.</span>
        </div>
        <div class="block-content collapse in">
            <div class="span12">
                <form class="form-horizontal" id="myForm" name="myForm" action="${BasePath}/meiyue/expertUser/save?${PublicParams}" enctype="multipart/form-data" method="post">
                    <input type="hidden" id="id" name="id" value="${expertUser.id}"/>
                    <fieldset>
                        <div class="control-group">
                            <label class="control-label" for="name" style="float: left;">专家名称：</label>
                            <div class="controls">
                                <input class="input-xlarge focused" name="name" id="name" value="${expertUser.nick}" type="text"/>
                            </div>
                        </div>


                        <div class="control-group">
                            <label class="control-label" for="describe" style="float: left;">专家介绍：</label>
                            <div class="controls">
                                <input class="input-xlarge focused" name="describe" id="describe" value="${expertUser.describe}" type="text"/>
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" for="pic" style="float: left;">专家头像：</label>
                            <div class="controls">
                                <input class="input-xlarge focused" name="pic" id="pic" value="${expertUser.expertIcon}" type="file" />
                                <%--图片规格：580*290，.jpg格式--%>
                                <br>
                                <c:if test="${expertUser.expertIcon!=null && expertUser.expertIcon!=''}">
                                    <img alt="" src="${imageHost}${expertUser.expertIcon}" width="200px" height="150px">
                                </c:if>
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" for="expertUserType" style="float: left;">状态：</label>
                            <div class="controls">
                                <label class="checkbox inline">
                                    <input type="checkbox" <c:if test="${expertUser.type==0}"> checked
                                           </c:if>id="expertUserType" name="expertUserType" value="0">默认专家
                                </label>
                            </div>
                        </div>

                        <div class="form-actions">
                            <button type="button" id="myBtn" onclick="saveForm()" class="btn btn-primary">保存</button>
                        </div>
                    </fieldset>
                </form>

            </div>
        </div>
    </div>
    <!-- /block -->
</div>
<script>
    function saveForm() {
        var name = $("#name").val();
        var describe = $("#describe").val();
        var pic = $("#pic").val();
        var id = $("#id").val();

        if (name == '' || name == null) {
            alert("请填写专家名称！");
            return false;
        }
//        if (name.length >= 10) {
//            alert("服务名称长度不能超过10个字符");
//            return false;
//        }
        if (describe == '' || describe == null) {
            alert("请填写专家介绍！");
            return false;
        }
        if (id == "" && pic == "") {
            alert("请上传专家头像！");
            return false;
        }

        $("#myBtn").attr("disabled", "disabled");
        $('#myForm').ajaxSubmit(function (data) {
            if (data.errno == 1) {
                $("#alertErr").show();
                $("#errodesc").html(data.errdesc);
                $("#myBtn").removeAttr("disabled");
            } else {
                alert("操作成功！");
                window.parent.closeModel();
            }
        });
    }
</script>


