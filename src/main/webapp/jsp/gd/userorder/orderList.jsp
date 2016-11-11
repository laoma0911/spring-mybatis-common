<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="/permission" prefix="pe" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="e" uri="https://www.owasp.org/index.php/OWASP_Java_Encoder_Project" %>
<jsp:include page="../../include/top.jsp"/>
<link href="${BasePath}/js/mediabox/css.css" rel="stylesheet" media="screen">
<!-- Body -->
<div class="container-fluid" onmousemove="initTrColor()">
    <div class="row-fluid">
        <!-- Menu -->
        <jsp:include page="../../include/menu.jsp"/>
        <div class="span9" id="content">
            <jsp:include page="../../include/location.jsp"/>
            <div class="row-fluid">
                <div class="span12">
                    <div class="block">
                        <div class="navbar navbar-inner block-header" style="border-bottom: none;">
                            <form class="form-inline" id="myForm" name="myForm"
                                  action="${BasePath}/meiyue/order/list?${PublicParams}" method="post">
                                UID：
                                <input type="text" id="uid" name="uid" value="${uid}">
                                状态：
                                <select name="status" id="status">
                                    <option
                                            <c:if test="${status==-1}">selected="selected" </c:if> value="-1">全部
                                    </option>
                                    <option
                                            <c:if test="${status==0}">selected="selected" </c:if> value="0">生效
                                    </option>
                                    <option
                                            <c:if test="${status==1}">selected="selected" </c:if> value="1">未生效
                                    </option>
                                </select>
                                <button type="button" onclick="submitForm()" class="btn btn-success btn-small">查询
                                </button>
                            </form>

                        </div>
                    </div>
                </div>

                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <div class="muted pull-left inline">小助手订单</div>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table class="table">
                                <thead>
                                <tr>
                                    <th nowrap="true">ID</th>
                                    <th nowrap="true">UID</th>
                                    <th nowrap="true">服务时长</th>
                                    <th nowrap="true">购买价格</th>
                                    <th nowrap="true">订单创建时间时间</th>
                                    <th nowrap="true">支付成功时间</th>
                                    <th nowrap="true">支付方式</th>
                                    <th nowrap="true">支付状态</th>
                                </tr>
                                </thead>
                                <tbody id="tbodys">
                                <c:forEach items="${data}" var="obj">
                                    <tr>
                                        <td nowrap="true" id="clickId">
                                                ${obj.id}
                                        </td>

                                        <td nowrap="true" style="vertical-align:middle">
                                            <font color="#08c">UID：</font><a href="${BasePath}/custom/userList?type=4&itemId=20&uid=${obj.uid}"  target="_black">${obj.uid}</a>
                                            <br>
                                            <font color="#08c">昵称：</font> ${obj.nick}<br>
                                        </td>
                                        <td nowrap="true" style="vertical-align:middle">
                                                ${obj.duration}个月
                                        </td>
                                        <td nowrap="true" style="vertical-align:middle">
                                                ${obj.price}
                                        </td>
                                        <td nowrap="true" style="vertical-align:middle">
                                            <script>formatTime(${obj.createTime});</script>
                                        </td>
                                        <td nowrap="true" style="vertical-align:middle">
                                            <c:if test="${obj.succeedTime != 0}">
                                                <script>formatTime(${obj.succeedTime});</script>
                                            </c:if>

                                        </td>
                                        <td nowrap="true" style="vertical-align:middle">
                                            <c:if test="${obj.paymentType==1}">
                                                <font color="green">支付宝</font>
                                            </c:if>
                                            <c:if test="${obj.paymentType==0}">
                                                <font color="green">微信</font>
                                            </c:if>
                                            <c:if test="${obj.paymentType==3}">
                                                <font color="green">苹果支付</font>
                                            </c:if>
                                        </td>

                                        <td nowrap="true" style="vertical-align:middle">
                                            <c:if test="${obj.paymentStatus==0}">
                                                <font color="green">生效</font>
                                            </c:if>
                                            <c:if test="${obj.paymentStatus==1}">
                                                <font color="red">未生效</font>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
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
                                        $("#myForm").submit();
                                    }
                                    sign = 1;
                                }
                            </script>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<hr>
<jsp:include page="../../include/bottom.jsp"/>


<script>

    function submitForm() {
        $("#myForm").submit();
    }

    function deleteExpert(id) {
        $.ajax({
            type: "POST",
            url: "${BasePath}/meiyue/expertService/delete?id=" + id,
            datatype: "json",
            success: function (data) {
                if (data.errno == 1) {
                    alert(data.errdesc);
                } else {
                    submitForm();
                }
            },
            error: function () {
                alert("操作出错，请联系管理员！");
            }
        });
    }


    function setStatus(id,status) {
        $.ajax({
            type: "POST",
            url: "${BasePath}/meiyue/expertService/setStatus?id=" + id + "&status=" + status,
            datatype: "json",
            success: function (data) {
                if (data.errno == 1) {
                    alert(data.errdesc);
                } else {
                    submitForm();
                }
            },
            error: function () {
                alert("操作出错，请联系管理员！");
            }
        });
    }
</script>