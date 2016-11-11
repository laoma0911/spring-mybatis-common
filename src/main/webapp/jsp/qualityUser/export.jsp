<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<jsp:include page="../include/head.jsp"/>
<style>
    body {
        padding-top: 0px;
    }
</style>
<div class="container-fluid">
    <div class="block">
        <div class="navbar navbar-inner block-header">
            <div class="muted pull-left">导出数据</div>
        </div>
        <div class="alert alert-error" id="alertErr" style="display: none;">
            <button class="close" data-dismiss="alert">×</button>
            <strong>Error!</strong> <span id="errodesc">This is an error message.</span>
        </div>
        <div class="block-content collapse in">
            <div class="span12">
                <form class="form-horizontal" id="myForm" name="myForm" action="${BasePath}/qualityUser/export" enctype="multipart/form-data"  method="post">
                    <fieldset>
                        <div class="control-group">
                            <label class="control-label" for="exportType" style="float: left;">类型：</label>

                            <div class="controls">
                                <select id="exportType" name="exportType">
                                    <option value="1">用户数据</option>
                                    <option value="2">文章数据</option>
                                </select>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="startDate" style="float: left;">时间：</label>

                            <div class="controls  form-inline">
                                <input type="text" class="Wdate" id="startDate" name="startDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'endDate\')}',readOnly:'false'})"/>至
                                <input type="text" class="Wdate" id="endDate" name="endDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'startDate\')}',maxDate:'%y-%M-%d',readOnly:'false'})"/>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="level" style="float: left;">用户级别：</label>

                            <div class="controls">
                                <select id="level" name="level">
                                    <option value="A">A</option>
                                    <option value="B">B</option>
                                    <option value="C">C</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-actions">
                            <button type="button" id="btn" class="btn btn-primary" onclick="submitForm()">保存</button>
                        </div>
                    </fieldset>
                </form>
            </div>
        </div>
    </div>
    <!-- /block -->
</div>
<script type="text/javascript">
    function submitForm() {
        var startDate = $("#startDate").val();
        var endDate = $("#endDate").val();
        if (startDate == null || startDate == "" || endDate == null || endDate == "") {
            alert("时间不能为空！");
            return false;
        }
        $('#myForm').submit();
    }
</script>