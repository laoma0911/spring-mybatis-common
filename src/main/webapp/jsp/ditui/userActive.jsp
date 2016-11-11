<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="/permission" prefix="pe" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="../include/top.jsp" />
<!-- Body -->
<div class="container-fluid">
    <div class="row-fluid">
        <!-- Menu -->
        <jsp:include page="../include/menu.jsp" />
        <div class="span9" id="content">
            <jsp:include page="../include/location.jsp" />
            <div class="row-fluid">
                <div class="span12">
                    <div class="block"  >
                        <div class="navbar navbar-inner block-header"  style="border-bottom: none;" >
                            <form class="form-search" name="myForm" id="myForm" action="${BasePath}/ditui/getUserActiveJson" method="post">
                                <td style="vertical-align: middle;">开始时间：</td>
                                <td><input type="text"  style="width: auto;" id="fromDay" name="fromDay" value="${startDate }" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:'false'})" class="Wdate" onClick="WdatePicker()" /></td>
                                <td style="vertical-align: middle;">结束时间：</td>
                                <td><input type="text"  style="width: auto;" id="toDay" name="toDay" value="${endDate }" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:'false'})" class="Wdate" onClick="WdatePicker()" /></td>
                                <td>渠道：</td>
                                <td>
                                    <select name="channel"  id="channel">
                                        <option  value="0">全部</option>
                                        <c:forEach items="${dituiOrgList}" var="org">
                                            <option value="${org.id}">${org.name}(${org.mobile})</option>
                                        </c:forEach>
                                    </select>
                                </td>
                                <button type="button" id="btn" name="btn" class="btn btn-success" style="vertical-align: middle;">查询</button>
                            </form>
                        </div>
                    </div>
                </div>

                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <div class="muted pull-left">用户活跃数据统计</div>
                        <div class="pull-right">
                            <%--              <pe:permission key="add"> --%>
                            <%--             <button class="btn btn-success" style="margin-top: -5px" onclick="window.location='${BasePath}/sisterPush/toAdd?type=${type}&itemId=${itemId}'">新增</button> --%>
                            <%--             </pe:permission> --%>
                            <span class="badge badge-info">${userCount}</span>
                            <br>
                        </div>
                    </div>

                    <div class="block-content collapse in">
                        <script type="text/javascript">
                            $(function () {
                                $('#btn').click(function(){
                                    $('#myForm').ajaxSubmit(function(data){
                                        initChart(data);
                                    });
                                    return false;
                                });
                            });
                            function initChart(data){
                                $('#container').highcharts({
                                    title: {
                                        text: '地推用户活跃量',
                                        x: -20 //center
                                    },
                                    subtitle: {
                                        text: 'Source: 用户活跃日志',
                                        x: -20
                                    },
                                    xAxis: {
                                        categories: data.categories
                                    },
                                    yAxis: {
                                        title: {
                                            text: '活跃人数'
                                        },
                                        plotLines: [{
                                            value: 0,
                                            width: 1,
                                            color: '#808080'
                                        }]
                                    },
                                    tooltip: {
                                        valueSuffix: ''
                                    },
                                    legend: {
                                        layout: 'horizontal',
                                        align: 'center',
                                        verticalAlign: 'bottom',
                                        borderWidth: 0
                                    },
                                    series: data.series
                                });
                            }
                        </script>
                        <script type="text/javascript" src="${BasePath}/js/highcharts/highcharts.js"></script>
                        <script type="text/javascript" src="${BasePath}/js/highcharts/modules/exporting.js"></script>
                        <div id="container" style="min-width:600px;height:600px"></div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="../include/bottom.jsp" />
