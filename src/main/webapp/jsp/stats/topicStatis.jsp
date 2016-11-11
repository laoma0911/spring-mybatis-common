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
							<form class="form-search" name="myForm" id="myForm" action="${BasePath}/stats/getTopicJson" method="post">
							开始时间：
								<input type="text"  style="width: auto;" id="beginDate"  name="beginDate" value="${startDate }" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:'false'})" class="Wdate" onClick="WdatePicker()" />
							结束时间：
								<input type="text"  style="width: auto;" id="endDate"  name="endDate" value="${endDate }" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:'false'})" class="Wdate" onClick="WdatePicker()" />
								<select name="dateType"  id="dateType"  class="input-medium search-query inline" >
									<option value="day">日</option>
									<option value="month">月</option>
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
										    	$("#version").append("<option value=\" "+version[1]+"  \">"+version[2]+"</option>"); 
										    }
									 }
								}
								</script>
								<select name="version"  id="version"  class="input-medium search-query inline" >
									<option value="" >全部</option>
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
	$('#topic').highcharts({
        title: {
            text: '发帖/回帖统计',
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
                text: '人次或发帖数'
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
	
	
	$('#reply').highcharts({
        legend:{
            align: 'center', //水平方向位置
            verticalAlign: 'top', //垂直方向位置
            x: 0, //距离x轴的距离
            y: 20 //距离Y轴的距离
        },
        title: {
            text: '回贴/回复人数统计',
            x: -20 //center
        },
        subtitle: {
            text: 'Source: 大姨吗APP',
            x: -20
        },
        xAxis: {
            categories: data.reply.categories
        },
        yAxis: {
            title: {
                text: '人次/回复数'
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
        series: data.reply.series
    });
	
	$('#like').highcharts({
        legend:{
            align: 'center', //水平方向位置
            verticalAlign: 'top', //垂直方向位置
            x: 0, //距离x轴的距离
            y: 20 //距离Y轴的距离
        },
        title: {
            text: '点赞总量/点赞人数/举报量/收藏量',
            x: -20 //center
        },
        subtitle: {
            text: 'Source: 大姨吗APP',
            x: -20
        },
        xAxis: {
            categories: data.like.categories
        },
        yAxis: {
            title: {
                text: '人数/数量'
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
        series: data.like.series
    });
	
}
		</script>
           <script type="text/javascript" src="${BasePath }/js/highcharts/highcharts.js"></script>
		  <script type="text/javascript" src="${BasePath}/js/highcharts/modules/exporting.js"></script>
            
            		<!-- 帖子 -->
  					<div id="topic" style="min-width:600px;widht:700px; height:400px"></div>
  					<!-- 回复 -->
  					<div id="reply" style="min-width:600px;widht:700px;height:400px"></div>
  					<!-- 点赞 -->
  					<div id="like" style="min-width:600px;widht:700px;height:400px"></div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<jsp:include page="../include/bottom.jsp" />