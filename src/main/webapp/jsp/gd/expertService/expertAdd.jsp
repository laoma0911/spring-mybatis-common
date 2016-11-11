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
            <div class="muted pull-left">小助手管理新增|修改</div>
        </div>

        <div class="alert alert-error" id="alertErr" style="display: none;">
            <button class="close" data-dismiss="alert">×</button>
            <strong>Error!</strong> <span id="errodesc">This is an error message.</span>
        </div>
        <div class="block-content collapse in">
            <div class="span12">
                <form class="form-horizontal" id="myForm" name="myForm" action="${BasePath}/meiyue/expertService/save?${PublicParams}" method="post">
                    <input type="hidden" id="id" name="id" value="${expertService.id }"/>
                    <fieldset>
                        <div class="control-group">
                            <label class="control-label" for="name" style="float: left;">服务名称：</label>

                            <div class="controls">
                                <input class="input-xlarge focused" name="name" id="name" value="${expertService.name}" type="text"/>
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" for="duration" style="float: left;">服务时长：</label>

                            <div class="controls col-xs-2">
                                <select name="duration" id="duration">
                                    <option value="1" <c:if test="${expertService.duration==1}">selected</c:if>>一个月</option>
                                    <option value="2" <c:if test="${expertService.duration==2}">selected</c:if>>两个月</option>
                                    <option value="3" <c:if test="${expertService.duration==3}">selected</c:if>>三个月</option>
                                    <option value="4" <c:if test="${expertService.duration==4}">selected</c:if>>四个月</option>
                                    <option value="5" <c:if test="${expertService.duration==5}">selected</c:if>>五个月</option>
                                    <option value="6" <c:if test="${expertService.duration==6}">selected</c:if>>六个月</option>
                                    <option value="7" <c:if test="${expertService.duration==7}">selected</c:if>>七个月</option>
                                    <option value="8" <c:if test="${expertService.duration==8}">selected</c:if>>八个月</option>
                                    <option value="9" <c:if test="${expertService.duration==9}">selected</c:if>>九个月</option>
                                    <option value="10" <c:if test="${expertService.duration==10}">selected</c:if>>十个月</option>
                                    <option value="11" <c:if test="${expertService.duration==11}">selected</c:if>>十一个月</option>
                                    <option value="12" <c:if test="${expertService.duration==12}">selected</c:if>>十二个月</option>
                                </select>
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" for="price" style="float: left;">价格：</label>
                            <div class="controls">
                                <input class="input-xlarge focused" name="price" id="price" value="${expertService.price}" type="text"/>
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
        var duration = $("#duration").val();
        var price = $("#price").val();

        if (name == '' || name == null) {
            alert("请填写服务名称！");
            return false;
        }
        if (name.length >= 10) {
            alert("服务名称长度不能超过10个字符");
            return false;
        }
        if (duration == '' || duration == null) {
            alert("请选择服务时长！");
            return false;
        }
        if (isNaN(price)) {
            alert("价格必须为数字！");
            return false;
        }

        if (price == '' || price == null) {
            alert("请填写价格！");
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


