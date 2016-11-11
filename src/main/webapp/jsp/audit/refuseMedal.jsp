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
            <div class="muted pull-left">拒绝或去除用户勋章</div>
        </div>

        <div class="alert alert-error" id="alertErr" style="display: none;">
            <button class="close" data-dismiss="alert">×</button>
            <span id="errodesc">This is an error message.</span>
        </div>
        <div class="block-content collapse in">
            <div class="span12">
                <form id="myDialogForm" name="myDialogForm" method="post" action="${BasePath}/audit/setMedalStatus" onsubmit="return false;">
                    <input type="hidden" id="type" name="type" value="${type }"/>
                    <input type="hidden" id="itemId" name="itemId" value="${itemId }"/>
                    <input type="hidden" name="uid" id="uid" value="${user.uid}"/>
                    <input type="hidden" name="mark" id="mark" value="${mark}"/>
                    <c:if test="${empty mark}">
                        <input type="hidden" name="status" id="status" value="2"/>
                    </c:if>
                    <c:if test="${not empty mark}">
                        <input type="hidden" name="status" id="status" value="3"/>
                    </c:if>
                    <input type="hidden" name="id" id="id" value="${medalApply.id}"/>
                    <fieldset>
                        对用户<font color="#08c">${user.nick}</font>申请[${medal.name}]拒绝的理由是：
                        <div>
                            快捷回复:
                            <select name="remark"  id="selectId" onchange="changeRemark()">
                                <option selected value="1">...</option>
                                <option value="领域不符">领域不符</option>
                                <option value="头像问题">头像问题</option>
                                <option value="广告用户">广告用户</option>
                                <option value="监控用户">监控用户</option>
                                <option value="缺乏运营">缺乏运营</option>
                            </select>
                            <script >
                                var reasonMap = {};
                                reasonMap["领域不符"]="您过去的发帖主题与勋章类型不相符，重新申请个其他勋章试试吧~";
                                reasonMap["头像问题"]="您的头像不符合规范，合格的头像搭配勋章才更炫酷哦~";
                                reasonMap["广告用户"]="您过去的发帖中多含广告倾向，这样是不可以申请勋章滴哦~";
                                reasonMap["监控用户"]="您现在处于监控期，不能申请勋章，再等等吧~";
                                reasonMap["缺乏运营"]="太可惜了，您没有按照承诺来运营勋章，现去除您的勋章，下次要懂得珍惜呀。";
                                function changeRemark(){
                                    var remark=$("#selectId").val();
                                    if(remark=='1'){
                                        $("#reason").val("");
                                    }else{
                                        $("#reason").val(reasonMap[remark]);
                                    }
                                }
                            </script>
                        </div>
                        <div>
                            <textarea name="reason" rows="4" id="reason"
                                      style="margin: 0px 0px 10px; width: 514px; height: 80px;"></textarea>
                        </div>
                </form>

                <div class="modal-footer">
                    <button onclick="submitRefuseForm()" class="btn btn-small btn-success">确定</button>
                </div>
            </div>
        </div>
    </div>
    <!-- /block -->


</div>
<script>
    //拒绝小组
    function submitRefuseForm() {
        $("#alertErr").hide();
        var reason = $("#reason").val();
        if (reason.length == 0) {
            alert("请选择或填写理由!");
            return false;
        }
        $('#myDialogForm').ajaxSubmit(function(data){
            if (data.errno == 1) {
                $("#alertErr").show();
                $("#errodesc").html(data.errdesc);
            } else {
                alert("操作成功!");
                window.parent.closeModel();
            }
        });
    }

</script>