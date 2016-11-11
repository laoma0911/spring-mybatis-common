<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="/permission" prefix="pe" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="e" uri="https://www.owasp.org/index.php/OWASP_Java_Encoder_Project" %>
<jsp:include page="../include/top.jsp"/>
<link href="${BasePath}/js/mediabox/css.css" rel="stylesheet" media="screen">
<!-- Body -->
<div class="container-fluid" onmousemove="initTrColor()">
	<div class="row-fluid">
		<!-- Menu -->
		<jsp:include page="../include/menu.jsp"/>
		<div class="span9" id="content">
			<jsp:include page="../include/location.jsp"/>
			<div class="row-fluid">
				<div class="span12">
					<div class="block">
						<div class="navbar navbar-inner block-header" style="border-bottom: none;">
							<form id="myForm" class="form-inline" name="myForm" action="${BasePath}/topic/allList?${PublicParams}" method="post">
								小组： <input type="text" name="categorytitle" value="${categorytitle }"/>
								topicId： <input type="text" name="topicId" value="${topicId }"/>
								uid：<input type="text" name="uid" value="${uid }"/>
								标题：<input type="text" name="title" value="${title }"/>
								筛选：<select name="topicstatus" id="topicstatus">
												<option <c:if test="${topicstatus==0 }">selected="selected" </c:if> value="0">全部</option>
												<option <c:if test="${topicstatus==1 }">selected="selected" </c:if> value="1">全局置顶</option>
												<option <c:if test="${topicstatus==2 }">selected="selected" </c:if> value="2">小组置顶</option>
												<option <c:if test="${topicstatus==3 }">selected="selected" </c:if> value="3">精华帖</option>
												<option <c:if test="${topicstatus==4 }">selected="selected" </c:if> value="4">锁定帖</option>
<%-- 												<option <c:if test="${topicstatus==5 }">selected="selected" </c:if> value="5">下沉帖</option> --%>
											</select>
								<br>
								状态：<select name="status" id="status">
												<option <c:if test="${status==0 }">selected="selected" </c:if> value="0">全部</option>
												<option <c:if test="${status==1 }">selected="selected" </c:if> value="1">删除</option>
												<option <c:if test="${status==2 }">selected="selected" </c:if> value="2">未删除</option>
											</select>
								<input type="submit" value="查询" class="btn btn-success btn-small"/>
									
								<input type="hidden" name="start" id="start" value="${start }"/>
								<input type="hidden" name="limit" id="limit" value="${limit }"/>
<%-- 								<input type="hidden" name="type" id="type" value="${type }"/> --%>
<%-- 								<input type="hidden" name="itemId" id="itemId" value="${itemId }"/> --%>
								<input type="hidden" name="sign" value="2" id="sign"/>
							</form>
						</div>
					</div>
				</div>
				<div id="fixedBar" class="navbar navbar-inner" style="clear:both;">
					<div class="muted pull-left inline">
						<button class="btn btn-success btn-small" onclick="refrom()">刷新
						</button>
						<span class="badge badge-info"></span>
						<button class="btn btn-success btn-small" id="btnSelectAll" onclick="selectAll()">全选
						</button>
						<span class="badge badge-info"></span>
						<pe:permission key="deleteUpdate">
							<button class="btn btn-danger btn-small" onclick="statusScHf(1)">删除
							</button>
							<span class="badge badge-info"></span>
							<button class="btn btn-success btn-small" onclick="statusScHf(0)">恢复
							</button>
							<span class="badge badge-info"></span>
						</pe:permission>
						<pe:permission key="lock">
							<button class="btn btn-success btn-small" onclick="lockSt(1)">
								锁定
							</button>
							<span class="badge badge-info"></span>
							<button class="btn btn-success btn-small" onclick="lockSt(0)">
								解锁
							</button>
							<span class="badge badge-info"></span>
						</pe:permission>
<%-- 						<pe:permission key="down"> --%>
<!-- 							<button class="btn btn-success btn-small" onclick="setbottomZt(1)">置底 -->
<!-- 							</button> -->
<!-- 							<span class="badge badge-info"></span> -->
<!-- 							<button class="btn btn-success btn-small" onclick="setbottomZt(0)">取消置底 -->
<!-- 							</button> -->
<!-- 							<span class="badge badge-info"></span> -->
<%-- 						</pe:permission> --%>
						<pe:permission key="down">
							<button class="btn btn-success btn-small" onclick="setIsdown(1)">下沉
							</button>
							<span class="badge badge-info"></span>
							<button class="btn btn-success btn-small" onclick="setIsdown(0)">取消下沉
							</button>
							<span class="badge badge-info"></span>
						</pe:permission>
						<pe:permission key="top">
							<button class="btn btn-success btn-small" onclick="settopZt(1)">小组置顶
							</button>
							<span class="badge badge-info"></span>
							<button class="btn btn-success btn-small" onclick="settopZt(2)">全局置顶
							</button>
							<span class="badge badge-info"></span>
							<button class="btn btn-success btn-small" onclick="settopZt(0)">取消置顶
							</button>
							<span class="badge badge-info"></span>
						</pe:permission>
						<pe:permission key="digest">
							<button class="btn btn-success btn-small" onclick="digestJh(1)">精华帖
							</button>
							<span class="badge badge-info"></span>
							<button class="btn btn-success btn-small" onclick="digestJh(0)">取消精华帖
							</button>
							<span class="badge badge-info"></span>
                        </pe:permission>
                            <pe:permission key="hidden">
                            <button class="btn btn-success btn-small" onclick="hiddenTopic(1)">隐藏
                            </button>
                            <span class="badge badge-info"></span>
                            <button class="btn btn-success btn-small" onclick="hiddenTopic(0)">取消隐藏
                            </button>
                            <span class="badge badge-info"></span>
						</pe:permission>
<%-- 						<pe:permission key="moveTopic"> --%>
                            <button class="btn btn-success btn-small" onclick="moveTopics()">
                                批量移动
                            </button>
<%--                         </pe:permission> --%>
					</div>
				</div>
				<div class="block">
					<div class="navbar navbar-inner block-header">
						<div class="muted pull-left inline">话题列表&nbsp;&nbsp;&nbsp;</div>
					</div>
					<div class="block-content collapse in">
						<div class="span12">
							<table class="table">
								<thead>
								<tr>
									<th width="1%"></th>
									<th width="11%">话题信息</th>
									<th width="10%">标题</th>
									<th width="43%">内容</th>
                                    <pe:permission key="lookData">
									<th width="5%">浏览量</th>
									<th width="5%">回复量</th>
									<th width="3%">UV</th>
									<th width="3%">UR</th>
                                    </pe:permission>
									<th width="10%">发布时间</th>
									<%--<th width="7%">推荐</th>--%>
									<th  width="2%">操作</th>
								</tr>
								</thead>
								<tbody id="tbodys">
								<c:forEach items="${list}" var="obj">
									<tr>
										<td id="clickId">
											<input type="checkbox" name="id" id="id" value="${obj.topicId }"/>
										</td>
										<td>
											topicId:${obj.topicId}<br>
											小组：${obj.groupTitle}<br>
											uid:<a href="${BasePath }/custom/userList?type=4&itemId=20&uid=${obj.uid}"  target="_black">${obj.uid }</a>
											<c:if test="${obj.isMonitor == 1}"><font style="color: #ff0000">[监控]</font></c:if>
											<c:if test="${obj.banCount != 0}">
												<font style="color: #ff0000">[违规${obj.banCount}]</font>
											</c:if>
											<br>
											nick:${obj.nick}
										</td>
										<td>
											<a href="${BasePath}/topic/topicDetail?${PublicParams}&topicId=${obj.topicId}" target="_blank"><e:forHtml value="${obj.title}"/></a>
											<c:if test="${obj.status==1 }"><font style="color: #ff0000">[删]</font></c:if>
											<c:if test="${obj.lock==1 }"><font style="color: #ff0000">[锁]</font></c:if>
<%-- 											<c:if test="${obj.setbottom==1 }"><font style="color: #ff0000">[置底]</font></c:if> --%>
											<c:if test="${obj.settop==1 }"><font style="color: #ff0000">[置顶]</font></c:if>
											<c:if test="${obj.settop==2 }"><font style="color: #ff0000">[公告]</font></c:if>
											<c:if test="${obj.digest==1 }"><font style="color: #ff0000">[精华]</font></c:if>
											<c:if test="${obj.isdown == 1}"><font style="color: #ff0000">[沉]</font></c:if>
											<c:if test="${obj.hidden == 1}"><font style="color: #ff0000">[已隐藏]</font></c:if>
										</td>
										<td>
												<e:forHtml value="${obj.content}"/>
												<c:if test="${obj.isPic == 1}"><font style="color: #ff0000">[图]</font></c:if>
											<br>
											<c:forEach items="${obj.picList}" var="pic">
												<a href="${pic.oriPic}" rel="lightbox[ostec]">
													<img src="${pic.pic}" width="130px" height="130px">&nbsp;
												</a>
											</c:forEach>
										</td>
                                        <pe:permission key="lookData">
										<td>${obj.viewnum }</td>
										<td>${obj.replynum }</td>
										<td>${obj.uv }</td>
										<td>${obj.ur }</td>
                                        </pe:permission>
										<td><script >formatTime("${obj.dateline }");</script></td>
										<%--<td>--%>
											<%--<c:choose>--%>
												<%--<c:when test="${obj.flag==0}">--%>
														<%--<label class="checkbox inline"><input type="checkbox" name="flag"  onchange="hottestOnChange(this)"  value="${obj.topicId },${obj.catId },${obj.topicHottestId },${obj.uid}"/>最热话题</label>--%>
												<%--</c:when>--%>
												<%--<c:otherwise>--%>
														<%--<label class="checkbox inline"><input type="checkbox"   name="flag"  checked="checked"  onchange="hottestOnChange(this)"  value="${obj.topicId },${obj.catId },${obj.topicHottestId },${obj.uid}"   />最热话题</label>--%>
												<%--</c:otherwise>--%>
											<%--</c:choose>--%>
										<%--</td>--%>
										<td>
<%-- 												<input type="button" class="btn btn-small btn-success" id="changeBtn" onclick="javascript:openModel('${BasePath}/topic/updateTopic?${PublicParams}&topicId=${obj.topicId}','修改');" value="编辑" /> --%>
                                            <pe:permission key="update">
												<a class="btn btn-small btn-success" href="${BasePath}/topic/updateTopic?${PublicParams}&topicId=${obj.topicId}" target="_blank">编辑</a>
                                            </pe:permission>
												<c:if test="${obj.status==1 }">
													<input type="button" class="btn btn-small btn-success" id="changeBtn" onclick="updateTopicStatus(${obj.topicId},0)" value="恢复" />
												</c:if>
												<c:if test="${obj.status==0 }">
													<input type="button" class="btn btn-small btn-danger" id="changeBtn" onclick="updateTopicStatus(${obj.topicId},1)" value="删除" />
												</c:if>
										</td>
									</tr>
								</c:forEach>
								</tbody>
							</table>
							<div class="pagination pagination-centered" id="pager"></div>
							<script type="text/javascript">
								var sign = 0;
								window.onload = function () {
									PAGER.initPager('${start}', ' ${total}', '${limit}', 8, 'pager', getData);
								}
								function getData(currentPage, pageSize) {
									if (sign > 0) {
										$("#start").val(currentPage);
										$("#limit").val(pageSize);
										$("#myForm").submit();
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


<jsp:include page="../include/bottom.jsp"/>


<script>
	//选中后改变背景颜色
	function initTrColor() {
		$("input[name='id']").each(function () {
			if (this.checked) {
				this.parentNode.parentNode.style.backgroundColor = "#D7E8D8";
			} else {
				this.parentNode.parentNode.style.backgroundColor = "#ffffff";
			}
		});
	}
	//    tr选中checkbox效果
	$('#tbodys tr').click(function () {
	//	var chks = $(':checkbox', this);
		var chks = $("input[name='id']", this);
		chks.prop('checked', !chks[0].checked);
	});
	
	
	function refrom() {
		$("#myForm").submit();
	}

	//全选
	function selectAll() {
		$("input[name='id']").each(function () {
			this.checked = true;
		});
		$("#btnSelectAll").html("取消全选");
		$("#btnSelectAll").attr("onclick", "cancelSelectAll()");
	}
	//取消全选
	function cancelSelectAll() {
		$("input[name='id']").each(function () {
			this.checked = false;
		});
		$("#btnSelectAll").html("全选");
		$("#btnSelectAll").attr("onclick", "selectAll()");
	}

	function updateTopicStatus(topicId,status){
		var path = "${BasePath}/topic/shDelTopic?topicIds=" + topicId + "&status=" + status;
		qqAjax(path);
	}
	
	//删除/恢复帖 子
	function statusScHf(status) {
		var ids = new Array();
		$("input[name='id']:checked").each(function () {
			var txt = $(this).val();
			ids.push(txt);
		});
		if (ids.length == 0) {
			alert("您还未选择要操作的数据？");
			return false;
		}

		var path = "${BasePath}/topic/shDelTopic?topicIds=" + ids + "&status=" + status;
		qqAjax(path);
	}

	//修改置顶状态
	function settopZt(settop) {
		var ids = new Array();
		$("input[name='id']:checked").each(function () {
			var txt = $(this).val();
			ids.push(txt);
		});
		if (ids.length == 0) {
			alert("您还未选择要操作的数据？");
			return false;
		}

		var path = "${BasePath}/topic/shSettopTopic?topicIds=" + ids + "&settop=" + settop;
		qqAjax(path);
	}

	function setbottomZt(setbottom) {
		var ids = new Array();
		$("input[name='id']:checked").each(function () {
			var txt = $(this).val();
			ids.push(txt);
		});
		if (ids.length == 0) {
			alert("您还未选择要操作的数据？");
			return false;
		}

		var path = "${BasePath}/topic/shSetbottomTopic?topicIds=" + ids + "&setbottom=" + setbottom;
		qqAjax(path);
	}
	
	function setIsdown(isdown){
		var ids = new Array();
		$("input[name='id']:checked").each(function () {
			var txt = $(this).val();
			ids.push(txt);
		});
		if (ids.length == 0) {
			alert("您还未选择要操作的数据？");
			return false;
		}

		var path = "${BasePath}/topic/shIsdownTopic?topicIds=" + ids + "&isdown=" + isdown;
		qqAjax(path);
	}
	
	function hottestOnChange(obj){
			var val = obj.value.split(",");
			var topicId = val[0];
			var groupId = val[1];
			var topicHottestId = val[2];
			var topicUid = val[3];
		var sod ;
		if(obj.checked){
// 			$(obj).attr("checked", true);
			sod = 0;
		} else {
// 			$(obj).attr("checked", false);
			sod = 1;
		}
		var path = "${BasePath }/topic/hottestChange?topicId=" + topicId + "&groupId=" + groupId + "&sod=" + sod + "&topicHottestId=" + topicHottestId + "&topicUid=" + topicUid;
		$.ajax({
			async:false,
			 type:"POST",
			 url:path,
			 datatype: "json",
			 success:function(data){
				 if(data.error != null){
						 alert(data.error);
				 } else if(data.topicHottestId != null){
					 obj.value = topicId + "," + topicId + "," + data.topicHottestId+","+topicUid;
				 } else {
					 obj.value = topicId + "," + topicId + ",'',"+topicUid;
				 }
			 } ,
			 error: function(){
			   alert("操作出错，请联系管理员！");
			 }         
		});
}

	function lockSt(lock) {
		var ids = new Array();
		$("input[name='id']:checked").each(function () {
			var txt = $(this).val();
			ids.push(txt);
		});
		if (ids.length == 0) {
			alert("您还未选择要操作的数据？");
			return false;
		}

		var path = "${BasePath}/topic/shLockTopic?topicIds=" + ids + "&lock=" + lock;
		qqAjax(path);
	}

	function digestJh(digest) {
		var ids = new Array();
		$("input[name='id']:checked").each(function () {
			var txt = $(this).val();
			ids.push(txt);
		});
		if (ids.length == 0) {
			alert("您还未选择要操作的数据？");
			return false;
		}

		var path = "${BasePath}/topic/shDigestTopic?topicIds=" + ids + "&digest=" + digest;
		qqAjax(path);
	}

    function hiddenTopic(digest) {
		var ids = new Array();
		$("input[name='id']:checked").each(function () {
			var txt = $(this).val();
			ids.push(txt);
		});
		if (ids.length == 0) {
			alert("您还未选择要操作的数据？");
			return false;
		}

		var path = "${BasePath}/topic/hiddenTopic?topicIds=" + ids + "&digest=" + digest;
		qqAjax(path);
	}

	function qqAjax(path) {
		$.ajax({
			type: "POST",
			url: path,
			datatype: "json",
			success: function (data) {
				if (data.errno == 1) {
					alert(data.errdesc);
				} else {
					window.location.reload(true);
				}
			},
			error: function () {
				alert("操作出错，请联系管理员！");
			}
		});
	}

	function getStr200(val) {
		var str = val;
		if (val != null && val.length > 200) {
			str = val.substring(0, 200);
		}
		document.write(str);
	}
	
	//移动
    function moveTopics() {
        var ids = new Array();
        $("input[name='id']:checked").each(function () {
            var txt = $(this).val();
            ids.push(txt);
        });
        if (ids.length == 0) {
            alert("请选择需要操作的数据！");
            return false;
        }
        openModel('${BasePath}/topic/toMoveTopicsToGroup?ids='+ids,'批量移动帖子','40%','40%');
    }

	//图片弹出
	Mediabox.scanPage = function () {
		var links = $$("a").filter(function (el) {
			return el.rel && el.rel.test(/^lightbox/i);
		});
		$$(links).mediabox({/* Put custom options here */}, null, function (el) {
			var rel0 = this.rel.replace(/[[]|]/gi, " ");
			var relsize = rel0.split(" ");
			return (this == el) || ((this.rel.length > 8) && el.rel.match(relsize[1]));
		});
	};
	window.addEvent("domready", Mediabox.scanPage);


</script>