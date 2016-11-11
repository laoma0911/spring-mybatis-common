<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="/permission" prefix="pe" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="../include/top.jsp"/>
<!-- Body -->
<script src="${BasePath}/js/json.js"></script>
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
                            <form id="myForm" name="myForm" action="${BasePath}/userCoupon/list" method="post"
                                  class="form-inline">
                                标题：<input type="text" name="title" value="${title}"/> <input type="submit"
                                                                                             value="查询"
                                                                                             class="btn btn-success btn-small"/>

                                <input type="hidden" name="start" id="start" value="${start }"/>
                                <input type="hidden" name="limit" id="limit" value="${limit }"/>
                                <input type="hidden" name="type" id="type" value="${type }"/>
                                <input type="hidden" name="itemId" id="itemId" value="${itemId }"/>

                            </form>
                        </div>
                    </div>
                </div>

                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <div class="muted pull-left">列表</div>
                        <div class="pull-right">
                            <pe:permission key="add">
                                <button class="btn btn-success btn-small" style="margin-top: -5px"
                                        onclick="openModel('${BasePath}/userCoupon/toAdd','新增')">新增
                                </button>
                            </pe:permission>
                        </div>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table class="table table-hover">
                                <thead>
                                <tr>
                  <%--                  private Long id;
                                    private Long uid;  //uq
                                    private String mobile;//uq 用户手机
                                    private String device;//uq 用户设备号
                                    private String coupon; //优惠券码
                                    private Integer couponType;//0:直减1:满减
                                    private Long dateline;  // 领取日期
                                    private Long expiredDate; //过期日期
                                    private Integer status;  //状态0:正常，其他待定--%>

                                    <th>ID</th>
                                    <th>用户昵称<br/>UID  </th>
                                    <th>手机号</th>
                                    <th>设备号</th>
                                <%--    <th>优惠券码</th>--%>
                                    <th>优惠券类型</th>
                                    <th>领取日期</th>
                                    <th>过期日期</th>
                             <%--       <th style="width: 8%;" >操作  </th>--%>
                                </tr>
                                </thead>
                                <tbody id="tbodys">
                                <c:forEach items="${list}" var="obj">
                                    <tr>
                                        <td class="id">${obj.id}</td>
                                        <td >${obj.nick} <br/>${obj.uid}</td>
                                        <td > ${obj.mobile}</td>


                                        <td class="id">${obj.device}</td>

                                     <%--   <td>${obj.coupon}</td>--%>
                                        <td>
                                            <c:if test="${obj.couponType==0}">直减</c:if>
                                            <c:if test="${obj.couponType==1}">满减</c:if>
                                        </td>
                                        <td>
                                            <script>formatDate("${obj.dateline}");</script>
                                        </td>
                                        <td>
                                            <script>formatDate("${obj.expiredDate}");</script>
                                        </td>
                                <%--        <td>
                                            <pe:permission key="update">
                                                <a class="btn btn-success btn-small"
                                                   href="javascript:openModel('${BasePath}/userCoupon/toEdit?id=${obj.id}','修改')">修改</a>
                                            </pe:permission>
                                            <pe:permission key="delete">
                                                <button class="btn del btn-danger btn-small">删除</button>
                                            </pe:permission>

                                        </td>--%>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                            <div class="pagination pagination-centered" id="pager"></div>
                            <script type="text/javascript">
                                var sign = 0;
                                window.onload = function () {
                                    PAGER.initPager('${start}', ' ${json.total}', '${limit}', 8, 'pager', getData);
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
<jsp:include page="../include/bottom.jsp"/>


<script>
    $(function () {

        //异步统计曝光量
        $("input[name='id']").each(function () {
            var id = this.value;
            $.post('${BasePath}/userCoupon/getClickNum', {'id': id}, function (data) {
                var obj = eval(data);
                if (obj.errno == 0) {
                    $("#clickNumDiv_" + id).html(data.totalClickNum ? data.totalClickNum :0 );
                }
            });
        });
        //异步统计点击量
        $("input[name='id1']").each(function () {
            var id = this.value;
            $.post('${BasePath}/userCoupon/getClickNum', {'id': id}, function (data) {
                var obj = eval(data);
                if (obj.errno == 0) {
                    $("#clickNumDiv1_" + id).html(data.totalClickNum ? data.totalClickNum :0);
                }
            });
        });


        $(".del").bind('click', function () {

            if (!confirm('确定删除该条记录吗？')) {
                return false;
            }
            var uid = $(this).parent().parent().find(".id").text();
            var tr = $(this).parent().parent();
            $.post('${BasePath}/userCoupon/delete', {
                'id': uid
            }, function (data) {
                var obj = eval(data);
                if (obj.errno == 0) {
                    alert('操作成功');
                    tr.remove();
                } else {
                    alert(obj.errdesc);
                }
            });

        });
    });
</script>