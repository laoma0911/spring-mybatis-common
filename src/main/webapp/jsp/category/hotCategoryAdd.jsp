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
            <div class="muted pull-left">热门小组推荐 添加|修改</div>
        </div>

        <div class="alert alert-error" id="alertErr" style="display: none;">
            <button class="close" data-dismiss="alert">×</button>
            <strong>Error!</strong> <span id="errodesc">This is an error message.</span>
        </div>
        <div class="block-content collapse in">
            <div>
                <form class="form-horizontal" id="myform" name="myform" action="${BasePath }/groupCategory/hotCategorySave"
                      enctype="multipart/form-data" method="post">
                    <input type="hidden" id="type" name="type" value="${type }"/>
                    <input type="hidden" id="id" name="id" value="${json.scheduleId }"/>
                    <input type="hidden" id="itemId" name="itemId" value="${itemId }"/>
                    <fieldset>
                        <%--<div class="control-group">--%>
                            <%--<label class="control-label" for="catType" style="float: left;">分类：</label>--%>
                            <%--<div class="controls">--%>
                                <%--<select name="catType" id="catType" onchange="getCategory(this)" >--%>
                                    <%--<option value="-1">请选择</option>--%>
                                    <%--<c:forEach items="${tgcList}" var="obj">--%>
                                        <%--<option--%>
                                                <%--<c:if test="${obj.id == json.catTypeId}">selected="selected" </c:if>--%>
                                                <%--value="${obj.id}">${obj.title}--%>
                                        <%--</option>--%>
                                    <%--</c:forEach>--%>
                                <%--</select>--%>
                            <%--</div>--%>
                        <%--</div>--%>

                        <div class="control-group">
                            <label class="control-label" for="category" style="float: left;">小组：</label>
                            <div class="controls">
                                <select name="category" id="category">
                                    <c:forEach items="${categoryList}" var="obj">
                                        <option
                                                <c:if test="${obj.id == json.id}">selected="selected" </c:if>
                                                value="${obj.id}">${obj.title}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>


                        <div class="control-group">
                            <label class="control-label" for="Date" style="float: left;">在线时间：</label>
                            <div class="controls">
                                <input id="startDate" name="startDate" class="Wdate" type="text" onfocus="WdatePicker({minDate:'%y-%M-{%d}',readOnly:'false',maxDate:'#F{$dp.$D(\'endDate\')}'})"/>
                                至
                                <input id="endDate" name="endDate" class="Wdate" type="text" onfocus="WdatePicker({readOnly:'false',minDate:'#F{$dp.$D(\'startDate\')}'})"/>
                            </div>
                        </div>


                        <div class="control-group">
                            <label class="control-label" for="title" style="float: left;">组名关键字：</label>

                            <div class="controls">
                                <input class="input-xlarge focused" name="title" id="title" style="width:205px;" type="text"/>
                                <input type="button" id="search" name="search" onclick="toSearch()" value="搜索"/><font
                                    color="green">此处可以搜索要推荐的小组！
                            </font>
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" for="position" style="float: left;">位置：</label>

                            <div class="controls">
                                <input class="input-xlarge focused" name="position" id="position"
                                       value="${json.position}" style="width:205px;" type="text"/>
                                <font color="green">
                                    <br>此处填入推荐小组的排位，例如：如果××小组是放在第一位那么填入：1 就可以了！(该项值不可填小于等于0的数字)</font>
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

    // 模糊匹配搜索小组名
    function toSearch(){
        $("#alertErr").hide();
        var title = $("#title").val();
        if (title=='' || title == null){
            alert("请填写关键字!");
            return false;
        }
        var aj = $.ajax( {
            url:'${BasePath}/groupCategory/getCategoryByTitle?title='+title,
            type:'post',
            cache:false,
            dataType:'json',
            success:function(data) {
                if(data.errno==0){
                    $("#category").empty();
                    var size=data.data.length;
                    for(var i=0;i<size;i++){
                        $("#category").append("<option value='"+data.data[i].id+"' >"+data.data[i].title+"</option>");
                    }
                    if(size==0){
                        $("#alertErr").show();
                        $("#errodesc").html("未找到相关小组，请重新填写!");
                    }
                }else{
                    alert(data.errdesc);
                }
            },
            error : function() {
                $("#alertErr").show();
                $("#errodesc").html("操作出错,请联系管理员");
            }
        });
    }


    function getCategory(obj){
        $("#alertErr").hide();
        var id=obj.value;
        //1.$.ajax带json数据的异步请求
        var aj = $.ajax( {
            url:'${BasePath}/topicTag/getCategoryJson?id='+id,
            type:'post',
            cache:false,
            dataType:'json',
            success:function(data) {
                if(data.errno==0){
                    $("#category").empty();
                    var size=data.data.length;
                    for(var i=0;i<size;i++){
                        $("#category").append("<option value='"+data.data[i].id+"' >"+data.data[i].title+"</option>");
                    }
                    if(size==0){
                        alert("该分类下没有小组，请重新选择！");
                    }
                }else{
                    alert(data.errdesc);
                }
            },
            error : function() {
                alert("异常！");
            }
        });

    }


    //回显时间
    $(function () {
        setByIdFormatDate("startDate","${json.startDate}");
        setByIdFormatDate("endDate","${json.endDate}");
    });


    //ajax提交表单
    $(function () {
        $("#alertErr").hide();
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
        var position = $("#position").val();
        var category = $("#category").val();
        var startDate = $("#startDate").val();
        var endDate = $("#endDate").val();
        if (category == '' || category == null) {
            alert("请选择小组!");
            return false;
        }
        if (position == "" || position == '') {
            alert("请填写位置!");
            return false;
        }
        if (position <= '0' || isNaN(position) || position <= 0){
            alert("该项值不可填小于等于0的数字或汉字!");
            return false;
        }
        if (startDate == "" || endDate == "") {
            alert("请填写起止时间!");
            return false;
        }
        return true;
    }
</script>