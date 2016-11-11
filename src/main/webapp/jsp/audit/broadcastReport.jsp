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
                            <form class="form-inline" id="myForm" name="myForm"
                                  action="${BasePath}/broadcastReport/list?${PublicParams}" method="post">
                                直播间名称: <input type="text" id="title" name="title" value="${title}"/>
                                UID: <input type="text" id="uid" name="uid" value="${uid}"/>
                                <select name="status" id="status">
                                    <%--<option--%>
                                    <%--<c:if test="${status==9}">selected="selected" </c:if> value="9">全部--%>
                                    <%--</option>--%>
                                        <option
                                                <c:if test="${status==1}">selected="selected" </c:if> value="1">待审核
                                        </option>
                                        <option
                                                <c:if test="${status!=1}">selected="selected" </c:if> value="2">已审核
                                        </option>

                                </select>
                                <button type="button" onclick="submitForm()" class="btn btn-success btn-small">查询
                                </button>
                               <input type="hidden" name="start" id="start" value="${start }"/>
                                <input type="hidden" name="limit" id="limit" value="${limit }"/>
                            </form>
                        </div>
                    </div>
                </div>
                <c:if test="${status==1}">
                    <div id="fixedBar" class="navbar navbar-inner" style="clear:both;">
                        <div class="muted pull-left inline">
                            <button class="btn btn-success btn-small"
                                    onclick="window.location.href=window.location.href; ">刷新
                            </button>
                            <button class="btn btn-success btn-small" id="btnSelectAll" onclick="selectAll()">全选
                            </button>
                            <pe:permission key="pass">
                                <button class="btn btn-success btn-small" onclick="setAdutiStatus(4)">通过</button>
                            </pe:permission>
                            <pe:permission key="delete">
                                <button class="btn btn-success btn-small" onclick="setAdutiStatus(5)">删除</button>
                            </pe:permission>
                        </div>
                    </div>
                </c:if>
                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <div class="muted pull-left inline">直播室语音审核列表</div>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table class="table">
                                <thead>
                                <tr>
                                    <th></th>
                                    <th>用户</th>
                                    <th nowrap="true">语音</th>
                                    <th nowrap="true">时长</th>
                                    <th nowrap="true">直播间名称</th>
                                    <th nowrap="true">发送时间</th>
                                    <th nowrap="true">操作</th>
                                </tr>
                                </thead>
                                <tbody id="tbodys">
                                <c:forEach items="${json}" var="obj">
                                    <tr>
                                        <td>
                                            <input
                                                    <c:if test="${status!=1}">type="hidden"</c:if>
                                                    <c:if test="${status==1}">type="checkbox"</c:if> name="id" id="id"
                                                    value="${obj.id }"/>
                                        </td>
                                        <td nowrap="true" class="uid">
                                            <font color="#08c">UID：</font><a
                                                href="${BasePath }/custom/userList?type=4&itemId=20&uid=${obj.uid}"
                                                target="_black">${obj.uid }</a>
                                            <br>
                                            <font color="#08c">昵称：</font> ${obj.nick}<br>
                                            <a href="${BasePath }/broadcastReport/list?uid=${obj.uid}&type=8&itemId=149">她的全部语音信息</a><br>
                                        </td>
                                        <td nowrap="true">
                                            <c:if test="${obj.content !=null && obj.content!=''}">
                                                <c:if test="${(obj.contentType !=null && obj.contentType!='') && obj.contentType==1 }">
                                                    <%--  <a target="_blank">${imageHost }${obj.content.url} </a> 24/${obj.content.time}--%>
                                                    <audio controls="controls" autoplay="autoplay"  id="audio_${obj.id }"  src=""   >
                                                        您的浏览器不支持 audio 标签
                                                    </audio>
                                                </c:if>
                                                <c:if test="${(obj.contentType !=null && obj.contentType!='') && obj.contentType==2 }">
                                                    <img src="${imageHost }${obj.content.url}" width="80px" height="80px"/>
                                                </c:if>

                                            </c:if>

                                        </td>
                                        <td nowrap="true">
                                            <c:if test="${obj.content !=null && obj.content!=''}">
                                            <c:if test="${(obj.contentType !=null && obj.contentType!='') && obj.contentType==1 }">
                                     ${obj.content.time} 秒</td>
                                        </c:if>
                                        </c:if>

                                        </td>
                                        <td nowrap="true">
                                                ${obj.title}
                               <%--             <a href="${LiveHost}/admin/liveroom/list?broadcastId=${obj.roomId}" target="_blank">${obj.title}</a></td>--%>
                                        </td>
                                        <td nowrap="true">
                                            <script>formatTime("${obj.dateline}");</script>
                                        </td>


                                        <td nowrap="true" style="vertical-align:middle">
                                            <c:if test="${status==1}">
                                                <c:if test="${obj.content !=null && obj.content!=''}">
                                                    <c:if test="${(obj.contentType !=null && obj.contentType!='') && obj.contentType==1 }">
                                                        <button    class="btn btn-danger btn-small"  name= "b1"  onclick="amrToMp3(${obj.id },'${obj.content.url}',this )">播放</button>
                                                    </c:if>



                                                </c:if>
                                                <pe:permission key="banUser">
                                                    <button class="btn btn-danger btn-small"
                                                            onclick="openModel('${BasePath}/broadcastReport/toBanUser?broadcastId=${obj.roomId}&uid=${obj.uid}&nick=${obj.nick}&id=${obj.id}','封禁用户','45%','70%')">
                                                        封禁用户
                                                    </button>
                                                </pe:permission>
                                            </c:if>
                                            <c:if test="${obj.status==3}">
                                                已封禁
                                            </c:if>
                                            <c:if test="${obj.status==4}">
                                                已通过

                                            </c:if>
                                            <c:if test="${obj.status==5}">
                                                已删除
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

<script type="text/javascript">
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

    function submitForm() {
        $("#sign").val("2");
        $("#myForm").submit();
    }

    //    tr选中checkbox效果
    $('#tbodys tr').click(function () {
        var chks = $(':checkbox', this);
        chks.prop('checked', !chks[0].checked);
    });
    //浏览图片
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

    //通过or删除
    function setAdutiStatus(status) {
        var ids = new Array();
        $("input[name='id']:checked").each(function () {
            var txt = $(this).val();
            ids.push(txt);
        });
        if (ids.length == 0) {
            alert("您还未选择要操作的数据？");
            return false;
        }
        $.ajax({
            type: "POST",
            url: "${BasePath}/broadcastReport/setAdutiStatus?ids=" + ids + "&status=" + status,
            datatype: "json",
            success: function (data) {
                if (data.errno == 1) {
                    alert(data.errdesc);
                } else {
                    submitForm();
                }
            },
            error: function () {
                alert("操作出错，请联系管理员！");
            }
        });
    }

    // 禁言
    function prohibitionSpeak(uid) {
        var path = "${BasePath}/broadcastReport/prohibitionSpeak?uid=" + uid;
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
                    submitForm();
                }
            },
            error: function () {
                alert("操作出错，请联系管理员！");
            }
        });
    }
    function  amrToMp3(id,url,btn){
        var path = "${BasePath}/broadcastReport/amrToMp3?url=" + url;
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
        if(btn.innerHTML=="播放"){
            audio.src="${BasePath}/broadcastReport/playMp3?url=" + url;
        }
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
        obj.innerHTML='播放';
    }
</script>