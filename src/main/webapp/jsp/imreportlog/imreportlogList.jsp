<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<%@ taglib uri="/permission" prefix="pe"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<jsp:include page="../include/top.jsp" />
<link href="${BasePath}/js/mediabox/css.css" rel="stylesheet" media="screen">
<!-- Body -->
<div class="container-fluid" onmousemove="initTrColor()">
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
							<form class="form-inline" id="myForm" name="myForm" action="${BasePath}/imReportLog/list" method="post">
								用户:
								<select name="status" id="status">
									<option <c:if test="${status==0 }">selected="selected" </c:if> value="0">待审核</option>
									<option <c:if test="${status==1 }">selected="selected" </c:if> value="1">已处理</option>
									<option <c:if test="${status==2 }">selected="selected" </c:if> value="2">已忽略</option>
								</select>
								<button type="button" onclick="submitForm()" class="btn btn-success btn-small">查询</button>
								<input type="hidden" name="start" id="start" value="${start }" />
								<input type="hidden" name="limit" id="limit" value="${limit }" />
								<input type="hidden" name="type" id="type" value="${type }" />
								<input type="hidden" name="itemId" id="itemId" value="${itemId }" />
							</form>
						</div>
					</div>
				</div>

                <div id="fixedBar" class="navbar navbar-inner" style="clear:both;">
                    <div class="muted pull-left inline">
                        <button class="btn btn-success btn-small" onclick="window.location.reload(true); ">刷新</button>
                        <span class="badge badge-info"></span>
                        <button class="btn btn-success btn-small" id="btnSelectAll" onclick="selectAll()">全选</button>
                        <span class="badge badge-info"></span>
                        <pe:permission key="ignore">
                        			<button class="btn btn-success btn-small" onclick="hlP()">批量忽略</button>
                        </pe:permission>
                    </div>
                </div>
				<!--kaishi -->
				<div class="block">
					<div class="navbar navbar-inner block-header">
						<div class="muted pull-left">私信举报列表</div>
						<div class="pull-right">
							<pe:permission key="operate">
								<button class="btn btn-success btn-small" style="margin-top: -5px" onclick="openModel('/groupCategory/categoryToAdd','新增')">新增
								</button>
							</pe:permission>
						</div>
					</div>
					<div class="block-content collapse in">
						<div class="span12">
							<table class="table table-hover">
								<thead>
									<tr>
                                        <th></th>
                                        <th>举报ID</th>
                                        <th>被举报用户</th>
                                        <th>私信</th>
                                        <th>举报时间</th>
										<pe:permission key="banUser">
											<th>操作</th>
										</pe:permission>
									</tr>
								</thead>
								<tbody id="tbodys">
									<c:forEach items="${list}" var="obj">
										<tr>
                                            <td>
                                                <input type="checkbox" name="id" id="id" value="${obj.id}"/>
                                            </td>
											<td>${obj.id}</td>
											<td>
												<a href="${BasePath }/custom/userList?type=4&itemId=20&uid=${obj.uid}"  target="_black">${obj.uid }</a><br>
												${obj.nick}<br>
												<a href="${BasePath }/audit/topicList?uid=${obj.uid}&type=8&itemId=43&status=-1">她的全部话题</a><br>
												<a href="${BasePath }/audit/replyList?uid=${obj.uid}&type=8&itemId=44&status=-1">她的全部回复</a>
											</td>
											<td>
<!-- 												<table class="table table-hover"> -->
													<c:forEach items="${obj.conlist}" var="con">
														<c:if test="${con.tag==1 }">
<!-- 															<tr><td> -->
																<textarea style="width:400px;height:50px;" readonly="" >${con.content}</textarea><br>
<!-- 															</td><tr> -->
														</c:if>
													</c:forEach>
<!-- 												</table> -->
												<c:forEach items="${obj.conlist}" var="con">
													<c:if test="${con.tag==2 }">
														<a href="${con.content}" rel="lightbox[ostec]">
                                                        	<img src="${con.content}" width="120px" height="120px">&nbsp;
                                                    	</a>
													</c:if>
												</c:forEach>
											</td>
											<td><script>formatTime("${obj.dateline}");</script></td>
											<pe:permission key="banUser">
												<td nowrap="true" style="vertical-align:middle">
												
													<c:if test="${status==0 }">
														<button class="btn btn-success btn-small" onclick="openModel('${BasePath}/imReportLog/toBanUser?uid=${obj.uid }&nick=${obj.nick}','封禁用户','50%','50%')">封禁用户</button>
													</c:if>
                                                </td>
											</pe:permission>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							<div class="pagination pagination-centered" id="pager"></div>
							<script type="text/javascript">
								var sign = 0;
								window.onload = function() {
									PAGER.initPager('${start}', ' ${total}',
											'${limit}', 8, 'pager', getData);
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

<jsp:include page="../include/bottom.jsp" />


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
    $("#tbodys tr").click(function () {
        var chks = $(':checkbox', this);
        chks.prop('checked', !chks[0].checked);
    });

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

	function submitForm() {
		// $("#sign").val("2");
		$("#myForm").submit();
	}
	
	function hlP(){
         
		var status=$("#status").val();
		
		if(status != 0){
			alert("请查询待审核项!");
			return false;
		}
		
         var ids = new Array();
         $("input[name='id']:checked").each(function () {
             var txt = $(this).val();
             ids.push(txt);
         });
         
         if (ids.length == 0) {
             alert("请选择需要操作的数据！");
             return false;
         }else if (!confirm('您确定忽略？')) {
             return false;
         }
		
         $.post('${BasePath}/imReportLog/updateStatus?ids=' + ids, {
             'status':2
         }, function (data) {
             var obj = eval(data);
             if (obj.errno == 0) {
                 window.location.reload();
             } else {
                 alert(obj.errdesc);
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

</script>