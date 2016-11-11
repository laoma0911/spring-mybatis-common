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
					<form id="myForm"  name="myForm"  action="${BasePath}/calendarusermerge/list" method="post">
									<table >
										<tr valign="middle">
											<td>来源用户：</td><td><input type="text" name="sourceUid" value="${sourceUid }"  id="sourceUid" /></td>
											<td>目标用户：</td><td><input type="text" name="targetUid" value="${targetUid }"  id="targetUid" /></td>
                                            <td>&nbsp;&nbsp;&nbsp;</td>
                                            <td><input type="button" class="btn-success" onclick="submitForm()" value="验证操作" /></td>
                                        </tr>
                                        <tr>
											<td>开始时间：</td>
											<td><input type="text" class="Wdate" id="startDate" name="startDate" value="${startDate }"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'endDate\')}',readOnly:'false'})" /></td>
											<td>结束时间：</td>
											<td><input type="text" class="Wdate" id="endDate" name="endDate" value="${endDate }" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'startDate\')}',readOnly:'false'})" /></td>
                                            <td></td>
											<td>
												<c:if test="${mergeDb == 0 }">
													<input type="checkbox"  name="mergeDb" id="mergeDb"   />合并时保留上传时间较大的数据
												</c:if>
												<c:if test="${mergeDb == 1 }">
													<input type="checkbox"  name="mergeDb" id="mergeDb"  checked="checked"  />合并时保留上传时间较大的数据
												</c:if>
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
         
         
						  <div class="block"  >
							<div class="navbar navbar-inner block-header"  style="border-bottom: none;" >
								<table cellpadding="3">
									<tr valign="middle">
										<td>来源用户：&nbsp;&nbsp;</td>
										<td align="left">
											<input type="hidden"  name="sourceName" id="sourceName" value="${sourceName }"  />
											<c:if test="${sourceName == null }">
													<span style="color:red">来源用户不存在</span>
											</c:if>
											<c:if test="${sourceName != null }">
													${sourceName }
											</c:if>
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										</td>
										<td>注册时间：</td>
										<td>
											<c:if test="${sourceDateline != null }">
				                      			<script >formatTime("${sourceDateline }");</script>
				                      		</c:if>
										</td>
									</tr>
									<tr valign="middle">
										<td>目标用户：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
										<td align="left">
												<input type="hidden"  name="targetName" id="targetName" value="${targetName }"  />
												<c:if test="${targetName == null }">
													<span style="color:red">目标用户不存在</span>
												</c:if>
												<c:if test="${targetName != null }">
														${targetName }
												</c:if>
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										</td>
										<td>注册时间：</td>
										<td>
											<c:if test="${targetDateline != null }">
				                      			<script >formatTime("${targetDateline }");</script>
				                      		</c:if>
										</td>
									</tr>
								</table>
                            </div>
						</div>
         
        <div class="block">
          <div class="navbar navbar-inner block-header">
            <div class="muted pull-left">前1000条源数据</div>
            <div class="pull-right">
	            <pe:permission key="merge">
	            	<c:if test="${sourceCount != null }">
                      			即将导入${sourceCount }条数据
                     </c:if>
           	 		<input type="button" class="btn btn-small btn-success" id="changeBtn" onclick="merge()" value="确认操作" />
    	        </pe:permission>
    	        <pe:permission key="down">
    	        	<input type="button" class="btn btn-small btn-success" id="changeBtn" onclick="exportFeedback()" value="导出日志" />
    	        </pe:permission>
		    </div>
          </div>
          <div class="block-content collapse in">
            <div class="span12">
              <table class="table table-hover">
                <thead>
                  <tr>
                    <th width="10%">时间</th>
                    <th width="10%">类型</th>
                    <th width="40%">源值</th>
                    <th width="40%">目标值</th>
                  </tr>
                </thead>
                <tbody id="tbodys">
                  <c:forEach items="${list}" var="obj">
                    <tr >
                        <td  width="10%">
                      		${obj.dateline}
                      	</td>
                      	<td  width="10%">${obj.eventtype }</td>
                      	<td  width="40%">
                      		<c:if test="${obj.sourcestatus == 1 }">
                      			<span style="color:red">删除</span>
                      		</c:if>
                      		<c:if test="${obj.sourcestatus != 1 }">
                      			${obj.sourcedata }
                      		</c:if>
                      	</td>
                      	<td  width="40%">
                      		<c:if test="${obj.targetstatus == 1 }">
                      			<span style="color:red">删除</span>
                      		</c:if>
                      		<c:if test="${obj.targetstatus != 1 }">
                      			${obj.targetdata }
                      		</c:if>
                      	</td>
                    </tr>
                  </c:forEach>
                </tbody>
              </table>
<!--                 <div class="pagination pagination-centered" id="pager"></div>  -->
            <script type="text/javascript">
// 	             var sign=0;
// 	              window.onload=function(){
// 	            	  PAGER.initPager('${start}',' ${json.total}','${limit}', 8, 'pager', getData);
// 	              }
// 	              function getData(currentPage,pageSize) {
// 	            	  if(sign>0){
// 		            	 	$("#start").val(currentPage);
// 		            	 	$("#limit").val(pageSize);
// 		            	 	$("#myForm").submit();
// 	            	  }
// 	            	  sign=1;
// 	           	 } 
               </script> 
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
function submitForm(seeker){
	
	var sourceUid = $("#sourceUid").val().trim();
	var targetUid = $("#targetUid").val().trim();
	var startDate = $("#startDate").val();
	var endDate = $("#endDate").val();
	if(sourceUid == "" || isNaN(sourceUid)){
		alert("来源用户不可以为空且是数字!");
		return ;
	}
	if(targetUid == "" || isNaN(targetUid)){
		alert("目标用户不可以为空且是数字!");
		return ;
	}
	
	if(targetUid == sourceUid){
		alert("来源用户与目标用户不能为同一个用户!");
		return ;
	}
	
	if(startDate == ""){
		alert("开始时间不能为空");
		return ;
	}
	if(endDate == ""){
		alert("结束时间不能为空");
		return ;
	}
	
// 	var startDateTm = Date.parse(new Date(startDate));
// 	var endDateTm = Date.parse(new Date(endDate));

// 	if((endDateTm - startDateTm) > (1000 * 60 * 60 * 24 * 31)){
// 		alert("请指定小于一个月的时间");
// 		return ;
// 	}
	
	$("#myForm").submit();
}

function merge(){

	var sourceName =$("#sourceName").val().trim();
	if(sourceName == ""){
		alert("来源用户不存在!");
		return ;
	}
	var targetName = $("#targetName").val().trim();
	if(targetName == ""){
		alert("目标用户不存在!");
		return ;
	}
	
	var sourceUid = $("#sourceUid").val().trim();
	var targetUid = $("#targetUid").val().trim();
	var startDate = $("#startDate").val();
	var endDate = $("#endDate").val();
	var mergeDb = document.getElementById("mergeDb").checked;
	
	
	if(sourceUid == "" || isNaN(sourceUid)){
		alert("来源用户不可以为空且是数字!");
		return ;
	}
	if(targetUid == "" || isNaN(targetUid)){
		alert("目标用户不可以为空且是数字!");
		return ;
	}
	if(targetUid == sourceUid){
		alert("来源用户与目标用户不能为同一个用户!");
		return ;
	}
	if(startDate == ""){
		alert("开始时间不能为空");
		return ;
	}
	if(endDate == ""){
		alert("结束时间不能为空");
		return ;
	}
	
	var m = "0";
	if(mergeDb){
		m = "1";
	}
	
	
	var path = "${BasePath}/calendarusermerge/merge?mergeDb=" + m + "&sourceUid=" + sourceUid + "&targetUid=" + targetUid + "&startDate=" + startDate + "&endDate=" + endDate;
	
	$.ajax({
		type: "POST",
		url: path,
		datatype: "json",
		success: function (data) {
			if (data.errno == 1) {
				alert(data.errdesc);
			} else {
				alert("共导入" + data.count + "条数据");
			}
		},
		error: function () {
			alert("操作出错，请联系管理员！");
		}
	});
	
}


function exportFeedback(){
	
	var sourceUid = $("#sourceUid").val();
	var targetUid = $("#targetUid").val();
	var startDate = $("#startDate").val();
	var endDate = $("#endDate").val();
	var mergeDb = document.getElementById("mergeDb").checked;
	
	var m = "0";
	if(mergeDb){
		m = "1";
	}
	
	
	openModel('${BasePath}/calendarusermerge/toExportFeedback?mergeDb=' + m + '&sourceUid=' + sourceUid + '&targetUid=' + targetUid + '&startDate=' + startDate + '&endDate=' + endDate,'导出自定义数据表','45%','58%',true);
}

</script>
	
