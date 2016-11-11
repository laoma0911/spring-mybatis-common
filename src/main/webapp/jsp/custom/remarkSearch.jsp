<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="/permission" prefix="pe" %>

<%--
  ~ /**
  ~  *dashan
  ~  */
  --%>

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
                            <form action="${BasePath}/custom/calendarRemark?type=${type}&itemId=${itemId}" method="post" id="myform" name="myform" class="form-search">
                                时间：
                                <input type="text" class="Wdate" id="date" name="date" value="${date}" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})" class="Wdate"/>
                                <select id="dateType" name="dateType">
                                    <option value="1" <c:if test="${dateType==1}">selected </c:if> >按月查询</option>
                                    <option value="2" <c:if test="${dateType==2}">selected </c:if> >按日查询</option>
                                </select>
                                备注：
                                <input type="text" name="remark" id="remark" value="${remark }"/>
                                <input type="button" onclick="find()" class="btn btn-success btn-small" value="查询"/>
                                <input type="hidden" name="start" id="start" value="${start }"/>
                                <input type="hidden" name="limit" id="limit" value="${limit }"/>
                                <script type="text/javascript">
                                    function find() {
                                        $("#myform").submit();
                                    }
                                </script>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <div class="muted pull-left">列表</div>
                        <div class="pull-right">
                        </div>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table class="table table-hover">
                                <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>时间</th>
                                    <th>关键字</th>
                                    <th>状态</th>
                                    <th>结果</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody id="tbodys">
                                <c:forEach items="${list}" var="obj">
                                    <tr>
                                        <td>${obj.id}</td>
                                        <td>${obj.datetime}</td>
                                        <td>${obj.remark}</td>
                                        <td>
                                            <c:if test="${obj.status==0}">
                                                <span style="color: greenyellow">未查询</span>
                                            </c:if>
                                            <c:if test="${obj.status==1}">
                                                <span style="color: #ff0000">查询中</span>
                                            </c:if>
                                            <c:if test="${obj.status==2}">
                                                <span style="color: green">完成</span>
                                            </c:if>
                                        </td>
                                        <td>${obj.result}</td>
                                        <td>
                                            <c:if test="${obj.status==2}">
                                                <input type="button" class="btn btn-success btn-small" value="重新查询" onclick="reSearch(${obj.id})"/>
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
                                };
                                function getData(currentPage, pageSize) {
                                    if (sign > 0) {
                                        $("#start").val(currentPage);
                                        $("#limit").val(pageSize);
                                        $("#myform").submit();
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
    function reSearch(id) {
        $.post('${BasePath}/custom/reSearch', {'id': id}, function (data) {
            var obj = eval(data);
            if (obj.errno == 0) {
                alert('操作成功');
                window.location.reload();
            } else {
                alert(obj.errdesc);
            }
        });
    }
</script>