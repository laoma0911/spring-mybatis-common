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
					<form id="myForm"  name="myForm"  action="${BasePath}/keyword/search" method="post">
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
											
											<td><input type="button" onclick="btnSubmit(this)" value="生成关键词数据表" /></td>
											<td>
<%-- 												<a class="btn cancel btn btn-primary btn-small"  href="javascript:openModel('${BasePath}/keyword/toExportFeedback','导出自定义数据表','45%','45%')">导出自定义数据表</a> --%>
												<input type="button" value="导出自定义数据表" onclick="exportFeedback()" />
											</td>
										</tr>
									
									</table>
									<input type="hidden"  name="start" id="start" value="${start }"/>
									<input type="hidden"  name="limit" id="limit" value="${limit }"/>
									<input type="hidden"  name="type" id="type" value="${type }"/>
									<input type="hidden"  name="itemId" id="itemId" value="${itemId }"/>
					</form>
                           </div>
						</div>
					</div>
         
        
        	<div class="block">
          <div class="navbar navbar-inner block-header">
            <div class="muted pull-left">关键词搜索量数据表</div>
            <div class="pull-right">
		    </div>
          </div>
          <div class="block-content collapse in">
            <div class="span12" style="overflow-x:auto;">
              <table class="table table-hover">
                <thead>
                  <tr>
                    <th >分类</th>
                    <th >关键词</th>
                    <c:forEach items="${tmList}" var="obj">
                    	<th>${obj}</th>
                    </c:forEach>
                    <th>操作</th>
                  </tr>
                </thead>
                <tbody id="tbodys">
                  <c:forEach items="${data}" var="obj">
                  	<tr>
                  		<c:forEach items="${obj.list}" var="obj2">
                  			<td>${obj2} </td>
                  		</c:forEach>
                  		<td>
                  		<input type="button" class="btn cancel btn btn-primary btn-small"   onclick="ooaa('${obj.label}','${obj.subLabel}')"  value="绘制曲线"/>
                  		</td>
                  	</tr>
                  </c:forEach>
                </tbody>
              </table>
                <div class="pagination pagination-centered" id="pager"></div> 
                <script type="text/javascript">
	             var sign=0;
	              window.onload=function(){
	            	  PAGER.initPager('${start}',' ${total}','${limit}', 8, 'pager', getData);
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
        
        
        <form id="myFormNew"  name="myFormNew"  action="${BasePath}/keyword/darwCurve" method="post" target="self">
        	<input type="hidden"  name="label" id="label">
        	<input type="hidden"  name="subLabel" id="subLabel">
        	<input type="hidden"  name="startDate1" id="startDate1">
        	<input type="hidden"  name="endDate1" id="endDate1">
        </form>
        
      </div>
    </div>
  </div>
</div>
  <hr>
  
<jsp:include page="../include/bottom.jsp" />
<script>
    function ooaa(label,subLabel){
    	
    	var startDate = $("#startDate").val();
    	var endDate = $("#endDate").val();
    	
    	$("#startDate1").val(startDate);
    	$("#endDate1").val(endDate);
    	$("#label").val(label);
    	$("#subLabel").val(subLabel);
    	
    	document.getElementById("myFormNew").submit();
    	
//     	openModel('${BasePath}/keyword/darwCurve?label='+label+'&subLabel='+subLabel+'&startDate='+startDate+"&endDate="+endDate,'绘制曲线',null,null,true);
    }
    
    function exportFeedback(){
    	
    	var startDate = $("#startDate").val();
    	var endDate = $("#endDate").val();
    	openModel('${BasePath}/keyword/toExportFeedback?startDate=' + startDate + '&endDate=' + endDate,'导出自定义数据表','45%','45%');
    }
    
    function btnSubmit(obj){
    	var startDate = $("#startDate").val();
    	var endDate = $("#endDate").val();
    	
    	var sd = startDate.split("-");
    	var ed = endDate.split("-");
    	
    	if(sd[0] != ed[0]){
				alert("时间段必须在相同年!");
				return false;
    	}
    	
    	obj.form.submit();
    }
    
</script>