<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../include/head.jsp"/>
<style>
    body {
        padding-top: 0px;
    }
</style>
<!-- Body -->
<div class="container-fluid">

    <!-- block -->
    <div class="block">
        <div class="navbar navbar-inner block-header">
            <div class="muted pull-left">封禁用户</div>
        </div>

        <div class="alert alert-error" id="alertErr" style="display: none;">
            <button class="close" data-dismiss="alert">×</button>
            <span id="errodesc">This is an error message.</span>
        </div>
        <div class="block-content collapse in">
            <div class="span12">
                <form id="myDialogForm" name="myDialogForm" method="post" action="${BasePath}/audit/signaturebanUser?${PublicParams}">
                    <input type="hidden" name="uid" id="uid" value="${json.uid}"/>
                    <input type="hidden" name="auditId" id="auditId" value="${json.auditId}"/>
                    <fieldset>
                        对用户<font color="#08c">${json.nick}</font>(${json.uid})的处理为:
                        <div>
                            <label class="checkbox inline">
                                <input type="radio" name="identity" value="3" checked="checked"/>封禁3天
                            </label>
                            <label class="checkbox inline">
                                <input type="radio" name="identity" value="15"/>封禁15天
                            </label>
                            <label class="checkbox inline">
                                <input type="radio" name="identity" value="30"/>封禁30天
                            </label>
                            <label class="checkbox inline">
                                <input type="radio" name="identity" value="0" checked="checked"/>永久封禁
                            </label>
                            <label class="checkbox inline">
                                <input type=checkbox  checked="checked" name="isWithDevice" id="isWithDevice"
                                       onclick="showBanList(this)" value="1"/>带设备
                            </label>
                        </div>
                        <div>
                            &nbsp;&nbsp;&nbsp;&nbsp;
                            快捷回复:
                            <select name="remark"  id="selectId" onchange="changeRemark()">
                                <option selected value="1">...</option>
                                <option value="广告封禁3天">广告封禁3天</option>
                                <option value="广告封禁15天">广告封禁15天</option>
                                <option value="广告封禁30天">广告封禁30天</option>
                                <option value="广告永久封禁">广告永久封禁</option>
                                <option value="骂人封禁3天">骂人封禁3天</option>
                                <option value="骂人封禁15天">骂人封禁15天</option>
                                <option value="骂人封禁30天">骂人封禁30天</option>
                                <option value="色情封禁3天">色情封禁3天</option>
                                <option value="色情封禁15天">色情封禁15天</option>
                                <option value="色情封禁30天">色情封禁30天</option>
                                <option value="男性用户永久封禁">男性用户永久封禁</option>
                            </select>
                            <script >
                                var reasonMap = {};
                                reasonMap["广告封禁3天"]="大姨吗社区严禁广告，此次处以禁言3天惩罚，下次将封禁账号，详情参阅全局置顶贴《新人入组必读》。";
                                reasonMap["广告封禁15天"]="大姨吗社区严禁广告，此次处以禁言15天惩罚，下次将封禁账号，详情参阅全局置顶贴《新人入组必读》。";
                                reasonMap["广告永久封禁"]="大姨吗社区严禁广告，您的账号已被永封禁，详情参阅全局置顶贴《新人入组必读》。";
                                reasonMap["广告封禁30天"]="大姨吗社区严禁广告，此次处以禁言30天惩罚，下次将封禁账号，详情参阅全局置顶贴《新人入组必读》。";
                                reasonMap["骂人封禁3天"]="由于您言辞过当，此次处以禁言3天惩罚，详情参阅全局置顶贴《新人入组必读》。";
                                reasonMap["骂人封禁15天"]="由于您言辞过当，此次处以禁言15天惩罚，详情参阅全局置顶贴《新人入组必读》。";
                                reasonMap["骂人封禁30天"]="由于您言辞过当，此次处以禁言30天惩罚，详情参阅全局置顶贴《新人入组必读》。";
                                reasonMap["色情封禁3天"]="由于您言论涉及色情内容，此次处以禁言3天惩罚，详情参阅全局置顶贴《新人入组必读》。";
                                reasonMap["色情封禁15天"]="由于您言论涉及色情内容，此次处以禁言15天惩罚，详情参阅全局置顶贴《新人入组必读》。";
                                reasonMap["色情封禁30天"]="由于您言论涉及色情内容，此次处以禁言30天惩罚，详情参阅全局置顶贴《新人入组必读》。";
                                reasonMap["男性用户永久封禁"]="大姨吗社区仅限女性用户使用，您的账号已被永封禁。";
                                function changeRemark(){
                                    var remark=$("#selectId").val();
                                    if(remark=='1'){
                                        $("#reason").val("");
                                    }else{
                                        $("#reason").val(reasonMap[remark]);
                                    }
                                }
                            </script>
                        </div>
                        <div>
                            <textarea name="reason" rows="4" id="reason"
                                      style="margin: 0px 0px 10px; width: 514px; height: 80px;"></textarea>
                        </div>
                        <div id="banDeviceDiv">
                            <table class='table'>
                                <thead>
                                <tr>
                                    <td></td>
                                    <td>device</td>
                                    <td>设备关联用户总数</td>
                                    <td>model</td>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${data}" var="obj">
                                    <tr>
                                        <td>
                                            <input type="checkbox" checked="checked" name="deviceId" id="deviceId" value="${obj.key2}"/>
                                        </td>
                                        <td>${obj.key2}</td>
                                        <td>${obj.count}</td>
                                        <td>${obj.model}</td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </fieldset>
                    <input type="hidden" name="devicesHidden" id="devicesHidden" value=""/>
                </form>

                <div class="modal-footer">
                    <button onclick="submitBanForm()" class="btn btn-primary">确定</button>
                </div>
            </div>
        </div>
    </div>
    <!-- /block -->


</div>
<script>

    function showBanList(obj) {
        if(!obj.checked){
            $("#banDeviceDiv").hide();
        }else{
            $("#banDeviceDiv").show();
        }
    }

    //    tr选中checkbox效果
    $("#tbodys tr").click(function () {
        var chks = $(':checkbox', this);
        chks.prop('checked', !chks[0].checked);
    });

    //封禁用户
    function submitBanForm() {
        $("#alertErr").hide();
        //封禁累类型 3:3天. 30:30天. 0:永久
        var banType = $("input[type='radio']:checked").val();
        //理由
        var reason = $("#reason").val();
        //是否带设备
        var isWithDevice = 1;
        var devices = new Array();
        if ($('#isWithDevice').is(':checked')) {
            isWithDevice = 1;

            $("input[name='deviceId']:checked").each(function () {
                var txt = $(this).val();
                devices.push(txt);
            });
            if (devices.length == 0) {
                alert("您还未选择要封禁的设备!");
                return false;
            }
        } else {
            isWithDevice = 0;
        }
        if (reason.length == 0) {
            alert("请选择或填写理由!");
            return false;
        }
        $("#devicesHidden").val(devices);
        $('#myDialogForm').ajaxSubmit(function(data){
            if (data.errno == 1) {
                $("#alertErr").show();
                $("#errodesc").html(data.errdesc);
            } else {
                alert("操作成功!");
                window.parent.closeModel();
            }
        });
    }

</script>