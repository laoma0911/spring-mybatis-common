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
				<div class="span9" id="content">
					<!-- morris stacked chart -->
					<div class="row-fluid">
						<!-- block -->
						<div class="block">
							<div class="navbar navbar-inner block-header">
								<div class="muted pull-left">修改密码</div>
							</div>
							<div class="alert alert-error" id="alertErr" style="display: none;">
								<button class="close" data-dismiss="alert">×</button>
								<strong>Error!</strong> <span id="errodesc">This is an error message.</span>
							</div>
							<div class="block-content collapse in">
								<div class="span12">
									<form class="form-horizontal" action="${BasePath}/user/updatePass" method="post">
										<input type="hidden" name="uid" id="uid" value="${user.id }"/>
										<input type="hidden" name="type" value="${type }"/>
										<input type="hidden" name="itemId" value="${itemId }"/>
										<fieldset>
											<legend>用户信息</legend>
											<div class="control-group">
												<label class="control-label" for="name"
												       style="float: left;">旧密码：</label>
												<div class="controls">
													<input class="input-xlarge" id="oldPass" name="oldPass"
													       type="password"/>
												</div>
											</div>
											<div class="control-group">

												<div class="controls">
													密码必须包括大写字母、小写字母、数字，且长度不少于8位。
												</div>
												<label class="control-label" for="name"
												       style="float: left;">新密码：</label>

												<div class="controls">
													<input class="input-xlarge" id="password" name="password"
													       type="password"/>
												</div>
											</div>
											<div class="control-group">
												<label class="control-label" for="name"
												       style="float: left;">再次密码：</label>

												<div class="controls">
													<input class="input-xlarge" id="repassword" name="repassword"
													       type="password"/>
												</div>
											</div>
											<div class="form-actions">
												<button type="button" onclick="updatePass()" class="btn btn-primary">
													保存
												</button>
												<button type="reset" class="btn btn-primary">重置</button>
											</div>
										</fieldset>
									</form>

								</div>
							</div>
						</div>
						<!-- /block -->
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	function updatePass() {
		var oldPass = $("#oldPass").val();
		var password = $("#password").val();
		var repassword = $("#repassword").val();
		if (oldPass == "") {
			alert("请输入旧密码");
			return false;
		}
		if (password == "") {
			alert("请输入新密码");
			return false;
		}
		if (oldPass == repassword) {
			alert("新旧密码相同！");
			return false;
		}
		if (repassword == "") {
			alert("请再次输入密码");
			return false;
		}
		if (password != repassword) {
			alert("两次密码不一致！");
			return false;
		}
		if (!password.match(/(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$/)){
			alert("密码必须为8-20位大写字母、小写字母、数字！");
			return false;
		}
		var uid = $("#uid").val();
		$.ajax({
			type: "POST",
			url: "${BasePath}/user/updatePass",
			data:{id:uid,oldPass:oldPass,password:password},
			datatype: "json",
			success: function (data) {
				if (data.errno == 1) {
					$("#alertErr").show();
					$("#errodesc").html(data.errdesc);
				} else {
					alert("修改成功，请退出后重新登录！");
					window.location.href = "${BasePath}/login.html";
				}
			},
			error: function () {
				alert("操作出错，请联系管理员！");
			}
		});
	}
</script>
<jsp:include page="../include/bottom.jsp"/>
