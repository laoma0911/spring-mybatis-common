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
            <div class="muted pull-left">小组管理 添加|修改</div>
        </div>

        <div class="alert alert-error" id="alertErr" style="display: none;">
            <button class="close" data-dismiss="alert">×</button>
            <strong>Error!</strong> <span id="errodesc">This is an error message.</span>
        </div>
        <div class="block-content collapse in">
            <div>
                <form class="form-horizontal" id="myform" name="myform" action="${BasePath }/groupCategory/categorySave"
                      enctype="multipart/form-data" method="post">
                    <input type="hidden" id="type" name="type" value="${type }"/>
                    <input type="hidden" id="id" name="id" value="${json.id }"/>
                    <input type="hidden" id="itemId" name="itemId" value="${itemId }"/>
                    <input type="hidden" id="oldPic" name="oldPic" value="${json.pic }"/>
                    <input type="hidden" id="oldbackground" name="oldbackground" value="${json.background }"/>
                    <fieldset>
                        <div class="control-group inline" id="userDiv"
                             <c:if test="${json.uid!=null &&  json.uid==0 }">style="display: none;"</c:if> >
                            <label class="control-label inline" for="name" style="float: left;">组长UID：</label>

                            <div class="controls inline">
                                <input class="input-xlarge focused inline" name="uid" id="uid" value="${json.uid }" onblur="getNick()" type="text"/>
                                组长昵称：<input class="input-xlarge focused inline" name="nick" id="nick" <c:if test="${json==null || json.uid>0 }">readonly</c:if> value="${json.nick}" type="text"/>
                            </div>
                        </div>


                        <div class="control-group">
                            <label class="control-label" for="name" style="float: left;">分类：</label>

                            <div class="controls">
                                <select name="catType" id="catType">
                                    <c:forEach items="${tgcList}" var="obj">
                                        <option
                                                <c:if test="${obj.id == json.catId}">selected="selected" </c:if>
                                                value="${obj.id}">${obj.title}
                                        </option>
                                    </c:forEach>
                                </select>

                                小组类型：
                                <select name="teamType" id="teamType" onchange="typeChange(this)">
                                    <c:forEach items="${staticCategoryList}" var="obj">
                                        <option
                                                <c:if test="${obj.id == '9_9'}">disabled=""</c:if>
                                                <c:if test="${obj.id == json.teamTypeAndType}">selected="selected" </c:if>
                                                value="${obj.id}">${obj.title}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>


                        <div class="control-group">
                            <label class="control-label" for="name" style="float: left;">小组名称：</label>

                            <div class="controls">
                                <input class="input-xlarge focused" name="title" id="title" value="${json.title}"
                                       type="text"/>
                            </div>
                        </div>

                        <div class="control-group" id="uploadDiv">
                            <label class="control-label" for="name" style="float: left;">小组头像：</label>

                            <div class="controls">
                                <input class="input-xlarge focused" name="pic" id="pic" value="${json.pic }"
                                       type="file"/>
                                <font color="green">只可上传200*200的图片</font>
                                <br>
                                <c:if test="${json.pic!=null && json.pic!=''}">
                                    <img alt="" src="${imageHost}${json.pic }" height="20PX" width="60PX">
                                </c:if>
                            </div>
                        </div>


                        <div class="control-group" id="backgroundDiv">
                            <label class="control-label" for="name" style="float: left;">小组背景图：</label>

                            <div class="controls">
                                <input class="input-xlarge focused" name="background" id="background" value="${json.background}" type="file"/>
                                <font color="green">只可上传500*350 ,大小限制200KB内。</font>
                                <br>
                                <c:if test="${json.background!=null && json.background!=''}">
                                    <img alt="" src="${imageHost}${json.background }" height="20PX" width="60PX">
                                </c:if>
                            </div>
                        </div>


                        <div class="control-group">
                            <label class="control-label" for="name" style="float: left;">简介：</label>

                            <div class="controls">
                                <textarea class="input-xlarge focused" id="desc" name="desc">${json.descs}</textarea>
                            </div>
                        </div>

                        <span id="showlink" style="display:none">
                            <div class="control-group">
                                <label class="control-label" for="name" style="float: left;">链接：</label>

                                <div class="controls">
                                    <input class="input-xlarge focused" name="link" id="link" value="${json.link}"
                                           type="text"/>
                                </div>
                            </div>
                        </span>

                        <div class="control-group">
                            <label class="control-label" for="name" style="float: left;">排序值：</label>

                            <div class="controls">
                                <input class="input-xlarge focused" name="displayorder" id="displayorder"
                                       value="${json.displayorder}"  <c:if test="${json.id == null}">onblur="checkable()"</c:if> type="text"/>
                                <font color="green">只可填写数字(排序值最大的会在第1位显示)</font>
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
    function typeChange(obj) {
        var type = obj.value;
        if (type == "2_0") {
            $("#showlink").show();
        } else {
            $("#showlink").hide();
        }
    }


    //验证表单数据
    function checkForm() {
        var catTitle = $("#catTitle").val();
        var uid = $("#uid").val();
        var nick = $("#nick").val();
        if (uid == "" || nick == "") {
            alert("组长UID不能为空！");
            return false;
        }
        if (catTitle == "") {
            alert("小组名称不能为空！");
            return false;
        }
        var oldPic = $("#oldPic").val();
        var oldbackground = $("#oldbackground").val();
        var file = $("#pic").val();
        var background = $("#background").val();
        if (oldPic == "" && file == "") {
            alert("请上传小组头像！");
            return false;
        }
        if (oldbackground == "" && background == "") {
            alert("请上传小组背景图！");
            return false;
        }
        return true;
    }
</script>
<script>
    //根据uid获取UserInfo
    function getNick() {
        var id = $("#uid").val();
        if (id == "") {
            $("#alertErr").show();
            $("#uid").val("");
            $("#errodesc").html("组长UID不能为空！");
            return false;
        } else if (isNaN(id)) {
            $("#alertErr").show();
            $("#uid").val("");
            $("#errodesc").html("组长UID请输入数字!");
            return false;
        }
        $.ajax({
            type: "POST",
            url: "${BasePath }/groupCategory/getUser?id=" + id,
            datatype: "json",
            success: function (data) {
                if (data.errno == 1) {
                    $("#alertErr").show();
                    $("#nick").val("");
                    $("#errodesc").html(data.errdesc);
                } else {
                    if (data.data.nick == null || data.data.nick == "") {
                        $("#alertErr").show();
                        $("#nick").val("");
                        $("#errodesc").html("用户的昵称为空！");
                    } else {
                        $("#alertErr").hide();
                        $("#nick").val(data.data.nick);
                    }
                }
            },
            error: function () {
                alert("操作出错，请联系管理员！");
            }
        });
    }

    function checkable() {
        $("#alertErr").hide();
        var displayorder = $("#displayorder").val();
        if (displayorder=='' ||displayorder==null){
            displayorder = 0;
        }
        var catType = $("#catType").val();
        $.ajax({
            type: "POST",
            url: "${BasePath }/groupCategory/checkable?displayorder=" + displayorder +"&catId="+catType,
            datatype: "json",
            success: function (data) {
                if (data.errno == 1) {
                    $("#alertErr").show();
                    $("#errodesc").html(data.errdesc);
                }
//                else {
//                    $("#alertErr").show();
//                    $("#errodesc").html("该位置");
//                }
            },
            error: function () {
                alert("操作出错，请联系管理员！");
            }
        });
    }
</script>