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
					<form id="myForm"  name="myForm"  action="${BasePath}/userCoinsInputController/search" method="post">
									<table >
										<tr valign="middle">
										
											<td>图表类型:</td>
											<td>
												<select name="pctype"  id="pctype" class="input-medium search-query inline"  onchange="changepctype(this)">
													<option value="0"  <c:if test="${pctype==0 }"> selected="selected"</c:if> >金币收入表</option>
													<option value="1" <c:if test="${pctype==1 }"> selected="selected"</c:if> >金币消耗表</option>
													<option value="2"  <c:if test="${pctype==2 }"> selected="selected"</c:if>>积分收入表</option>
												</select>
											</td>
											
											<td>平台:</td>
											<td>
												<select name="platform"  id="platform" class="input-medium search-query inline"  onchange="changeFlatform(this)">
													<option value=""  >全部</option>
													<option  value="android">Android</option>
													<option value="ios">IOS</option>
													<option value="wp">WP</option>
												</select>
											</td>
											
											
											<td>版本:</td>
											<td>
											
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
											</td>
											
											
											
											
											<td>规则名称</td>
											<td>
											
											<script type="text/javascript">
													function changepctype(obj){
														var val=obj.value;
														$("#rulyKey").val("");
														$("#rulyKey").html("");
														$("#rulyKey").append("<option value=\"\">全部</option>"); 
														
														var versionListStr ;
														if(val == 2){
															versionListStr = "${listP}";
														} else if(val == 1){
															$("#rulyKey").append("<option value=\"APP_POPULARIZE\">百宝箱</option>");
															$("#rulyKey").append("<option value=\"consume,0\">兑吧</option>");
															$("#rulyKey").append("<option value=\"refund\">兑吧退款</option>");
															$("#rulyKey").append("<option value=\"consume,1\">金币抢领</option>");
															$("#rulyKey").append("<option value=\"refund,1\">抢领退款</option>");
															$("#rulyKey").append("<option value=\"MAFEN\">玛分精灵</option>");
															$("#rulyKey").append("<option value=\"consume,2\">最热活动</option>");
														} else {
															versionListStr = "${listC}";
														}
														
														var versionList=versionListStr.split("-");
														 for (var i=0;i<versionList.length ;i++ ) {
															    var version=versionList[i].split(",");
															    $("#rulyKey").append("<option value=\""+version[0]+"\">"+version[1]+"</option>"); 
														 }
													}
													
													$(function () {
														var val=obj.value;
														$("#rulyKey").val("");
														$("#rulyKey").html("");
														$("#rulyKey").append("<option value=\"\">全部</option>"); 
														var versionListStr= "${listC}";
														
														var versionList=versionListStr.split("-");
														 for (var i=0;i<versionList.length ;i++ ) {
															    var version=versionList[i].split(",");
															    $("#rulyKey").append("<option value=\""+version[0]+"\">"+version[1]+"</option>"); 
														 }
													});	
													
													</script>
											
											<select name="rulyKey"  id="rulyKey"  class="input-medium search-query inline" >
												<option value=""  >全部</option>
											</select>
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
            <div class="muted pull-left">金币积分日统计</div>
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
    	
    	var str = "金币收入统计";
    	var pctype = $("#pctype").val();
    	if(pctype == 0){
    		str = "金币收入统计";
    	} else if(pctype == 1){
    		str = "金币消耗统计";
    	} else if(pctype == 2){
    		str = "积分收入统计";
    	}
    	
    	
        $('#myForm').ajaxSubmit(function(data){
            initChart(data,"container",str);
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
    
    
    
    
    
</script>