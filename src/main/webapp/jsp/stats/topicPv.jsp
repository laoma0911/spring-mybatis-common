<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="/permission" prefix="pe" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%--
  ~ /**
  ~  *dashan
  ~  */
  --%>

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
							<form class="form-search" name="myForm" id="myForm" action="${BasePath}/stats/getTopicPVJson" method="post">
							开始时间：
								<input type="text"  style="width: auto;" id="beginDate"  name="beginDate" value="${startDate }" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:'false'})" class="Wdate" onClick="WdatePicker()" />
							结束时间：
								<input type="text"  style="width: auto;" id="endDate"  name="endDate" value="${endDate }" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:'false'})" class="Wdate" onClick="WdatePicker()" />
								<select name="dateType"  id="dateType" class="input-medium search-query inline"  >
									<option value="day">日</option>
									<%--<option value="month">月</option>--%>
								</select>
								<select name="platform"  id="platform"  class="input-medium search-query inline"  onchange="changeFlatform(this)" >
									<option value="-1"  >全部</option>
									<option  value="android">Android</option>
									<option value="ios">IOS</option>
									<option value="wp">WP</option>
								</select>
								<script type="text/javascript">
								function changeFlatform(obj){
									var val=obj.value;
									$("#version").val("");
									$("#version").html("");
									$("#version").append("<option value=\"\">全部</option>"); 
									 var versionListStr="${versionListStr}";
									 var versionList=versionListStr.split("-");
									 for (var i=0;i<versionList.length ;i++ ) {
										    var version=versionList[i].split(",");
										    if(version[0]==val){
										    	$("#version").append("<option value=\""+version[1]+"\">"+version[2]+"</option>"); 
										    }
									 }
								}
								</script>
								
								<select name="version"  id="version"  class="input-medium search-query inline" >
								<option value="">全部</option>
								</select>
  								<button type="button" id="btn" name="btn" class="btn btn-success">Search</button>
					</form>
                   </div>
						</div>
					</div>
         
        <div class="block">
          <div class="navbar navbar-inner block-header">
            <div class="muted pull-left">话题数据统计</div>
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
            text: '话题页PV、UV',
            x: -20 //center
        },
        subtitle: {
            text: 'Source: 大姨吗APP',
            x: -20
        },
        xAxis: {
            categories: data.topic.categories
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
        series: data.topic.series
    });

	$('#topicList').highcharts({
        title: {
            text: '话题列表页PV，UV',
            x: -20 //center
        },
        subtitle: {
            text: 'Source: 大姨吗APP',
            x: -20
        },
        xAxis: {
            categories: data.topicList.categories
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
        series: data.topicList.series
    });


    $('#index').highcharts({
        title: {
            text: '首页内容流PV,UV',
            x: -20 //center
        },
        subtitle: {
            text: 'Source: 大姨吗APP',
            x: -20
        },
        xAxis: {
            categories: data.index.categories
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
        series: data.index.series
    });
}
		</script>
           <script type="text/javascript" src="${BasePath }/js/highcharts/highcharts.js"></script>
		  <script type="text/javascript" src="${BasePath}/js/highcharts/modules/exporting.js"></script>
  					<div id="container" style="min-width:600px;height:400px"></div>

                    <br>

  					<div id="topicList" style="min-width:600px;height:400px"></div>
                    <br>
                    <div id="index" style="min-width:600px;height:400px"></div>

          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<jsp:include page="../include/bottom.jsp" />