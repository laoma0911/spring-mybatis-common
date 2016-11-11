<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="/permission" prefix="pe" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
							<form id="myForm" class="form-inline" name="myForm" action="${BasePath}/apptabicon/list?${PublicParams}"
							      method="post">
								<table>
									<tr valign="middle">
										<td>标题：</td>
										<td><input type="text" name="title" value="${title }"/></td>
										<td>
											状态：<select name="status" id="status">
												<option<c:if test="${status==-1 }"> selected="selected"</c:if>  value="-1">全部</option>
												<option <c:if test="${status==0 }"> selected="selected"</c:if>   value="0">未删除</option>
												<option <c:if test="${status==1 }"> selected="selected"</c:if>   value="1">删除</option>
											</select>
										</td>
										<td><input type="submit" value="查询" class="btn btn-success btn-small"/></td>
									</tr>
								</table>
								
								<input type="hidden"  name="start" id="start" value="${start }"/>
								<input type="hidden"  name="limit" id="limit" value="${limit }"/>
								
							</form>
						</div>
					</div>
					<div id="fixedBar" class="navbar navbar-inner" style="clear:both;">
						<div class="muted pull-left inline">
							<button class="btn btn-success btn-small" onclick="refrom()">刷新</button>
							<span class="badge badge-info"></span>
							<button class="btn btn-success btn-small" id="btnSelectAll" onclick="selectAll()">全选
							</button>
							<span class="badge badge-info"></span>
							<pe:permission key="delete">
								<button class="btn btn-success btn-small" onclick="deleteAudit()">删除</button>
								<span class="badge badge-info"></span>
							</pe:permission>
							<pe:permission key="add">
								<button class="btn btn-success btn-small" onclick="openModel('${BasePath}/apptabicon/saveOrUpdate?${PublicParams}','新增')">新增</button>
									<span class="badge badge-info"></span>
							</pe:permission>
						</div>
					</div>
					<div class="block">
						<div class="navbar navbar-inner block-header">
							<div class="muted pull-left inline">动态推广项</div>
						</div>
						<div class="block-content collapse in">
							<div class="span12">
								<table class="table">
									<thead>
									<tr>
										<th width="5%"></th>
										<th width="5%">id</th>
										<th width="10%">标题</th>
										<th width="10%">图片</th>
										<th width="20%">链接</th>
                                        <th width="10%">时间</th>
										<th width="10%">状态</th>
										<th width="10%">操作</th>
									</tr>
									</thead>
									<tbody id="tbodys">
									<c:forEach items="${list}" var="obj">
										<tr>
											<td>
												<input type="checkbox" name="id" id="id" value="${obj.id}"/>
											</td>
											<td>
													${obj.id}
											</td>
											<td>
													${obj.title}
											</td>
											<td>
													 <c:if test="${obj.icon!=null && obj.icon!=''}">
												  		<img alt="" src="${imageHost }${obj.icon }" style="width: 80px;height: 80px;">
												  </c:if>
											</td>
											<td>
													${obj.link}
											</td>
                                            <td>
                                                <script type="text/javascript">formatTime('${obj.startTime}')</script>
                                                <br/>
                                                <script type="text/javascript">formatTime('${obj.endTime}')</script>

                                            </td>
											<td>
													<c:if test="${obj.status==0 }">正常</c:if>
													<c:if test="${obj.status==1 }">删除</c:if>
											</td>
											<td style="vertical-align:middle">
												<pe:permission key="update">
											      <button class="btn btn-danger btn-small" onclick="openModel('${BasePath}/apptabicon/saveOrUpdate?${PublicParams}&id=${obj.id}','修改')">修改</button>
											      </pe:permission>
											      <pe:permission key="delete">
												      <c:if test="${obj.status==1 }">
												      	<button class="btn btn-danger btn-small" onclick="delAjax('${obj.id}',0)">恢复</button>
												      </c:if>
												      <c:if test="${obj.status==0 }">
												      	<button class="btn btn-danger btn-small" onclick="delAjax('${obj.id}',1)">删除</button>
												      </c:if>
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
 </div>


<jsp:include page="../include/bottom.jsp"/>


<script>
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

	//删除
	function deleteAudit() {
		var ids = new Array();
		$("input[name='id']:checked").each(function () {
			var txt = $(this).val();
			ids.push(txt);
		});
		if (ids.length == 0) {
			alert("您还未选择要操作的数据？");
			return false;
		}
		delAjax(ids,1);
	}
	
	function delAjax(ids,status){
		$.ajax({
			type: "POST",
			url: "${BasePath}/apptabicon/del?ids=" + ids + "&status=" + status,
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
	//    tr选中checkbox效果
	$('#tbodys tr').click(function () {
		var chks = $(':checkbox', this);
		chks.prop('checked', !chks[0].checked);
	});
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
</script>