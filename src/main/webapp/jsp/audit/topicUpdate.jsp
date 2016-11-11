<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../include/head.jsp"/>
<script type="text/javascript" src="${BasePath }/js/kindeditor/kindeditor-min.js"></script>
<script type="text/javascript" src="${BasePath }/js/kindeditor/lang/zh_CN.js"></script>
<script>
    var editorIntro;
    KindEditor.ready(function (K) {
        editorIntro = K.create('textarea[name="content"]', {
            filterMode: true,
            htmlTags: {
                span: ['.color'],
                p: [],
                strong: [],
                a: ["href", "target"],
                //br: [],
                img: ["src", "width", "height"]
            },
            newlineTag: "p",
            uploadJson: '${BasePath}/article/uploadimage',
            items: ['undo', 'redo', 'image', 'multiimage', 'forecolor', 'bold', 'link', 'source', 'preview', 'fullscreen'],
            afterChange: function () {
                this.sync();
            }
        });
    });
</script>
<style>
    body {
        padding-top: 0px;
    }
</style>
<!-- Body -->
<div class="container-fluid">
    <div class="block">
        <div class="navbar navbar-inner block-header">
            <div class="muted pull-left">话题内容修改</div>
        </div>
        <div class="alert alert-error" id="alertErr" style="display: none;">
            <button class="close" data-dismiss="alert">×</button>
            <strong>Error!</strong> <span id="errodesc">This is an error message.</span>
        </div>
        <div class="block-content collapse in">
            <div>
                <form class="form-horizontal" id="myForm" name="myForm" action="${BasePath }/topic/saveTopic" enctype="multipart/form-data" method="post">
                    <input type="hidden" id="id" name="id" value="${topic.id }"/>
                    <div class="control-group">
                        <label class="control-label" for="title" style="float: left;">标题：</label>
                        <div class="controls">
                            <input class="input-xlarge focused" name="title" id="title" value="${topic.title }" type="text"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="content" style="float: left;">正文：</label>
                        <div class="controls">
                            <textarea id="content" name="content" cols="100" rows="8" style="position:fixed;padding-top: 100px; width:90%;height:600px;visibility:hidden;">${topic.content }</textarea>
                        </div>
                    </div>
                    <div class="control-group" >
                        <label class="control-label" for="pic" style="float: left;">头图：</label>
                        <div class="controls">
                            <input class="input-xlarge focused" name="pic" id="pic" value=""   type="file" />最小为600*600
                            <br>
                            <c:if test="${topicPic!=null && topicPic.oriPic!=''}">
                                <img alt="" src="${imageHost }${topicPic.oriPic }"  width="80px"  height="80px">
                            </c:if>
                        </div>
                    </div>
                    <div class="form-actions">
                        <input type="button" id="btn" class="btn btn-primary" value="保存"/>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    $('#btn').click(function () {
        var flag = checkForm();
        if (flag) {
            $("#btn").attr("disabled", "disabled");
            $('#myForm').ajaxSubmit(function (data) {
                if (data.errno == 0) {
                    alert("操作成功！");
                    $("#btn").removeAttr("disabled");
                    //  window.parent.closeModel();
                } else if (data.errno == 1) {
                    $("#alertErr").show();
                    $("#errodesc").html(data.errdesc);
                    $("#btn").removeAttr("disabled");
                }
            });
        }
    });

    function checkForm() {
        var title = $("#title").val();
        if (title == "") {
            alert("活动标题不能为空！");
            return false;
        }
        var content = $("#content").val();
        if (content == "") {
            alert("请输入正文！");
            return false;
        }
        return true;
    }
</script>