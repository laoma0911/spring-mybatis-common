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
                <!--kaishi -->
                <pe:permission key="add">
                    <div id="fixedBar" class="navbar navbar-inner" style="clear:both;">
                        <div class="muted pull-left inline">
                            <button class="btn btn-success btn-small" type="button" onclick="submitForm()">保存</button>
                        </div>
                        <div class="pull-left">
                            <h5>
                                &nbsp;&nbsp;&nbsp;&nbsp;马甲uid请使用逗号分割
                            </h5>
                        </div>
                    </div>
                </pe:permission>
                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <div class="muted pull-left">马甲名单</div>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table class="table table-hover">
                                <thead>
                                <tr>
                                    <th width="10%">ID</th>
                                    <th width="25%">标签</th>
                                    <th width="50%">马甲uid</th>
                                </tr>
                                </thead>
                                <form  id="myform" name="myform" action="${BasePath}/userTags/save" method="post">
                                <tbody id="tbodys">
                                <c:forEach items="${data}" var="obj">
                                    <tr>
                                        <td class="id">${obj.tagId}
                                            <input type="checkbox" name="ids" id="ids" checked="checked" value="${obj.id}"
                                                   style="display: none;"/>
                                        </td>
                                        <td>
                                                ${obj.tagsName}
                                        </td>
                                        <td>
                                            <textarea name="uids_${obj.id}" rows="4" id="uids_${obj.id}"
                                               style="margin: 0px 0px 10px; width: 550px; height: 150px;">${obj.uids}</textarea>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                                    </form>
                            </table>
                            <div class="pagination pagination-centered" id="pager"></div>
                            <script type="text/javascript">
                                var sign = 0;
                                window.onload = function () {
                                    PAGER.initPager('${start}', ' ${total}', '${limit}', 8, 'pager', getData);
                                }
                                function getData(currentPage, pageSize) {
                                    if (sign > 0) {
                                        $("#start").val(currentPage);
                                        $("#limit").val(pageSize);
                                        window.location.href = "${BasePath}/userTags/list?start=" + currentPage + "&limit=" + pageSize + "&type=${type}&itemId=${itemId}";
                                    }
                                    sign = 1;
                                }
                            </script>
                        </div>
                    </div>
                </div>
                <!--jieshu-->
            </div>
        </div>
    </div>
</div>
<hr>
<jsp:include page="../include/bottom.jsp"/>
<script>
    function submitForm(){
        $("#btn").attr("disabled", "disabled");
        $('#myform').ajaxSubmit(function (data) {
            if (data.errno == 0) {
                alert("操作成功！");
                window.location.reload();
            } else if (data.errno == 1) {
                 alert(data.errdesc);
                $("#btn").removeAttr("disabled");
            }
        });
    }


</script>
