<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="/permission" prefix="pe" %>
<%@ taglib prefix="e" uri="https://www.owasp.org/index.php/OWASP_Java_Encoder_Project" %>
<jsp:include page="../include/top.jsp"/>
<link href="${BasePath}/js/mediabox/css.css" rel="stylesheet" media="screen">
<!-- Body -->
<div class="container-fluid">
    <div class="row-fluid">
        <!-- Menu -->
        <jsp:include page="../include/menu.jsp"/>
        <div class="span9" id="content">
            <jsp:include page="../include/location.jsp"/>
            <div class="row-fluid">
                <div class="span12">

                    <div class="block">
                        <div class="navbar navbar-inner block-header" style="border-bottom: none;">
                            <form action="${BasePath}/weixinarticle/list?type=${type}&itemId=${itemId}" method="post" id="myform" class="form-search">
                                uid：<input type="text" name="uid" id="uid" value="${uid}"/>
                                公众号：<input type="text" name="name" id="name" value="${name}"/>
                                标题：<input type="text" name="title" id="title" value='${title}' class="span3"/>
                                <input type="hidden" name="start" id="start" value="${start }"/>
                                <input type="hidden" name="limit" id="limit" value="${limit }"/>
                                <input type="submit" class="btn btn-small btn-success" value="查询"/>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <div class="muted pull-left">
                            徽信文章列表<br>
                        </div>
<!--                         <div class="pull-right"> -->
<!--                             <button class="btn btn-success btn-small" style="margin-top: -5px" id="btnSelectAll" onclick="selectAll()">全选</button> -->
<%--                             <pe:permission key="delete"> --%>
<!--                             	<button class="btn btn-success btn-small" style="margin-top: -5px" id="btnDelAll" onclick="delByIds()">删除</button> -->
<%--                             </pe:permission> --%>
<!--                           </div> -->
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table class="table table-hover">
                                <thead>
                                <tr>
<!--                                 	<th></th> -->
                                    <th>ID</th>
                                    <th>标题</th>
                                    <th>公众号</th>
                                    <th>抓取取时间</th>
                                    <th>状态</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody id="tbodys">
                                <c:forEach items="${list}" var="obj">
                                    <tr>
<!--                                     	<td> -->
<%--                                     		<c:if test="${obj.name == '' }"> --%>
<%-- 													<input type="checkbox" name="id" id="id" value="${obj.id}"/>                                    		 --%>
<%--                                     		</c:if> --%>
<!--                                     	 </td> -->
                                        <td>${obj.id}</td>
                                        <td>${obj.title}</td>
                                        <td>${obj.name}</td>
                                        <td><script>formatTime("${obj.createtime}");</script></td>
                                        <td>
                                        	<c:if test="${obj.status == 0 }">
                                        		未发布
                                        	</c:if>
                                        	<c:if test="${obj.status != 0 }">
                                        		已发布
                                        	</c:if>
                                        </td>
                                        <td>
                                        		<pe:permission key="update">
                                        			<c:if test="${obj.status == 0 }">
														<a class="btn btn-success btn-small" href="${BasePath}/topicArticle/weixinToAdd?id=${obj.id}" target="_black">编辑</a>                                 		
                                        			</c:if>
                                        		</pe:permission>
<%--                                         		<pe:permission key="delete"> --%>
<%--                                         			<c:if test="${obj.name == '' }"> --%>
<%--                                         				<a class="btn btn-success btn-small" onclick="delById(${obj.id})">删除</a> --%>
<%--                                         			</c:if> --%>
<%--                                         		</pe:permission> --%>
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
<jsp:include page="../include/bottom.jsp"/>

<script type="text/javascript">


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

function delById(id){
	ajaxDelByIds(id);
}

function delByIds() {
    var ids = new Array();
    $("input[name='id']:checked").each(function () {
        var txt = $(this).val();
        ids.push(txt);
    });
    if (ids.length == 0) {
        alert("您还未选择要删除的文章？");
        return false;
    }
    ajaxDelByIds(ids);
}

 function ajaxDelByIds(ids){
		$.ajax({
			type: "POST",
			url: "${BasePath}/weixinarticle/delByIds?ids=" + ids,
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

</script>
