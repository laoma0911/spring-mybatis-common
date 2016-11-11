<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="/permission" prefix="pe" %>
<jsp:include page="../include/head.jsp"/>
<style>
    body {
        padding-top: 0px;
    }
</style>
<!-- Body -->
<div class="container-fluid">
    <div class="row-fluid">
        <!-- Menu -->
        <div class="span9" id="content">
            <div class="row-fluid">
                <div class="span9" id="content">
                    <!-- morris stacked chart -->
                    <!-- block -->
                    <div class="block">
                        <div class="alert alert-error" id="alertErr" style="display: none;">
                            <button class="close" data-dismiss="alert">×</button>
                            <strong>Error!</strong> <span id="errodesc">This is an error message.</span>
                        </div>
                        <div class="block-content collapse in">
                            <div class="span12">
                                <form class="form-horizontal addForm" id="addForm" name="addForm" action="${BasePath }/resBanner/saveResBanner" method="post">
                                    <input type="hidden" value="${itemId}" name="itemId"/>
                                    <input type="hidden" value="${type}" name="type"/>
                                    <input type="hidden" value="${resBanner.id }" name="id" id="id"/>
                                    <fieldset>
                                        <legend>填写申请信息</legend>
                                        <div class="control-group">
                                            <label class="control-label" style="float: left;">申请时间</label>

                                            <div class="controls">
                                                <c:if test="${resBanner==null }">
                                                    <input id="start" name="starts" class="Wdate" type="text" onfocus="WdatePicker({minDate:'%y-%M-{%d}',readOnly:'false',maxDate:'#F{$dp.$D(\'end\')}'})" placeholder="开始时间"/>
                                                    &nbsp;-&nbsp;
                                                    <input id="end" name="ends" class="Wdate" type="text" onfocus="WdatePicker({readOnly:'false',minDate:'#F{$dp.$D(\'start\')}'})" placeholder="结束时间"/>
                                                </c:if>
                                                <c:if test="${resBanner!=null }">
                                                    ${resBanner.time }
                                                </c:if>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label" for="proposer" style="float: left;">申请人</label>

                                            <div class="controls">
                                                <input class="input-xlarge focused" id="proposer" name="proposer" type="text" placeholder="申请人姓名" value="${resBanner.proposer }">
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label" style="float: left;">状态</label>

                                            <div class="controls">
                                                <pe:permission key="apply">
                                                <input class="radio" name="status" type="radio" id="radio1" value="1"  checked="checked"  ><label style="display: inline;" for="radio1">申请</label>
                                                </pe:permission>
                                                <pe:permission key="ensure">
                                                <input class="radio" name="status" type="radio" id="radio2" value="2"  <c:if test="${resBanner.status==2 }"> checked="checked"</c:if>><label style="display: inline;" for="radio2">确定</label>
                                                </pe:permission>
                                            </div>
                                        </div>
                                        <c:if test="${itemId==5 }">
                                            <div class="control-group">
                                                <label class="control-label" for="project" style="float: left;">位置</label>
                                                <div class="controls">
                                                    <select id="location" name="location" <c:if test="${resBanner.id>0}"> disabled </c:if> >
                                                        <option value="1" <c:if test="${resBanner.location==1 }">selected="selected"</c:if>>焦点图1</option>
                                                        <option value="2" <c:if test="${resBanner.location==2 }">selected="selected"</c:if>>焦点图2</option>
                                                        <option value="3" <c:if test="${resBanner.location==3 }">selected="selected"</c:if>>焦点图3</option>
                                                        <option value="4" <c:if test="${resBanner.location==4 }">selected="selected"</c:if>>焦点图4</option>
                                                        <option value="5" <c:if test="${resBanner.location==5 }">selected="selected"</c:if>>焦点图5</option>
                                                        <option value="6" <c:if test="${resBanner.location==6 }">selected="selected"</c:if>>焦点图6</option>
                                                        <option value="7" <c:if test="${resBanner.location==7 }">selected="selected"</c:if>>焦点图7</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </c:if>
                                        <c:if test="${itemId==156 }">
                                            <div class="control-group">
                                                <label class="control-label" for="project" style="float: left;">位置</label>
                                                <div class="controls">
                                                    <select id="location" name="location" <c:if test="${resBanner.id>0}"> disabled </c:if>>
                                                        <option value="1" <c:if test="${resBanner.location==1 }">selected="selected"</c:if>>位置1</option>
                                                        <option value="5" <c:if test="${resBanner.location==5 }">selected="selected"</c:if>>位置5</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </c:if>
                                        <c:if test="${itemId==157 }">
                                            <div class="control-group">
                                                <label class="control-label" for="project" style="float: left;">位置</label>
                                                <div class="controls">
                                                    <select id="location" name="location" <c:if test="${resBanner.id>0}"> disabled </c:if>>
                                                        <option value="2" <c:if test="${resBanner.location==2 }">selected="selected"</c:if>>位置2</option>
                                                        <option value="4" <c:if test="${resBanner.location==4 }">selected="selected"</c:if>>位置4</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </c:if>
                                        <c:if test="${itemId==165 }">
                                            <div class="control-group">
                                                <label class="control-label" for="project" style="float: left;">位置</label>
                                                <div class="controls">
                                                    <select id="location" name="location" <c:if test="${resBanner.id>0}"> disabled </c:if>>
                                                        <option value="1" <c:if test="${resBanner.location==1 }">selected="selected"</c:if>>位置1</option>
                                                        <option value="4" <c:if test="${resBanner.location==4 }">selected="selected"</c:if>>位置4</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </c:if>
                                        <div class="control-group">
                                            <label class="control-label" for="project" style="float: left;">项目名</label>

                                            <div class="controls">
                                                <input class="input-xlarge focused" name="project" id="project" type="text" placeholder="项目名" value="${resBanner.project }">
                                            </div>
                                        </div>

                                        <div class="form-actions">
                                            <button type="button" onclick="saveForm()" class="btn btn-primary submit">保存</button>
                                        </div>
                                    </fieldset>
                                </form>
                            </div>
                        </div>
                    </div>
                    <!-- /block -->
                </div>
            </div>
            <script>
                function saveForm() {
                    var startDate = $("#start").val();
                    var endDate = $("#end").val();
                    var location = $("#location").val();
                    var id=$("#id").val();
                    if(id=='' && (startDate=='' || endDate=='')){
                        alert('时间不能为空！');
                        return false;
                    }
                    var proposer=$("#proposer").val();
                    var project=$("#project").val();
                    if(proposer==''){
                        alert("申请人不能为空！");
                        return false;
                    }else if(proposer.length>20){
                        alert("申请人长度不能超过20！");
                        return false;
                    }
                    if(project==''){
                        alert("项目不能为空！");
                        return false;
                    }else if(project.length>20){
                        alert("项目长度不能超过20！");
                        return false;
                    }
                    var status = $("input[type='radio']:checked").val();
                    if(typeof(status) =='undefined'){
                        alert("请选择状态！");
                        return false;
                    }
                    $("#myButton").attr("disabled", "disabled");
                    $('#addForm').ajaxSubmit(function (data) {
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

                function saveResBanner() {
                    var startDate = $("#start").val();
                    var endDate = $("#end").val();
                    var location = $("#location").val();
                    if(startDate=='' || endDate==''){
                        alert('时间不能为空！');
                        return false;
                    }
                    var proposer=$("#proposer").val();
                    var project=$("#project").val();
                    if(proposer==''){
                        alert("申请人不能为空！");
                        return false;
                    }else if(proposer.length>20){
                        alert("申请人长度不能超过20！");
                        return false;
                    }
                    if(project==''){
                        alert("项目不能为空！");
                        return false;
                    }else if(project.length>20){
                        alert("项目长度不能超过20！");
                        return false;
                    }
                    var path = "${BasePath }/resBanner/checkDate?starts=" + startDate + "&ends=" + endDate + "&itemId=${itemId}";
                    var itemId = "${itemId }";
                    if (itemId == 5) {
                        path += "&location=" + location;
                    } else {
                        path += "&location=0";
                    }
                    $.ajax({
                        type: "POST",
                        url: path,
                        datatype: "json",
                        success: function (data) {
                            if (data.errno == 1) {
                                $("#alertErr").show();
                                $("#errodesc").html(data.errdesc);
                            } else {
                                document.addForm.submit();
                            }
                        },
                        error: function () {
                            alert("操作出错，请联系管理员！");
                        }
                    });
                }


            </script>