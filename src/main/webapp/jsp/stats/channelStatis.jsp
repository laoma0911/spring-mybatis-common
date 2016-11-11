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
                            <form class="form-search" name="myForm" id="myForm" action="${BasePath}/stats/channelStats" method="post">
                                渠道：
                                <select name="channel" id="channel">
                                    <option value="">全部</option>
                                    <c:forEach items="${channelsList}" var="obj">
                                        <option value="${obj.name }"  <c:if test="${obj.name==channel }">selected="selected"</c:if>  >${obj.name }</option>
                                    </c:forEach>
                                </select>
                                注册时间：
                                <input type="text" style="width: auto;" id="regStart" name="regStart" value="${regStart }" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-%d',readOnly:'false'})" class="Wdate" onClick="WdatePicker()"/>
                                ～
                                <input type="text" style="width: auto;" id="regEnd" name="regEnd" value="${regEnd}" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-%d',readOnly:'false'})" class="Wdate" onClick="WdatePicker()"/>

                                统计时间：
                                <input type="text" style="width: auto;" id="statisStart" name="statisStart" value="${statisStart }" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-%d',readOnly:'false'})" class="Wdate" onClick="WdatePicker()"/>
                                ～
                                <input type="text" style="width: auto;" id="statisEnd" name="statisEnd" value="${statisEnd }" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-%d',readOnly:'false'})" class="Wdate" onClick="WdatePicker()"/>
                                <input type="submit" value="查询" class="btn btn-success btn-small" />
                            </form>
                        </div>
                    </div>
                </div>

                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <div class="muted pull-left">渠道质量分析</div>
                        <div class="pull-right">
                            <%--<pe:permission key="add">--%>
                                <button class="btn btn-success btn-small" style="margin-top: -5px" onclick="openModel('${BasePath}/stats/toAddChannel','新增','50%','50%')">新增</button>
                            <%--</pe:permission>--%>
                        </div>
                    </div>

                    <div class="block-content collapse in">
                        <div class="span12">
                            <table class="table table-hover">
                                <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>渠道</th>
                                    <th >注册开始时间</th>
                                    <th>注册结束时间</th>
                                    <th>统计开始时间</th>
                                    <th>统计结束时间</th>
                                    <th>状态</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody id="tbodys">
                                <c:forEach items="${data.data}" var="obj">
                                    <tr >
                                        <td  class="uid">${obj.id}</td>
                                        <td>${obj.channel}</td>
                                        <td>${obj.regStart}</td>
                                        <td>${obj.regEnd}</td>
                                        <td>${obj.statsStart}</td>
                                        <td>${obj.statsEnd}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${obj.status==0}">
                                                    <span style="color: #df8505">未开始</span>
                                                </c:when>
                                                <c:when test="${obj.status==1}">
                                                    <span style="color: #5bc0de">执行中</span>
                                                </c:when>
                                                <c:when test="${obj.status==2}">
                                                    <span style="color: green">完成</span>
                                                </c:when>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <pe:permission key="update">
                                                <a class="btn btn-success btn-small" href="javascript:openModel('${BasePath}/card/toEdit?id=${obj.id}','修改')" >修改</a>
                                            </pe:permission>
                                            <pe:permission key="delete">
                                                <button class="btn del btn-danger btn-small">删除</button>
                                            </pe:permission>
                                            <pe:permission key="log">
                                                <a class="btn btn-info btn-small" href="javascript:openModel('${BasePath}/mei/toMeiImageLog?id=${obj.id}','查看每日')">查看每日</a>
                                            </pe:permission>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                            <div class="pagination pagination-centered" id="pager"></div>
                            <script type="text/javascript">
                                var sign=0;
                                window.onload=function(){
                                    PAGER.initPager('${start}','10000000','${limit}', 8, 'pager', getData);
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
            </div>
        </div>
    </div>
</div>
<jsp:include page="../include/bottom.jsp"/>