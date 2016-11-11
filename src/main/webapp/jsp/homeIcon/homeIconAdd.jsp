<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../include/head.jsp"/>
<style>
    body{
        padding-top: 0px;
    }
</style>
<!-- Body -->
<div class="container-fluid">

    <!-- block -->
    <div class="block">
        <div class="navbar navbar-inner block-header">
            <div class="muted pull-left">设置 首页入口ICON</div>
        </div>

        <div class="alert alert-error" id="alertErr" style="display: none;">
            <button class="close" data-dismiss="alert">×</button>
            <strong>Error!</strong> <span id="errodesc">This is an error message.</span>
        </div>
        <div class="block-content collapse in">
            <div class="span12">
                <form class="form-horizontal" id="saveCustom" name="saveCustom" action="${BasePath }/homeIcon/save"
                      enctype="multipart/form-data" method="post">
                    <input type="hidden" id="type" name="type" value="${type }"/>
                    <input type="hidden" id="id" name="id" value="${json.data.id}"/>
                    <input type="hidden" id="itemId" name="itemId" value="${itemId }"/>
                    <input type="hidden" id="oldPic" name="oldPic" value="${json.data.imgPath }"/>
                    <fieldset>
                        <div class="control-group">
                            <label class="control-label" for="name"
                                   style="float: left;">位置：</label>

                            <div class="controls">
                                <select name="position" id="position" onclick="checklinkShow()">
                                    <option value="1"
                                            <c:if test="${json.data.position==1 }">selected="selected" </c:if>  >
                                        位置1
                                    </option>
                                    <option value="2"
                                            <c:if test="${json.data.position==2 }">selected="selected" </c:if>>
                                        位置2
                                    </option>
                                    <option value="3"
                                            <c:if test="${json.data.position==3 }">selected="selected" </c:if>>
                                        位置3
                                    </option>
                                    <option value="4"
                                            <c:if test="${json.data.position==4 }">selected="selected" </c:if>>
                                        位置4
                                    </option>
                                </select>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="name"
                                   style="float: left;">添加图片：</label>

                            <div class="controls">
                                <input class="input-xlarge focused" name="imgPath" id="imgPath"
                                       value="${json.data.imgPath }" type="file"/><font color="green">图片规格：82*77</font>
                                <br>
                                <c:if test="${json.data.imgPath!=null && json.data.imgPath!=''}">
                                    <img alt="" src="${imageHost }${json.data.imgPath }">
                                </c:if>

                            </div>
                        </div>
                        <%--<span id="linkShow" <c:if test="${json.data==null || json.data.position==1 || json.data.position==4 }">style="display: none"}</c:if>  >--%>
                        <%--<div class="control-group">--%>
                        <%--<label class="control-label" for="name"--%>
                        <%--style="float: left;">跳转链接：</label>--%>

                        <%--<div class="controls">--%>
                        <%--<input class="input-xlarge focused" name="link" id="link"--%>
                        <%--value="${json.data.url}" type="text"/>--%>
                        <%--</div>--%>
                        <%--</div>--%>
                        <%--</span>--%>
                        <div class="control-group">
                            <label class="control-label" for="name"
                                   style="float: left;">显示文案：</label>

                            <div class="controls">
                                <input class="input-xlarge focused" name="title" id="title"
                                       value="${json.data.title}" type="text"/><font color="green">限制十个字以内</font>
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" for="name" style="float: left;">在线时间：</label>

                            <div class="controls">
                                <input id="startDate" name="startDate" class="Wdate" type="text"
                                       onfocus="WdatePicker({minDate:'%y-%M-{%d}',readOnly:'false',maxDate:'#F{$dp.$D(\'endDate\')}'})"/>
                                至
                                <input id="endDate" name="endDate" class="Wdate" type="text"
                                       onfocus="WdatePicker({readOnly:'false',minDate:'#F{$dp.$D(\'startDate\')}'})"/>
                            </div>
                        </div>

                        <div class="form-actions">
                            <button type="button"  id="myBtn" onclick="submitForm()" class="btn btn-primary">保存</button>
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
        var title = $("#title").val();
        if (title == "") {
            alert("文案不能为空！");
            return false;
        }
        if (title.length > 10) {
            alert("文案长度过程，限定10个字之内！");
            return false;
        }
        var id = $("#id").val();
        var imgPath = $("#imgPath").val();
        if (id == "" && imgPath == "") {
            alert("请上传图片");
            return false;
        }
//        var position=$("#position").val();
//        var link = $("#link").val();
//        if ((position==2 || position==3) && link == "") {
//            alert("请输入跳转链接地址！");
//            return false;
//        }
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
       	 	$("#myBtn").attr("disabled","disabled");
            $('#saveCustom').ajaxSubmit(function (data) {
                if (data.errno == 0) {
                    alert("操作成功！");
                    window.parent.closeModel();
                } else if (data.errno == 1) {
                    $("#alertErr").show();
                    $("#errodesc").html(data.errdesc);
                    $("#myBtn").removeAttr("disabled");
                }
            });
        }
    }

    $(function () {
        setByIdFormatDate("startDate", "${json.data.startTime}");
        setByIdFormatDate("endDate", "${json.data.endTime}");
    });

    function checklinkShow() {
        if ($("#position").val() == 1 || $("#position").val() == 4) {
            $("#linkShow").hide();
        } else {
            $("#linkShow").show();
        }
    }
</script>