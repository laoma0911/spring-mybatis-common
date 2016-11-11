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
                <form class="form-horizontal" id="saveCustom" name="saveCustom" action="${BasePath }/groupCategory/save"
                      enctype="multipart/form-data" method="post">
                    <input type="hidden" id="type" name="type" value="${type }"/>
                    <input type="hidden" id="id" name="id" value="${json.id}"/>
                    <input type="hidden" id="itemId" name="itemId" value="${itemId }"/>
                    <input type="hidden" id="oldPic" name="oldPic" value="${json.background }"/>
                    <fieldset>

                        <div class="control-group">
                            <label class="control-label" for="name"
                                   style="float: left;">分类名称：</label>

                            <div class="controls">
                                <input class="input-xlarge focused" name="title" id="title"
                                       value="${json.title}" type="text"/><font color="green">限制十个字以内</font>
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" for="name"
                                   style="float: left;">排序值：</label>

                            <div class="controls">
                                <input class="input-xlarge focused" name="displayorder" id="displayorder"
                                       value="${json.displayorder}" type="text"/><font color="green">只可填写数字(排序值最大的会在第1位显示)</font>
                            </div>
                        </div>

                        <div class="control-group" id="uploadDiv">
                            <label class="control-label" for="name" style="float: left;">背景图：</label>

                            <div class="controls">
                                <input class="input-xlarge focused" name="pic" id="pic" value="${json.background}" type="file"/>
                                <font color="green">只可上传1080*756 ,大小限制200KB内。</font>
                                <br>
                                <c:if test="${json.background!=null && json.background!=''}">
                                    <img alt="" src="${imageHost}${json.background }">
                                </c:if>
                            </div>
                        </div>


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
        var title = $("#title").val();
        if (title == "") {
            alert("小组名称！");
            return false;
        }
        if (title.length > 10) {
            alert("小组名称长度过程，限定10个字之内！");
            return false;
        }
        var displayorder = $("#displayorder").val();

        if (displayorder == "" ) {
            alert("请填写位置!");
            return false;
        }
        var reg = new RegExp("^[0-9]*$");
        if(!reg.test(displayorder)) {
            alert("顺序只可以填写数字!");
            return false;
        }
        var oldPic = $("#oldPic").val();
        var file = $("#pic").val();
        if (oldPic == "" && file == "") {
            alert("请上传背景图！");
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