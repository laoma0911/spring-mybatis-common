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
            <div class="muted pull-left">新增</div>
        </div>

        <div class="alert alert-error" id="alertErr" style="display: none;">
            <button class="close" data-dismiss="alert">×</button>
            <strong>Error!</strong> <span id="errodesc">This is an error message.</span>
        </div>
        <div class="block-content collapse in">
            <div>
                <form class="form-horizontal" id="myform" name="myform" action="${BasePath }/label/save?${PublicParams}"
                      enctype="multipart/form-data" method="post">
                    <input type="hidden" id="id" name="id" value="${labels.id}"/>
                    <fieldset>
                        <div class="control-group">
                            <label class="control-label" for="name" style="float: left;">小标签：</label>

                            <div class="controls">
                                <input class="input-xlarge focused" name="name" id="name" value="${labels.labelName}"
                                       type="text"/>
                                <font color="red">小标签名称最多10个字</font>
                            </div>
                        </div>

                        <div class="form-actions">
                            <button type="button" id="btn" name="btn" class="btn btn-primary">保存</button>
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
    $(function () {
        $('#btn').click(function () {
            var flag = checkForm();
            if (flag) {
                $("#btn").attr("disabled", "disabled");
                $('#myform').ajaxSubmit(function (data) {
                    if (data.errno == 0) {
                        alert("操作成功！");
                        window.parent.closeModel();
                    } else if (data.errno == 1) {
                        $("#alertErr").show();
                        $("#errodesc").html(data.errdesc);
                        $("#btn").removeAttr("disabled");
                    }
                });
            }
        });
    });

    //验证表单数据
    function checkForm() {
        var name = $("#name").val();
        if (name == "") {
            alert("小标签名称不能为空！");
            return false;
        }
        if (name.length > 10) {
            alert("小标签名称最长不超过10个字！");
            return false;
        }
        return true;
    }

</script>