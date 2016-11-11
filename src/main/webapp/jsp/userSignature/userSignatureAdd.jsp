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
            <div class="muted pull-left">添加 | 修改 签名管理</div>
        </div>

        <div class="alert alert-error" id="alertErr" style="display: none;">
            <button class="close" data-dismiss="alert">×</button>
            <strong>Error!</strong> <span id="errodesc">This is an error message.</span>
        </div>
        <div class="block-content collapse in">
            <div class="span12">
                <form class="form-horizontal" id="myForm" name="myForm" action="${BasePath }/userSignature/save"
                      enctype="multipart/form-data" method="post">
                    <input type="hidden" id="id" name="uid" value="${uid }"/>
                    <input type="hidden" id="deletePicFlag" name="deletePicFlag" value="0"/>
                    <fieldset>
                        <div class="control-group">
                            <label class="control-label" for="signature" style="float: left;">文字签名：</label>

                            <div class="controls">
                                <input type="text" id="signature" name="signature"
                                       value="${userSignature.signature}"/><font color="red">不超过16个字</font>
                            </div>

                        </div>
                        <div class="control-group">
                            <label class="control-label" for="pic" style="float: left;">图片签名：</label>

                            <div class="controls">
                                <input class="input-xlarge focused" name="pic" id="pic" value="${userSignature.pic }"
                                       type="file"/>
                                <font color="red">图片大小750*600</font>
                                <br>
                                <c:if test="${userSignature.pic!=null && userSignature.pic!=''}">
                                    <img alt="" src="${imageHost }${userSignature.pic }" width="80px" height="80px"
                                         id="picImg">
                                    <button type="button" class="btn btn-danger btn-small" onclick="deletePic1();">删除
                                    </button>
                                </c:if>

                            </div>

                        </div>

                        <div class="form-actions">
                            <button type="button" id="myBtn" onclick="saveForm()" class="btn btn-primary">确定
                            </button>
                        </div>
                    </fieldset>
                </form>
            </div>
        </div>
    </div>
    <!-- /block -->
</div>
<script>
    function deletePic1() {
        $("#picImg").hide();
        $("#pic").val("");
        $("#deletePicFlag").val("1");
        //return  false;
    }
    /**
     *去掉签名字符串空格 以及计算长度 中文长度2 英文 数字为1  16个字符 意味长度32
     * @param str
     * @returns {*}
     */
    function strlen(str) {
        if (str == null) return 0;
        if (typeof str != "string") {
            str += "";
        }
        return str.replace(/^\s+|\s+$/g, "").replace(/[^\x00-\xff]/g, "01").length;
    }
  //  alert(strlen(" zhao1"));
    function saveForm() {
        var sign = $.trim($("#signature").val());
        var pic = $("#pic").val();
        var id = $("#id").val();
//        if (sign == "") {
//            alert("签名不能为空！");
//            return false;
//        }
        $("#signature").val(sign);
        if (strlen(sign)> 32) {
            alert("签名不能超过16个字哦！");
            return false;
        }
        if (id == "" && pic == "") {
            alert("请上传图片！");
            return false;
        }

        $("#myBtn").attr("disabled", "disabled");
        $('#myForm').ajaxSubmit(function (data) {
            if (data.errno == 1) {
                $("#myBtn").removeAttr("disabled");
                $("#alertErr").show();
                $("#errodesc").html(data.errdesc);
            } else {
                alert("操作成功！");
                window.parent.closeModel();
            }
        });
    }
</script>

