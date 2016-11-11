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
							<form class="form-search" name="myForm" id="myForm" action="${BasePath}/stats/getUserInfoJson" method="post">
							开始时间：
								<input type="text"  style="width: auto;" id="beginDate"  name="beginDate" value="${startDate }" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:'false'})" class="Wdate" onClick="WdatePicker()" />
							结束时间：
								<input type="text"  style="width: auto;" id="endDate"  name="endDate" value="${endDate }" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:'false'})" class="Wdate" onClick="WdatePicker()" />
								<select name="dateType"  id="dateType" class="input-medium search-query inline"  >
									<option value="day">日</option>
									<option value="month">月</option>
								</select>
  								<button type="button" id="btn" name="btn" class="btn">Search</button>
					</form>
                   </div>
						</div>
					</div>
         
        <div class="block">
          <div class="navbar navbar-inner block-header">
            <div class="muted pull-left">用户数据统计</div>
            <div class="pull-right">
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
	$('#nick').highcharts({
        title: {
            text: '统计',
            x: -20 //center
        },
        subtitle: {
            text: 'Source: 大姨吗APP',
            x: -20
        },
        xAxis: {
            categories: data.nick.categories
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
        series: data.nick.series
    });
}
		</script>
           <script type="text/javascript" src="${BasePath }/js/highcharts/highcharts.js"></script>
		  <script type="text/javascript" src="${BasePath}/js/highcharts/modules/exporting.js"></script>
  					<div id="nick" style="min-width:700px;height:400px"></div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<jsp:include page="../include/bottom.jsp" />