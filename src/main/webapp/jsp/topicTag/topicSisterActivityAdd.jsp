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
            <div class="muted pull-left">添加 | 修改 推荐活动</div>
        </div>

        <div class="alert alert-error" id="alertErr" style="display: none;">
            <button class="close" data-dismiss="alert">×</button>
            <strong>Error!</strong> <span id="errodesc">This is an error message.</span>
        </div>
        <div class="block-content collapse in">
            <div class="span12">
                <form class="form-horizontal" id="myForm" name="myForm" action="${BasePath }/topicSisterActivity/save" enctype="multipart/form-data" method="post">
                    <input type="hidden" id="type" name="type" value="${type }"/>
                    <input type="hidden" id="id" name="id" value="${topicTagActivity.id }"/>
                    <input type="hidden" id="itemId" name="itemId" value="${itemId }"/>
                    <fieldset>

                        <div class="control-group">
                            <label class="control-label" for="userStatus" style="float: left;">用户状态：</label>
                            <div class="controls">
                                <%--<label class="checkbox inline"><input type="checkbox" id="userStatus_0" name="userStatus" value="0"/>全部</label>--%>
                                <%--<label class="checkbox inline"><input type="checkbox" id="userStatus_1" name="userStatus" value="1"/>记经期</label>--%>
                                <%--<label class="checkbox inline"><input type="checkbox" id="userStatus_2" name="userStatus" value="2"/>备孕</label>--%>
                                <%--<label class="checkbox inline"><input type="checkbox" id="userStatus_3" name="userStatus" value="3"/>怀孕中</label>--%>
                                <%--<label class="checkbox inline"><input type="checkbox" id="userStatus_4" name="userStatus" value="4"/>宝妈</label>--%>
                                    <label class="radio inline"><input type="radio" name="userStatus"  value="0" checked>全部</label>
                                    <label class="radio inline"><input type="radio" name="userStatus" value="1"  <c:if test="${topicTagActivity.userStatus=='1' }">checked</c:if> >记经期</label>
                                    <label class="radio inline"><input type="radio" name="userStatus" value="2"  <c:if test="${topicTagActivity.userStatus=='2' }">checked</c:if> >备孕</label>
                                    <label class="radio inline"><input type="radio" name="userStatus" value="3"  <c:if test="${topicTagActivity.userStatus=='3' }">checked</c:if> >怀孕中</label>
                                    <label class="radio inline"><input type="radio" name="userStatus" value="4"  <c:if test="${topicTagActivity.userStatus=='4' }">checked</c:if> >宝妈</label>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="location" style="float: left;">位置：</label>

                            <div class="controls">
                                <select name="location" id="location">
                                    <option value="2" <c:if test="${topicTagActivity.location==2}">selected</c:if>  >位置2</option>
                                    <option value="4" <c:if test="${topicTagActivity.location==4}">selected</c:if> >位置4</option>
                                </select>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="title" style="float: left;">标题：</label>

                            <div class="controls">
                                <input type="text" id="title" name="title" value="${topicTagActivity.title}"/>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="link" style="float: left;">链接：</label>
                            <div class="controls">
                                <input type="text" id="link" name="link"
                                       value="${topicTagActivity.link}"/>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="uid" style="float: left;">发布者UID：</label>
                            <div class="controls">
                                <input type="text" id="uid" name="uid"
                                       value="${topicTagActivity.uid}" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"  />
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="pic" style="float: left;">图片：</label>

                            <div class="controls">
                                <input class="input-xlarge focused" name="pic" id="pic" value="${topicTagActivity.pic }" type="file"/>图片规格：640*384
                                <br>
                                <c:if test="${topicTagActivity.pic!=null && topicTagActivity.pic!=''}">
                                    <img alt="" src="${imageHost }${topicTagActivity.pic }" width="80px" height="80px">
                                </c:if>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="startDate" style="float: left;">推荐开始日期：</label>

                            <div class="controls">
                                <input type="text" id="startDate" name="startDate"
                                       value="${topicTagActivity.startDate}" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'%y-%M-%d',maxDate:'#F{$dp.$D(\'endDate\')}',readOnly:'false'})"/>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="endDate" style="float: left;">推荐结束日期：</label>

                            <div class="controls">
                                <input type="text" id="endDate" name="endDate"
                                       value="${topicTagActivity.endDate}" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'startDate\')}',readOnly:'false'})"/>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="platform_0" style="float: left;">客户端平台：</label>

                            <div class="controls">
                                <label class="checkbox inline">
                                    <input type="checkbox" <c:if test="${topicTagActivity.platform=='0' || topicTagActivity.platform=='0,1'}"> checked </c:if> id="platform_0" name="platform" value="0"/>Android
                                </label>
                                <label class="checkbox inline">
                                    <input type="checkbox" <c:if test="${topicTagActivity.platform=='1' || topicTagActivity.platform=='0,1'}"> checked </c:if> id="platform_1" name="platform" value="1"/>IOS
                                </label>
                            </div>
                        </div>
                        
                        <div class="control-group">
							<label class="control-label" for="name" style="float: left;">同步到谷歌客户端：</label>
							<div class="controls">
								<input type="checkbox" id="toGoogle" name="toGoogle"  value="0" onchange="toGoogleChange(this)"/>
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
    function saveForm() {
        var title = $("#title").val();
        var link = $("#link").val();
        var pic = $("#pic").val();
        var id = $("#id").val();
        var uid = $("#uid").val();
//        var targetUserStatusAll = new Array();
//        $("input[name='userStatus']:checked").each(function () {
//            var txt = $(this).val();
//            targetUserStatusAll.push(txt);
//        });
//        if (targetUserStatusAll.length == 0) {
//            alert("请选择用户状态");
//            return false;
//        }
        if (title == "") {
            alert("标题不能为空！");
            return false;
        }
        if (link == "") {
            alert("链接不能为空！");
            return false;
        }
        if(uid==""){
            alert("发布者UID不能为空！");
            return false;
        }

        if (id == "" && pic == "") {
            alert("请上传图片！");
            return false;
        }
        var startDate = $("#startDate").val();
        var endDate = $("#endDate").val();
        if (startDate == "") {
            alert("开始时间不能为空！");
            return false;
        } else if (endDate == "") {
            alert("结束时间不能为空！");
            return false;
        }
        var platformArry = new Array();
        $("input[name='platform']:checked").each(function () {
            var txt = $(this).val();
            platformArry.push(txt);
        });
        if (platformArry.length == 0) {
            alert("请选择推送的客户端！");
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
    

	function toGoogleChange(obj){
		if (obj.checked) {
			$("#toGoogle").val("1");
		} else {
			$("#toGoogle").val("0");
		}
	}
</script>
<script type="text/javascript">
    $(document).ready(function () {
        setByIdFormatDate("startDate", '${topicTagActivity.startDate}');
        setByIdFormatDate("endDate", '${topicTagActivity.endDate}');
        
        var toGoogle = "${topicTagActivity.toGoogle}";
		if(toGoogle == 1){
			$("#toGoogle").attr("checked", true);
			$("#toGoogle").val("1");
		}
        
        //setCheckBoxValue("${topicTagActivity.userStatus}", "userStatus");

        <%--var userStatus = "${topicTagActivity.userStatus}";--%>
        <%--if (userStatus == "" || userStatus == "0") {--%>
            <%--$("input[name='userStatus']").each(function () {--%>
                <%--this.checked = true;--%>
            <%--});--%>
        <%--}--%>
        //区域
//        $("input[name='userStatus']").click(function (obj) {//全选
//            if (this.id == 'userStatus_0') {
//                var flag = this.checked;
//                $("input[name='userStatus']").each(function () {
//                    this.checked = flag;
//                });
//            } else {
//                var flag = this.checked;
//                if (flag) {
//                    var sign = true;
//                    $("input[name='userStatus']").each(function () {
//                        if (this.id != 'userStatus_0' && this.checked == false) {
//                            sign = false;
//                        }
//                    });
//                    if (sign) {
//                        $("input[name='userStatus']").each(function () {
//                            if (this.id == 'userStatus_0') {
//                                this.checked = true;
//                            }
//                        });
//                    } else {
//                        $("#userStatus_0").attr("checked", false);
//                    }
//                } else {
//                    $("#userStatus_0").attr("checked", false);
//                }
//            }
//        });


    });
</script>

