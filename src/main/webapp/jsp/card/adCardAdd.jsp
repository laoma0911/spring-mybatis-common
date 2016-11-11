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
            <div class="muted pull-left">首页广告卡片 【新增】|【修改】 </div>
        </div>
        <div class="alert alert-error" id="alertErr" style="display: none;">
            <button class="close" data-dismiss="alert">×</button>
            <strong>Error!</strong> <span id="errodesc">This is an error message.</span>
        </div>
        <div class="block-content collapse in">
            <div class="span12">
                <form class="form-horizontal" id="myForm" name="myForm"  action="${BasePath }/card/saveAdCard" enctype="multipart/form-data"   method="post">
                    <input type="hidden" id="type" name="type" value="${type }"/>
                    <input type="hidden" id="id" name="id" value="${json.data.id }"/>
                    <input type="hidden" id="itemId" name="itemId" value="${itemId }"/>
                    <fieldset>

                        <div class="control-group">
                            <label class="control-label" for="name" style="float: left;">卡片名称：</label>
                            <div class="controls">
                                <input type="text"  id="name" name="name" value="${json.data.name }"  />
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="title" style="float: left;">卡片标题：</label>
                            <div class="controls">
                                <input type="text"  name="title" id="title" value="${json.data.title}" />
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="url" style="float: left;">卡片指向链接：</label>
                            <div class="controls">
                                <input type="text"  id="url" name="url" value="${json.data.url }"  />
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="monitorLink" style="float: left;">爆光链接：</label>
                            <div class="controls">
                                <input type="text"  id="monitorLink" name="monitorLink" value="${json.data.monitorLink }"  />
                            </div>
                        </div>
                        <div class="control-group"   >
                            <label class="control-label" for="morelink" style="float: left;">卡片上更多ICON指向的链接：</label>
                            <div class="controls">
                                <input type="text"  id="morelink" name="morelink" value="${json.data.moreLink }"  />
                            </div>
                        </div>

                        <div class="control-group" id="uploadDiv"   >
                            <label class="control-label" for="pic" style="float: left;">上传图片：</label>
                            <div class="controls">
                                <input class="input-xlarge focused" name="pic" id="pic" value="${json.data.pic }"   type="file" />
                                <br>
                                <c:if test="${json.data.pic!=null && json.data.pic!=''}">
                                    <img alt="" src="${imageHost }${json.data.pic }" width="80px" height="80px">
                                </c:if>
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" for="startDate" style="float: left;">开始时间：</label>
                            <div class="controls  form-inline">
                                <input type="text" class="Wdate" id="startDate" name="startDate"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'endDate\')}',readOnly:'false'})" />
                            </div>
                            <label class="control-label" for="endDate" style="float: left;">结束时间：</label>
                            <div class="controls  form-inline">
                                <input type="text" class="Wdate" id="endDate" name="endDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'startDate\')}',readOnly:'false'})" />
                            </div>
                        </div>

                        <div class="form-actions">
                            <button type="button" id="myBtn"  onclick="saveForm()" class="btn btn-primary">保存</button>
                        </div>
                    </fieldset>
                </form>
            </div>
        </div>
    </div>
    <!-- /block -->
</div>
<script>
    function saveForm(){

        var id=$("#id").val();
        var pic=$("#pic").val();
        var name=$("#name").val();
        var title=$("#title").val();
        var startDate=$("#startDate").val();
        var endDate=$("#endDate").val();
        var url=$("#url").val();
        var moreLink=$("#moreLink").val();

        if(id=="" && pic==""){
            alert("请上传图片！");
            return false;
        }
        if(name==""){
            alert("请输入卡片名称！");
            return false;
        }
        if(title==""){
            alert("请输入卡片标题！");
            return false;
        }

        if(url==""){
            alert("卡片指向链接！");
            return false;
        }
        if(startDate==""){
            alert("请输入开始时间！");
            return false;
        }
        if(endDate==""){
            alert("请输入结束时间！");
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
<script type="text/javascript">
    $(document).ready(function(){
        setByIdFormatTime("startDate",'${json.data.startTime}');
        setByIdFormatTime("endDate",'${json.data.endTime}');
    });
</script>

