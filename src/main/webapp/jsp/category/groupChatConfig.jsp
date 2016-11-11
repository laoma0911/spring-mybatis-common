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
            <div class="muted pull-left">小组管理聊天设置</div>
        </div>

        <div class="alert alert-error" id="alertErr" style="display: none;">
            <button class="close" data-dismiss="alert">×</button>
            <strong>Error!</strong> <span id="errodesc">This is an error message.</span>
        </div>
        <div class="block-content collapse in">
            <div>
                <form class="form-horizontal" id="myform" name="myform" action="${BasePath }/groupchatconfig/setGroupChatConfig"
                      enctype="multipart/form-data" method="post">
                    <input type="hidden" id="type" name="type" value="${type }"/>
                    <input type="hidden" id="groupId" name="groupId" value="${chatConfig.groupId}"/>
                    <input type="hidden" id="itemId" name="itemId" value="${itemId }"/>


                        <div class="control-group">
                            <label class="control-label" for="name" style="float: left;">公告：</label>

                            <div class="controls">
                                <input class="input-xlarge focused" name="announcement" id="announcement"
                                       value="${chatConfig.announcement}" type="text"/>
                            </div>
                        </div>


                            <div class="control-group">
                                <label class="control-label" for="name" style="float: left;">链接：</label>

                                <div class="controls">
                                    <input class="input-xlarge focused" name="link" id="link" value="${chatConfig.link}"
                                           type="text"/>
                                </div>
                            </div>

                    <!-- 屏蔽小组聊天最大人数，暂时由悟空获取支持最大人数  by： mzb   2015-11-30 -->
                        <%--<div class="control-group">--%>
                            <%--<label class="control-label" for="name" style="float: left;">最大人数：</label>--%>

                            <%--<div class="controls">--%>
                                <%--<input class="input-xlarge focused" name="maxnum" id="maxnum"--%>
                                       <%--value="${chatConfig.maxnum}" type="text"/>--%>
                                <%--<font color="green">只可填写数字</font>--%>
                            <%--</div>--%>
                        <%--</div>--%>

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
        var announcement = $("#announcement").val();
//        var link = $("#link").val();
//        var maxnum = $("#maxnum").val();
        if (announcement == "") {
            alert("公告不能为空！");
            return false;
        }
//        if (link == "") {
//            alert("链接不能为空！");
//            return false;
//        }
//        if (maxnum == "" || isNaN(maxnum)) {
//            alert("最大人数不能为空切必须为数字！");
//            return false;
//        }
        return true;
    }
</script>
