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
                <form class="form-horizontal" id="myform" name="myform" action="${BasePath}/periodicremind/save" method="post">
                    <input type="hidden" id="type" name="type" value="${type }"/>
                    <input type="hidden" id="id" name="id" value="${remind.id }"/>
                    <input type="hidden" id="itemId" name="itemId" value="${itemId }"/>
                    <fieldset>


                        <div class="control-group">
                            <label class="control-label" for="platform" style="float: left;">平台：</label>

                            <div class="controls">
                                <label class="checkbox inline">
                                    <input type="checkbox" id="platform_1" name="platform" value="1"/>IOS
                                </label>
                                <label class="checkbox inline">
                                    <input type="checkbox" id="platform_0" name="platform" value="0"/>Android
                                </label>
                                <label class="checkbox inline">
                                    <input type="checkbox" id="platform_2" name="platform" value="2"/>WP
                                </label>
                            </div>
                        </div>


                        <div class="control-group">
                            <label class="control-label" for="name" style="float: left;">时期：
                            </label>
                            <div class="controls">
                                <label class="radio inline">
                                    <input type="radio" name="period" id="period_1" value="1" onclick="changeDay()">月经期
                                </label>

                                <label class="radio inline">
                                    <input type="radio" name="period" id="period_2" value="2" onclick="changeDay()" >卵泡期
                                </label>

                                <label class="radio inline">
                                    <input type="radio" name="period" id="period_3" value="3" onclick="changeDay()">排卵期
                                </label>

                                <label class="radio inline">
                                    <input type="radio" name="period" id="period_4" value="4" onclick="changeDay()" >黄体期
                                </label>

                                <label class="radio inline">
                                    <input type="radio" name="period" id="period_5" value="5" onclick="changeDay()" >排卵日
                                </label>
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" for="name" style="float: left;">范围：
                            </label>
                            <div class="controls">
                                <label class="radio inline">
                                    <input type="radio" name="range" id="range_-1" value="-1" onclick="changeDay()" >之前
                                </label>

                                <label class="radio inline">
                                    <input type="radio" name="range" id="range_0" value="0" onclick="changeDay()"  >之中
                                </label>

                                <label class="radio inline">
                                    <input type="radio" name="range" id="range_1" value="1" onclick="changeDay()" >之后
                                </label>
                            </div>
                        </div>



                        <div class="control-group">
                            <label class="control-label" for="name" style="float: left;">日期：
                            </label>
                            <div class="controls">
                                <select name="day" id="day" >
                                    <option value="1" <c:if test="${remind.day == 1 }">selected="selected" </c:if> >第1天</option>
                                    <option value="2" <c:if test="${remind.day == 2 }">selected="selected" </c:if> >第2天</option>
                                    <option value="3" <c:if test="${remind.day == 3 }">selected="selected" </c:if> >第3天</option>
                                    <option value="4" <c:if test="${remind.day == 4 }">selected="selected" </c:if> >第4天</option>
                                    <option value="5" <c:if test="${remind.day == 5 }">selected="selected" </c:if> >第5天</option>
                                    <option value="6" <c:if test="${remind.day == 6 }">selected="selected" </c:if> >第6天</option>
                                    <option value="7" <c:if test="${remind.day == 7 }">selected="selected" </c:if> >第7天</option>
                                    <option value="8" <c:if test="${remind.day == 8 }">selected="selected" </c:if> >第8天</option>
                                    <option value="9" <c:if test="${remind.day == 9 }">selected="selected" </c:if> >第9天</option>
                                    <option value="10" <c:if test="${remind.day == 10 }">selected="selected" </c:if>>第10天</option>
                                    <option value="11" <c:if test="${remind.day == 11 }">selected="selected" </c:if>>第11天</option>
                                    <option value="12" <c:if test="${remind.day == 12 }">selected="selected" </c:if>>第12天</option>
                                    <option value="13" <c:if test="${remind.day == 13 }">selected="selected" </c:if>>第13天</option>
                                    <option value="14" <c:if test="${remind.day == 14 }">selected="selected" </c:if>>第14天</option>
                                    <option value="15" <c:if test="${remind.day == 15 }">selected="selected" </c:if>>第15天</option>
                                </select>
                            </div>
                        </div>


                        <div class="control-group">
                            <label class="control-label" for="name" style="float: left;">提醒时间：
                            </label>
                            <div class="controls">
                                <label class="radio inline">
                                    <input type="radio" name="remindTime" id="remindTime_1" value="1">8:00
                                </label>

                                <label class="radio inline">
                                    <input type="radio" name="remindTime" id="remindTime_2" value="2">12:00
                                </label>

                                <label class="radio inline">
                                    <input type="radio" name="remindTime" id="remindTime_3" value="3">18:00
                                </label>

                                <label class="radio inline">
                                    <input type="radio" name="remindTime" id="remindTime_4" value="4">20:00
                                </label>
                            </div>
                        </div>



                        <div class="control-group">
                            <label class="control-label" for="content" style="float: left;">提醒内容：</label>
                            <div class="controls">
                                <input class="input-xlarge focused" name="content" id="content" value="${remind.content}"
                                       type="text" style="width: 200px"/>
                                <font color="green">20个字以内!</font>
                            </div>
                        </div>


                        <div class="control-group">
                            <label class="control-label" for="linkurl" style="float: left;">跳转链接：</label>

                            <div class="controls">
                                <input class="input-xlarge focused" name="linkurl" id="linkurl" value="${remind.linkurl}"
                                       type="text" style="width: 200px"/>
                            </div>
                        </div>


                        <div class="control-group">
                            <label class="control-label" for="name" style="float: left;">开始时间：</label>

                            <div class="controls">
                                <input id="start" name="start" class="Wdate" type="text"
                                       onfocus="WdatePicker({minDate:'%y-%M-{%d}',readOnly:'false',maxDate:'#F{$dp.$D(\'end\')}'})"
                                       style="width: 200px"/>
                                </div>
                            <label class="control-label" for="name" style="float: left;">结束时间：</label>
                            <div class="controls">
                                <input id="end" name="end" class="Wdate" type="text"
                                       onfocus="WdatePicker({readOnly:'false',minDate:'#F{$dp.$D(\'start\')}'})"
                                       style="width: 200px"/>
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
    function changeDay(){
        var range=$('input[name="range"]:checked').val();//-1 0 1
        var val=$('input[name="period"]:checked').val();
        if(val==3 && range==0) {
            $("#day").empty();
            for (var i = 1; i <= 10; i++) {
                $("#day").append("<option value='"+i+"'>第"+i+"天</option>");
             }
        }else if(val==4 && range==0){
            $("#day").empty();
            for (var i = 1; i <= 9; i++) {
                $("#day").append("<option value='"+i+"'>第"+i+"天</option>");
            }
        }else if(val==5 && range==0){
            $("#day").empty();
            for (var i = 1; i <= 1; i++) {
                $("#day").append("<option value='"+i+"'>第"+i+"天</option>");
            }
        }else{
            $("#day").empty();
            for (var i = 1; i <= 15; i++) {
                $("#day").append("<option value='"+i+"'>第"+i+"天</option>");
            }
        }

    }


    //ajax提交表单
    $(function () {

        setByIdFormatDate("start", "${remind.start}");
        setByIdFormatDate("end", "${remind.end}");


        var vals="${remind.period}";
        var val = vals.split(",");
        for(var i=0;i<val.length;i++){
            $("#period_" + val[i]).attr("checked", true);
        }

        var vals="${remind.range}";
        var val = vals.split(",");
        for(var i=0;i<val.length;i++){
            $("#range_" + val[i]).attr("checked", true);
        }

        var vals="${remind.remindTime}";
        var val = vals.split(",");
        for(var i=0;i<val.length;i++){
            $("#remindTime_" + val[i]).attr("checked", true);
        }


        var vals = "${remind.platform}";
        if (vals == "") {
            $("input[name='platform']").each(function() {
                this.checked = true;
            });
        } else {
            var val = vals.split(",");
            for (var i = 0; i < val.length; i++) {
                $("#platform_" + val[i]).attr("checked", true);
            }
        }

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
        var content = $("#content").val();
        var linkurl = $("#linkurl").val();

        var period = $("#period").val();
        var range = $("#range").val();
        var day = $("#day").val();
        var remindTime = $("#remindTime").val();

        var platformArry = new Array();
        $("input[name='platform']:checked").each(function () {
            var txt = $(this).val();
            platformArry.push(txt);
        });
        if (platformArry.length == 0) {
            alert("平台不可以为空,请勾选平台！");
            return false;
        }

        if (period == "") {
            alert("请勾选时期!");
            return false;
        }
        if (range == "") {
            alert("请勾选范围");
            return false;
        }
        if (day == "") {
            alert("请选择日期");
            return false;
        }
        if (remindTime == "") {
            alert("请勾选提醒时间");
            return false;
        }
        if (content == "") {
            alert("提醒内容不可为空");
            return false;
        }
        if (content.length > 20) {
            alert("提醒内容最长20个字！");
            return false;
        }

        if (linkurl == "") {
            alert("请填写跳转链接!");
            return false;
        }

        var startDate = $("#start").val();
        var endDate = $("#end").val();
        if (startDate == "" || endDate == "") {
            alert("请输入开始日期、结束日期！");
            return false;
        }
        return true;
    }

</script>