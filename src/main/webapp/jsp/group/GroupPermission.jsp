<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

<jsp:include page="../include/top.jsp"/>
<!-- Body -->
<div class="container-fluid">
	<div class="row-fluid">
		<!-- Menu -->
		<jsp:include page="../include/menu.jsp"></jsp:include>
		<div class="span9" id="content">
			<jsp:include page="../include/location.jsp"></jsp:include>
			<div class="row-fluid">
				<div class="span12">
					<!-- block -->
					<div class="block">
						<div class="navbar navbar-inner block-header">
							<div class="muted pull-left">用户组权限 - ${group.name}</div>
							<input type="hidden" name="t_groupId" value="${group.id}" id="t_groupId" />
						</div>
						<div class="block-content collapse in">
							<table class="table table-bordered" id="tabs">
								<thead>
								<tr>
									<th style="width:50px;">
										<input type="checkbox" style="margin-top:-2px;" class="tab_all_check"
										       value="all">&nbsp;&nbsp;全选
									</th>
									<th style="width:80px;text-align: center;">节点</th>
									<th style="width:100px;text-align: center;">菜单权限</th>
									<th>操作权限</th>
								</tr>
								</thead>
								<tbody>
								<c:forEach items="${categoryList}" var="category">
								<tr>
									<td style="text-align:center;">
										<input type="checkbox" style="margin-top:-2px;" class="tr_all_check" value="${category.id}" />
									</td>
									<td style="text-align: center;">${category.name}</td>
									<td colspan="2" style="padding: 0; margin:0;">
										<c:forEach items="${privilegeList}" var="privilege">
										<c:if test="${category.id==privilege.categoryId}">
										<table class="table table-bordered" style="padding:0;margin:0; border:0">
											<tbody>
											<tr style="border:0;">
												<td class="Neitr" style="text-align: center;border-left:0;">
													${privilege.name}
												</td>
												<td class="Neitr" style="width:30px;text-align: center;border-left:0;">
													<input type="checkbox" style="margin-top:-2px;"
														class="single tr_nei_all_check checkval_${category.id} qufen_${category.id}_${privilege.id}" value="${category.id}_${privilege.id}" />
												</td>
												<td style="border-left:none;">
													<c:forEach items="${operationList}" var="operation">
													<c:if test="${privilege.id==operation.privilegeId}">
													<span class="t_operate">
														<input type="checkbox" style="margin-top:-2px;"
															name="operationIds"
															class="all_check checkval_${category.id} checkval_${category.id}_${privilege.id}"
															id="checks_${category.id}_${privilege.id}_${operation.id}" value="${category.id}_${privilege.id}_${operation.id}">
														<label class="checks" for="checks_${category.id}${privilege.id}${operation.id}">${operation.name}</label>
													</span>
													</c:if>
													</c:forEach>
												</td>
											</tr>
											</tbody>
										</table>
										</c:if>
										</c:forEach>
									</td>
								</tr>
								</c:forEach>
								<tr>
									<td colspan="4">
										<button class="btn" id="save">确定</button>
										<button class="btn" id="reset">重设</button>
									</td>
								</tr>
								</tbody>
							</table>
						</div>
					</div>
					<!-- /block -->
				</div>
			</div>
		</div>
	</div>
</div>
<jsp:include page="../include/bottom.jsp"/>

<script>
	$(function(){
		$("#reset").bind('click',function(){
			window.location.reload();
		});
		$("#save").bind('click',function(){
			$(this).unbind();
			/*
			 找出所有已经选中的input
			 */
			var checks = $(".all_check:checked");
			var aclist='';              //定义变量
			checks.each(function(i){         //循环拼装被选中项的值
				aclist += $(this).val()+',';
			});
			aclist = aclist.substring(0,aclist.length-1);
			var groupId = $("#t_groupId").val();
			$.post('${BasePath}/group/saveAcl',{
				'aclist'	:	aclist,
				'groupId'	:	groupId
			},function(data){
				var obj = eval(data);
				if(obj.errno == 0){
					alert("操作成功");
					window.location.reload();
				}else{
					alert(obj.errdesc);
					return false;
				}
			});
			//	成功之后做刷新	window.location.reload();
			if(!aclist){
				//alert('添加权限成功!');
				//window.location.href = '/Acl/Index/user';
			}
		});
		$(".tr_all_check").bind('click',function(){
			//判断是否被选中
			var vals = $(this).val();
			//alert($(this).prop("checked"));
			if($(this).prop("checked")){
				$(".checkval_"+vals).prop("checked",true);
				$(".qufen_"+vals).prop("checked",true);
			}else{
				$(".checkval_"+vals).prop("checked",false);
				$(".qufen_"+vals).prop("checked",false);
			}
		});

		$(".tr_nei_all_check").bind('click',function(){
			//判断是否被选中
			var vals = $(this).val();
			if($(this).prop("checked")){
				$(".checkval_"+vals).prop("checked",true);
			}else{
				$(".checkval_"+vals).prop("checked",false);
			}
		});
		$(".tab_all_check").bind('click',function(){
			//tabs
			if($(this).prop("checked")){
				$("#tabs input[type=checkbox]").prop("checked",true);
			}else{
				$("#tabs input[type=checkbox]").prop("checked",false);
			}
		});

		$('input[name="checkval[]"]').bind('click',function(){
			var $single = $(this).parent().parent().find('input[name="checkval[]"]');
			var flag = 0;
			$single.each(function(){
				if(!$(this).is(':checked')){
					flag = 1;
				}
			});
			if(flag == 0){
				$(this).parent().parent().parent().find(".single").prop("checked",'true');
			}else{
				$(this).parent().parent().parent().find(".single").removeAttr("checked");
			}
		});
	});
	
	<c:forEach items="${keyList}" var="key">
		$("#checks_${key}").attr("checked", true);
	</c:forEach>
</script>