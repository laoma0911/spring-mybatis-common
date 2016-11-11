<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="/permission" prefix="pe" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../include/head.jsp" />
<jsp:include page="../include/model.jsp" />
<!-- Body -->
	<div class="row-fluid">


			<div class="row-fluid">
				<div class="span12">
				  <div class="block"  >
					<div class="navbar navbar-inner block-header"  style="border-bottom: none;" >
							<form class="form-search" name="myForm" id="myForm" action="${BasePath}/broadcast/getStatsJson" method="post">
                                <input  type="hidden"  name="url"  value="${url}"/>
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
            <div class="muted pull-left">用户分享wap数据统计</div>
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
            categories: data.tag.categories
        },
        yAxis: {
            title: {
                text: '次数'
            },
            plotLines: [{
                value: 0,
                width: 1,
                color: '#808080'
            }]
        },
        tooltip: {
            valueSuffix: '次数'
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
  					<div id="nick" style="min-width:700px;height:400px"></div>
          </div>
        </div>
      </div>
</div>
