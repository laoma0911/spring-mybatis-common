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
				<div class="span12" style="overflow-x:auto;">
				    <div class="block"  >
					<div class="navbar navbar-inner block-header"  style="border-bottom: none;" >
					<form id="myForm"  name="myForm"  action="${BasePath}/pointscoinssummary/search" method="post">
									<table >
										<tr valign="middle">
<!-- 											<td>类型：</td> -->
<!-- 											<td> -->
<!-- 												<select id="pctype" name="pctype"> -->
<%-- 													<option  <c:if test="${pctype==0 }">selected="selected" </c:if>  value="0">金币</option> --%>
<%-- 													<option  <c:if test="${pctype==1 }">selected="selected" </c:if> value="1"  >积分</option> --%>
<!-- 												</select> -->
<!-- 											</td> -->
											<td>日期:</td>
											<td><input type="text" class="Wdate" id="startDate" name="startDate" value="${startDate }"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'endDate\')}',readOnly:'false'})" /></td>
											<td>至:</td>
											<td><input type="text" class="Wdate" id="endDate" name="endDate" value="${endDate }" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'startDate\')}',readOnly:'false'})" /></td>
											<td><input type="button" onclick="btnSubmit()" value="查询" /></td>
										</tr>
									
									</table>
									<input type="hidden"  name="type" id="type" value="${type }"/>
									<input type="hidden"  name="itemId" id="itemId" value="${itemId }"/>
					</form>
                           </div>
						</div>
					</div>
         
        
        	<div class="block">
          <div class="navbar navbar-inner block-header">
            <div class="muted pull-left">金币统计</div>
            <div class="pull-right">
		    </div>
          </div>
          <div class="block-content collapse in">
            <div class="span12" style="overflow-x:auto;">
		                        <script type="text/javascript" src="${BasePath }/js/highcharts/highcharts.js"></script>
		                        <script type="text/javascript" src="${BasePath}/js/highcharts/modules/exporting.js"></script>
		                        <div id="container" style="min-width:600px;height:400px"></div>
            </div>
          </div>
        </div>
        
        
        
        	<div class="block">
		          <div class="navbar navbar-inner block-header">
		            <div class="muted pull-left">积分统计</div>
		            <div class="pull-right">
				    </div>
		          </div>
		          <div class="block-content collapse in">
		            <div class="span12" style="overflow-x:auto;">
<%-- 				                        <script type="text/javascript" src="${BasePath }/js/highcharts/highcharts.js"></script> --%>
<%-- 				                        <script type="text/javascript" src="${BasePath}/js/highcharts/modules/exporting.js"></script> --%>
				                        <div id="container1" style="min-width:600px;height:400px"></div>
		            </div>
		          </div>
		        </div>
        
      </div>
    </div>
  </div>
</div>
  <hr>
  
<jsp:include page="../include/bottom.jsp" />
<script>
    
    
    
    
    function btnSubmit(){
    	
    	var startDate = $("#startDate").val();
    	var endDate = $("#endDate").val();
    	
    	if(startDate == "" || endDate == ""){
    		alert("日期不能为空");
    		return ;
    	}
    	
        $('#myForm').ajaxSubmit(function(data){
            initChart(data,"container","金币统计");
            initChart1(data,"container1","积分统计");
        });
    }
    
    function initChart(data,id,name){
        $('#'+id).highcharts({
            title: {
                text: name,
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
                    text: ''
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
            series: data.tag.series
        });
    }
    
    function initChart1(data,id,name){
        $('#'+id).highcharts({
            title: {
                text: name,
                x: -20 //center
            },
            subtitle: {
                text: 'Source: 大姨吗APP',
                x: -20
            },
            xAxis: {
                categories: data.tag1.categories
            },
            yAxis: {
                title: {
                    text: ''
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
            series: data.tag1.series
        });
    }
    
    
    
    
</script>