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
            <div class="muted pull-left">发送私信</div>
        </div>

        <div class="alert alert-error" id="alertErr" style="display: none;">
            <button class="close" data-dismiss="alert">×</button>
            <strong>Error!</strong> <span id="errodesc">This is an error message.</span>
        </div>
        <div class="block-content collapse in">
            <div class="span12">
                <form class="form-horizontal" id="myForm" name="myForm" action="${BasePath}/privateMsg/sendMessage" enctype="multipart/form-data" method="post">
                    <fieldset>
                        <div class="control-group">
                            <label class="control-label" for="sendUid" style="float: left;">发送者：</label>
                            <div class="controls">
                                <select name="sendUid"  id="sendUid" class="input-xlarge focused" >
                                    <c:forEach items="${uList}" var="obj" >
                                        <option  <c:if test="${dymUid == obj.uid}">selected="selected"</c:if> value="${obj.uid}">${obj.nick}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="receiveUid" style="float: left;">接收者UID：</label>
                            <div class="controls">
                                <textarea class="input-xlarge focused" id="receiveUid" name="receiveUid" readonly="true">${receiveUid}</textarea>
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" for="content" style="float: left;">回复内容 ：</label>
                            <div class="controls">
                                <textarea class="input-xlarge focused" id="content" name="content"style="width: 270px;height: 90px"></textarea>
                                <font color="red">
                                    <br>Max=500字
                                    <br>[[url=http://www.dayima.com]]大姨吗[[/url]]
                                    <br>文案“大姨吗”增加超链接,跳转至wap页面(内部浏览器)
                                </font>
                            </div>
                        </div>

                        <div class="control-group" id="uploadDiv">
                            <label class="control-label" for="pic" style="float: left;">图片：</label>

                            <div class="controls">
                                <input class="input-xlarge focused" name="pic" id="pic" type="file"/>
                                <br>
                                <font color="red">图片与文字二选一，如已添加图片内容则不保存！</font>
                            </div>
                        </div>

                        <div class="form-actions">
                            <button type="button" id="myBtn" onclick="saveForm()" class="btn btn-primary">发送</button>
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
        $("#myBtn").attr("disabled", "disabled");
        var content = $("#content").val();
        if(content == ""){
            alert("私信内容不能为空");
            return ;
        }
        if(content.length > 500){
            alert("私信内容不能超过500字,现在长度" + content.length);
            return ;
        }
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
<jsp:include page="../include/bottom.jsp"/>


