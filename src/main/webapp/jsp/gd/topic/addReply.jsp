<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="${BasePath}/jsp/include/head.jsp"/>
<style>
    body{
        padding-top: 0px;
    }
    .aixuexi {
        width: 150px;
        height: 150px;
        border: 1px solid black;
    }

    .aixuexi img {
        width: 100%;
        height: 100%;
    }

</style>
<!-- Body -->
<div class="container-fluid">

    <!-- block -->
    <div class="block">
        <div class="navbar navbar-inner block-header">
            <div class="muted pull-left">回复或编辑</div>
        </div>

        <div class="alert alert-error" id="alertErr" style="display: none;">
            <button class="close" data-dismiss="alert">×</button>
            <strong>Error!</strong> <span id="errodesc">This is an error message.</span>
        </div>
        <div class="block-content collapse in">
            <div class="span12">
                <form class="form-horizontal" id="saveCustom" name="saveCustom" action="${BasePath }/meiyue/topic/saveReply"
                      enctype="multipart/form-data" method="post">
                    <input type="hidden" id="type" name="type" value="${type}"/>
                    <input type="hidden" id="sign" name="sign" value="${sign}"/>
                    <input type="hidden" id="topicId" name="topicId" value="${topicId}"/>
                    <input type="hidden" id="itemId" name="itemId" value="${itemId }"/>
                    <c:if test="${not empty sign}">
                        <input type="hidden" name="replyId" value="${topicReply.id }"/>
                    </c:if>
                    <fieldset>
                        <c:if test="${empty sign}">
                            <div class="control-group">
                                <label class="control-label" for="name"
                                       style="float: left;">回复者：</label>

                                <div class="controls">
                                    <select name="officialUser" id="officialUser" onchange="changeReplyUser(this)">
                                        <option value="请选择">请选择</option>
                                        <c:forEach items="${userList}" var="obj">
                                            <option <c:if test="${obj.key == 1}">selected="selected" </c:if>
                                                    value="${obj.key}">${obj.value}</option>
                                        </c:forEach>
                                    </select>
                                    &nbsp;&nbsp;
                                    <input type="hidden" id="uid" name="uid" value="${checkUser.uid}"/>
                                    <input type="text" id="nick" name="nick" value="${checkUser.nick}" onblur="getNick()"/>
                                </div>
                            </div>


                            <div class="control-group">
                                <label class="control-label" for="name"
                                       style="float: left;">被回复楼层ID：</label>

                                <div class="controls">
                                    <input class="input-xlarge focused" name="replyId" id="replyId"
                                           value="<c:if test="${topicReply.replyId !=0 }">${topicReply.replyId}</c:if>"
                                           type="text"/>
                                </div>
                            </div>
                        </c:if>

                        <div class="control-group">
                            <label class="control-label" for="name"
                                   style="float: left;">回复内容:</label>

                            <div class="controls">
                                <textarea class="input-xlarge focused" id="text" name="text" rows="4" style="margin: 0px; width: 454px; height: 156px;">${topicReply.content}</textarea>
                            </div>
                        </div>


                        <div class="control-group">
                            <label class="control-label" for="name" style="float: left;">快捷回复:</label>

                            <div class="controls">
                                <select name="remark" id="selectId" onchange="changeRemark()">
                                    <option value="请选择">请选择</option>
                                    <option value="举报处理">举报处理</option>
                                    <option value="违规警告">违规警告</option>
                                    <option value="联系客服">联系客服</option>
                                    <option value="联系美月客服">联系美月客服</option>
                                </select>
                            </div>
                            <script>
                                var reasonMap = {};
                                reasonMap["举报处理"] = "您好，已处理，感谢举报~";
                                reasonMap["违规警告"] = "由于您违反了大姨吗论坛规定，此次警告，下次封禁帐号，希望达成相互体谅，谢谢合作。详情参阅全局置顶贴《新人必读》——论坛管理员";
                                reasonMap["联系客服"] = "亲，请联系24小时客服QQ800041796（企业QQ，需选择“搜服务”），会有工作人员协助处理。如果遇到咨询人数较多，请耐心等待~";
                                reasonMap["联系美月客服"] = "亲，您好~请联系美月微信账号miss-youxuan ，美月优选的客服工作时间周一至周日，早上9:00-20:00.，建议亲有任何问题尽量在工作时间内联系美月，以便能及时解决您所遇到的问题，给您带来更好的购物体验，同时也谢谢您对美月优选的支持与理解哟~~";
                                function changeRemark() {
                                    var remark = $("#selectId").val();
                                    if (remark == '1') {
                                        $("#text").val("");
                                    } else {
                                        $("#text").val(reasonMap[remark]);
                                    }
                                }
                            </script>
                        </div>


                        <div class="control-group">
                            <label class="control-label" for="name"
                                   style="float: left;">添加回复图片：</label>

                            <div class="controls">
                                <input class="input-xlarge focused" name="pic" id="pic"
                                       value="${topicReplyPic.oriPic }" type="file"/>
                            </div>
                        </div>


                        <c:if test="${topicReplyPic!=null && topicReplyPic!=''}">
                            <div class="control-group">
                                <label class="control-label" for="name"
                                       style="float: left;">原回复图片:</label>
                                <div class="controls aixuexi">
                                    <img alt="" src="${topicReplyPic.oriPic }">
                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                    <c:if test="${topicReplyPic.status == 1}">
                                        <font color="red">该回复图片已删除</font>
                                    </c:if>
                                </div>
                            </div>
                        </c:if>


                        <div class="form-actions">
                            <button type="button"  id="myBtn" onclick="submitForm()" class="btn btn-primary">保存</button>
                        </div>
                    </fieldset>
                </form>
            </div>
        </div>
    </div>
    <!-- /block -->


</div>
<script>

    function changeReplyUser(obj) {
        $("#alertErr").hide();
        var kind=obj.value;
        var topicId = $("#topicId").val();
        $('#uid').val("");
        $('#nick').val("");


        if(kind != '4'){
            $("#nick").attr("readonly", true);
        }else{
            $("#nick").attr("readonly", false);
        }
        //1.$.ajax带json数据的异步请求
        var aj = $.ajax( {
            url: '${BasePath}/meiyue/topic/getTopicReplyUser?kind=' + kind + "&topicId=" + topicId,
            type:'post',
            cache:false,
            dataType:'json',
            success:function(data) {
                if(data.errno==0){
                    $("#nick").val(data.data.nick);
                    $("#uid").val(data.data.uid);
                }else{
                    alert(data.errdesc);
                }
            },
            error : function() {
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



    function checkForm() {
        var uid = $("#uid").val();
        if (uid.length == 0 && uid == "") {
            alert("请选择或填写回复者ID");
            return false;
        }
        var text = $("#text").val();
        if (text == "" || text.length ==0) {
            alert("回复内容不能为空！");
            return false;
        }
        return true;
    }

    function submitForm() {
        var sign = $("#sign").val();
        if (sign != 1){
            if (checkForm()) {
                $('#saveCustom').ajaxSubmit(function (data) {
                    if (data.errno == 0) {
                        alert("操作成功！");
                        window.parent.closeModel();
                    } else if (data.errno == 1) {
                        $("#alertErr").show();
                        $("#errodesc").html(data.errdesc);
                    }
                });
            }
        }else {
            $('#saveCustom').ajaxSubmit(function (data) {
                if (data.errno == 0) {
                    alert("操作成功！");
                    window.parent.closeModel();
                } else if (data.errno == 1) {
                    $("#alertErr").show();
                    $("#errodesc").html(data.errdesc);
                }
            });
        }
    }
</script>