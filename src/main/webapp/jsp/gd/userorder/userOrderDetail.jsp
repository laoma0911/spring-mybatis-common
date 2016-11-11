<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
            <div class="muted pull-left">小助手订单详情</div>
        </div>
        <c:if test="${orderDetail!=null}">
            <div class="block-content collapse in">
                <div class="span">
                    <table>
                        <tr>
                            <td>小助手信息：</td>
                            <td style="color: green">${orderDetail.expertService.name}</td>
                        </tr>

                        <tr>
                            <td>服务时长：</td>
                            <td style="color: green">
                                    ${orderDetail.duration}个月
                            </td>
                        </tr>
                        <tr>
                            <td>购买价格：</td>
                            <td style="color: green">${orderDetail.price}</td>
                        </tr>
                        <tr>
                            <td>订单创建时间时间：</td>
                            <td style="color: green">
                                <script>formatTime("${orderDetail.createTime}");</script>
                            </td>
                        </tr>

                        <tr>
                            <td>支付成功时间：</td>
                            <td style="color: green">
                                <c:if test="${orderDetail.succeedTime != null}">
                                    <script>formatTime("${orderDetail.succeedTime}");</script>
                                </c:if>
                            </td>
                        </tr>

                        <tr>
                            <td>支付方式：</td>
                            <td style="color: green">
                                <c:if test="${orderDetail.paymentType == 0}">微信</c:if>
                                <c:if test="${orderDetail.paymentType == 1}">支付宝</c:if>
                            </td>
                        </tr>

                        <tr>
                            <td>支付状态：</td>
                            <c:if test="${orderDetail.paymentStatus == 0}">
                                <td style="color: green">
                                    支付成功
                                </td>
                            </c:if>
                            <c:if test="${orderDetail.paymentStatus == 1}">
                                <td style="color: red">
                                    未支付
                                </td>
                            </c:if>
                        </tr>
                    </table>
                </div>
            </div>
        </c:if>
    </div>
</div>