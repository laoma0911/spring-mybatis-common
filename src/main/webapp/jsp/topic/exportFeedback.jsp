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
            <div class="muted pull-left">导出软件反馈</div>
        </div>

        <div class="alert alert-error" id="alertErr" style="display: none;">
            <button class="close" data-dismiss="alert">×</button>
            <strong>Error!</strong> <span id="errodesc">This is an error message.</span>
        </div>
        <div class="block-content collapse in">
            <div class="span12">
                <form class="form-horizontal" id="saveCustom" name="saveCustom" action="${BasePath }/topic/exportsoftFeedExcel"
                      enctype="multipart/form-data" method="post">
                    <input type="hidden" id="type" name="type" value="${type }"/>
                    <input type="hidden" id="itemId" name="itemId" value="${itemId }"/>
                    <fieldset>
                        <%--<div class="control-group">--%>
                            <%--<label class="control-label" for="name" style="float: left;">导出的开始时间：</label>--%>

                            <%--<div class="controls">--%>
                                <%--<input type="text" class="Wdate" id="startDate" name="startDate"--%>
                                       <%--onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'upTime\')}',maxDate:'#F{$dp.$D(\'downTime\')}',readOnly:'false'})"/>--%>
                            <%--</div>--%>
                            <%--<label class="control-label" for="name" style="float: left;">导出的结束时间：</label>--%>

                            <%--<div class="controls">--%>
                                <%--<input type="text" class="Wdate" id="endDate" name="endDate"--%>
                                       <%--onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'startDate\')}',maxDate:'#F{$dp.$D(\'downTime\')}',readOnly:'false'})"/>--%>
                            <%--</div>--%>
                        <%--</div>--%>


                        <div class="control-group">
                            <label class="control-label" for="name" style="float: left;">导出的开始时间：</label>
                            <div class="controls">
                                <input type="text" class="Wdate" id="startDate" name="startDate"
                                       onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'endDate\')}',readOnly:'false'})" />
                            </div>
                            <br>
                            <label class="control-label" for="name" style="float: left;">导出的结束时间：</label>
                            <div class="controls">
                                <input type="text" class="Wdate" id="endDate" name="endDate"
                                       onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'startDate\')}',maxDate:'%y-%M-%',readOnly:'false'})" />
                            </div>
                        </div>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            下载后的csv文件 需要使用,来进行分列
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
<script>
    function checkForm() {

        var startDate = $("#startDate").val();
        if (startDate == "") {
            alert("请输入开始时间！");
            return false;
        }
        var endDate = $("#endDate").val();
        if (endDate == "") {
            alert("请输入结束时间！");
            return false;
        }
        return true;
    }
</script>
<jsp:include page="../include/bottom.jsp"/>
<script>
    function submitForm() {
        var flag = checkForm();
        if (flag) {
            document.getElementById("saveCustom").submit();

//            window.parent.closeModel();
        }
    }

    $(function () {
        setByIdFormatTime("startDate", "${startTime}");
        setByIdFormatTime("endDate", "${endTime}");
    });

</script>