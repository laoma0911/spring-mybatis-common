<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
							<form action="${BasePath}/custom/adminLogList?type=${type}&itemId=${itemId}" method="post" id="myform" name="myform" class="form-search">
								<table>
									<tr>
										<td style="width: 230px;">管理用户uid：<input type="text" 	style="width: 160px;" name="op_uid" id="op_uid" value="${op_uid }" /></td>
										<td style="width: 230px;">被操作uid：<input type="text" 	style="width: 160px;" name="uid" id="uid" value="${uid }" />
										</td>
										<td style="width: 40px;">被操作的分类： <select name="opclass">
												
												<c:choose> <c:when test="${opclass==-1}">
														<option value="-1" selected="selected">全部</option>
													</c:when> <c:otherwise>
														<option value="-1">全部</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opclass==0}">
														<option value="0" selected="selected">用户组</option>
													</c:when> <c:otherwise>
														<option value="0">用户组</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opclass==1}">
														<option value="1" selected="selected">论坛</option>
													</c:when> <c:otherwise>
														<option value="1">论坛</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opclass==2}">
														<option value="2" selected="selected">论坛回复</option>
													</c:when> <c:otherwise>
														<option value="2">论坛回复</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opclass==3}">
														<option value="3" selected="selected">换量链接</option>
													</c:when> <c:otherwise>
														<option value="3">换量链接</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opclass==4}">
														<option value="4" selected="selected">论坛广告</option>
													</c:when> <c:otherwise>
														<option value="4">论坛广告</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opclass==5}">
														<option value="5" selected="selected">精选文章</option>
													</c:when> <c:otherwise>
														<option value="5">精选文章</option>
												</c:otherwise></c:choose>
												<%--<c:choose>--%>
                                                    <%--<c:when test="${opclass==6}">--%>
														<%--<option value="6" selected="selected">巴士活动-巴士</option>--%>
													<%--</c:when> <c:otherwise>--%>
														<%--<option value="6">巴士活动-巴士</option>--%>
												<%--</c:otherwise></c:choose>--%>
												<%--<c:choose> <c:when test="${opclass==7}">--%>
														<%--<option value="7" selected="selected">巴士活动-路线</option>--%>
													<%--</c:when> <c:otherwise>--%>
														<%--<option value="7">巴士活动-路线</option>--%>
												<%--</c:otherwise></c:choose>--%>
												<%--<c:choose> <c:when test="${opclass==8}">--%>
														<%--<option value="8" selected="selected">巴士活动-座位</option>--%>
													<%--</c:when> <c:otherwise>--%>
														<%--<option value="8">巴士活动-座位</option>--%>
												<%--</c:otherwise></c:choose>--%>
												<%--<c:choose> <c:when test="${opclass==9}">--%>
														<%--<option value="9" selected="selected">巴士活动-巴士预订</option>--%>
													<%--</c:when> <c:otherwise>--%>
														<%--<option value="9">巴士活动-巴士预订</option>--%>
												<%--</c:otherwise></c:choose>--%>
												<%--<c:choose> <c:when test="${opclass==10}">--%>
														<%--<option value="10" selected="selected">巴士活动-友情链接</option>--%>
													<%--</c:when> <c:otherwise>--%>
														<%--<option value="10">巴士活动-友情链接</option>--%>
												<%--</c:otherwise></c:choose>--%>
												<%--<c:choose> <c:when test="${opclass==11}">--%>
														<%--<option value="11" selected="selected">巴士活动-活动周期</option>--%>
													<%--</c:when> <c:otherwise>--%>
														<%--<option value="11">巴士活动-活动周期</option>--%>
												<%--</c:otherwise></c:choose>--%>
												<c:choose> <c:when test="${opclass==12}">
														<option value="12" selected="selected">banner管理</option>
													</c:when> <c:otherwise>
														<option value="12">banner管理</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opclass==13}">
														<option value="13" selected="selected">文件上传管理</option>
													</c:when> <c:otherwise>
														<option value="13">文件上传管理</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opclass==14}">
														<option value="14" selected="selected">贴士</option>
													</c:when> <c:otherwise>
														<option value="14">贴士</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opclass==15}">
														<option value="15" selected="selected">小组图片审核</option>
													</c:when> <c:otherwise>
														<option value="15">小组图片审核</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opclass==16}">
														<option value="16" selected="selected">广告猎手</option>
													</c:when> <c:otherwise>
														<option value="16">广告猎手</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opclass==17}">
														<option value="17" selected="selected">小组审核</option>
													</c:when> <c:otherwise>
														<option value="17">小组审核</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opclass==18}">
														<option value="18" selected="selected">大姨吗网站下载页</option>
													</c:when> <c:otherwise>
														<option value="18">大姨吗网站下载页</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opclass==19}">
														<option value="19" selected="selected">头图管理</option>
													</c:when> <c:otherwise>
														<option value="19">头图管理</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opclass==20}">
														<option value="20" selected="selected">IPA管理</option>
													</c:when> <c:otherwise>
														<option value="20">IPA管理</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opclass==21}">
														<option value="21" selected="selected">测试管理</option>
													</c:when> <c:otherwise>
														<option value="21">测试管理</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opclass==22}">
														<option value="22" selected="selected">开机广告</option>
													</c:when> <c:otherwise>
														<option value="22">开机广告</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opclass==23}">
														<option value="23" selected="selected">插屏广告</option>
													</c:when> <c:otherwise>
														<option value="23">插屏广告</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opclass==24}">
														<option value="24" selected="selected">首页广告</option>
													</c:when> <c:otherwise>
														<option value="24">首页广告</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opclass==25}">
														<option value="25" selected="selected">求助活动管理</option>
													</c:when> <c:otherwise>
														<option value="25">求助活动管理</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opclass==26}">
														<option value="26" selected="selected">提问活动管理</option>
													</c:when> <c:otherwise>
														<option value="26">提问活动管理</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opclass==27}">
														<option value="27" selected="selected">话题广告</option>
													</c:when> <c:otherwise>
														<option value="27">话题广告</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opclass==28}">
														<option value="28" selected="selected">数据合并</option>
													</c:when> <c:otherwise>
														<option value="28">数据合并</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opclass==29}">
														<option value="29" selected="selected">系统信息</option>
													</c:when> <c:otherwise>
														<option value="29">系统信息</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opclass==30}">
														<option value="30" selected="selected">小组消息</option>
													</c:when> <c:otherwise>
														<option value="30">小组消息</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opclass==31}">
														<option value="31" selected="selected">推送版本管理</option>
													</c:when> <c:otherwise>
														<option value="31">推送版本管理</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opclass==32}">
														<option value="32" selected="selected">最新版本</option>
													</c:when> <c:otherwise>
														<option value="32">最新版本</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opclass==33}">
														<option value="33" selected="selected">自定义菜单</option>
													</c:when> <c:otherwise>
														<option value="33">最新版本</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opclass==34}">
														<option value="34" selected="selected">用户头像</option>
													</c:when> <c:otherwise>
														<option value="34">用户头像</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opclass==35}">
														<option value="35" selected="selected">姐妹说</option>
													</c:when> <c:otherwise>
														<option value="35">姐妹说</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opclass==36}">
														<option value="36" selected="selected">ubaby知识推荐</option>
													</c:when> <c:otherwise>
														<option value="36">ubaby知识推荐</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opclass==37}">
														<option value="37" selected="selected">ubaby首页精华贴</option>
													</c:when> <c:otherwise>
														<option value="37">ubaby首页精华贴</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opclass==38}">
														<option value="38" selected="selected">ubaby小组推荐贴</option>
													</c:when> <c:otherwise>
														<option value="38">ubaby小组推荐贴</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opclass==39}">
														<option value="39" selected="selected">ubaby设置怀孕人数</option>
													</c:when> <c:otherwise>
														<option value="39">ubaby设置怀孕人数</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opclass==40}">
														<option value="40" selected="selected">ubaby小组banner</option>
													</c:when> <c:otherwise>
														<option value="40">ubaby小组banner</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opclass==41}">
														<option value="41" selected="selected">ubaby知识</option>
													</c:when> <c:otherwise>
														<option value="41">ubaby知识</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opclass==42}">
														<option value="42" selected="selected">uba42by趣味知识</option>
													</c:when> <c:otherwise>
														<option value="42">uba42by趣味知识</option>
												</c:otherwise></c:choose>
													<c:choose> <c:when test="${opclass==43}">
														<option value="43" selected="selected">ubaby系统公告</option>
													</c:when> <c:otherwise>
														<option value="43">ubaby系统公告</option>
												</c:otherwise></c:choose>
													<c:choose> <c:when test="${opclass==44}">
														<option value="44" selected="selected">主题包</option>
													</c:when> <c:otherwise>
														<option value="44">主题包</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opclass==45}">
														<option value="45" selected="selected">主题</option>
													</c:when> <c:otherwise>
														<option value="45">主题</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opclass==46}">
														<option value="46" selected="selected">ubaby头图管理</option>
													</c:when> <c:otherwise>
														<option value="46">ubaby头图管理</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opclass==47}">
														<option value="47" selected="selected">ubaby的小组推荐</option>
													</c:when> <c:otherwise>
														<option value="47">ubaby的小组推荐</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opclass==48}">
														<option value="48" selected="selected">泡泡广告</option>
													</c:when> <c:otherwise>
														<option value="48">泡泡广告</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opclass==49}">
														<option value="49" selected="selected">大姨妈积分奖罚</option>
													</c:when> <c:otherwise>
														<option value="49">大姨妈积分奖罚</option>
												</c:otherwise></c:choose>
										</select>
										</td>
										<td style="width: 40px;">操作： <select name="opcode">
												<c:choose> <c:when test="${opcode==-1}">
														<option value="-1" selected="selected">全部</option>
													</c:when> <c:otherwise>
														<option value="-1">全部</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opcode==0}">
														<option value="0" selected="selected">创建</option>
													</c:when> <c:otherwise>
														<option value="0">创建</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opcode==1}">
														<option value="1" selected="selected">读取</option>
													</c:when> <c:otherwise>
														<option value="1">读取</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opcode==2}">
														<option value="2" selected="selected">修改</option>
													</c:when> <c:otherwise>
														<option value="2">修改</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opcode==3}">
														<option value="3" selected="selected">逻辑删除</option>
													</c:when> <c:otherwise>
														<option value="3">逻辑删除</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opcode==4}">
														<option value="4" selected="selected">物理删除</option>
													</c:when> <c:otherwise>
														<option value="4">物理删除</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opcode==5}">
														<option value="5" selected="selected">审核</option>
													</c:when> <c:otherwise>
														<option value="5">审核</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opcode==6}">
														<option value="6" selected="selected">Ban设备</option>
													</c:when> <c:otherwise>
														<option value="6">Ban设备</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opcode==7}">
														<option value="7" selected="selected">Ban用户</option>
													</c:when> <c:otherwise>
														<option value="7">Ban用户</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opcode==8}">
														<option value="8" selected="selected">审核通过</option>
													</c:when> <c:otherwise>
														<option value="8">审核通过</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opcode==9}">
														<option value="9" selected="selected">审核不通过</option>
													</c:when> <c:otherwise>
														<option value="9">审核不通过</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opcode==10}">
														<option value="10" selected="selected">关闭</option>
													</c:when> <c:otherwise>
														<option value="10">关闭</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opcode==11}">
														<option value="11" selected="selected">话题推荐</option>
													</c:when> <c:otherwise>
														<option value="11">话题推荐</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opcode==12}">
														<option value="12" selected="selected">话题取消推荐</option>
													</c:when> <c:otherwise>
														<option value="12">话题取消推荐</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opcode==13}">
														<option value="13" selected="selected">话题置顶</option>
													</c:when> <c:otherwise>
														<option value="13">话题置顶</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opcode==14}">
														<option value="14" selected="selected">话题取消置顶</option>
													</c:when> <c:otherwise>
														<option value="14">话题取消置顶</option>
												</c:otherwise></c:choose>
												<c:choose> <c:when test="${opcode==15}">
														<option value="15" selected="selected">推荐的排序</option>
													</c:when> <c:otherwise>
														<option value="15">推荐的排序</option>
												</c:otherwise></c:choose>
										</select>
										</td>
										<td style="width: 100px;">
											<input type="text"	style="width: 100px;" name="start1" value="${start1 }" class="Wdate"	onClick="WdatePicker()" />
											<input type="text"  style="width: 100px;"  name="end" value="${end}" class="Wdate" onClick="WdatePicker()" />
											
<%-- 											<input type="text"  style="width: auto;" id="startTm"  name="start1" value="${start1 }" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',readOnly:'false'})" class="Wdate" /> --%>
<%-- 											<input type="text"  style="width: auto;" id="endTm"  name="end" value="${end }" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',readOnly:'false'})" class="Wdate"  /> --%>
											
										</td>
										<td style="width: 100px;">
											<input type="text"	style="width: 100px;" name="key" value="${key }" />
										</td>
										<td style="width: 40px;"><input type="reset" value="取消" />
											<input type="button" onclick="find()" class="btn" name="Bsearch" value="查询" /></td>
									</tr>
								</table>
									<input type="hidden"  name="start" id="start" value="${start }"/>
										<input type="hidden"  name="limit" id="limit" value="${limit }"/>
										
										
										<script type="text/javascript">
											function find(){
												var op_uid = $("#op_uid").val().trim();
												var uid = $("#uid").val().trim();
												if(isNaN(op_uid)){
													alert("管理用户uid只能是数字!");
													 $("#op_uid").val('');
													return ;
												}
												if(isNaN(uid)){
													alert("被操作uid只能是数字!");
													 $("#uid").val('');
													return ;
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
						<div class="muted pull-left">管理员操作日志列表</div>
						<div class="pull-right">
<!-- 							<button class="btn" style="margin-top: -5px" -->
<%-- 								onclick="window.location='${BasePath}/custom/toAddBanUser?type=${type}&itemId=${itemId}'">新增</button> --%>
							<span class="badge badge-info">${json.total}</span>
						</div>
					</div>
					<div class="block-content collapse in">
						<div class="span12">
							<table class="table table-hover">
								<thead>
									<tr>
										<th>ID</th>
										<th>admin</th>
										<th>被操作user</th>
										<th>创建时间</th>
										<th>内容</th>
										<th>操作端</th>
									</tr>
								</thead>
								<tbody id="tbodys">
									<c:forEach items="${json.data}" var="obj">
										<tr>
											<td>${obj.id}</td>
											<td>${obj.opUserName}</td>
											<td>${obj.uid}</td>
											<td>
											<script language="javascript">formatTime("${obj.dateline}");</script>
											</td>
											<td>${obj.info}</td>
											<td>
                                                <c:if test="${obj.refer==0}">Web</c:if>
                                                <c:if test="${obj.refer==1}">客户端</c:if>
                                            </td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							
								         <div class="pagination pagination-centered" id="pager"></div> 
			                				<script type="text/javascript">
											             var sign=0;
											              window.onload=function(){
											            	  PAGER.initPager('${start}',' ${json.total}','${limit}', 8, 'pager', getData);
											              };
											              function getData(currentPage,pageSize) {
											            	  if(sign>0){
											            	 	$("#start").val(currentPage);
											            	 	$("#limit").val(pageSize);
											            	 	$("#myform").submit();
											            	  }
											            	  sign=1;
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
	function deleteDevice(uid) {
		if (!confirm('确定解封该条记录吗？')) {
			return false;
		}
		$.post('${BasePath}/custom/banUserDelete', {
			'uid' : uid
		}, function(data) {
			var obj = eval(data);
			if (obj.errno == 0) {
				alert('操作成功');
				window.location.reload();
			} else {
				alert(obj.errdesc);
			}
		});
	}
</script>