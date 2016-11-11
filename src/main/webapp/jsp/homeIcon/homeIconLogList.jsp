<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="/permission" prefix="pe" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="../include/head.jsp"/>
<script>
    <c:if test="${CHECKUSER==false }">
    alert("用户没有登录，请登录！");
    window.location.href = "${BasePath}";
    </c:if>
</script>
<style>
    body {
        padding-top: 0px;
    }
</style>
<!-- Body -->
<div class="container-fluid">
    <div class="block">
        <div class="navbar navbar-inner block-header" style="border-bottom: none;">
            <form class="form-search" name="myForm" id="myForm" action="${BasePath}/homeIcon/logList" method="post">
                开始时间：
                <input type="text" style="width: auto;" id="startDate" name="startDate" value="${startDate }"
                       onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:'false'})" class="Wdate"
                       onClick="WdatePicker()"/>
                结束时间：
                <input type="text" style="width: auto;" id="endDate" name="endDate" value="${endDate }"
                       onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:'false'})" class="Wdate"
                       onClick="WdatePicker()"/>
                <select name="dateType" id="dateType" class="input-medium search-query inline">
                    <option value="">总数</option>
                    <option value="day"  <c:if test="${dateType=='day' }"> selected="selected"</c:if>>日</option>
                    <option value="month"  <c:if test="${dateType=='month' }"> selected="selected"</c:if>>月</option>
                </select>
                <input type="hidden" id="position" name="position" value="${position }"/>
                <input type="hidden" id="type" name="type" value="${type }"/>
                <input type="hidden" id="itemId" name="itemId" value="${itemId }"/>
                <input type="hidden" name="start" id="start" value="${start }"/>
                <input type="hidden" name="limit" id="limit" value="${limit }"/>
                <button type="submit" id="btn">Search</button>
            </form>
        </div>
    </div>
</div>

<div class="block">
    <div class="navbar navbar-inner block-header">
        <div class="muted pull-left">日志列表</div>
    </div>
    <div class="block-content collapse in">
        <div class="span12">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>时间</th>
                    <th>平台</th>
                    <th>点击量</th>
                </tr>
                </thead>
                <tbody id="tbodys">
                <c:forEach items="${json.data}" var="obj">
                    <tr>
                        <td>
                            <c:choose>
                                <c:when test="${obj.dateline==0 }">
                                    总点击数
                                </c:when>
                                <c:otherwise>
                                    ${obj.dateline }
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${obj.platform==0 }">
                                    Android
                                </c:when>
                                <c:when test="${obj.platform==1 }">
                                    ios
                                </c:when>
                                <c:when test="${obj.platform==2 }">
                                    wp
                                </c:when>
                            </c:choose>
                        </td>
                        <td>
                                ${obj.num }
                        </td>
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
<hr>
<jsp:include page="../include/bottom.jsp"/>