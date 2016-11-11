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
            <div class="muted pull-left">推荐到最热</div>
        </div>

        <div class="alert alert-error" id="alertErr" style="display: none;">
            <button class="close" data-dismiss="alert">×</button>
            <strong>Error!</strong> <span id="errodesc">This is an error message.</span>
        </div>
        <div class="block-content collapse in">
            <div class="span12">
                <form class="form-horizontal" id="myForm" name="myForm" action="${BasePath }/topic/saveRecommend" enctype="multipart/form-data" method="post">
                    <input type="hidden" id="type" name="type" value="${type }"/>
                    <input type="hidden" id="id" name="id" value="${obj.id }"/>
                    <input type="hidden" id="topicId" name="topicId" value="${topicId }"/>
                    <input type="hidden" id="itemId" name="itemId" value="${itemId }"/>
                    <fieldset>
                        <div class="control-group">
                            <label class="control-label" for="tagId" style="float: left;">标签：</label>

                            <div class="controls">
                                <select id="tagId" name="tagId">
                                    <c:forEach items="${topicTagList}" var="tag">
                                        <option value="${tag.id}"
                                                <c:if test="${tag.id==obj.tagId}">selected="selected"</c:if> >${tag.tag}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" for="tagId" style="float: left;">推荐日期：</label>

                            <div class="controls">
                                <input type="text" style="width: auto;" id="date" name="date" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:00',readOnly:'false'})" class="Wdate" onClick="WdatePicker()"/>
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" for="tagId" style="float: left;">推荐模式：</label>

                            <div class="controls">
                                <select id="picType" name="picType" onchange="picTypeChange()">
                                    <option value="1">小图模式</option>
                                    <option value="2">大图模式</option>
                                </select>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="pic" style="float: left;"></label>
                            <div class="controls">
                                <input type="hidden" id="havePic" name="havePic" value="0"/>
                                <img id="smallPic" src="" width="100px" height="100px"/>
                            </div>
                        </div>
                        <div class="control-group" id="uploadDiv">
                            <label class="control-label" for="pic" style="float: left;">上传图片：</label>
                            <div class="controls">
                                <input class="input-xlarge focused" name="pic" id="pic" value="" type="file"/><span id="tipSpan" style="color: #ff0000">图片规格：500*500</span>
                            </div>
                        </div>
                        <div class="form-actions">
                            <button type="button" id="myBtn" onclick="saveForm()" class="btn btn-primary">保存</button>
                        </div>
                    </fieldset>
                </form>
            </div>
        </div>
    </div>
    <!-- /block -->
</div>
<script>
    function picTypeChange() {
        var id = $("#topicId").val();
        var picType = $("#picType").val();
        $.post('${BasePath}/topic/getPic', {'topicId': id, 'picType': picType}, function (data) {
            var obj = eval(data);
            if (obj.errno == 0 && obj.pic!= '') {
                $("#smallPic").attr("src", obj.pic);
                $("#smallPic").show();
                $("#havePic").val(1);
            } else {
                $("#smallPic").hide();
                $("#havePic").val(0);
                $("#smallPic").attr("src", "");
            }
        });
        if (picType == 1) {
            $("#tipSpan").html("最小750*525");
        } else {
            $("#tipSpan").html("图片为正方形，最小600*600");
        }
    }
    function getCategory(obj) {
        var id = obj.value;
        //1.$.ajax带json数据的异步请求
        var aj = $.ajax({
            url: '${BasePath}/topicTag/getCategoryJson?id=' + id,
            type: 'post',
            cache: false,
            dataType: 'json',
            success: function (data) {
                if (data.errno == 0) {
                    $("#groupId").empty();
                    var size = data.data.length;
                    for (var i = 0; i < size; i++) {
                        $("#groupId").append("<option value='" + data.data[i].id + "' >" + data.data[i].title + "</option>");
                    }
                    if (size == 0) {
                        alert("该分类下没有小组，请重新选择！");
                    }
                } else {
                    alert(data.errdesc);
                }
            },
            error: function () {
                alert("异常！");
            }
        });

    }

    function saveForm() {
        var date = $("#date").val();
        var havePic = $("#havePic").val();
        var file = $("#pic").val();
        if (date == "") {
            alert("请选择时间！");
            return false;
        }
        if (havePic == "0" && file == "") {
            alert("请上传封面图片！");
            return false;
        }
        $("#myBtn").attr("disabled", "disabled");
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
<script type="text/javascript">
    function initPicType(id, picType) {
        $.post('${BasePath}/topic/getPic', {'topicId': id, 'picType': picType}, function (data) {
            var obj = eval(data);
            if (obj.errno == 0 && obj.pic != '') {
                $("#smallPic").attr("src", obj.pic);
                $("#smallPic").show();
                $("#havePic").val(1);
            } else {
                $("#smallPic").hide();
                $("#havePic").val(0);
            }
        });
        if (picType == 1) {
            $("#tipSpan").html("最小750*525");
        } else {
            $("#tipSpan").html("图片为正方形，最小600*600");
        }
    }
    $(document).ready(function () {
        var id = $("#topicId").val();
        initPicType(id, 1);
        setCheckBoxValue("${json.data.status}", "status");
        setCheckBoxValue("${json.data.age}", "age");
        setByIdFormatTime("startDate", '${json.data.startTime}');
        setByIdFormatTime("endDate", '${json.data.endTime}');
        setByIdFormatTime("date", '${obj.recommendDate}');


        //年龄阶段
        $("input[name='age']").click(function (obj) {//全选
            if (this.id == 'age_0') {
                var flag = this.checked;
                $("input[name='age']").each(function () {
                    this.checked = flag;
                });
            } else {
                var flag = this.checked;
                if (flag) {
                    var sign = true;
                    $("input[name='age']").each(function () {
                        if (this.id != 'age_0' && this.checked == false) {
                            sign = false;
                        }
                    });
                    if (sign) {
                        $("input[name='age']").each(function () {
                            if (this.id == 'age_0') {
                                this.checked = true;
                            }
                        });
                    } else {
                        $("#age_0").attr("checked", false);
                    }
                } else {
                    $("#age_0").attr("checked", false);
                }
            }
        });

        //年龄阶段
        $("input[name='status']").click(function (obj) {//全选
            if (this.id == 'status_0') {
                var flag = this.checked;
                $("input[name='status']").each(function () {
                    this.checked = flag;
                });
            } else {
                var flag = this.checked;
                if (flag) {
                    var sign = true;
                    $("input[name='status']").each(function () {
                        if (this.id != 'status_0' && this.checked == false) {
                            sign = false;
                        }
                    });
                    if (sign) {
                        $("input[name='status']").each(function () {
                            if (this.id == 'status_0') {
                                this.checked = true;
                            }
                        });
                    } else {
                        $("#status_0").attr("checked", false);
                    }
                } else {
                    $("#status_0").attr("checked", false);
                }
            }
        });

    });
</script>

