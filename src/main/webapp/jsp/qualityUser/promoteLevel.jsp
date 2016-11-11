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
            <div class="muted pull-left">提升${level}级</div>
        </div>
        <div class="alert alert-error" id="alertErr" style="display: none;">
            <button class="close" data-dismiss="alert">×</button>
            <strong>Error!</strong> <span id="errodesc">This is an error message.</span>
        </div>
        <div class="block-content collapse in">
            <div class="span12">
                <form class="form-horizontal" id="myForm" name="myForm" action="${BasePath}/qualityUser/promoteLevel" method="post">
                    <fieldset>
                        <div class="control-group">
                            <label class="control-label" for="condition" style="float: left;">条件：</label>

                            <div class="controls">
                                <select id="condition" name="condition" onchange="conditionChange(this)">
                                    <option value="-1">请选择条件</option>
                                    <c:if test="${level=='B'}">
                                        <option value="1">所发话题推荐量多余12</option>
                                        <option value="2">所发话题回复量多余50</option>
                                    </c:if>
                                    <c:if test="${level=='C'}">
                                        <option value="1">所发话题推荐量多余12</option>
                                        <option value="2">所发话题回复量多余50</option>
                                        <option value="3">所发话题推荐量多余8</option>
                                        <option value="4">所发话题回复量多余20</option>
                                    </c:if>
                                </select>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="startDate" style="float: left;">开始时间：</label>

                            <div class="controls  form-inline">
                                <input type="text" class="Wdate" id="startDate" name="startDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'endDate\')}',readOnly:'false'})"/>
                            </div>
                            <label class="control-label" for="endDate" style="float: left;">结束时间：</label>

                            <div class="controls  form-inline">
                                <input type="text" class="Wdate" id="endDate" name="endDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'startDate\')}',maxDate:'%y-%M-%d',readOnly:'false'})"/>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="jibie" style="float: left;">来源：</label>

                            <div class="controls">
                                <input type="hidden" id="level" name="level" value="${level}"/>
                                <input type="text" id="jibie" value="${level}级" readonly/>
                            </div>
                        </div>
                        <div class="control-group inline">
                            <label class="control-label" for="toLevelA" style="float: left;">级别：</label>

                            <div class="controls">
                                <label class="radio inline">
                                    <input type="radio" name="toLevel" id="toLevelA" value="A" checked>A级别
                                </label>
                                <c:if test="${level=='C'}">
                                    <label class="radio inline">
                                        <input type="radio" name="toLevel" id="toLevelB" value="B">B级别
                                    </label>
                                </c:if>
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
        var condition = $("#condition").val();
        var toLevel=$('input[name="toLevel"]:checked').val();
        if(condition==-1){
            alert("请选择提升条件！")
            return false;
        }
        if(startDate==null || startDate=="" || endDate==null || endDate==""){
            alert("时间不能为空！");
            return false;
        }
        if(toLevel==null || toLevel=='undefined'){
            alert("请选择级别！");
            return false;
        }
        $("#btn").attr("disabled", "disabled");
        $('#myForm').ajaxSubmit(function (data) {
            if (data.errno == 0) {
                alert("任务正在后台执行，需要时间较长，请稍后后查看结果！");
                window.parent.closeModel();
            } else if (data.errno == 1) {
                $("#alertErr").show();
                $("#errodesc").html(data.errdesc);
                $("#btn").removeAttr("disabled");
            }
        });
    }
    function conditionChange(obj) {
        var val = obj.value;
        if (val == -1) {
            alert("请选择提升条件！");
            return false;
        }
        if (val == 1 || val == 2) {
            $("#toLevelA").removeAttr("disabled");
            $("#toLevelA").attr("checked", "checked");
            $("#toLevelB").attr("disabled", "disabled");
            $("#toLevelB").removeAttr("checked");
        } else if (val == 3 || val == 4) {
            $("#toLevelB").removeAttr("disabled");
            $("#toLevelB").attr("checked", "checked");
            $("#toLevelA").attr("disabled", "disabled");
            $("#toLevelA").removeAttr("checked");
        }

    }
</script>