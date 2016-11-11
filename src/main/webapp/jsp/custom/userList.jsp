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
                                &nbsp;&nbsp; &nbsp;UID：<input type="text" id="uid" name="uid" value="${uid}" style="width:90px;"/>
								昵称：
                                <select  id="nickTtpe"  name="nickTtpe" style="width:70px;">
                                    <option value="1" <c:if test="${nickTtpe==1}"> selected="selected" </c:if> >精确</option>
                                    <option value="2" <c:if test="${nickTtpe==2}"> selected="selected" </c:if> >模糊</option>
                                </select>
                                <input type="text" name="nick" value="${nick }" style="width:90px;" />
                                <pe:permission key="lookPone">
                                    手机：<input type="text" name="mobile" value="${mobile}" style="width:90px;" />
                                </pe:permission>
                                <pe:permission key="lookEmail">
                                邮箱：<input type="text" name="email" value="${email }" style="width:130px;" />
                                </pe:permission>
								组：<select name="group_id" style="width:90px;">
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
                                <select  id="platform"  name="platform" style="width:100px;">
                                    <option  value="-1" >全部平台</option>
                                    <option value="0"  <c:if test="${platform==0}"> selected="selected" </c:if>  >  android</option>
                                    <option value="1" <c:if test="${platform==1}"> selected="selected" </c:if> >iPhone</option>
                                    <option value="2" <c:if test="${platform==2}"> selected="selected" </c:if> >wp</option>
                                </select>
								注册地区：<input type="text" name="regCountry" value="${regCountry }" style="width:90px;" />
                                <br>
                                注册ip：<input type="text" name="regIp" value="${regIp }" style="width:90px;" />
                                最后登陆ip：<input type="text" name="lastloginip" value="${lastloginip }" style="width:90px;" />
                                年龄：<input type="text" name="minAge"  style="width:30px"  value="${minAge}" />-<input type="text"  style="width:30px" name="maxAge" value="${maxAge}" />
                                &nbsp;
                                经期：
                                <input type="text" name="minPeriod" style="width:30px" value="${minPeriod}" />-<input type="text"  style="width:30px" name="maxPeriod" value="${maxPeriod}" />
                                &nbsp;&nbsp;
                                周期：
                                <input type="text" name="minCycle" style="width:30px" value="${minCycle}" />-<input type="text"  style="width:30px" name="maxCycle" value="${maxCycle}" />
                                <%--初潮年龄：--%>
                                <%--<input type="text" name="menarche" style="width:30px" value="${menarche}"  />--%>
                                <%---<input type="text"  style="width:30px" name="menarche2" value="0" />--%>
									 排序：<select name="order" style="width:100px;">
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
										<c:when test="${order=='reg_time'}">
											<option value="reg_time" selected="selected">注册时间</option>
										</c:when>
										<c:otherwise>
											<option value="reg_time">注册时间</option>
										</c:otherwise>
									</c:choose>
									<%--<c:choose>--%>
										<%--<c:when test="${order=='loginnum'}">--%>
											<%--<option value="loginnum" selected="selected">登陆次数</option>--%>
										<%--</c:when>--%>
										<%--<c:otherwise>--%>
											<%--<option value="loginnum">登陆次数</option>--%>
										<%--</c:otherwise>--%>
									<%--</c:choose>--%>
									<c:choose>
										<c:when test="${order=='last_login'}">
											<option value="last_login" selected="selected">最后登录时间</option>
										</c:when>
										<c:otherwise>
											<option value="last_login">最后登录时间</option>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${order=='login_days'}">
											<option value="login_days" selected="selected">登陆天数</option>
										</c:when>
										<c:otherwise>
											<option value="login_days">登陆天数</option>
										</c:otherwise>
									</c:choose>
								</select> <select name="asc" style="width:100px;">
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
                                <input type="reset" class="btn btn-danger btn-small" value="重置" />

								<script type="text/javascript">
									function find() {
										var uid = $("#uid").val().trim();
										if (isNaN(uid)) {
											alert("uid只能是数字!");
											$("#uid").val('0');
											return;
										}
                                        $("#start").val(1);
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
										<th>UID<br>发帖数<br>回帖数</th>
										<th>昵称<br>用户组<br>头像</th>
										<%--<th>勋章</th>--%>
										<th>
                                            年龄|初潮<br>
                                            经期|周期
                                        </th>
                                        <th>
                                            <pe:permission key="lookPone">
                                                手机/绑定时间<br>
                                            </pe:permission>
                                        <pe:permission key="lookEmail">
                                           邮箱/绑定时间<br>
                                        </pe:permission>
                                        </th>
										<th>登录天数
										</th>
										<th>最后登录<br>时间|IP|地区
										</th>
										<th>注册平台<br>时间|IP|地区
										</th>
										<th>封禁过期</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody id="tbodys">
									<c:forEach items="${userList}" var="obj">
										<tr>
											<td class="id" style="width: 5%;">
                                            ${obj.uid}<br/>
                                                发帖数：<a href="${BasePath }/audit/topicList?uid=${obj.uid}&type=8&itemId=43&status=-1" target="_blank" > ${obj.topicNum }</a><br>
                                                回帖数：<a href="${BasePath }/audit/replyList?uid=${obj.uid}&type=8&itemId=44&status=-1" target="_blank" >${obj.replyNum }</a><br>
                                            </td>
											<td style="width: 5%;">
											<c:if test="${obj.nick!=null && obj.nick!=''}">
                                                <a href="${BasePath}/custom/nickLogList?type=4&itemId=21&uid=${obj.uid}"  target="_blank" >${obj.nick }</a><br>
                                            </c:if>
                                                <script type="text/javascript">
                                                    formatCustomerGroupType('${obj.group_id}');
                                                </script>
                                                <c:if  test="${obj.avatar!=null && obj.avatar!=''}">
                                                    <img alt="" src="${obj.avatar}" width="100px" height="100px"/>
                                                    <pe:permission key="deleteAvatar">
                                                        <input type="button"  onclick="delUserAvatar(${obj.uid})" class="btn btn-small btn-danger"  value="删除"/>
                                                    </pe:permission>
                                                </c:if>
                                            </td>
											<td style="width: 5%;">
                                                    ${obj.age} | ${obj.menarche }<br>
                                                    ${obj.period} | ${obj.cycle }
											</td>
											<%--<td style="width: 5%;">${obj.medal}</td>--%>

											<td style="width: 5%;">
                                                <pe:permission key="lookPone">
                                                    <c:if test="${obj.mobile!=null}">
                                                        ${obj.mobile} <br>
                                                        <c:if test="${obj.mobileDate!=null && obj.mobileDate>0}">
                                                            <script type="text/javascript">formatTime('${obj.mobileDate}');</script>
                                                        </c:if>
                                                    </c:if>
                                                </pe:permission>
                                                <pe:permission key="lookEmail">
                                                <c:if test="${obj.email!=null}">
                                                    ${obj.email} <br>
                                                    <c:if test="${obj.emailDate!=null && obj.emailDate>0}">
                                                        <script type="text/javascript">formatTime('${obj.emailDate}');</script>
                                                    </c:if>
                                                </c:if>
                                                </pe:permission>
                                            </td>
											<td style="width: 5%;">
                                                    <%--${obj.loginNum }--%>
												${obj.loginDays }
											</td>
											<td style="width: 10%;">
                                                <script>
												formatTime("${obj.lastLogin }");
											</script><br>
												${obj.lastLoginIp} <br> ${obj.lastLoginCountry }</td>
											<td style="width: 10%;">
                                                <c:if test="${obj.platform==0}">android</c:if>
                                                <c:if test="${obj.platform==1 }">iPhone</c:if>
                                                <c:if test="${obj.platform==2 }">wp</c:if>
                                                <br>
                                                <c:if test="${obj.regTime!=null && obj.regTime>0}">
                                                <script>
												    formatTime("${obj.regTime }");
											    </script><br>
                                                </c:if>
												${obj.regIp }
                                                <br>
                                                ${obj.regCountry }</td>
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
                                                <pe:permission key="lookCalendar">
                                                    <a class="btn btn-success btn-small" href="${BasePath}/calendar/list?type=11&itemId=92&uid=${obj.uid }" target="_blank" >查看日历</a>
                                                </pe:permission>
												<pe:permission key="userSignature">
													<button class="btn btn-success btn-small" onclick="openModel('${BasePath}/userSignature/toEdit?uid=${obj.uid }','签名管理','50%','50%')">签名管理</button>
												</pe:permission>
                                                <pe:permission key="qualityUser">
                                                    <button class="btn btn-success btn-small" onclick="addQulityUser(${obj.uid})">加入用户库</button>
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
    function addQulityUser(uid){
        $.post('${BasePath}/qualityUser/addQualityUser',{ 'uid':uid },function(data){
            var obj = eval(data);
            if(obj.errno==0){
                alert('操作成功');
            }else{
                alert(obj.errdesc);
            }
        });
    }
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