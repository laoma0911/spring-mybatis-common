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
                            <form id="myForm"  name="myForm"  action="${BasePath}/topicArticle/list" method="post" class="form-inline">
                                <table>
                                    <tr>
                                        <td style="vertical-align: middle;">标签：</td>
                                        <td>
                                            <select name="tagId" id="tagId" class="input-medium search-query inline">
                                                <option value="">全部</option>
                                                <c:forEach items="${tagList}" var="tag">
                                                    <option value="${tag.id}"
                                                            <c:if test="${tagId==tag.id}"> selected="selected"</c:if> >${tag.tag}
                                                    </option>
                                                </c:forEach>
                                            </select>
                                        </td>
                                        <td style="vertical-align: middle;">话题ID：</td><td><input type="text" name="topicId" value="${topicId }" /></td>
                                        <td style="vertical-align: middle;">话题标题：</td><td><input type="text" name="title" value="${title }" /></td>
                                        <td style="vertical-align: middle;">是否推荐到最热：</td>
                                        <td>
                                            <select id="queryType" name="queryType">
                                                <option value="9">全部</option>
                                                <option value="1"
                                                        <c:if test="${queryType==1}">selected="selected" </c:if> >已推荐
                                                </option>
                                                <option value="0"
                                                        <c:if test="${queryType==0}">selected="selected" </c:if> >未推荐
                                                </option>
                                            </select>
                                        </td>
                                        <td style="vertical-align: middle;">小标签：</td><td><input type="text" name="label" value="${label}" /></td>
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
                        <div class="muted pull-left">内容分布列表</div>
                        <div class="pull-right">
                            <pe:permission key="add">
                                <a class="btn btn-success btn-small inline" style="margin-top: -5px" href="${BasePath}/topicArticle/toAdd" target="_black">新增</a>
                            </pe:permission>
                        </div>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table class="table table-hover">
                                <thead>
                                <tr>
                                    <th>文章ID</th>
                                    <th>标签</th>
                                    <th width="15%">标题</th>
                                    <th>封面图</th>
                                    <th>首图</th>
                                    <th>发布时间</th>
                                    <th>推荐到热门时间</th>
                                    <th>是否推荐到热门</th>
                                    <pe:permission key="lookData">
                                        <th>浏览量|回复量</th>
                                        <th>UV|UR</th>
                                        <th>收藏数</th>
                                    </pe:permission>
                                    <th>小标签</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody id="tbodys">
                                <c:forEach items="${articleList}" var="obj">
                                    <tr>
                                        <td class="id">${obj.id}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${obj.tagName!=null && obj.tagName!=''}">
                                                    ${obj.tagName}
                                                </c:when>
                                                <c:otherwise>
                                                    ${obj.tagId}<font color="#dc143c">(已删)</font>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${obj.topicId!=null && obj.topicId>0 }">
                                                    ${obj.topicId}<br>
                                                    <a target="_blank" href="${BasePath }/topic/topicDetail?topicId=${obj.topicId}&type=${type}&itemId=${itemId}">
                                                            ${obj.title }</a>
                                                </c:when>
                                                <c:otherwise>
                                                    ${obj.title}
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:if test="${obj.pic!=null && obj.pic!=''}">
                                                <img src="${imageHost}${obj.pic}" width="100px" height="100px">
                                            </c:if>
                                        </td>
                                        <td>
                                            <c:if test="${obj.firstPic!=null && obj.firstPic!=''}">
                                                <img src="${imageHost}${obj.firstPic}" width="100px" height="100px">
                                            </c:if>
                                        </td>
                                        <td>
                                            <script>formatTime("${obj.publishTime}");</script>
                                        </td>
                                        <td>
                                            <c:if test="${obj.recommendDate != 0}">
                                                <script>formatTime("${obj.recommendDate}");</script>
                                            </c:if>
                                        </td>

                                        <td>
                                            <c:if test="${obj.topicId>0 && obj.flag==1 }">
                                                <font color="green">已推荐</font>
                                            </c:if>
                                            <c:if test="${obj.topicId>0 && obj.flag==0 }">
                                                <font color="#dc143c">未推荐</font>
                                            </c:if>
                                        </td>
                                        <pe:permission key="lookData">
                                            <td>${obj.viewNum} | ${obj.replyNum}</td>
                                            <td>${obj.uv} | ${obj.ur}</td>
                                            <input type="hidden" name="topicId" value="${obj.topicId}"/>
                                            <td id="favId_${obj.topicId}"></td>
                                        </pe:permission>
                                        <td>
                                            <c:forEach items="${obj.labelList}" var="labelObj">
                                                <a href="${BasePath}/topicArticle/list?type=${type}&itemId=${itemId}&labelId=${labelObj.id}">${labelObj.labelName}</a><br/>
                                            </c:forEach>
                                        </td>
                                        <td>
                                            <pe:permission key="update">
                                                <a class="btn btn-success btn-small" href="${BasePath}/topicArticle/toModify?id=${obj.id}"
                                                   target="_black">修改</a>
                                            </pe:permission>
                                            <pe:permission key="delete">
                                                <button class="btn del btn-danger btn-small">删除</button>
                                            </pe:permission>

                                            <pe:permission key="recommended">
                                                <c:if test="${obj.flag==1 }">
                                                    <a class="btn btn-small btn-danger" onclick="cancelHot(${obj.id})">取消到热门</a>
                                                </c:if>

                                                <c:if test="${obj.flag==0 && obj.topicId>0}">
                                                    <a class="btn btn-small btn-success" onclick="openDate(${obj.id},1)">推荐到热门</a>
                                                </c:if>
                                            </pe:permission>
                                            <pe:permission key="syncGdTopic">
                                            <c:if test="${obj.topicId>0}">
                                                <c:choose>
                                                    <c:when test="${obj.gdTopicId>0}">
                                                        <a class="btn btn-small btn-danger" onclick="syncGdTopic(${obj.topicId},${obj.id},2)">取消到美月</a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a class="btn btn-small btn-success" onclick="syncGdTopic(${obj.topicId},${obj.id},1)">同步到美月</a>
                                                    </c:otherwise>
                                                </c:choose>
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
                    <form class="form-horizontal" id="recommendForm" name="recommendForm" action="${BasePath }/topicArticle/syncToTopicTagRecommend" enctype="multipart/form-data" method="post">
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
    function openDate(id, picType) {
        $.post('${BasePath}/topicArticle/getPic', {'id': id, 'picType': picType}, function (data) {
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
        if (picType == 1) {
            $("#tipSpan").html("最小750*525");
        } else {
            $("#tipSpan").html("最小为640*384");
        }
        $("#id").val(id);
        $('#dateModel').modal('show');
    }
    //同步到美月  type=1 同步  type=2 取消
    function syncGdTopic(topicId,articleId,type){
        $.post('${BasePath}/topicArticle/syncTopicToGdTopic', {'topicId': topicId,'articleId':articleId,'type':type}, function (data) {
            var obj = eval(data);
            if (obj.errno == 0) {
                alert("操作成功！");
                window.location.reload();
            } else {
                alert("操作失败！");
            }
        });
    }
    function picTypeChange() {
        var id = $("#id").val();
        var picType = $("#picType").val();
        $.post('${BasePath}/topicArticle/getPic', {'id': id, 'picType': picType}, function (data) {
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
            $("#tipSpan").html("最小为640*384");
        }
    }
    //保存
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
            $.post('${BasePath}/topicArticle/cancelTopicTagRecommend', {'id': id
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
    // 删除记录
    $(function () {
        $(".del").bind('click', function () {
            if (!confirm('确定删除该条记录吗？')) {
                return false;
            }
            var id = $(this).parent().parent().find(".id").text();
            var tr = $(this).parent().parent();
            $.post('${BasePath}/topicArticle/delete', {
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
</script>