<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="/permission" prefix="pe" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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
                            <form class="form-search" name="myForm" id="myForm" action="${BasePath}/stats/hotTopicStats" method="post">
                                开始时间：
                                <input type="text" style="width: auto;" id="date" name="date" value="${date }" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:'false'})" class="Wdate" onClick="WdatePicker()"/>
                                <input type="hidden"  name="start" id="start" value="${start }"/>
                                <input type="hidden"  name="limit" id="limit" value="${limit }"/>
                                <input type="hidden"  name="type" id="type" value="${type }"/>
                                <input type="hidden"  name="itemId" id="itemId" value="${itemId }"/>
                                <button type="submit"  class="btn">Search</button>
                            </form>
                        </div>
                    </div>
                </div>

                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <div class="muted pull-left">热门分享帖子列表</div>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table class="table table-hover">
                                <thead>
                                <tr>
                                    <th>排序</th>
                                    <th>标题</th>
                                    <th>标签</th>
                                    <th>上线时间</th>
                                    <th>分享总数</th>
                                    <th>微信朋友</th>
                                    <th>朋友圈</th>
                                    <th>QQ空间</th>
                                    <th>QQ好友</th>
                                </tr>
                                </thead>
                                <tbody id="tbodys">
                                <c:forEach items="${list}" var="obj">
                                    <tr>
                                        <td>${obj.rank}</td>
                                        <td>
                                            <a target="_blank" href="${BasePath }/topic/topicDetail?topicId=${obj.topicId}&type=${type}&itemId=${itemId}">${obj.title }</a>
                                        </td>
                                        <td>${obj.tag}</td>
                                        <td> <script >formatTime("${obj.dateline}");</script></td>
                                        <td>${obj.shareTotal }</td>
                                        <td>${obj.shareWeixin }</td>
                                        <td>${obj.shareMoment }</td>
                                        <td>${obj.shareQqzone }</td>
                                        <td>${obj.shareQq }</td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                            <div class="pagination pagination-centered" id="pager"></div>
                            <script type="text/javascript">
                                var sign = 0;
                                window.onload = function () {
                                    PAGER.initPager('${start}', '10000', '${limit}', 8, 'pager', getData);
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