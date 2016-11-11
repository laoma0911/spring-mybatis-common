<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%--
  ~ /**
  ~  *dashan
  ~  */
  --%>

<jsp:include page="../../include/head.jsp"/>
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
            <div class="muted pull-left">话题投票</div>
        </div>

        <div class="alert alert-error" id="alertErr" style="display: none;">
            <button class="close" data-dismiss="alert">×</button>
            <strong>Error!</strong> <span id="errodesc">This is an error message.</span>
        </div>
        <div class="block-content collapse in">
            <div class="span12">
                <form class="form-horizontal" id="myForm" name="myForm" action="${BasePath }/meiyue/vote/save" enctype="multipart/form-data" method="post">
                    <input type="hidden" id="type" name="type" value="${type }"/>
                    <input type="hidden" id="id" name="id" value="${obj.id }"/>
                    <input type="hidden" id="itemId" name="itemId" value="${itemId }"/>
                    <fieldset>
                        <div class="control-group">
                            <label class="control-label" for="title" style="float: left;">投票名称：</label>

                            <div class="controls">
                                <input type="text" id="title" name="title" value="${obj.title }"/><span style="color: #ff0000">最多20个字</span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="endDate" style="float: left;">截止时间：</label>

                            <div class="controls  form-inline">
                                <input type="text" class="Wdate" id="endDate" name="endDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'%y-%M-%d',readOnly:'false'})"/>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="selectType" style="float: left;">单选/多选：</label>

                            <div class="controls">
                                <select id="selectType" name="selectType">
                                    <option value="0" <c:if test="${obj.selectType==0}"> selected="selected" </c:if>  >单选</option>
                                    <option value="1" <c:if test="${obj.selectType==1}"> selected="selected" </c:if>  >最多选两项</option>
                                    <option value="2" <c:if test="${obj.selectType==2}"> selected="selected" </c:if>  >最多选三项</option>
                                    <option value="3" <c:if test="${obj.selectType==3}"> selected="selected" </c:if>  >最多选四项</option>
                                    <option value="4" <c:if test="${obj.selectType==4}"> selected="selected" </c:if>  >最多选五项</option>
                                    <option value="5" <c:if test="${obj.selectType==5}"> selected="selected" </c:if>  >最多选六项</option>
                                    <option value="6" <c:if test="${obj.selectType==6}"> selected="selected" </c:if>  >最多选七项</option>
                                    <option value="7" <c:if test="${obj.selectType==7}"> selected="selected" </c:if>  >最多选八项</option>
                                    <option value="8" <c:if test="${obj.selectType==8}"> selected="selected" </c:if>  >最多选九项</option>
                                    <option value="9" <c:if test="${obj.selectType==9}"> selected="selected" </c:if>  >最多十选项</option>
                                </select>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="voteType1" style="float: left;">投票形式：</label>

                            <div class="controls  form-inline">
                                <label class="radio inline">
                                    <input type="radio" name="voteType" id="voteType1" onclick="typeChange(this)" value="0" checked>话题投票
                                </label>
                                <label class="radio inline">
                                    <input type="radio" name="voteType" id="voteType2" onclick="typeChange(this)" value="1"
                                           <c:if test="${obj.voteType==1}">checked</c:if> >图片投票
                                </label>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="resultType1" style="float: left;">投票结果：</label>

                            <div class="controls  form-inline">
                                <label class="radio inline">
                                    <input type="radio" name="resultType" id="resultType1" value="0" checked>投票后可见
                                </label>
                                <%--<label class="radio inline">--%>
                                    <%--<input type="radio" name="resultType" id="resultType2" value="1"--%>
                                           <%--<c:if test="${obj.resultType==1}">checked</c:if> >所有人可见--%>
                                <%--</label>--%>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="name_0" style="float: left;">
                                <input type="button" class="btn btn-success btn-small" onclick="addItem()" value="添加选项"/>
                            </label>

                            <div class="controls" id="itemDiv">
                                <c:if test="${obj==null}">
                                    <div id="item_0">选项：
                                        <input type="text" id="name_0" name="name" value=""/><img id="image_0" src="" width="80px" height="80px"/><input name="pic" id="pic_0" type="hidden"/><input  type="button" class="btn btn-warning btn-small" name="btn_upload" onclick="showdiv(0)" value="上传图片"/><button class="btn btn-danger btn-small" onclick="removeItem(0)">删除</button></div>
                                </c:if>
                                <c:if test="${obj!=null && obj.id>0}">
                                    <c:forEach items="${voteItemList}" var="voteItem">
                                        <c:choose>
                                            <c:when test="${obj.voteType==1}">
                                                <div id="item_${voteItem.id}">
                                                    选项：<input type="hidden" name="voteItemId" value="${voteItem.id}" /><input type="text" id="name_${voteItem.id}" name="name" value="${voteItem.title}"/><img id="image_${voteItem.id}" name="img_show" src="http://a.dayima.com/${voteItem.pic}" width="80px" height="80px"/><input name="pic" id="pic_${voteItem.id}" type="hidden" value="${voteItem.pic}"/><input type="button" class="btn btn-warning btn-small" name="btn_upload" onclick="showdiv(${voteItem.id})" value="上传图片"/><button class="btn btn-danger btn-small" onclick="removeItem(${voteItem.id})">删除</button>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div id="item_${voteItem.id}">
                                                    选项：<input type="hidden" name="voteItemId" value="${voteItem.id}" /><input type="text" id="name_${voteItem.id}" name="name" value="${voteItem.title}"/><img id="image_${voteItem.id}" name="img_show" src="" width="80px" height="80px"/><input name="pic" id="pic_${voteItem.id}" type="hidden" value="${voteItem.pic}"/><input type="button" class="btn btn-warning btn-small" name="btn_upload" onclick="showdiv(${voteItem.id})" value="上传图片"/><button class="btn btn-danger btn-small" onclick="removeItem(${voteItem.id})">删除</button>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>

                                    </c:forEach>
                                </c:if>
                            </div>
                            <div class="form-actions">
                                <button type="button" id="btn" name="btn" onclick="submitForm()" class="btn btn-primary">保存</button>
                            </div>
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
        var voteType=$('input[name="voteType"]:checked').val();
        if(voteType==0){
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

    <form class="form-horizontal" id="imgForm" name="imgForm" action="${BasePath}/meiyue/vote/uploadImage" enctype="multipart/form-data" method="post">
        <input type="hidden" id="tempIndex" name="tempIndex" value=""/>
        <input class="input-xlarge focused" name="image" id="image" type="file"/>
        <input type="button" class="btn btn-success btn-small" onclick="uploadImage()" value="上传图片"/>
    </form>
</div>


<script>
    var i ='${maxId}';
    function addItem() {
        var list = document.getElementsByName("name");
        if(list.length==20){
            alert("最多添加20个项目！");
            return false;
        }
        i++;
        $("#itemDiv").append("<div id=\"item_" + i + "\">选项：<input type=\"hidden\" name=\"voteItemId\" value='' /><input type=\"text\" id=\"name_" + i + "\" name=\"name\" value=\"\"/><img id=\"image_" + i + "\" src=\"\" width=\"80px\" height=\"80px\"/><input name=\"pic\" id=\"pic_" + i + "\"  type=\"hidden\"/><input type=\"button\" class=\"btn btn-warning btn-small\" onclick=\"showdiv(" + i + ")\" value=\"上传图片\"/>    <button class=\"btn btn-danger btn-small\" onclick=\"removeItem(" + i + ")\">删除</button></div>");
    }
    function removeItem(i) {
        $("#item_" + i).remove();
    }

    function submitForm() {
        var title = $("#title").val();
        var endDate = $("#endDate").val();
        if (title == '') {
            alert("标题不能为空！");
            return false;
        } else if (title.length > 20) {
            alert("标题不能超过20个字！");
            return false;
        }
        if (endDate == '') {
            alert("截止时间不能为空！");
            return false;
        }
        var list = document.getElementsByName("name");
        for (var j = 0; j < list.length; j++) {
            if(list[j].value==''){
                alert("项目不能为空！");
                return false;
            }
            if(list[j].value.indexOf(",")>=0){
                alert("项目名字不能有带英文状态下的逗号！");
                return false;
            }
            if(list[j].value.length>20){
                alert("项目名字不能超过20个字符！");
                return false;
            }
        }
        var voteType=$('input[name="voteType"]:checked').val();
        if(voteType==1){
            var list = document.getElementsByName("pic");
            for (var j = 0; j < list.length; j++) {
                if(list[j].value==''){
                    alert("图片不能为空！");
                    return false;
                }
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
    function typeChange(obj) {
//        var id = obj.value;
//        if (id == 0) {
//            var list = document.getElementsByName("pic");
//            for (var j = 0; j < list.length; j++) {
//                list[j].style.display = "none";
//            }
//            var list = document.getElementsByName("img_show");
//            for (var j = 0; j < list.length; j++) {
//                list[j].style.display = "none";
//            }
//            var list = document.getElementsByName("btn_upload");
//            for (var j = 0; j < list.length; j++) {
//                list[j].style.display = "none";
//            }
//        } else {
//            var list = document.getElementsByName("pic");
//            for (var j = 0; j < list.length; j++) {
//                list[j].style.display = "block";
//            }
//            var list = document.getElementsByName("img_show");
//            for (var j = 0; j < list.length; j++) {
//                list[j].style.display = "block";
//            }
//            var list = document.getElementsByName("btn_upload");
//            for (var j = 0; j < list.length; j++) {
//                list[j].style.display = "block";
//            }
//        }
    }
    function uploadImage() {
        var index = $("#tempIndex").val();
        $('#imgForm').ajaxSubmit(function (data) {
            if (data.errno == 0) {
                //alert("上传成功！");
                $("#pic_" + index).val(data.pic);
                $("#image_" + index).attr("src", "http://a.dayima.com/" + data.pic);
                hidediv();
            } else if (data.errno == 1) {
                $("#alertErr").show();
                $("#errodesc").html(data.errdesc);
                $("#btn").removeAttr("disabled");
            }
        });
    }
    $(document).ready(function(){
        setByIdFormatTime("endDate",'${obj.endDate}');
    });
</script>