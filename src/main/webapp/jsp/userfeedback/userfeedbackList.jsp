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
                    <div class="block"  >
                        <div class="navbar navbar-inner block-header"  style="border-bottom: none;" >
                            <form id="myForm"  name="myForm"  action="${BasePath}/feedback/list?${PublicParams}" method="post">
                                <table >
                                    <tr valign="middle">
                                        <td>UID：</td><td><input type="text" name="uid" value="${uid}" /></td>
                                        <td><input type="submit" value="查询" /></td>
                                    </tr>
                                </table>
                                <input type="hidden"  name="start" id="start" value="${start}"/>
                                <input type="hidden"  name="limit" id="limit" value="${limit}"/>
                            </form>
                        </div>
                    </div>
                </div>
                <!--kaishi -->
                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <div class="muted pull-left">用户意见反馈</div>
                        <div class="pull-right">
                            <span class="badge badge-info">${userCount}</span>
                        </div>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table class="table table-hover">
                                <thead>
                                <tr>
                                    <th nowrap="true">ID</th>
                                    <th nowrap="true">UID</th>
                                    <th nowrap="true">反馈意见</th>
                                    <th nowrap="true">平台</th>
                                    <th nowrap="true">反馈时间</th>
                                </tr>
                                </thead>
                                <tbody id="tbodys">
                                <c:forEach items="${json.data}" var="obj">
                                    <tr>
                                        <td nowrap="true" class="id">${obj.id}</td>
                                        <td nowrap="true">${obj.uid}</td>
                                        <td style="width: 400px;" class="tdBreak">${obj.content}</td>
                                        <td>
                                            <script type="text/javascript">formatPlatform('${obj.platform}');</script>
                                        </td>
                                        <td>
                                            <script>formatTime("${obj.dateline}");</script>
                                        </td>

                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                            <div class="pagination pagination-centered" id="pager"></div>
                            <script type="text/javascript">
                                var sign=0;
                                window.onload=function(){
                                    PAGER.initPager('${start}',' ${json.total}','${limit}', 8, 'pager', getData);
                                }
                                function getData(currentPage,pageSize) {
                                    if(sign>0){
                                        $("#start").val(currentPage);
                                        $("#limit").val(pageSize);
                                        $("#myForm").submit();
                                    }
                                    sign=1;
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
