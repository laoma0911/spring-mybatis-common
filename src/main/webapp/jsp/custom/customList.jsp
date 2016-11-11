<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<%@ taglib uri="/permission" prefix="pe"%>

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
							<form 	action="${BasePath }/custom/userList?type=${type}&itemId=${itemId}" 	method="post" id="myform" name="myform">
								UID：<input type="text" id="uid" name="uid" value="${uid}" />
								昵称：<input type="text" name="nick" value="${nick }" />
                                <select name="search_style">
                                    <c:choose>
                                        <c:when test="${search_style=='0'}">
                                            <option value="0" selected="selected">精确</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="0">精确</option>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${search_style=='1'}">
                                            <option value="1" selected="selected">模糊匹配，请慎用</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="1">模糊匹配，请慎用</option>
                                        </c:otherwise>
                                    </c:choose>
                                </select>
                                <pe:permission key="lookPhone">
                                    手机：<input type="text" name="mobile" value="${mobile}" />
                                </pe:permission>
                                <pe:permission key="lookEmial">
                                邮箱：<input type="text" name="email" value="${email }" />
                                </pe:permission>
								勋章：
								<select  id="medal"  name="medal">
										<option  value="" >全部</option>
										<c:forEach  items="${medalList }"  var="obj">
											<option  value="${obj.id }"   <c:if test="${obj.id==medal }">selected="selected"</c:if>   > ${obj.name } </option>
										</c:forEach>
								</select>
								
								
								
								组：<select name="group_id">
									<c:choose>
										<c:when test="${group_id=='-1'}">
											<option value="-1" selected="selected">全部</option>
										</c:when>
										<c:otherwise>
											<option value="-1">全部</option>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${group_id=='0'}">
											<option value="0" selected="selected">普通</option>
										</c:when>
										<c:otherwise>
											<option value="0">普通</option>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${group_id=='1'}">
											<option value="1" selected="selected">官方</option>
										</c:when>
										<c:otherwise>
											<option value="1">官方</option>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${group_id=='2'}">
											<option value="2" selected="selected">监控</option>
										</c:when>
										<c:otherwise>
											<option value="2">监控</option>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${group_id=='3'}">
											<option value="3" selected="selected">VIP</option>
										</c:when>
										<c:otherwise>
											<option value="3">VIP</option>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${group_id=='10'}">
											<option value="10" selected="selected">美容控</option>
										</c:when>
										<c:otherwise>
											<option value="10">美容控</option>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${group_id=='11'}">
											<option value="11" selected="selected">美体狂人</option>
										</c:when>
										<c:otherwise>
											<option value="11">美体狂人</option>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${group_id=='12'}">
											<option value="12" selected="selected">知心MM</option>
										</c:when>
										<c:otherwise>
											<option value="12">知心MM</option>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${group_id=='13'}">
											<option value="13" selected="selected">占星师</option>
										</c:when>
										<c:otherwise>
											<option value="13">占星师</option>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${group_id=='14'}">
											<option value="14" selected="selected">健康达人</option>
										</c:when>
										<c:otherwise>
											<option value="14">健康达人</option>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${group_id=='15'}">
											<option value="15" selected="selected">超级妈咪</option>
										</c:when>
										<c:otherwise>
											<option value="15">超级妈咪</option>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${group_id=='16'}">
											<option value="16" selected="selected">灌水王</option>
										</c:when>
										<c:otherwise>
											<option value="16">灌水王</option>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${group_id=='17'}">
											<option value="17" selected="selected">关注中</option>
										</c:when>
										<c:otherwise>
											<option value="17">关注中</option>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${group_id=='18'}">
											<option value="18" selected="selected">两性</option>
										</c:when>
										<c:otherwise>
											<option value="18">两性</option>
										</c:otherwise>
									</c:choose>
                                    <c:choose>
                                        <c:when test="${group_id=='19'}">
                                            <option value="19" selected="selected">好评达人</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="19">好评达人</option>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${group_id=='20'}">
                                            <option value="20" selected="selected">优秀组长</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="20">优秀组长</option>
                                        </c:otherwise>
                                    </c:choose>
								</select>

                                <!--  <br> 性别：<select name="sex">
									<c:choose>
										<c:when test="${sex=='-1'}">
											<option value="-1" selected="selected"></option>
										</c:when>
										<c:otherwise>
											<option value="-1"></option>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${sex=='1'}">
											<option value="1" selected="selected">男</option>
										</c:when>
										<c:otherwise>
											<option value="1">男</option>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${sex=='0'}">
											<option value="0" selected="selected">女</option>
										</c:when>
										<c:otherwise>
											<option value="0">女</option>
										</c:otherwise>
									</c:choose>
								</select> 注册平台：<select name="platform">
									<c:choose>
										<c:when test="${platform=='0'}">
											<option value="0" selected="selected"></option>
										</c:when>
										<c:otherwise>
											<option value="0"></option>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${platform=='2'}">
											<option value="2" selected="selected">iPhone</option>
										</c:when>
										<c:otherwise>
											<option value="2">iPhone</option>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${platform=='1'}">
											<option value="1" selected="selected">Android</option>
										</c:when>
										<c:otherwise>
											<option value="1">Android</option>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${platform=='3'}">
											<option value="3" selected="selected">WP</option>
										</c:when>
										<c:otherwise>
											<option value="3">WP</option>
										</c:otherwise>
									</c:choose>
								</select> 注册地区：<input type="text" name="regcountry"
									value="${regcountry }" />	-->
                                    <%--注册ip：<input type="text" name="regip" value="${regip }" />--%>
                                    <%--最后登陆ip：<input type="text" name="lastloginip" value="${lastloginip }" />--%>



									 排序：<select		name="order">
									 <c:choose>
										<c:when test="${order=='uid'}">
											<option value="uid" selected="selected">uid</option>
										</c:when>
										<c:otherwise>
											<option value="uid">uid</option>
										</c:otherwise>
									</c:choose>
									<%--<c:choose>--%>
										<%--<c:when test="${order=='age'}">--%>
											<%--<option value="age" selected="selected">年龄</option>--%>
										<%--</c:when>--%>
										<%--<c:otherwise>--%>
											<%--<option value="age">年龄</option>--%>
										<%--</c:otherwise>--%>
									<%--</c:choose>--%>
									<c:choose>
										<c:when test="${order=='regtime'}">
											<option value="regtime" selected="selected">注册时间</option>
										</c:when>
										<c:otherwise>
											<option value="regtime">注册时间</option>
										</c:otherwise>
									</c:choose>
<%-- 									<c:choose> --%>
<%-- 										<c:when test="${order=='onlinetime'}"> --%>
<!-- 											<option value="onlinetime" selected="selected">在线时间</option> -->
<%-- 										</c:when> --%>
<%-- 										<c:otherwise> --%>
<!-- 											<option value="onlinetime">在线时间</option> -->
<%-- 										</c:otherwise> --%>
<%-- 									</c:choose> --%>
									<c:choose>
										<c:when test="${order=='loginnum'}">
											<option value="loginnum" selected="selected">登陆次数</option>
										</c:when>
										<c:otherwise>
											<option value="loginnum">登陆次数</option>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${order=='lastlogin'}">
											<option value="lastlogin" selected="selected">最后登录时间</option>
										</c:when>
										<c:otherwise>
											<option value="lastlogin">最后登录时间</option>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${order=='logindays'}">
											<option value="logindays" selected="selected">登陆天数</option>
										</c:when>
										<c:otherwise>
											<option value="logindays">登陆天数</option>
										</c:otherwise>
									</c:choose>
								</select> <select name="asc">
									<c:choose>
										<c:when test="${asc=='desc'}">
											<option value="desc" selected="selected">倒序</option>
										</c:when>
										<c:otherwise>
											<option value="desc">倒序</option>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${asc=='asc'}">
											<option value="asc" selected="selected">正序</option>
										</c:when>
										<c:otherwise>
											<option value="asc">正序</option>
										</c:otherwise>
									</c:choose>
								</select> 
								<input type="hidden"  name="start" id="start" value="${start }"/>
								<input type="hidden"  name="limit" id="limit" value="${limit }"/>
								<input type="hidden"  name="type" id="type" value="${type }"/>
								<input type="hidden"  name="itemId" id="itemId" value="${itemId }"/>
								<input type="submit" class="btn btn-success btn-small" value="查询" onclick="find()" />

								<script type="text/javascript">
									function find() {
										var uid = $("#uid").val().trim();
										if (isNaN(uid)) {
											alert("uid只能是数字!");
											$("#uid").val('0');
											return;
										}
										$("#myform").submit();
									}
								</script>

							</form>
						</div>
					</div>
				</div>




				<div class="block">
					<div class="navbar navbar-inner block-header">
						<div class="muted pull-left">用户数据列表</div>
						<div class="pull-right">
						<pe:permission key="add">
							<button class="btn btn-small btn-success"   onclick="openModel('${BasePath}/custom/toUserAdd','新增','50%','50%')">新增</button>
						</pe:permission>
							<%-- 			  <span class="badge badge-info">${json.total}</span> --%>
						</div>
					</div>
					<div class="block-content collapse in">
						<div class="span12">
							<table class="table table-hover">
								<thead>
									<tr>
										<th>UID</th>
										<th>昵称</th>
										<th>用户头像</th>
										<th>用户组</th>
										<th>勋章</th>
										<th>年龄|初潮</th>
										<th>经期|周期</th>
                                        <pe:permission key="lookEmail">
                                            <th>邮箱<br>绑定时间</th>
                                        </pe:permission>
                                        <pe:permission key="lookPhone">
										    <th>手机<br>绑定时间</th>
                                        </pe:permission>
										<%--<th>性别</th>--%>
										<th>发贴/回帖</th>
										<th>登录次数<br> 登录天数
										</th>
										<th>最后登录时间<br> 最后登录IP<br> 最后登录地区
										</th>
										<th>注册时间<br> 注册IP<br> 注册地区
										</th>
										<th>注册平台</th>
<!-- 										<th>昵称最后修改</th> -->
										<th>封禁过期</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody id="tbodys">
									<c:forEach items="${json.data}" var="obj">
										<tr>
											<td class="id" style="width: 5%;">${obj.uid}</td>
											<td style="width: 5%;">
											<c:if test="${obj.nick!=null && obj.nick!=''}">
                                                <a href="${BasePath}/custom/nickLogList?type=4&itemId=21&uid=${obj.uid}">${obj.nick }</a><br>
                                            </c:if>
                                                <a href="${BasePath }/audit/topicList?uid=${obj.uid}&type=8&itemId=43&status=-1">她的话题</a><br>
                                                <a href="${BasePath }/audit/replyList?uid=${obj.uid}&type=8&itemId=44&status=-1">她的回复</a>
											</td>
											<td style="width: 5%;">
											<c:if  test="${obj.avatar!=null && obj.avatar!=''}">
													<img alt="" src="${obj.avatar}" />
                                                <pe:permission key="deleteAvatar">
													    <input type="button"  onclick="delUserAvatar(${obj.uid})" class="btn btn-small btn-danger"  value="删除"/>
                                                    </pe:permission>
											</c:if>   
											</td>
											<td style="width: 5%;"><script type="text/javascript">
												formatCustomerGroupType('${obj.group_id}');
											</script>
											</td>
											<td style="width: 5%;">${obj.medal}</td>
											<td style="width: 5%;">${obj.age} | ${obj.menarche } </td>
											<td style="width: 5%;">${obj.period} | ${obj.cycle }</td>
                                            <pe:permission key="lookEmail">
											<td style="width: 5%;">
                                                <c:if test="${obj.email!=null}">
                                                    ${obj.email} <br>
                                                        <script type="text/javascript">formatTime('${obj.emailDate}');</script>
                                                </c:if>
                                            </td>
                                            </pe:permission>
                                            <pe:permission key="lookPhone">
											<td style="width: 5%;">
                                                <c:if test="${obj.mobile!=null}">
                                                    ${obj.mobile}
                                                        <br>
                                                <script type="text/javascript">formatTime('${obj.mobileDate}');</script>
                                                </c:if>
                                            </td>
                                            </pe:permission>
											<%--<td style="width: 3%;"><c:if test="${obj.sex==1}">男</c:if>--%>
												<%--<c:if test="${obj.sex==0 }">女</c:if></td>--%>
											<td style="width: 5%;">${obj.topicNum }/${obj.replyNum }
											<td style="width: 5%;">${obj.loginNum }<br>
												${obj.loginDays }
											</td>
											<td style="width: 10%;"><script>
												formatTime("${obj.lastLogin }");
											</script><br>
												${obj.lastLoginIp} <br> ${obj.lastLoginCountry }</td>
											<td style="width: 10%;"><script>
												formatTime("${obj.regTime }");
											</script><br>
												${obj.regIp }<br> ${obj.regCountry }</td>
											<td style="width: 5%;">
												<c:if test="${obj.platform==0}">android</c:if>
												<c:if test="${obj.platform==1 }">iPhone</c:if>
												<c:if test="${obj.platform==2 }">wp</c:if>
											</td>
<%-- 											<td style="width: 5%;">${obj.nickLastUpdate}</td> --%>
											<td style="width: 5%;">${obj.expires }</td>
											<td style="width: 10%;">
												<c:choose>
														<c:when test="${obj.expires==null }">
															<pe:permission key="banUser">
															<button class="btn btn-success btn-small" onclick="openModel('${BasePath}/custom/toBanUser?uid=${obj.uid }','封禁用户','50%','50%')">封禁</button>
															</pe:permission>
															<pe:permission key="banUserDev">
															<button class="btn btn-danger btn-small" onclick="openModel('${BasePath}/custom/toBanUserDev?uid=${obj.uid}','带设备封禁','50%','50%')">带设备封禁</button>
															</pe:permission>
														</c:when>
														<c:otherwise>
															<pe:permission key="delBanUser">
																<button class="btn btn-success btn-small" onclick="deleteDevice('${obj.uid }')">解封</button>
															</pe:permission>
															<pe:permission key="delBanUserDev">
																<button class="btn btn-danger btn-small" onclick="openModel('${BasePath}/custom/toDelUserDev?uid=${obj.uid }','解除用户和设备封禁')">解除用户和设备封禁</button>
															</pe:permission>
														</c:otherwise>
												</c:choose>
												<pe:permission key="lookDevice">
													<a class="btn btn-success btn-small" href="${BasePath}/custom/toDeviceList?uid=${obj.uid }" target="_blank" >查看设备</a>
												</pe:permission>
												<pe:permission key="update">
													<button class="btn btn-success btn-small" onclick="openModel('${BasePath}/custom/toUpdateMedal?uid=${obj.uid }','编辑勋章','50%','50%')">编辑勋章</button>
												</pe:permission>
                                                <pe:permission key="banEmail">
                                                    <c:if test="${obj.email!=null}">
                                                        <button class="btn btn-success btn-small" onclick="delEmail('${obj.uid}')">解绑邮箱</button>
                                                    </c:if>
                                                </pe:permission>
                                                <pe:permission key="banPhone">
                                                    <c:if test="${obj.mobile!=null}">
                                                        <button class="btn btn-success btn-small" onclick="delMobile('${obj.uid}')">解绑手机</button>
                                                    </c:if>
                                                </pe:permission>
                                                <pe:permission key="setPass">
                                                    <button class="btn btn-success btn-small" onclick="openModel('${BasePath}/custom/toUpdatePass?uid=${obj.uid }','编辑用户','50%','50%')">编辑用户</button>
                                                </pe:permission>
                                            </td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							<div class="pagination pagination-centered" id="pager"></div>
							<script type="text/javascript">
								var sign = 0;
								window.onload = function () {
									PAGER.initPager('${start}', ' 2000000000', '${limit}', 8, 'pager', getData);
								}
								function getData(currentPage, pageSize) {
									if (sign > 0) {
										$("#start").val(currentPage);
										$("#limit").val(pageSize);
										$("#myform").submit();
									}
									sign = 1;
								}
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
    function delEmail(uid){
        if(!confirm('确定解封该邮箱吗？')){
            return false;
        }
        $.post('${BasePath}/custom/delEmail',{ 'uid':uid },function(data){
            var obj = eval(data);
            if(obj.errno==0){
                alert('操作成功');
                window.location.reload();
            }else{
                alert(obj.errdesc);
            }
        });

    }

    function delMobile(uid){
        if(!confirm('确定解封该手机吗？')){
            return false;
        }
        $.post('${BasePath}/custom/delMobile',{ 'uid':uid },function(data){
            var obj = eval(data);
            if(obj.errno==0){
                alert('操作成功');
                window.location.reload();
            }else{
                alert(obj.errdesc);
            }
        });

    }

	function toUpdate(uid, nick, group_id, sex, type, itemId) {

		nick = encodeURI(nick);
		nick = encodeURI(nick);
		window.location = "${BasePath}/custom/toUpdate?uid=" + uid + "&nick="
				+ nick + "&group_id=" + group_id + "&sex=" + sex + "&type="
				+ type + "&itemId=" + itemId;
	}

	$(function() {
		$(".del").bind('click', function() {

			if (!confirm('确定删除该条记录吗？')) {
				return false;
			}
			var uid = $(this).parent().parent().find(".id").text();
			var tr = $(this).parent().parent();
			$.post('${BasePath}/url/delete', {
				'id' : uid
			}, function(data) {
				var obj = eval(data);
				if (obj.errno == 0) {
					alert('操作成功');
					tr.remove();
				} else {
					alert(obj.errdesc);
				}
			});

		});
	});
	//解封
	function deleteDevice(uid){
		if(!confirm('确定解封该条记录吗？')){
	        return false;
	      }
	      $.post('${BasePath}/custom/banUserDelete',{ 'uid':uid },function(data){
	        var obj = eval(data);
	        if(obj.errno==0){
	          alert('操作成功');
	          window.location.reload();
	        }else{
	          alert(obj.errdesc);
	        }
	      });
	}
	
	//删除用户头像
	function delUserAvatar(uid){
		if(confirm('确定删除用户头像吗？')){
	      $.post('${BasePath}/custom/delUserAvatar',{ 'uid':uid },function(data){
	        var obj = eval(data);
	        if(obj.errno==0){
	          alert('操作成功');
	          window.location.reload();
	        }else{
	          alert(obj.errdesc);
	        }
	      });
	}
	}
</script>