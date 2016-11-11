<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="/permission" prefix="pe" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../include/head.jsp"/>
<%-- <jsp:include page="../include/top.jsp"/> --%>
<script type="text/javascript" src="${BasePath }/js/kindeditor/kindeditor-min.js"></script>
<script type="text/javascript" src="${BasePath }/js/kindeditor/lang/zh_CN.js"></script>


<!-- Bootstrap -->
<script src="${BasePath}/bootstrap/bootstrap/js/bootstrap.min.js"></script>
<script src="${BasePath}/bootstrap/vendors/jquery-1.9.1.min.js"></script>
<link href="${BasePath}/bootstrap/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
<link href="${BasePath}/bootstrap/bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet" media="screen">
<link href="${BasePath}/bootstrap/vendors/easypiechart/jquery.easy-pie-chart.css" rel="stylesheet" media="screen">
<link href="${BasePath}/bootstrap/assets/styles.css" rel="stylesheet" media="screen">
<link href="${BasePath}/bootstrap/assets/table.css" rel="stylesheet" media="screen">
<link href="${BasePath}/css/css.css" rel="stylesheet" media="screen">

<%-- <link rel="stylesheet" href="${BasePath}/plugin/pages/pagination.css" media="all"/> --%>
<!--分页样式-->
<!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->

<script src="${BasePath}/js/fixedtoolbar.js"></script>
<script src="${BasePath}/js/pager.js"></script>
<script src="${BasePath}/js/utils.js"></script>
<script src="${BasePath}/js/My97DatePicker/WdatePicker.js"></script>
<script src="${BasePath}/bootstrap/vendors/modernizr-2.6.2-respond-1.1.0.min.js"></script>
<script src="${BasePath}/js/mediabox/mootools-core.js"></script>
<script src="${BasePath}/js/mediabox/mediabox.js"></script>


<script src="${BasePath}/js/jquery/form.js"></script>
<style>
    body {
        padding-top: 0px;
    }
</style>
<!-- Body -->
<div class="container-fluid">
    <div class="block">
        <div class="navbar navbar-inner block-header">
            <div class="muted pull-left">
                <input type="button" onclick="firstIndex()" value="刷新" class="btn btn-success btn-small"/>
            </div>
            <div class="muted pull-right">
                <input type="button" onclick="replySendClick(0,0)" value="发送" class="btn btn-success btn-small"/>
                <%--<button class="btn btn-success btn-small" id="btnSelectAll" onclick="selectAll()">全选</button>--%>
                <%--<input type="button" onclick="" value="隐藏" class="btn btn-success btn-small"/>--%>
                <%--<input type="button" onclick="" value="恢复" class="btn btn-success btn-small"/>--%>
            </div>
        </div>

        <div class="alert alert-error" id="alertErr" style="display: none;">
            <button class="close" data-dismiss="alert">×</button>
            <strong>Error!</strong> <span id="errodesc">This is an error message.</span>
        </div>
        <div class="block-content collapse in">
            <div>
                <table class="table table-hover">
                    <thead>
                    <tr>
                        <th>序号</th>
                        <th>层主信息</th>
                        <th>聊天内容</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody id="tbodys">
                    <c:forEach items="${rows}" var="obj" varStatus="aa">
                        <tr>
                            <td>
                                ${aa.index+1}
                                <%--<input type="checkbox" name="id" id="id" value="${obj.messageId}"/>--%>
                            </td>
                            <td>
                                时间:
                                <script>formatTime("${obj.dateline}");</script>
                                <br>
                                UID: <a href="${BasePath }/custom/userList?type=4&itemId=20&uid=${obj.uid} "  target="_black">${obj.uid }</a>
                                <br>
                                昵称:${obj.nick}
                            </td>
                            <td>
                                <c:if test="${obj.tag==0 }">
                                    ${obj.message }
                                </c:if>
                                <c:if test="${obj.tag==1 }">
                                    <c:if test="${obj.message.type==2 }">
                                        <img src="${obj.message.message }" width="160px" height="75px" onerror="deleteImg(this);" >
                                    </c:if>
                                    <c:if test="${obj.message.type==3 }">
                                        ${obj.message.message }
                                    </c:if>
                                    <c:if test="${obj.message.type==1}">
                                        ${obj.message.message }
                                    </c:if>
                                    <c:if test="${obj.message.type==4 }">
                                        <c:if test="${obj.message.message !=null && obj.message.message!=''}">
<%--   <font color="red">    ${obj.message.message} </font>--%>
                                            <audio controls="controls" autoplay="autoplay"  id="audio_${obj.messageId }"  src=""   >
                                                您的浏览器不支持 audio 标签
                                            </audio>
                                             时长：${obj.message.duration} 秒
                                            </c:if>
                                    </c:if>

                                    <c:if test="${obj.message.repliedUid!=0 }">
                                        <br>
                                        -----------------------------
                                        <br>
                                        <strong>${obj.message.repliedNick }</strong>
                                        <br>
                                        <c:if test="${obj.message.repliedMessageType==2 }">
                                            <img src="${obj.message.repliedMessage }" width="160px" height="75px">
                                        </c:if>
                                        <c:if test="${obj.message.repliedMessageType==1 }">
                                            ${obj.message.repliedMessage }
                                        </c:if>
                                        <c:if test="${obj.message.repliedMessageType==3 }">
                                            ${obj.message.repliedMessage }
                                        </c:if>
                                        <c:if test="${obj.message.repliedMessageType==4 }">
                                            <audio controls="controls" autoplay="autoplay"    src=""   >
                                                您的浏览器不支持 audio 标签
                                            </audio>
                                        </c:if>
                                    </c:if>

                                </c:if>
                            </td>
                            <td>
                           <input type="button" onclick="replySendClick(${obj.uid},${obj.messageId})" value="回复" class="btn btn-success btn-small"/>
                                <c:if test="${(obj.message.message !=null && obj.message.message !='')}">
                                    <input onclick="amrToMp3(${obj.messageId },'${obj.message.message}',this )"   <c:if test="${obj.message.type!=4 }"> type="hidden" </c:if>           <c:if test="${obj.message.type==4 }"> type="button" </c:if> value="播放语音" class="btn btn-small btn-danger"/>
                            <input  <c:if test="${obj.message.type!=2 }"> type="hidden" </c:if>           <c:if test="${obj.message.type==2 }">  type="button" </c:if>   onclick="delMsg(${obj.uid},${obj.messageId},'${obj.message.message }' );" value="删除图片" class=" btn btn-small btn-danger"/>
                            <input  <c:if test="${obj.message.type!=4 }"> type="hidden" </c:if>           <c:if test="${obj.message.type==4 }"> type="button" </c:if>  onclick="delMsg(${obj.uid},${obj.messageId},'${obj.message.message }' );" value="删除语音" class="btn btn-small btn-danger"/>

                                </c:if>



                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="muted pull-right">
                <form id="myForm" name="myForm" action="${BasePath}/groupchatconfig/groupChatRoom?conversationId=${conversationId }&type=${type}&itemId=${itemId}" method="post" class="form-inline">
                    <input type="hidden" id="dateline" name="dateline" value="${dateline }">
                    <input type="button" value="首页" onclick="firstIndex()" class="btn btn-success btn-small">
                    <input type="submit" id="nextindex" name="nextindex" value="下一页" class="btn btn-success btn-small">
                </form>
            </div>
        </div>
    </div>
    <!-- /block -->
</div>

<input type='button' id='addVote' name='addVote' data-toggle='modal' href='#modal-container-331250' value="abc" style='display:none'/>

<div class="container-fluid">
    <div class="row-fluid">
        <div class="span12">
            <div id="modal-container-331250" class="modal hide fade" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h3 id="myModalLabel">
                        发送
                    </h3>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" id="r_saveArticle" name="r_saveArticle" action="${BasePath}/groupchatconfig/send" method="post" enctype="multipart/form-data">
                        <div class="modal-body">
                            发送者：
                            <select name="officialUser" id="officialUser" onchange="changeReplyUser(this)">
                                <option value="请选择">请选择</option>
                                <c:forEach items="${userList}" var="obj">
                                    <option
                                            <c:if test="${obj.key == 1}">selected="selected" </c:if> value="${obj.key}">${obj.value}</option>
                                </c:forEach>
                            </select>
                            &nbsp;&nbsp;
                            <input type="hidden" id="conversationId" name="conversationId" value="${conversationId}"/>
                            <input type="hidden" id="uid" name="uid" value="${checkUser.uid}"/>
                            <input type="hidden" id="repliedUid" name="repliedUid" value=""/>
                            <input type="text" id="nick" name="nick" value="${checkUser.nick}" onblur="getNick()" style="width:30%;"/>
                        </div>
                        <div class="modal-body" id="repliedIdDiv">被回复楼层ID：<input type="text" id="repliedId" name="repliedId" readonly value=""/></div>
                        <div class="modal-body">发送内容:<textarea class="input-xlarge focused" id="message" name="message" rows="4" style="margin: 0px; width: 454px; height: 156px;"></textarea></div>
                        <div class="modal-body">图片:<input class="input-xlarge focused" name="pic" id="pic" type="file"/></div>
                    </form>
                    <input type="hidden" id="replyUserUid" name="replyUserUid"/>
                </div>
                <div class="modal-footer">
                    <button class="btn" id="replyclose" name="replyclose" data-dismiss="modal" aria-hidden="true">关闭</button>
                    <button class="btn btn-primary" onclick="sendMsg()">发送</button>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function delMsg(uid,msgId,message){
        var aj = $.ajax({
            url: '${BasePath}/groupchatconfig/delMsg?msgId='+msgId+'&uid='+uid+'&message='+message,
            type: 'post',
            cache: false,
            dataType: 'json',
            success: function (data) {
                if (data.errno == 0) {
                   alert("删除成功！");
                } else {
                    alert(data.errdesc);
                }
            },
            error: function () {
                alert("异常！");
            }
        });
    }
    function firstIndex() {
        $("#dateline").val('0');
        $('#nextindex').trigger("click");
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

    //发送
    function sendMsg() {
        var uid = $("#uid").val();
        if (uid == '') {
            alert("发送者UID不能为空！")
            return false;
        }
        var message = $("#message").val();
        var pic = $("#pic").val();
        if (message == "" && pic == "") {
            alert("请输入要发送的信息，或者上传图片！");
            return false;
        }
        $('#r_saveArticle').ajaxSubmit(function (data) {
            if (data.errno == 1) {
                alert(data.errdesc);
            } else {
                alert("操作成功！");
                $('#replyclose').trigger("click");
            }
        });
    }
    function replySendClick(repliedUid, repliedId) {
        if (repliedUid != 0) {
            $("#repliedId").val(repliedId);
            $("#repliedUid").val(repliedUid);
            $("#repliedIdDiv").show();
        } else {
            $("#repliedId").val("");
            $("#repliedUid").val("");
            $("#repliedIdDiv").hide();
        }
        $("#addVote").trigger("click");
    }
    function changeReplyUser(obj) {
        $("#alertErr").hide();
        var kind = obj.value;
        $('#uid').val("");
        $('#nick').val("");
        if (kind != '4') {
            $("#nick").attr("readonly", true);
        } else {
            $("#nick").attr("readonly", false);
        }
        //1.$.ajax带json数据的异步请求
        var aj = $.ajax({
            url: '${BasePath}/topic/getTopicReplyUser?kind=' + kind,
            type: 'post',
            cache: false,
            dataType: 'json',
            success: function (data) {
                if (data.errno == 0) {
                    $("#nick").val(data.data.nick);
                    $("#uid").val(data.data.uid);
                } else {
                    alert(data.errdesc);
                }
            },
            error: function () {
                alert("异常！");
            }
        });
    }


    // 根据uid获取NICK
    function getNick() {
        var officialUser = $("#officialUser").val();
        if (officialUser == 4) {
            $("#alertErr").hide();
            var id = $("#nick").val();
            if (id == "") {
                $("#alertErr").show();
                $("#uid").val("");
                $("#errodesc").html("UID不能为空！");
                return false;
            } else if (isNaN(id)) {
                $("#alertErr").show();
                $("#uid").val("");
                $("#errodesc").html("UID请输入数字!");
                return false;
            }
            $.ajax({
                type: "POST",
                url: "${BasePath }/groupCategory/getUser?id=" + id,
                datatype: "json",
                success: function (data) {
                    if (data.errno == 1) {
                        $("#alertErr").show();
                        $("#nick").val("");
                        $("#errodesc").html(data.errdesc);
                    } else {
                        if (data.data.nick == null || data.data.nick == "") {
                            $("#alertErr").show();
                            $("#nick").val("");
                            $("#errodesc").html("用户的昵称为空！");
                        } else {
                            $("#nick").val(data.data.nick);
                            $("#uid").val(data.data.uid);
                        }
                    }
                },
                error: function () {
                    alert("操作出错，请联系管理员！");
                }
            });
        }
    }
    function  amrToMp3(id,url,btn){
        var path = "${BasePath}/groupchatconfig/amrToMp3?url=" + url;
        $.ajax({
            type: "POST",
            url: path,
            datatype: "json",
            success: function (data) {
                if (data.errno == 1) {
                    alert(data.errdesc);
                } else {
                    play(id,data.url,btn);
                }
            },
            error: function () {
                alert("操作出错，请联系管理员！");
            }
        });

    }

    function  play(id,url,btn){
        var audio = document.getElementById('audio_'+id);

            audio.src="${BasePath}/groupchatconfig/playMp3?url=" + url;

        playOrPaused(audio,btn);
        var is_playFinish=  setInterval(function(){
            if(audio.ended){
                //   btn.innerHTML=="暂停"
            }
            //callback(audio,btn);
            window.clearInterval(is_playFinish);

        },1);


    }
    function  callback(audio,btn){
        // audio.play();
        playOrPaused(audio,btn);
    }
    function playOrPaused(id,obj){
        if(id.paused){
            id.play();
            obj.name="";
            // obj.innerHTML='暂停';
            return;
        }
        id.pause();

    }
</script>
