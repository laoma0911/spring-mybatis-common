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
            <div class="muted pull-left">直播间</div>
        </div>
        <div class="alert alert-error" id="alertErr" style="display: none;">
            <button class="close" data-dismiss="alert">×</button>
            <strong>Error!</strong> <span id="errodesc">This is an error message.</span>
        </div>
        <div class="block-content collapse in">
            <div class="span12">
                <form class="form-horizontal" id="myForm" name="myForm" action="${BasePath }/broadcast/save" enctype="multipart/form-data" method="post">
                    <input type="hidden" id="type" name="type" value="${type }"/>
                    <input type="hidden" id="id" name="id" value="${obj.id }"/>
                    <input type="hidden" id="itemId" name="itemId" value="${itemId }"/>
                    <fieldset>
                        <div class="control-group">
                            <label class="control-label" for="broadcastName" style="float: left;">直播间主题：</label>
                            <div class="controls">
                                <input type="text" id="broadcastName" name="broadcastName" value="${obj.broadcastName }"/><span style="color: #ff0000">最多50个字</span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="onlineBeginTime" style="float: left;">在线时间：</label>
                            <div class="controls">
                                <input type="text" class="Wdate" id="onlineBeginTime" name="onlineBeginTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'%y-%M-%d %H:%m:%s',maxDate:'#F{$dp.$D(\'onlineEndTime\')}',readOnly:'false'})" />
                                至${ob.onlineBeginTime}   ${ob.onlineEndTime}
                                <input type="text" class="Wdate" id="onlineEndTime" name="onlineEndTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'onlineBeginTime\')}',readOnly:'false'})" />
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="beginTime" style="float: left;">直播时间：</label>
                            <div class="controls">
                                <input type="text" class="Wdate" id="beginTime" name="beginTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'onlineBeginTime\')}',maxDate:'#F{$dp.$D(\'onlineEndTime\')}',readOnly:'false'})" />
                                至
                                <input type="text" class="Wdate" id="endTime" name="endTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'beginTime\')}',maxDate:'#F{$dp.$D(\'onlineEndTime\')}',readOnly:'false'})" />
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="pic" style="float: left;">banner图片：</label>

                            <div class="controls">
                                <input class="input-xlarge focused" name="pic" id="pic" value="${json.pic }" type="file"/>图片规格：640*300
                                <br>
                                <c:if test="${obj.pic!=null && obj.pic!=''}">
                                    <img alt="" src="${imageHost }${obj.pic }" width="80px" height="80px">
                                </c:if>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="sharePic" style="float: left;">分享图片：</label>

                            <div class="controls">
                                <input class="input-xlarge focused" name="sharePic" id="sharePic" value="${json.sharePic }" type="file"/>图片规格：200*200
                                <br>
                                <c:if test="${obj.sharePic!=null && obj.sharePic!=''}">
                                    <img alt="" src="${imageHost }${obj.sharePic }" width="80px" height="80px">
                                </c:if>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="clickUrl" style="float: left;">banner链接：</label>

                            <div class="controls  form-inline">
                                <input type="text" id="clickUrl" name="clickUrl" value="${obj.clickUrl }"/><span style="color: #ff0000"></span>
                            </div>
                        </div>
                        <%--<div class="control-group">--%>
                            <%--<label class="control-label" for="compereUid" style="float: left;">直播间小组手：</label>--%>
                            <%--<div class="controls">--%>
                                <%--<input type="text" id="compereUid" name="compereUid" value="${obj.compereUid }" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" />--%>
                            <%--</div>--%>
                        <%--</div>--%>
                        <div class="control-group">
                            <label class="control-label" for="name_0" style="float: left;">
                                <input type="button" class="btn btn-success btn-small" onclick="addItem()" value="添加选项"/>
                            </label>
                            <div class="controls" id="itemDiv">
                                <c:if test="${obj==null}">
                                    <div id="item_0">
                                        UID：<input type="text" id="uid_0" name="uid" value=""/>称号：<input type="text" id="name_0" name="name" value=""/><button class="btn btn-danger btn-small" onclick="removeItem(0)">删除</button>
                                    </div>
                                </c:if>
                                <c:if test="${obj!=null && obj.id>0}">
                                    <c:forEach items="${itemList}" var="item">
                                        <div id="item_${item.id}">
                                            UID：<input type="text" id="uid_${item.id}" name="uid" value="${item.uid}"/>称号：<input type="text" id="name_${item.id}" name="name" value="${item.title}"/><button class="btn btn-danger btn-small" onclick="removeItem(${item.id})">删除</button>
                                        </div>
                                    </c:forEach>
                                </c:if>
                            </div>
                        </div>
                        <div class="form-actions">
                            <button type="button" id="btn" name="btn" onclick="submitForm()" class="btn btn-primary">保存</button>
                        </div>
                    </fieldset>
                </form>
            </div>
        </div>
    </div>
</div>
<!--弹出层-->
<script language="javascript" type="text/javascript">
    function showdiv(index) {
        var voteType = $('input[name="voteType"]:checked').val();
        if (voteType == 0) {
            alert("话题投票不能上传图片！");
            return false;
        }
        document.getElementById("show").style.display = "block";
        $("#tempIndex").val(index);
    }
    function hidediv() {
        document.getElementById("show").style.display = 'none';
    }
</script>
<style type="text/css">
    #bg {
        display: none;
        position: absolute;
        top: 0%;
        left: 0%;
        width: 50%;
        height: 50%;
        background-color: black;
        z-index: 1001;
        -moz-opacity: 0.7;
        opacity: .70;
        filter: alpha(opacity=70);
    }

    #show {
        display: none;
        position: absolute;
        top: 25%;
        left: 22%;
        width: 30%;
        height: 30%;
        padding: 8px;
        border: 8px solid #E8E9F7;
        background-color: white;
        z-index: 1002;
        overflow: auto;
    }
</style>
<div id="bg"></div>
<div id="show">
    <input id="btnclose" type="button" value="X" onclick="hidediv();"/>

    <form class="form-horizontal" id="imgForm" name="imgForm" action="${BasePath}/vote/uploadImage" enctype="multipart/form-data" method="post">
        <input type="hidden" id="tempIndex" name="tempIndex" value=""/>
        <input class="input-xlarge focused" name="image" id="image" type="file"/>
        <input type="button" class="btn btn-success btn-small" onclick="uploadImage()" value="上传图片"/>
    </form>
</div>


<script>
    var i = '${maxId}';
    function addItem() {
        var list = document.getElementsByName("name");
//        if (list.length == 20) {
//            alert("最多添加20个项目！");
//            return false;
//        }
        i++;
        $("#itemDiv").append("<div id=\"item_" + i + "\">UID：<input type=\"text\" name=\"uid\" value='' />称号：<input type=\"text\" id=\"name_" + i + "\" name=\"name\" value=\"\"/><button class=\"btn btn-danger btn-small\" onclick=\"removeItem(" + i + ")\">删除</button></div>");
    }
    function removeItem(i) {
        var list = document.getElementsByName("name");
        if (list.length == 1) {
            alert("至少有一项！");
            return false;
        }else {
            $("#item_" + i).remove();
        }
    }

    function submitForm() {
        var broadcastName = $("#broadcastName").val();
        var id=$("#id").val();
        var pic=$("#pic").val();
        var sharePic=$("#sharePic").val();
        var clickUrl=$("#clickUrl").val();
        var beginTime=$("#beginTime").val();
        var endTime = $("#endTime").val();
        var onlineBeginTime=$("#onlineBeginTime").val();
        var onlineEndTime = $("#onlineEndTime").val();
        if(beginTime=='' || endTime=="" || onlineBeginTime=="" || onlineEndTime==""){
            alert("时间不能为空！");
            return false;
        }

        if (broadcastName == '') {
            alert("直播间主题不能为空！");
            return false;
        } else if (broadcastName.length > 50) {
            alert("直播间主题不能超过50个字！");
            return false;
        }
//        if (endDate == '') {
//            alert("截止时间不能为空！");
//            return false;
//        }
        if(id=="" && pic==""){
            alert("请上传图片！");
            return false;
        }
        if(id=="" && sharePic==""){
            alert("请上传分享图片！");
            return false;
        }
        if(clickUrl==""){
            alert("链接不能为空！");
            return false;
        }

        var list = document.getElementsByName("uid");
        for (var j = 0; j < list.length; j++) {
            if (list[j].value == '') {
                alert("UID不能为空！");
                return false;
            }
            if(isNaN(list[j].value)){
                alert("UID必须是数字！");
                return false;
            }
        }
        var list2 = document.getElementsByName("name");
        for (var j = 0; j < list2.length; j++) {
            if (list2[j].value == '') {
                alert("称号不能为空！");
                return false;
            }
            if (list2[j].value.indexOf(",") >= 0) {
                alert("称号名字不能有带英文状态下的逗号！");
                return false;
            }
            if (list2[j].value.length > 10) {
                alert("称号名字不能超过10个字符！");
                return false;
            }
        }
        $("#btn").attr("disabled", "disabled");
        $('#myForm').ajaxSubmit(function (data) {
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
    $(document).ready(function () {
        setByIdFormatTime("endTime", '${obj.endTime}');
        setByIdFormatTime("beginTime", '${obj.beginTime}');
        setByIdFormatTime("onlineEndTime", '${obj.onlineEndTime}');
        setByIdFormatTime("onlineBeginTime", '${obj.onlineBeginTime}');
    });
</script>