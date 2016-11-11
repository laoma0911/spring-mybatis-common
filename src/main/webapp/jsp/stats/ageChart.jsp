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
                            <form class="form-search" name="myForm" id="myForm" action="${BasePath}/stats/getAgeJson" method="post">
                                <select name="year" id="year" class="input-medium search-query inline">
                                    <c:forEach items="${yearList }" var="year">
                                        <option value="${year }">${year }年</option>
                                    </c:forEach>
                                </select>
                                <select name="month" id="month" class="input-medium search-query inline">
                                    <option value="01"
                                            <c:if test="${month==1 }">selected="selected"</c:if>   >1月
                                    </option>
                                    <option value="02"
                                            <c:if test="${month==2 }">selected="selected"</c:if> >2月
                                    </option>
                                    <option value="03" <c:if test="${month==3 }">selected="selected"</c:if>>3月</option>
                                    <option value="04"
                                            <c:if test="${month==4 }">selected="selected"</c:if> >4月
                                    </option>
                                    <option value="05" <c:if test="${month==5 }">selected="selected"</c:if>>5月</option>
                                    <option value="06" <c:if test="${month==6 }">selected="selected"</c:if>>6月</option>
                                    <option value="07" <c:if test="${month==7 }">selected="selected"</c:if>>7月</option>
                                    <option value="08" <c:if test="${month==8 }">selected="selected"</c:if>>8月</option>
                                    <option value="09" <c:if test="${month==9 }">selected="selected"</c:if>>9月</option>
                                    <option value="10" <c:if test="${month==10 }">selected="selected"</c:if>>10月</option>
                                    <option value="11" <c:if test="${month==11 }">selected="selected"</c:if>>11月</option>
                                    <option value="12"
                                            <c:if test="${month==12}">selected="selected"</c:if> >12月
                                    </option>
                                </select>
                                <button type="button" id="btn" name="btn" class="btn btn-success btn-small">Search</button>
                                <pe:permission key="download">
                                    <button type="button" class="btn btn-info btn-small" onclick="downAgeUser()">导出数据</button>
                                </pe:permission>
                            </form>
                        </div>
                    </div>
                </div>

                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <div class="muted pull-left">用户数据统计</div>
                        <div class="pull-right">
                            <br>
                        </div>
                    </div>
                    <form id="downForm" name="downForm" action="${BasePath}/stats/exportUserAge" style="display: none;">
                        <input type="text" id="yearForm" name="year"/>
                        <input type="text" id="monthForm" name="month"/>
                    </form>

                    <div class="block-content collapse in">
                        <script type="text/javascript">
                            function downAgeUser() {
                                var year=$("#year").val();
                                var month=$("#month").val();
                                $("#yearForm").val(year);
                                $("#monthForm").val(month);
                                $('#downForm').submit();
                            }
                            $(function () {
                                $('#btn').click(function () {
                                    $('#myForm').ajaxSubmit(function (data) {
                                        initChart(data);
                                    });
                                    return false;
                                });
                            });
                            function initChart(json) {
                                //柱状图
                                $('#ageZhu').highcharts({
                                    chart: {
                                        type: 'column'
                                    },
                                    title: {
                                        text: '年龄分布柱状图'
                                    },
                                    subtitle: {
                                        text: '大姨吗APP'
                                    },
                                    xAxis: {
                                        categories: json.categories
                                    },
                                    yAxis: {
                                        min: 0,
                                        title: {
                                            text: '人数'
                                        }
                                    },
                                    tooltip: {
                                        headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                                        pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                                        '<td style="padding:0"><b>{point.y}</b></td></tr>',
                                        footerFormat: '</table>',
                                        shared: true,
                                        useHTML: true
                                    },
                                    plotOptions: {
                                        column: {
                                            pointPadding: 0.2,
                                            borderWidth: 0
                                        }
                                    },
                                    series: [{
                                        name: '人数',
                                        data: json.data

                                    }]
                                });

                                //饼图
//	    $('#ageBing').highcharts({
//	        chart: {
//	            plotBackgroundColor: null,
//	            plotBorderWidth: null,
//	            plotShadow: false
//	        },
//	        title: {
//	            text: '用户年龄分布饼状图'
//	        },
//	        tooltip: {
//	    	    pointFormat: '{series.name}: <b>{point.percentage:.2f}%</b>'
//	        },
//	        plotOptions: {
//	            pie: {
//	                allowPointSelect: true,
//	                cursor: 'pointer',
//	                dataLabels: {
//	                    enabled: true,
//	                    color: '#000000',
//	                    connectorColor: '#000000',
//	                    format: '<b>{point.name}</b>: {point.percentage:.2f} %'
//	                }
//	            }
//	        },
//	        series: [{
//	            type: 'pie',
//	            name: '比例',
//	            data:
//	              json.pieData
//	        }]
//	    });
                            }
                        </script>
                        <script type="text/javascript" src="${BasePath }/js/highcharts/highcharts.js"></script>
                        <script type="text/javascript" src="${BasePath}/js/highcharts/modules/exporting.js"></script>
                        <div id="ageZhu" style="min-width:700px;height:400px"></div>

                        <%--<div id="ageBing" style="min-width:700px;height:400px"></div>--%>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="../include/bottom.jsp"/>