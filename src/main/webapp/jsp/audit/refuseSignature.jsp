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
            <div class="muted pull-left">拒绝用户签名</div>
        </div>

        <div class="alert alert-error" id="alertErr" style="display: none;">
            <button class="close" data-dismiss="alert">×</button>
            <span id="errodesc">This is an error message.</span>
        </div>
        <div class="block-content collapse in">
            <div class="span12">
                <form id="myDialogForm" name="myDialogForm" method="post" action="${BasePath}/audit/setSignatureStatus?${PublicParams}" onsubmit="return false;">
                    <input type="hidden" name="uid" id="uid" value="${user.uid}"/>
                    <input type="hidden" name="status" id="status" value="-1"/>
                    <input type="hidden" name="id" id="id" value="${signatureAudit.id}"/>
                    <fieldset>
                        对用户<font color="#08c">${user.nick}</font>(${user.uid})签名删除的理由是：
                        <div>
                            快捷回复:
                            <select name="remark"  id="selectId" onchange="changeRemark()">
                                <option selected value="1">...</option>
                                <option value="含有色情内容">含有色情内容</option>
                                <option value="含有广告内容">含有广告内容</option>
                                <option value="含有反动内容">含有反动内容</option>
                                <option value="含有不文明内容">含有不文明内容</option>
                            </select>
                            <script >
                                var reasonMap = {};
                                reasonMap["含有色情内容"]="您修改的签名因含有色情内容，审核未通过，请重新修改。";
                                reasonMap["含有广告内容"]="您修改的签名因含有广告内容，审核未通过，请重新修改。";
                                reasonMap["含有反动内容"]="您修改的签名因含有反动内容，审核未通过，请重新修改。";
                                reasonMap["含有不文明内容"]="您修改的签名因含有不文明内容，审核未通过，请重新修改。";
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