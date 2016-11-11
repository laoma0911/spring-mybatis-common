<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="/permission" prefix="pe" %>
<%@ taglib prefix="e" uri="https://www.owasp.org/index.php/OWASP_Java_Encoder_Project" %>
 <jsp:include page="/jsp/include/head.jsp"/> 
<jsp:include page="/jsp/include/model.jsp"/>
<link href="${BasePath}/bootstrap/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">

<link href="${BasePath}/js/mediabox/css.css" rel="stylesheet" media="screen">
<div class="container-fluid">
    <div class="row-fluid">
        <!-- Menu -->
        <div class="span15" id="content">
            <div class="row-fluid">
                <div class="span12">
                    <div class="block">
                        <div class="navbar navbar-inner block-header" style="border-bottom: none;">
                            <pe:permission key="deleteTopic">
                                <strong>话题操作：</strong>
                                <c:choose>
                                    <c:when test="${topic.status==0 }">
                                        <input class="btn del btn btn-danger btn-small" type="button" value="删除"
                                               onclick="delTopic()"/>
                                    </c:when>
                                    <c:when test="${topic.status==1 }">
                                        <input class="btn del btn btn-primary btn-small" type="button" value="恢复"
                                               onclick="cancelTopic()"/>
                                    </c:when>
                                </c:choose>
                            </pe:permission>

                            <pe:permission key="reply">
                                <a class="btn cancel btn btn-primary btn-small"
                                   href="javascript:openModel('${BasePath}/topic/toReply?replyId=${reply.id}&sign=0&topicId=${topic.id}','回复','50%','65%')">回复</a>
                            </pe:permission>
                            
                             <pe:permission key="down">
                             	<c:if test="${topicLock == 0}">
                            	<input class="btn del btn btn-primary btn-small" type="button" value="下沉" onclick="setIsdown(1,${topic.id})"/>
	                            </c:if>
	                            <c:if test="${topicLock == 1}">
	                            	<input class="btn del btn btn-primary btn-small" type="button" value="取消下沉"  onclick="setIsdown(0,${topic.id})"/>
	                            </c:if>
                             </pe:permission>
                                       
                             <pe:permission key="lock">
                             			 <c:if test="${topic.lock == 0}">
			                             	<input class="btn del btn btn-primary btn-small" type="button" value="锁定" onclick="lockSt(1,${topic.id})"/>
			                             </c:if>
			                             <c:if test="${topic.lock == 1}">
			                             	<input class="btn del btn btn-primary btn-small" type="button" value="解锁"  onclick="lockSt(0,${topic.id})"/>
			                             </c:if>
                             </pe:permission>

                            <pe:permission key="hidden">
                                <c:if test="${topic.hidden == 0}">
                                    <input class="btn del btn btn-primary btn-small" type="button" value="隐藏" onclick="hiddenTopic(1,${topic.id})"/>
                                </c:if>
                                <c:if test="${topic.hidden == 1}">
                                    <input class="btn del btn btn-primary btn-small" type="button" value="取消隐藏"  onclick="hiddenTopic(0,${topic.id})"/>
                                </c:if>
                            </pe:permission>
                                           
                            <br>
                            <br>
                            话题ID：${topic.id} <input type="hidden" name="topicId" id="topicId"
                                                                               value="${topic.id}"/>
                            &nbsp;&nbsp;&nbsp;发表时间：
                            <script>formatTime("${topic.dateline}");</script>
                            &nbsp;&nbsp;&nbsp;最后回复时间：
                            <script>formatTime("${topic.lastreplytime}");</script>
                            &nbsp;&nbsp;&nbsp; 回复数：${topic.replynum}
                            <br>
                            楼主UID：<a href="${BasePath }/custom/userList?type=4&itemId=20&uid=${user.uid} "  target="_black">${user.uid }</a><input type="hidden" name="uid" id="uid" value="${user.uid}"/>&nbsp;&nbsp;&nbsp;
                            昵称：${user.nick}<br>
                            标题：<e:forHtml value="${topic.title}"/>
                            <c:if test="${topic.status == 1}"><font
                                    style="color: #ff0000">[删]</font></c:if>
                            <c:if test="${topic.lock == 1}"><font
                                    style="color: #ff0000">[锁]</font></c:if>
                            <c:if test="${topicLock == 1}"><font
                                    style="color: #ff0000">[沉]</font></c:if>
                            <c:if test="${topic.settop == 1}">
                                <font style="color: #ff0000">[小组置顶]</font>
                            </c:if>
                            <c:if test="${topic.settop == 2}">
                                <font style="color: #ff0000">[公告置顶]</font>
                            </c:if>
                            <br>
                            头图:
                            <c:if test="${headPic != null}">
                                <a href="${headPic.oriPic}" rel="lightbox[ostec]">
                                    <img id="${headPic.id}" src="${headPic.pic}" width="100px" height="100px">
                                </a>
                            </c:if>
                            <c:if test="${headPic == null}"><font color="red">无</font></c:if>
                            <br>
                            <c:if test="${not empty topic.content}">
                                <strong>
                                    <%--<c:if test="${settingsType == 1}">--%>
                                        <pre>${topic.content}</pre>
                                    <%--</c:if>--%>
                                    <%--<c:if test="${settingsType == 0}">--%>
                                        <%--<pre><e:forHtml value="${topic.content}"/></pre>--%>
                                    <%--</c:if>--%>
                                </strong>
                                <br>
                            </c:if>
                            <!--投票统计-->
                            <c:if test="${voteItemList!=null}">
                                <table>
                                <tr bgcolor="#7fffd4" >
                                    <td colspan="3">投票详情</td>
                                </tr>
                                <c:forEach items="${voteItemList}" var="item" varStatus="status">
                                    <tr bgcolor="#f0f8ff">
                                        <td colspan="2">${status.index+1}.${item.title} <span style="color: royalblue">${item.num}票 ${item.bili}%</span> </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <div class="progress">
                                                <div class="bar" style="width: ${item.bili}%;"></div>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </table>
                            </c:if>
                            <c:forEach items="${topicPics}" var="topicPic">
                                <c:if test="${not empty topicPic.pic}">
                                    <div class="btn-group btn-group-vertical">

                                        <a href="${topicPic.oriPic}" rel="lightbox[ostec]">
                                            <img id="${topicPic.id}" src="${topicPic.pic}" width="150px" height="150px">&nbsp;&nbsp;
                                        </a>
                                        <pe:permission key="deleteTopicPic">
                                            <c:choose>
                                                <c:when test="${settingsType == 0 and topicPic.status!=1}">
                                                    <input id="delPicId" class="btn del btn btn-danger btn-small"
                                                           type="button"
                                                           value="删除" onclick="deltopicpic('1','${topicPic.id}','')"
                                                           style="margin-left: auto; margin-right: auto;margin-top: 10px; margin-bottom: 10px;"/>
                                                </c:when>
                                                <c:when test="${settingsType == 0 and topicPic.status==1}">
                                                    <input class="btn del btn btn-primary btn-small" type="button"
                                                           value="恢复"
                                                           onclick="deltopicpic('0','${topicPic.id}','')"
                                                           style="margin-left: auto; margin-right: auto;margin-top: 10px; margin-bottom: 10px;"/>
                                                </c:when>
                                            </c:choose>
                                        </pe:permission>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>
                </div>


                <div class="block">
                    <div class="navbar navbar-inner block-header" style="border-bottom: none;">

                        <form id="saveCustom" name="saveCustom" action="${BasePath }/topic/exportTopicReplys">
                            回复操作：
                            <input type="hidden" name="topicId" value="${topic.id}"/>

                            <button class="btn btn-success btn-small" style="margin-top: -5px" id="btnSelectAll" onclick="selectAll()">全选
                            </button>
                            <pe:permission key="deleteReply">
                                <button class="btn btn-danger btn-small" style="margin-top: -5px" onclick="deleteAll()">删除</button>
                            </pe:permission>
                            <pe:permission key="updateReply">
                                <button class="btn btn-success btn-small" style="margin-top: -5px" onclick="cancelAll()">恢复删除</button>
                            </pe:permission>
                            <pe:permission key="hiddenReply">
                                <button class="btn btn-danger btn-small" style="margin-top: -5px" onclick="hiddenReply(1)">隐藏
                                </button>
                                <button class="btn btn-success btn-small" style="margin-top: -5px" onclick="hiddenReply(0)">取消隐藏
                                </button>
                            </pe:permission>
                            排序:
                            <select name="sort" id="sort" onchange="toSort()">
                                <option <c:if test="${sort==0 }">selected="selected" </c:if> value="0">最新回复</option>
                                <option
                                        <c:if test="${sort==1 }">selected="selected" </c:if>
                                        value="1">最赞回复
                                </option>
                            </select>
                            <pe:permission key="exportReply">
                                <button class="btn btn-success btn-small" style="margin-top: -5px"
                                        onclick="exportTopicReplys()">导出回复
                                </button>
                            </pe:permission>
                        </form>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table class="table table-hover">
                                <thead>
                                <tr>
                                    <th></th>
                                    <th style="width: 5%">楼层ID</th>
                                    <th style="width: 20%">层主信息</th>
                                    <th style="width: 45%;">回复内容</th>
                                    <th style="width: 20%">回复图片</th>
                                    <th style="width: 10%">操作</th>
                                </tr>
                                </thead>
                                <tbody id="tbodys">
                                <c:forEach items="${replyResult}" var="reply">
                                    <tr>
                                        <td>
                                            <input type="checkbox" name="replyId" id="replyId"
                                                   value="${reply.replyId}_${reply.uid}_${reply.status}"/>
                                        </td>
                                        <td>
                                                ${reply.id}
                                            <br>
                                            <br>
                                            <c:if test="${reply.hidden==1}">
                                                <font color="red">[已隐藏]</font>
                                            </c:if>
                                        </td>
                                        <td>
                                            时间：
                                            <script>formatTime("${reply.createTime}");</script>
                                            <br>
                                            UID：<a href="${BasePath }/custom/userList?type=4&itemId=20&uid=${reply.uid}"
                                                   target="_black">${reply.uid} </a><br>
                                            昵称：${reply.nick}<br>
                                        </td>
                                        <td>
                                                ${reply.floor}楼
                                            &nbsp;&nbsp;${reply.currentLikeNum}赞<br>
                                            <c:if test="${not empty reply.replyToFloor}">
                                                回复${reply.replyToFloor}楼：
                                            </c:if>
                                                    <e:forHtml value="${reply.content}"/>${reply.emotion}
                                        </td>
                                        <td>
                                            <c:if test="${not empty reply.replyImg}">
                                                <div class="btn-group btn-group-vertical">
                                                    <a href="${reply.replyImg}" rel="lightbox[ostec]">
                                                        <div class="aixuexi">
                                                            <img src="${reply.replyImg}">
                                                        </div>
                                                    </a>
                                                    <pe:permission key="deleteReplyPic">
                                                        <c:choose>
                                                            <c:when test="${reply.replyPicStatus!=1}">
                                                                <input id="delPicId"
                                                                       class="btn del btn btn-danger btn-small"
                                                                       type="button"
                                                                       value="删除"
                                                                       onclick="deltopicpic('1','','${reply.replyPicId}')"
                                                                       style="margin-left: auto; margin-right: auto;margin-top: 10px; margin-bottom: 10px;"/>
                                                            </c:when>
                                                            <c:when test="${reply.replyPicStatus==1}">
                                                                <input class="btn del btn btn-primary btn-small"
                                                                       type="button"
                                                                       value="恢复"
                                                                       onclick="deltopicpic('0','','${reply.replyPicId}')"
                                                                       style="margin-left: auto; margin-right: auto;margin-top: 10px; margin-bottom: 10px;"/>
                                                            </c:when>
                                                        </c:choose>
                                                    </pe:permission>
                                                </div>
                                            </c:if>
                                        </td>
                                        <td style="vertical-align:middle">
                                            <c:choose>
                                                <c:when test="${reply.status==0 }">
                                                    <pe:permission key="deleteReply">
                                                        <input class="btn del btn btn-danger btn-small" type="button" value="删除"
                                                               onclick="deleteReply('${reply.replyId}_${reply.uid}')"/><br>
                                                    </pe:permission>
                                                </c:when>
                                                <c:when test="${reply.status==1 }">
                                                    <pe:permission key="updateReply">
                                                        <input class="btn cancel btn btn-primary btn-small" type="button"
                                                               value="恢复"
                                                               onclick="cancelReply('${reply.replyId}_${reply.topicId}')"/><br>
                                                    </pe:permission>
                                                </c:when>
                                            </c:choose>
                                            <pe:permission key="reply">
                                                <a class="btn cancel btn btn-primary btn-small"
                                                   href="javascript:openModel('${BasePath}/topic/toReply?replyId=${reply.id}&sign=0&topicId=${reply.topicId}','回复','50%','65%')">回复</a><br>
                                            </pe:permission>
                                            <pe:permission key="like">
                                                <input class="btn cancel btn btn-primary btn-small" type="button" value="点赞"
                                                       onclick="openModel('${BasePath}/topic/toReplyLike?replyId=${reply.replyId }&topicId=${reply.topicId }&uid=${reply.uid }','点赞','60%','60%')"/><br>
                                            </pe:permission>
                                            <pe:permission key="modifyReply">
                                                <a class="btn cancel btn btn-primary btn-small"
                                                   href="javascript:openModel('${BasePath}/topic/toReply?replyId=${reply.id}&sign=1&topicId=${reply.topicId}','编辑回复','50%','65%')">编辑</a><br>
                                            </pe:permission>
                                            <pe:permission key="hiddenReply">
                                                <c:choose>
                                                    <c:when test="${reply.hidden==1}">
                                                        <button class="btn btn-success btn-small" onclick="hiddenReply(0,${reply.id})">取消隐藏</button><br>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <button class="btn btn-danger btn-small" onclick="hiddenReply(1,${reply.id})">隐藏</button><br>
                                                    </c:otherwise>
                                                </c:choose>
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
                                        window.location.href = "${BasePath}/topic/topicDetail?topicId=${topic.id}&sort=${sort}&start=" + currentPage + "&limit=" + pageSize + "&type=${type}&itemId=${itemId}";
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
<jsp:include page="/jsp/include/bottom.jsp"/>
<script>

    function exportTopicReplys() {
        document.getElementById("saveCustom").submit();
    }


    // 隐藏帖子
    function hiddenReply(digest,replyId) {
        if(replyId>0){
            var path = "${BasePath}/topic/hiddenReply?replyIds=" + replyId + "&digest=" + digest;
            qqAjax(path);
        }else{
            var replyIdArry = new Array();
            $("input[name='replyId']:checked").each(function () {
                var txt = $(this).val();
                var date=txt.split("_");
                replyIdArry.push(date[0]);
            });
            if (replyIdArry.length == 0) {
                alert("请选择要操作的数据！");
                return false;
            }
            var path = "${BasePath}/topic/hiddenReply?replyIds=" + replyIdArry + "&digest=" + digest;
            qqAjax(path);
        }
    }


    // tr选中checkbox效果
    $('#tbodys tr').click(function () {
        var chks = $(':checkbox', this);
        chks.prop('checked', !chks[0].checked);
    })


    function toSort(){
        var sort = $("#sort").val();
        window.location.href="${BasePath}/topic/topicDetail?topicId=${topic.id}&sort="+sort+"&type=${type}&itemId=${itemId}";
    }

    function deltopicpic(obj, topicPicId, replyPicId) {
        var path = "${BasePath}/topic/updatePicStatus?picId=" + topicPicId + "&status=" + obj + "&replyPicId=" + replyPicId;
        $.ajax({
            type: "POST",
            url: path,
            datatype: "json",
            success: function (data) {
                if (data.errno == 1) {
                    alert(data.errdesc);
                } else {
                    window.location.reload();
                }
            },
            error: function () {
                alert("操作出错，请联系管理员！");
            }
        });
    }


    function delTopic(obj) {
        var topicId = $("#topicId").val();
        var uid = $("#uid").val();
        var path = "${BasePath}/topic/delTopic?topicId=" + topicId + "&uid=" + uid + "&type=${type}&itemId=${itemId}";
        $.ajax({
            type: "POST",
            url: path,
            datatype: "json",
            success: function (data) {
                if (data.errno == 1) {
                    $("#alertErr").show();
                    $("#errodesc").html(data.errdesc);
                } else {
                    window.location.reload();
                }
            },
            error: function () {
                alert("操作出错，请联系管理员！");
            }
        });
    }

    function cancelTopic() {
        var path = "${BasePath}/topic/cancelTopic?topicId=" + ${topic.id} +"&type=${type}&itemId=${itemId}";
        $.ajax({
            type: "POST",
            url: path,
            datatype: "json",
            success: function (data) {
                if (data.errno == 1) {
                    $("#alertErr").show();
                    $("#errodesc").html(data.errdesc);
                } else {
                    window.location.href = "${BasePath}/topic/topicDetail?topicId=${topic.id}&type=${type}&itemId=${itemId}";
                }
            },
            error: function () {
                alert("操作出错，请联系管理员！");
            }
        });
    }

    //全选
    function selectAll() {
        $("input[name='replyId']").each(function () {
            this.checked = true;
        });
        $("#btnSelectAll").html("取消全选");
        $("#btnSelectAll").attr("onclick", "cancelSelectAll()");
    }
    //取消全选
    function cancelSelectAll() {
        $("input[name='replyId']").each(function () {
            this.checked = false;
        });
        $("#btnSelectAll").html("全选");
        $("#btnSelectAll").attr("onclick", "selectAll()");
    }

    <!--全部删除-->
    function deleteAll() {
        var replyIdArry = new Array();
        $("input[name='replyId']:checked").each(function () {
            var txt = $(this).val();
            var status = txt.substr(txt.length - 1);
            if (status == '0') {
                replyIdArry.push(txt.substr(0, txt.length - 2));
            }
        });
        if (replyIdArry.length == 0) {
            alert("请选择要删除回复！");
            return false;
        }
        if (confirm("确定要删除吗？")) {
            var path = "${BasePath}/topic/deleteAll?replyIds=" + replyIdArry + "&type=${type}&itemId=${itemId}";
            $.ajax({
                type: "POST",
                url: path,
                datatype: "json",
                success: function (data) {
                    if (data.errno == 1) {
                        $("#alertErr").show();
                        $("#errodesc").html(data.errdesc);
                    } else {
                        window.location.reload();
                    }
                },
                error: function () {
                    alert("操作出错，请联系管理员！");
                }
            });
        }
    }
    <!--全部恢复-->
    function cancelAll() {
        var replyIdArry = new Array();
        $("input[name='replyId']:checked").each(function () {
            var txt = $(this).val();
            var status = txt.substr(txt.length - 1);
            if (status == '1') {
                replyIdArry.push(txt.substr(0, txt.length - 2));
            }
        });
        if (replyIdArry.length == 0) {
            alert("请选择需要操作的数据！");
            return false;
        }
        var path = "${BasePath}/topic/recoverReply?params=" + replyIdArry + "&type=${type}&itemId=${itemId}";
        $.ajax({
            type: "POST",
            url: path,
            datatype: "json",
            success: function (data) {
                if (data.errno == 1) {
                    $("#alertErr").show();
                    $("#errodesc").html(data.errdesc);
                } else {
                    window.location.reload();
                }
            },
            error: function () {
                alert("操作出错，请联系管理员！");
            }
        });
    }

    function deleteReply(replyIds) {
        var path = "${BasePath}/topic/deleteAll?replyIds=" + replyIds + "&type=${type}&itemId=${itemId}";
        $.ajax({
            type: "POST",
            url: path,
            datatype: "json",
            success: function (data) {
                if (data.errno == 1) {
                    $("#alertErr").show();
                    $("#errodesc").html(data.errdesc);
                } else {
                    window.location.href = "${BasePath}/topic/topicDetail?topicId=${topic.id}&type=${type}&itemId=${itemId}";
                }
            },
            error: function () {
                alert("操作出错，请联系管理员！");
            }
        });
    }

    function cancelReply(replyIds) {
        var path = "${BasePath}/topic/recoverReply?params=" + replyIds + "&type=${type}&itemId=${itemId}";
        $.ajax({
            type: "POST",
            url: path,
            datatype: "json",
            success: function (data) {
                if (data.errno == 1) {
                    $("#alertErr").show();
                    $("#errodesc").html(data.errdesc);
                } else {
                    window.location.reload();
                }
            },
            error: function () {
                alert("操作出错，请联系管理员！");
            }
        });
    }
    
    
    function setIsdown(isdown,id){
		var path = "${BasePath}/topic/shIsdownTopic?topicIds=" + id + "&isdown=" + isdown;
		qqAjax(path);
	}
    
    function lockSt(lock,id) {
		var path = "${BasePath}/topic/shLockTopic?topicIds=" + id + "&lock=" + lock;
		qqAjax(path);
	}

    function hiddenTopic(hidden,id) {
		var path = "${BasePath}/topic/hiddenTopic?topicIds=" + id + "&digest=" + hidden;
		qqAjax(path);
	}
    
    function qqAjax(path) {
		$.ajax({
			type: "POST",
			url: path,
			datatype: "json",
			success: function (data) {
				if (data.errno == 1) {
					  $("#alertErr").show();
	                  $("#errodesc").html(data.errdesc);
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

<script type="text/javascript">
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

<style>
    body {
        padding-top: 0px;
    }
</style>

