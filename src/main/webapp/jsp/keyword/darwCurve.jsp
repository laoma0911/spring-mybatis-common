<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../include/head.jsp"/>
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
            <div class="muted pull-left">绘制曲线-${label }-${subLabel }</div>
        </div>

        <div class="alert alert-error" id="alertErr" style="display: none;">
            <button class="close" data-dismiss="alert">×</button>
            <strong>Error!</strong> <span id="errodesc">This is an error message.</span>
        </div>
        <div class="block-content collapse in">
            <div class="span12">
                <form class="form-horizontal" id="myForm" name="myForm" action="${BasePath }/keyword/getDarwCurve" method="post">
                    <input type="hidden" id="type" name="type" value="${type }"/>
                    <input type="hidden" id="itemId" name="itemId" value="${itemId }"/>
                    <input type="hidden" id="label" name="label" value="${label }"/>
                    <input type="hidden" id="subLabel" name="subLabel" value="${subLabel }"/>

						<table >
										<tr valign="middle">
											<td>平台：</td>
											<td>
												<select id="platform" name="platform">
													<option   value="-1">全部</option>
													<option  <c:if test="${platform==0 }">selected="selected" </c:if>  value="0">android</option>
													<option  <c:if test="${platform==1 }">selected="selected" </c:if> value="1"  >ios</option>
													<option  <c:if test="${platform==2 }">selected="selected" </c:if>  value="2" >WP</option>
												</select>
											</td>
											<td>日期:</td>
											<td><input type="text" class="Wdate" id="startDate" name="startDate" value="${startDate }"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'endDate\')}',readOnly:'false'})" /></td>
											<td>至:</td>
											<td><input type="text" class="Wdate" id="endDate" name="endDate" value="${endDate }" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'startDate\')}',readOnly:'false'})" /></td>
											<td>按:</td>
											<td>
												<select id="stype" name="stype">
													<option selected="selected" value="1">周</option>
												</select>
											</td>
											
<!-- 											<td><input type="button" onclick="btnSubmit(this)" value="重绘曲线" /></td> -->
												<td><button type="button" id="btn" name="btn" class="btn btn-success">Search</button></td>
										</tr>
									
									</table>

                </form>
            </div>
            
            
            <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <div class="muted pull-left">数据统计</div>
                        <div class="pull-right">
                            <span class="badge badge-info">${userCount}</span>
                            <br>
                        </div>
                    </div>

                    <div class="block-content collapse in">
                        <script type="text/javascript">
                            $(function () {
                               		 $('#btn').click(function(){
                                	
	                                	  var startDate = $("#startDate").val();
	                                      if (startDate == "") {
	                                          alert("请输入开始时间！");
	                                          return false;
	                                      }
	                                      var endDate = $("#endDate").val();
	                                      if (endDate == "") {
	                                          alert("请输入结束时间！");
	                                          return false;
	                                      }
	                                      
	                                  	var sd = startDate.split("-");
	                                  	var ed = endDate.split("-");
	                                  	
	                                  	if(sd[0] != ed[0]){
	                                				alert("时间段必须在相同年!");
	                                				return false;
	                                  	}
	                                	
	                                    $('#myForm').ajaxSubmit(function(data){
	                                        initChart(data);
	                                    });
	                                    return false;
	                                });
	                                
	                                $('#myForm').ajaxSubmit(function(data){
	                                    initChart(data);
	                                });
                                
                            });
                            function initChart(data){
                                $('#container').highcharts({
                                    title: {
                                        text: 'myForm',
                                        x: -20 //center
                                    },
                                    subtitle: {
                                        text: 'Source: 大姨吗APP',
                                        x: -20
                                    },
                                    xAxis: {
                                        categories: data.tag.categories
                                    },
                                    yAxis: {
                                        title: {
                                            text: '人'
                                        },
                                        plotLines: [{
                                            value: 0,
                                            width: 1,
                                            color: '#808080'
                                        }]
                                    },
                                    tooltip: {
                                        valueSuffix: '人'
                                    },
                                    legend: {
                                        layout: 'horizontal',
                                        align: 'center',
                                        verticalAlign: 'bottom',
                                        borderWidth: 0
                                    },
                                    series: data.tag.series
                                });
                            }
                        </script>
                        <script type="text/javascript" src="${BasePath }/js/highcharts/highcharts.js"></script>
                        <script type="text/javascript" src="${BasePath}/js/highcharts/modules/exporting.js"></script>
                        <div id="container" style="min-width:600px;height:400px"></div>
                    </div>
                </div>
            
            
        </div>
    </div>
    <!-- /block -->

	


</div>
<jsp:include page="../include/bottom.jsp"/>
<script>

</script>