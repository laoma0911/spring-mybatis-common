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
                <form class="form-horizontal" id="myform" name="myform" action="${BasePath }/medal/save"
                      enctype="multipart/form-data" method="post">
                    <input type="hidden" id="type" name="type" value="${type }"/>
                    <input type="hidden" id="id" name="id" value="${medal.id }"/>
                    <input type="hidden" id="itemId" name="itemId" value="${itemId }"/>
                    <input type="hidden" id="oldPic" name="oldPic" value="${medal.icon }"/>
                    <fieldset>

                        <c:if test="${empty id}">
                            <div class="control-group">
                                <label class="control-label" for="id" style="float: left;">可选ID列表：</label>

                                <div class="controls">
                                    <select class="input-xlarge" id="position" name="position">
                                        <c:forEach items="${positions}" var="obj">
                                            <option
                                                    <c:if test="${medal.id == obj}">selected="selected" </c:if>
                                                    value="${obj}">${obj}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </c:if>

                        <div class="control-group">
                            <label class="control-label" for="medalType" style="float: left;">勋章类型：</label>
                            <div class="controls">
                                <select class="input-xlarge" id="medalType" name="medalType">
                                    <option <c:if test="${medal.type == 0}">selected="selected" </c:if> value="0">领域勋章</option>
                                    <option <c:if test="${medal.type == 1}">selected="selected" </c:if> value="1">特殊勋章</option>
                                </select>
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" for="name" style="float: left;">勋章名称：</label>

                            <div class="controls">
                                <input class="input-xlarge focused" name="name" id="name" value="${medal.name}"
                                       type="text"/>
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" for="groupId" style="float: left;">推荐：</label>
                            <div class="controls">
                                <select class="input-xlarge" id="recommend" name="recommend">
                                    <option value="0">推荐</option>
                                    <option value="1">不推荐</option>
                                </select>
                            </div>
                        </div>

                        <div class="control-group" id="uploadDiv">
                            <label class="control-label" for="name" style="float: left;">图标：</label>

                            <div class="controls">
                                <input class="input-xlarge focused" name="icon" id="icon" value="${medal.icon }"
                                       type="file"/><font color="green">(图标规格:正方形)</font>
                                <br>
                                <c:if test="${medal.icon!=null && medal.icon!=''}">
                                    <img alt="" src="${medal.icon }" height="20PX" width="60PX">
                                </c:if>
                            </div>
                        </div>


                        <div class="control-group">
                            <label class="control-label" for="name" style="float: left;">规则：</label>

                            <div class="controls">
                                <textarea class="input-xlarge focused" id="rule" name="rule">${medal.rule}</textarea>
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
        var rule = $("#rule").val();

        if (name == "") {
            alert("勋章名称不能为空！");
            return false;
        }
        if (name.length > 6) {
            alert("勋章名称最长六个字！");
            return false;
        }

        if (rule == "") {
            alert("请填写规则!");
            return false;
        }

        if (rule.length > 500) {
            alert("规则不可超过500字,请重新编辑!");
            return false;
        }
        var oldPic = $("#oldPic").val();
        var file = $("#icon").val();
        if (oldPic == "" && file == "") {
            alert("请上传图片！");
            return false;
        }
        return true;
    }

</script>