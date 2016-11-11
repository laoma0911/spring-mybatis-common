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
            <div class="muted pull-left">拒绝</div>
        </div>

        <div class="alert alert-error" id="alertErr" style="display: none;">
            <button class="close" data-dismiss="alert">×</button>
            <span id="errodesc">This is an error message.</span>
        </div>
        <div class="block-content collapse in">
            <div class="span12">
                <form id="myDialogForm" name="myDialogForm" method="post" action="${BasePath}/audit/setCategory" onsubmit="return false;">
                    <input type="hidden" id="type" name="type" value="${type }"/>
                    <input type="hidden" id="itemId" name="itemId" value="${itemId }"/>
                    <input type="hidden" name="uid" id="uid" value="${user.uid}"/>
                    <input type="hidden" name="status" id="status" value="4"/>
                    <input type="hidden" name="mark" id="mark" value="${mark}"/>
                    <input type="hidden" name="ids" id="ids" value="${topicCategory.id}"/>
                    <fieldset>
                        对用户<font color="#08c">${user.nick}</font>创建的[${topicCategory.title}]小组拒绝的理由是：
                        <div>
                            快捷回复:
                            <select name="remark" id="selectId" onchange="changeRemark()">
                                <option selected value="1">...</option>
                                <option value="分类不符">分类不符</option>
                                <option value="主题不明">主题不明</option>
                                <option value="头像不符">头像不符</option>
                                <option value="含有联系方式">含有联系方式</option>
                                <c:if test="${empty mark}">
                                    <option value="类似小组">类似小组</option>
                                    <option value="不支持广告、购物">不支持广告、购物</option>
                                    <option value="话题讨论形式">话题讨论形式</option>
                                    <option value="监控期">监控期</option>
                                </c:if>
                            </select>
                            <script >
                                var reasonMap = {};
                                reasonMap["分类不符"]="亲爱的玛芬, 您申请的小组主题与所选分类不符，请重新核对后再提交申请。详情请参阅《申请创建小组指导手册》。";
                                reasonMap["主题不明"]="亲爱的玛芬，您申请的小组主题不明确，请重新修改下名称或描述表达清晰再次提交申请。详情请参阅《申请创建小组指导手册》。";
                                reasonMap["类似小组"]="亲爱的玛芬，现已存在类似主题小组，${text}欢迎到已有小组发帖，详情请参阅《申请创建小组指导手册》。";
                                reasonMap["头像不符"]="亲爱的玛芬，您申请的小组头像不符合规范，请更换图片后再次提交申请~详情请参阅《申请创建小组指导手册》。";
                                reasonMap["含有联系方式"]="亲爱的玛芬，您申请小组的名称或描述中含有联系方式，避免广告嫌疑请修改后再次提交申请吧~详情请参阅《申请创建小组指导手册》。";
                                reasonMap["不支持广告、购物"]="亲爱的玛芬，大姨吗社区暂不支持广告、购物性小组，欢迎您到【广告集结地】小组发帖。详情请参阅《申请创建小组指导手册》。";
                                reasonMap["话题讨论形式"]="亲爱的玛芬，您申请的小组名称为话题讨论形式，建议到其他小组发帖讨论。详情请参阅《申请创建小组指导手册》。";
                                reasonMap["监控期"]="亲爱的玛芬，您现在处于监控期，不能创建小组，详情请参阅《申请创建小组指导手册》。";
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
                    <button onclick="submitRefuseForm()" class="btn btn-primary">确定</button>
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
            if (data.errno == 0) {
                alert("操作成功!");
                window.parent.closeModel();
            } else {
                $("#alertErr").show();
                $("#errodesc").html(data.errdesc);
            }
        });
    }

</script>
