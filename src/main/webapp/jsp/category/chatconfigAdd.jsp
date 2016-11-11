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
            <div class="muted pull-left">群聊全局公告 新增|修改</div>
        </div>

        <div class="alert alert-error" id="alertErr" style="display: none;">
            <button class="close" data-dismiss="alert">×</button>
            <strong>Error!</strong> <span id="errodesc">This is an error message.</span>
        </div>
        <div class="block-content collapse in">
            <div>
                <form class="form-horizontal" id="myform" name="myform" action="${BasePath}/chatconfig/save" method="post">
                    <input type="hidden" id="type" name="type" value="${type }"/>
                    <input type="hidden" id="id" name="id" value="${config.id }"/>
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
                            <label class="control-label" for="content" style="float: left;">提醒内容：</label>
                            <div class="controls">
                                <input class="input-xlarge focused" name="announcement" id="announcement" value="${config.announcement}"
                                       type="text" style="width: 200px"/>
                                <font color="green">30个字以内!</font>
                            </div>
                        </div>


                        <div class="control-group">
                            <label class="control-label" for="linkurl" style="float: left;">跳转链接：</label>

                            <div class="controls">
                                <input class="input-xlarge focused" name="link" id="link" value="${config.link}"
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
    //ajax提交表单
    $(function () {

        setByIdFormatDate("start", "${config.start}");
        setByIdFormatDate("end", "${config.end}");


        var vals = "${config.platform}";
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
        var announcement = $("#announcement").val();
//        var link = $("#link").val();

        var platformArry = new Array();
        $("input[name='platform']:checked").each(function () {
            var txt = $(this).val();
            platformArry.push(txt);
        });
        if (platformArry.length == 0) {
            alert("平台不可以为空,请勾选平台！");
            return false;
        }

        if (announcement == "") {
            alert("公告内容不可为空");
            return false;
        }
        if (announcement.length > 30) {
            alert("公告内容最长30个字！");
            return false;
        }

//        if (link == "") {
//            alert("请填写公告链接!");
//            return false;
//        }

        var startDate = $("#start").val();
        var endDate = $("#end").val();
        if (startDate == "" || endDate == "") {
            alert("请输入开始日期、结束日期！");
            return false;
        }
        return true;
    }

</script>