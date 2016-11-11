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
            <div class="muted pull-left">金币兑换商品</div>
        </div>

        <div class="alert alert-error" id="alertErr" style="display: none;">
            <button class="close" data-dismiss="alert">×</button>
            <strong>Error!</strong> <span id="errodesc">This is an error message.</span>
        </div>
        <div class="block-content collapse in">
            <div class="span12">
                <form class="form-horizontal" id="myForm" name="myForm" action="${BasePath }/coinProduct/save" enctype="multipart/form-data" method="post">
                    <input type="hidden" id="type" name="type" value="${type }"/>
                    <input type="hidden" id="id" name="id" value="${obj.id }"/>
                    <input type="hidden" id="itemId" name="itemId" value="${itemId }"/>
                    <fieldset>
                        <div class="control-group">
                            <label class="control-label" for="title" style="float: left;">标题：</label>

                            <div class="controls">
                                <input type="text" id="title" name="title" value="${obj.title }"/><span style="color: #ff0000">最多12个字</span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="name" style="float: left;">商家名称：</label>

                            <div class="controls">
                                <input type="text" name="name" id="name" value="${obj.name}"/><span style="color: #ff0000">最多6个字</span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="groupId" style="float: left;">小组ID：</label>

                            <div class="controls">
                                <input type="text" id="groupId" name="groupId" value="${obj.groupId}" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"  ><span style="color: #ff0000">可选，不填写不显示小组</span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="startDate" style="float: left;">上线时间：</label>

                            <div class="controls  form-inline">
                                <input type="text" class="Wdate" id="startDate" name="startDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:00:00',minDate:'%y-%M-%d',readOnly:'false'})"/>
                            </div>
                        </div>
                        <div class="form-actions">
                            <button type="button" id="btn" name="btn"   class="btn btn-primary">保存</button>
                        </div>
                    </fieldset>
                    <input type="hidden" name="ageForm" id="ageForm" value=""/>
                </form>
            </div>
        </div>
    </div>
    <!-- /block -->
</div>
<script>
    function checkForm() {
        var title = $("#title").val();
        var name = $("#name").val();
        var groupId = $("#groupId").val();
        if (title == '') {
            alert("标题不能为空！");
            return false;
        } else if (title.length > 12) {
            alert("标题不能超过12个字！");
            return false;
        }
//        if (name == '') {
//            alert("商家名称不能为空！");
//            return false;
//        } else if (name.length > 6) {
//            alert("商家名称不能超过6个字！");
//            return false;
//        }
        return true;
    }
    //ajax提交表单
    $(function () {
        $('#btn').click(function(){
            var flag=checkForm();
            if(flag){
                $("#btn").attr("disabled","disabled");
                $('#myForm').ajaxSubmit(function(data){
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
        });

        setByIdFormatTime("startDate",'${obj.startDate}');
    });
</script>