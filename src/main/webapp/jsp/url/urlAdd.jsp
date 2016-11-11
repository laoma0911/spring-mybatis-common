<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

<jsp:include page="../include/head.jsp"/>
<!-- Body -->
<div class="container-fluid">
    <div class="block">
        <div class="navbar navbar-inner block-header">
            <div class="muted pull-left">添加URL</div>
        </div>

        <div class="alert alert-error" id="alertErr" style="display: none;">
            <button class="close" data-dismiss="alert">×</button>
            <strong>Error!</strong> <span id="errodesc">This is an error message.</span>
        </div>
        <div class="block-content collapse in">
            <div>
                <form class="form-horizontal" method="post">
                    <input type="hidden" id="id" name="id" value="${json.data.id }"/>
                    <input type="hidden" id="type" name="type" value="${type }"/>
                    <input type="hidden" id="itemId" name="itemId" value="${itemId }"/>
                    <fieldset>
                        <legend>短链接信息</legend>
                        <div class="control-group">
                            <!-- Select Basic -->
                            <label class="control-label" for="domainId" style="float: left;">所属域名</label>

                            <div class="controls">
                                <select class="input-xlarge" id="domainId" name="domainId">
                                    <c:forEach items="${domainJson.data}" var="domain">
                                        <c:choose>
                                            <c:when test="${json.data.id == domain.id}">
                                                <option value="${domain.id}" selected="selected">${domain.domain}</option>
                                            </c:when>
                                            <c:otherwise>
                                                <option value="${domain.id}">${domain.domain}</option>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" for="shortUrl" style="float: left;">短链接</label>

                            <div class="controls">
                                <input class="input-xlarge focused" id="shortUrl" name="shortUrl" type="text" value="${json.data.shortUrl }"/>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="originalUrl" style="float: left;">原始路径</label>

                            <div class="controls">
                                <input class="input-xlarge focused" id="originalUrl" name="originalUrl" type="text" value="${json.data.originalUrl }"/>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="targetUrl" style="float: left;">目的路径</label>
                            <div class="controls">
                                <input class="input-xlarge focused" id="targetUrl" name="targetUrl" type="text" value="${json.data.targetUrl }"/>
                            </div>
                        </div>
                        <div class="form-actions">
                            <button type="button" onclick="saveUrl()" class="btn btn-primary">保存</button>
                        </div>
                    </fieldset>
                </form>

            </div>
        </div>
    </div>
    <!-- /block -->
</div>
<script>
    function saveUrl() {
        var id = $("#id").val();
        var domainId = $("#domainId").val();
        var shortUrl = $("#shortUrl").val();
        var originalUrl = $("#originalUrl").val();
        var targetUrl=$("#targetUrl").val();
//        if (shortUrl == "") {
//            alert("短链接不能为空！");
//            return;
//        }
        if (originalUrl == "") {
            alert("原始路径不能为空！");
            return;
        }
        if (targetUrl== "") {
            alert("目的路径不能为空！");
            return;
        }
        $.ajax({
            type: "POST",
            url: "${BasePath }/url/save?domainId=" + domainId + "&shortUrl=" + shortUrl + "&originalUrl=" + originalUrl +"&targetUrl="+targetUrl+ "&id=" + id,
            datatype: "json",
            success: function (data) {
                if (data.errno == 1) {
                    $("#alertErr").show();
                    $("#errodesc").html(data.errdesc);
                } else if (data.errno == 0) {
                    alert("操作成功！");
                    window.parent.closeModel();
                }
            },
            error: function () {
                alert("操作出错，请联系管理员！");
            }
        });
    }


</script>