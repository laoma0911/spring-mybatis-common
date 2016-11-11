<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="/permission" prefix="pe" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../include/top.jsp"/>
<!-- Body -->
<div class="container-fluid">
    <div class="row-fluid">
        <!-- Menu -->
        <jsp:include page="../include/menu.jsp" />
        <div class="span9" id="content">
            <jsp:include page="../include/location.jsp" />
            <div class="row-fluid">
                <div class="span12">
                    <div class="block"  >
                        <div class="navbar navbar-inner block-header"  style="border-bottom: none;" >
                            <form id="myForm"  name="myForm"  action="${BasePath}/kolTopicArticle/list" method="post" class="form-inline">
                                <table>
                                    <tr>
                                    	<td style="vertical-align: middle;">开始时间：</td>
                                    	<td><input type="text" class="Wdate" id="startDate" name="startDate"  value="${startDate }" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'endDate\')}',readOnly:'false'})" /></td>
                                    	<td style="vertical-align: middle;">结束时间：</td>
                                    	<td><input type="text" class="Wdate" id="endDate" name="endDate" value="${endDate }" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'startDate\')}',maxDate:'%y-%M-%d %H:%m:%s',readOnly:'false'})" /></td>
                                        <td style="vertical-align: middle;">标题：</td><td><input type="text" name="title" value="${title }" /></td>
                                        <td>&nbsp;<input type="submit" value="查询" /></td>
                                    </tr>
                                </table>
                                <input type="hidden" name="start" id="start" value="${start }"/>
                                <input type="hidden" name="limit" id="limit" value="${limit }"/>
                                <input type="hidden" name="type" id="type" value="${type }"/>
                                <input type="hidden" name="itemId" id="itemId" value="${itemId }"/>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <div class="muted pull-left">话题列表</div>
                        <div class="pull-right">
                        </div>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table class="table table-hover">
                                <thead>
                                <tr>
                                    <th>序号</th>
                                    <th>标题</th>
                                    <th>浏览量</th>
                                    <th>回复量</th>
                                    <th>收藏量</th>
                                    <th>分享量</th>
                                    <th>发布时间</th>
                                    <th>推荐到热门</th>
                                    <th>同步到客户端</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody id="tbodys">
                                <c:forEach items="${list}" var="obj">
                                    <tr>
                                        <td class="id">${obj.id}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${obj.topicId!=null && obj.topicId>0 }">
                                                    ${obj.topicId}<br>
                                                    <a target="_blank" href="${BasePath }/topic/topicDetail?topicId=${obj.topicId}&type=${type}&itemId=${itemId}">${obj.title }</a>
                                                </c:when>
                                                <c:otherwise>
                                                    ${obj.title}
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${obj.viewNum}</td>
                                        <td>${obj.replyNum}</td>
                                        <input type="hidden" name="topicId" value="${obj.topicId}"/>
                                         <td id="favId_${obj.topicId}"></td>
                                         <td>分享量</td>
                                         <td><script>formatTime("${obj.publishTime}");</script></td>
                                         <td>
                                         	<c:if test="${obj.flag==1 }"><font color="green">已推荐</font></c:if>
                                            <c:if test="${obj.flag==0 }"><font color="#dc143c">未推荐</font></c:if>
                                         </td>
                                        <td>
                                        	<c:if test="${obj.syncClient==1 }"><font color="green">已同步</font></c:if>
                                            <c:if test="${obj.syncClient==0 }"><font color="#dc143c">未同步</font></c:if>
                                        </td>
                                        <td>
	                                        <pe:permission key="update">
                                        		<a class="btn btn-success btn-small" href="${BasePath}/kolTopicArticle/toModify?id=${obj.id}" target="_black">编辑</a>
                                        	</pe:permission>
                                        	<pe:permission key="delete">
                                        		<button class="btn del btn-danger btn-small">删除</button>
                                        	</pe:permission>
                                        	<pe:permission key="recommended">
	                                       	    <c:if test="${obj.flag==1 }"><a class="btn btn-small btn-danger" onclick="cancelHot(${obj.id})">取消到热门</a></c:if>
	                                            <c:if test="${obj.flag==0 }"><a class="btn btn-small btn-success" onclick="openDate(${obj.id},1)">推荐到热门</a></c:if>
                                            </pe:permission>
                                            <pe:permission key="syncClient">
                                            	<c:if test="${obj.syncClient==0 }"><a class="btn btn-small btn-danger" onclick="sClient(${obj.id})">同步到客户端</a></c:if>
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
<jsp:include page="../include/bottom.jsp"/>

<div class="container-fluid">
    <div class="row-fluid">
        <div class="span12">
            <div id="dateModel" class="modal hide fade" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h3 id="myModalLabel">
                        推荐到热门
                    </h3>
                </div>
                <div class="modal-body">
                    <div class="alert alert-error" id="alertErr" style="display: none;">
                        <%--<button class="close" data-dismiss="alert">×</button>--%>
                        <strong>Error!</strong> <span id="errodesc">This is an error message.</span>
                    </div>
                    <form class="form-horizontal" id="recommendForm" name="recommendForm" action="${BasePath }/kolTopicArticle/syncToTopicTagRecommend" enctype="multipart/form-data" method="post">
                        <p>
                            推荐日期：<input type="text" style="width: auto;" id="date" name="date"
                                        onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:00',readOnly:'false'})" class="Wdate"
                                        onClick="WdatePicker()"/>
                            <input type="hidden" id="id" name="id" value=""/>
                            <input type="hidden" id="havePic" name="havePic" value="0"/>
                        </p>

                        <p>
                            推荐模式：<select id="picType" name="picType" onchange="picTypeChange()">
                            <option value="1">小图模式</option>
                            <option value="2">大图模式</option>
                        </select>
                        </p>
                        <p>
                            <img id="smallPic" src="" width="100px" height="100px"/>
                        </p>
                        <p>
                            <input class="input-xlarge focused" name="pic" id="pic" value="" type="file"/><span id="tipSpan" style="color: #ff0000">图片规格：500*500</span>
                        </p>
                    </form>
                </div>
                <div class="modal-footer">
                    <button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
                    <button onclick="saveDate()" class="btn btn-primary">保存</button>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $(function () {
        //异步统计收藏数
        $("input[name='topicId']").each(function () {
            var id = this.value;
            $.post('${BasePath}/article/getClickNum', {'id': id}, function (data) {
                var obj = eval(data);
                if (obj.errno == 0) {
                    $("#favId_" + id).html(obj.fav);
                }
            });
        });
    });
    
 // 删除记录
    $(function () {
        $(".del").bind('click', function () {
            if (!confirm('确定删除该条记录吗？')) {
                return false;
            }
            var id = $(this).parent().parent().find(".id").text();
            var tr = $(this).parent().parent();
            $.post('${BasePath}/kolTopicArticle/delete', {
                'id': id
            }, function (data) {
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
    
	//获取推荐模式中图片   1:小图 2:头图
    function openDate(id) {
		//默认选中第一个小图模式
   	  var select = document.getElementById("picType");  
   	  select.options[0].selected = true;  
		
        $.post('${BasePath}/kolTopicArticle/getPic', {'id': id, 'picType': 1}, function (data) {
            var obj = eval(data);
            if (obj.errno == 0 && obj.pic != '') {
                $("#smallPic").attr("src", obj.pic);
                $("#smallPic").show();
                $("#havePic").val(1);
            } else {
                $("#smallPic").hide();
                $("#havePic").val(0);
            }
        });
        $("#id").val(id);
        $('#dateModel').modal('show');
    }
	//切换小图大图模式
    function picTypeChange() {
        var id = $("#id").val();
        var picType = $("#picType").val();
        $.post('${BasePath}/kolTopicArticle/getPic', {'id': id, 'picType': picType}, function (data) {
            var obj = eval(data);
            if (obj.errno == 0 && obj.pic !='') {
                $("#smallPic").attr("src", obj.pic);
                $("#smallPic").show();
                $("#havePic").val(1);
            } else {
                $("#smallPic").hide();
                $("#havePic").val(0);
                $("#smallPic").attr("src", "");
            }
        });
        if (picType == 1) {
            $("#tipSpan").html("最小750*525");
        } else {
            $("#tipSpan").html("尺寸为640*384");
        }
    }
	
    //保存推荐到热门信息
    function saveDate() {
        var date = $("#date").val();
        var id = $("#id").val();
        var havePic =$("#havePic").val();
        var pic=$("#pic").val();
        if (date == "") {
            alert("请选择时间！");
            return false;
        }
        if(pic=='' && havePic==0){
            alert("请上传图片！");
            return false;
        }
        $('#recommendForm').ajaxSubmit(function (data) {
            if (data.errno == 1) {
                $("#alertErr").show();
                $("#errodesc").html(data.errdesc);
            } else {
                alert("操作成功！");
                window.location.reload();
            }
        });
    }

    //取消推荐到热门
    function cancelHot(id) {
        if (confirm("确定要取消到是热门吗？")) {
            $.post('${BasePath}/kolTopicArticle/cancelTopicTagRecommend', {'id': id
            }, function (data) {
                var obj = eval(data);
                if (obj.errno == 0) {
                    window.location.reload(true);
                } else {
                    alert(obj.errdesc);
                }
            });
        }
    }
    
    //同步到客户端 
    function sClient(id){
    	$.post('${BasePath}/kolTopicArticle/syncClient', {
            'id': id
        }, function (data) {
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