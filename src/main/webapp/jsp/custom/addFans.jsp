<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="/permission" prefix="pe" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="../include/top.jsp"/>
<!-- Body -->
<div class="container-fluid">
    <div class="row-fluid">
        <!-- Menu -->
        <jsp:include page="../include/menu.jsp"/>
        <div class="span9" id="content">
            <jsp:include page="../include/location.jsp"/>
            <div class="row-fluid">
                <div class="span12">
                    <div class="block">
                        <div class="navbar navbar-inner block-header" style="border-bottom: none;">
                            <form class="form-inline" id="myForm" name="myForm" action="${BasePath}/custom/addFans" method="post">
                                uid: <input type="text" id="uid" name="uid">
                                粉丝数: <input type="text" id="num" name="num">
                                <button type="button" onclick="submitForm()" class="btn btn-success btn-small">添加
                                </button>
                                <input type="hidden" name="type" id="type" value="${type }"/>
                                <input type="hidden" name="itemId" id="itemId" value="${itemId }"/>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<hr>

<jsp:include page="../include/bottom.jsp"/>

<script>
    function submitForm() {
        var uid=$("#uid").val();
        var num=$("#num").val();
        if(uid!="" && isNaN(uid)){
            alert("uid只能为数字");
            return false;
        }
        if(num!="" && isNaN(num)){
            alert("粉丝数只能为数字");
            return false;
        }
        if(num>2000){
            alert("粉丝数只能填写小于2000");
            return false;
        }

        $('#myForm').ajaxSubmit(function (data) {
            if (data.errno == 0) {
                alert("操作成功！");
            } else if (data.errno == 1) {
                alert(data.errdesc);
            }
        });
    }

</script>