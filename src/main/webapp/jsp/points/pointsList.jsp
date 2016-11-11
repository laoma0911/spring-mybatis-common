<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<%@ taglib uri="/permission" prefix="pe"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

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
					<div class="block">
						<div class="navbar navbar-inner block-header"
							style="border-bottom: none;">
							<form class="form-search" name="myForm" id="myForm"	action="${BasePath}/points/list"  onsubmit="return checkForm()" method="post">
								UID:<input type="text" name="uid" id="uid" value="${uid }" /> 
								时间：<input type="text"  style="width: auto;" id="beginDate" name="beginDate" value="${startDate }" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'${endData }',readOnly:'false'})"    class="Wdate" onClick="WdatePicker()" /> 
<%-- 								结束时间：<input type="text"  style="width: auto;" id="endDate" name="endDate" 	value="${endDate }"	onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:'false'})" 	class="Wdate" onClick="WdatePicker()" /> --%>
													<input type="hidden" id="type" name="type" value="${type }"/>
                    								<input type="hidden" id="itemId" name="itemId" value="${itemId }"/>
								<button type="submit" id="btn" name="btn" class="btn">Search</button>
							</form>
						</div>
					</div>
				</div>

				<div class="block">
					<div class="navbar navbar-inner block-header">
						<div class="muted pull-left">用户积分列表</div>
						<div class="muted pull-right" style="color:red;">用户当前总积分：${pointsInfo.points}&nbsp;&nbsp;等级:${pointsInfo.level}</div>
					</div>
					<div class="block-content collapse in">
						<div class="span12">
							<table class="table table-hover">
								<thead>
									<tr>
										<th>积分规则|时间</th>
										<th>积分</th>
										
									</tr>
								</thead>
								<tbody id="tbodys">
								<tr class="error">
											<td>总积分</td>
											<td >${sumPoints }</td>
								</tr>
									<c:forEach items="${pointsList}" var="obj">
										<tr class="success"  onclick="openDetail('${obj.name}')">
											<td>${obj.name}<input type="hidden"  id="sign_${obj.name }"  value="1"/></td>
											<td ><font color="red">${obj.point}</font>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <img   src="${BasePath}/image/large_chart.png"  style="width: 20px;height: 20px;"/></td>
										
										</tr>
										<c:forEach items="${obj.list }" var="subObj">
												<tr   id="${obj.name }"  style="display: none;">
													<td><fmt:formatDate value="${subObj.dateline}" pattern="yyyy-MM-dd  HH:mm:ss" /></td>
													<td>${subObj.points}</td>
												</tr>
										</c:forEach>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<hr>
<script type="text/javascript">
	function openDetail(id){
		var sign=$("#sign_"+id).val();
		$.each($("#"+id), function(i){
					if(sign==0){
						 this.style.display = 'none'; 
					}else{
						 this.style.display = ''; 
					}
		             
		}); 
		if(sign==0){
			$("#sign_"+id).val("1");
		}else{
			$("#sign_"+id).val("0");
		}
	}
	function checkForm(){
		var uid=$("#uid").val().trim();
		if(uid==""){
			alert("请输入UID！");
			return false;
		}
		
		if(isNaN(uid)){
			alert("uid只能为数字");
			return false;
		}
		
		var startDate=$("#beginDate").val();
		if(startDate=="") {
			alert("请输入开始时间！");
			return false;
		}
// 		var endDate=$("#endDate").val();
// 		if(endDate=="") {
// 			alert("请输入结束时间！");
// 			return false;
// 		}
		return true;
	}
</script>
<jsp:include page="../include/bottom.jsp" />