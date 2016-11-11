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
        </div>

        <div class="alert alert-error" id="alertErr" style="display: none;">
            <button class="close" data-dismiss="alert">×</button>
            <strong>Error!</strong> <span id="errodesc">This is an error message.</span>
        </div>
        <div class="block-content collapse in">
            <div class="span12">
                <form class="form-horizontal" id="myForm" name="myForm"  action="${BasePath }/tipsCategory/save"  enctype="multipart/form-data"   method="post">
                    <input type="hidden" id="id" name="id" value="${json.data.id }"/>
                    <input type="hidden" id="hiddenPic" name="hiddenPic" value="${json.data.pic }"/>

                    <fieldset>
                        <div class="control-group">
                            <label class="control-label" for="name" style="float: left;">名称：</label>
                            <div class="controls">
                                <input type="text"  id="name" name="name" value="${json.data.name}"  />
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" for="displayorder" style="float: left;">排序值：</label>
                            <div class="controls">
                                <input type="text"  id="displayorder" name="displayorder" value="${json.data.displayOrder}"  />
                            </div>
                        </div>

                        <div class="control-group" id="uploadDiv"   >
                            <label class="control-label" for="pic" style="float: left;">上传图片：</label>
                            <div class="controls">
                                <input class="input-xlarge focused" name="pic" id="pic" value="${json.data.pic }"   type="file" /><span style="color: #ff0000">(png.jpg,jpeg,尺寸：150*150)</span>
                                <br>
                                <c:if test="${json.data.pic!=null && obj.pic!=''}">
                                    <img alt="" src="${imageHost }${json.data.pic }"  width="80px"  height="80px">
                                </c:if>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="keywords" style="float: left;">关键字：</label>
                            <div class="controls">
                                <textarea class="input-xlarge focused"  name="keywords"  id="keywords">${json.data.keywords }</textarea><span style="color: #ff0000">关键字之间用‘,’隔开</span>
                            </div>
                        </div>
                        <div class="form-actions">
                            <button type="button" id="myBtn"  onclick="saveForm()" class="btn btn-primary">保存</button>
                        </div>
                    </fieldset>
                    <input type="hidden"   name="statusForm" id="statusForm"  value=""/>
                    <input type="hidden"   name="ageForm" id="ageForm"  value=""/>


                </form>
            </div>
        </div>
    </div>
    <!-- /block -->
</div>
<script>
    function saveForm(){
        var id=$("#id").val();
        var title=$("#name").val();
        if(title==""){
            alert("标题不能为空！");
            return false;
        }else if(title.length>4){
            alert("标题不能超过4个字符！");
            return false;
        }
        var order=$("#displayorder").val();
        if(order==''){
            alert("排序值不能为空！");
            return false;
        }else if(isNaN(order)){
            alert("排序值必须为数字!");
            return false;
        }
        var keyword=$("#keywords").val();
        if(keyword==''){
            alert("关键字不能为空！");
            return false;
        }

        $("#myBtn").attr("disabled","disabled");
        $('#myForm').ajaxSubmit(function(data){
            if(data.errno==1){
                $("#alertErr").show();
                $("#errodesc").html(data.errdesc);
                $("#myBtn").removeAttr("disabled");
            }else{
                alert("操作成功！");
                window.parent.closeModel();
            }
        });
    }
</script>