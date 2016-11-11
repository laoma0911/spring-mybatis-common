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
            <div class="muted pull-left">添加精准Push</div>
        </div>

        <div class="alert alert-error" id="alertErr" style="display: none;">
            <button class="close" data-dismiss="alert">×</button>
            <strong>Error!</strong> <span id="errodesc">This is an error message.</span>
        </div>
        <div class="block-content collapse in">
            <div class="span12">
                <form class="form-horizontal" id="saveCustom" name="saveCustom" action="${BasePath }/custom/save"
                      method="post">
                    <input type="hidden" id="id" name="id" value="${json.data.id }"/>
                    <input type="hidden" id="itemId" name="itemId" value="${itemId }"/>
                    <fieldset>
                        <div class="control-group">
                            <table class="table">
                                <tr>
                                    <td>
                                        <label class="checkbox"><input type="checkbox" id="userStatus_0"
                                                                       name="userStatus" value="0"/>全部</label>
                                    </td>
                                    <td>
                                        <label class="checkbox"><input type="checkbox" id="userStatus_1"
                                                                       name="userStatus" value="1"/>记经期</label>
                                    </td>
                                    <td>
                                        <label class="checkbox"><input type="checkbox" id="userStatus_2"
                                                                       name="userStatus" value="2"/>备孕</label>
                                    </td>
                                    <td>
                                        <label class="checkbox"><input type="checkbox" id="userStatus_3"
                                                                       name="userStatus" value="3"/>怀孕中</label>
                                    </td>
                                    <td>
                                        <label class="checkbox"><input type="checkbox" id="userStatus_4"
                                                                       name="userStatus" value="4"/>宝妈</label>
                                    </td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>
                                        <label class="checkbox"><input type="checkbox" id="period_0" name="period"
                                                                       value="0"/>全部</label>
                                    </td>
                                    <td>
                                        <label class="checkbox"><input type="checkbox" id="period_1" name="period"
                                                                       value="1"/>月经期</label>
                                    </td>
                                    <td>
                                        <label class="checkbox"><input type="checkbox" id="period_2" name="period"
                                                                       value="2"/>卵泡期</label>
                                    </td>
                                    <td>
                                        <label class="checkbox"><input type="checkbox" id="period_3" name="period"
                                                                       value="3"/>排卵期</label>
                                    </td>
                                    <td>
                                        <label class="checkbox"><input type="checkbox" id="period_5" name="period"
                                                                       value="5"/>黄体期</label>
                                    </td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td colspan="6"><span style="color: #ff0000">（小组选择全部，推送所有加入的小组的用户，都不选择的话，推送所有人，包括没有加入小组的人）</span></td>
                                </tr>
                                <tr>
                                    <td><label class="checkbox">
                                        <input type="checkbox" id="group_0" name="group" value="0"/>全部
                                    </label>
                                    </td>
                                    <td><label class="checkbox">
                                        <input type="checkbox" id="group_1" name="group" value="1"/>健康
                                    </label><label class="checkbox">
                                        <input type="checkbox" id="group_2" name="group" value="2"/>孕育
                                    </label></td>
                                    <td><label class="checkbox">
                                        <input type="checkbox" id="group_3" name="group" value="3"/>情感
                                    </label><label class="checkbox">
                                        <input type="checkbox" id="group_4" name="group" value="4"/>美体护肤
                                    </label></td>
                                    <td><label class="checkbox">
                                        <input type="checkbox" id="group_5" name="group" value="5"/>成长
                                    </label> <label class="checkbox">
                                        <input type="checkbox" id="group_6" name="group" value="6"/>生活
                                    </label></td>
                                    <td><label class="checkbox">
                                        <input type="checkbox" id="group_7" name="group" value="7"/>杂谈
                                    </label><label class="checkbox">
                                        <input type="checkbox" id="group_8" name="group" value="8"/>购物
                                    </label></td>
                                    <td><label class="checkbox">
                                        <input type="checkbox" id="group_9" name="group" value="9"/>其他
                                    </label></td>
                                </tr>
                                <tr>
                                    <td><label class="checkbox">
                                        <input type="checkbox" id="age_0" name="age" value="0"/>全部
                                    </label></td>
                                    <td><label class="checkbox">
                                        <input type="checkbox" id="age_1" name="age" value="1"/>14岁-21岁
                                    </label></td>
                                    <td><label class="checkbox">
                                        <input type="checkbox" id="age_2" name="age" value="2"/>22岁-28岁
                                    </label></td>
                                    <td><label class="checkbox">
                                        <input type="checkbox" id="age_3" name="age" value="3"/>29岁-35岁
                                    </label></td>
                                    <td><label class="checkbox">
                                        <input type="checkbox" id="age_4" name="age" value="4"/>36岁以上
                                    </label></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>特征</td>
                                    <td><label class="checkbox">
                                        <input type="checkbox" id="feature_1" name="feature" value="1"/>魔瘦用户
                                    </label></td>
                                </tr>
                                <tr>
                                    <td><label class="checkbox">
                                        <input type="checkbox" id="area_0" name="area" value="0"/>全部
                                    </label></td>
                                    <td><label class="checkbox">
                                        <input type="checkbox" id="area_1" name="area" value="1"/>北京
                                    </label>
                                        <label class="checkbox">
                                            <input type="checkbox" id="area_2" name="area" value="2"/>天津
                                        </label>
                                        <label class="checkbox">
                                            <input type="checkbox" id="area_3" name="area" value="3"/>河北
                                        </label>
                                        <label class="checkbox">
                                            <input type="checkbox" id="area_4" name="area" value="4"/>山西
                                        </label>
                                        <label class="checkbox">
                                            <input type="checkbox" id="area_5" name="area" value="5"/>内蒙古
                                        </label>
                                        <label class="checkbox">
                                            <input type="checkbox" id="area_6" name="area" value="6"/>辽宁
                                        </label>
                                        <label class="checkbox">
                                            <input type="checkbox" id="area_7" name="area" value="7"/>吉林
                                        </label>
                                        <label class="checkbox">
                                            <input type="checkbox" id="area_8" name="area" value="8"/>黑龙江
                                        </label></td>
                                    <td><label class="checkbox">
                                        <input type="checkbox" id="area_9" name="area" value="9"/>上海
                                    </label>
                                        <label class="checkbox">
                                            <input type="checkbox" id="area_10" name="area" value="10"/>江苏
                                        </label>
                                        <label class="checkbox">
                                            <input type="checkbox" id="area_11" name="area" value="11"/>浙江
                                        </label>
                                        <label class="checkbox">
                                            <input type="checkbox" id="area_12" name="area" value="12"/>安徽
                                        </label>
                                        <label class="checkbox">
                                            <input type="checkbox" id="area_13" name="area" value="13"/>福建
                                        </label>
                                        <label class="checkbox">
                                            <input type="checkbox" id="area_14" name="area" value="14"/>江西
                                        </label>
                                        <label class="checkbox">
                                            <input type="checkbox" id="area_15" name="area" value="15"/>山东
                                        </label>
                                        <label class="checkbox">
                                            <input type="checkbox" id="area_16" name="area" value="16"/>河南
                                        </label>
                                    </td>
                                    <td><label class="checkbox">
                                        <input type="checkbox" id="area_17" name="area" value="17"/>湖北
                                    </label>
                                        <label class="checkbox">
                                            <input type="checkbox" id="area_18" name="area" value="18"/>湖南
                                        </label>
                                        <label class="checkbox">
                                            <input type="checkbox" id="area_19" name="area" value="19"/>广东
                                        </label>
                                        <label class="checkbox">
                                            <input type="checkbox" id="area_20" name="area" value="20"/>广西
                                        </label>
                                        <label class="checkbox">
                                            <input type="checkbox" id="area_21" name="area" value="21"/>海南
                                        </label>
                                        <label class="checkbox">
                                            <input type="checkbox" id="area_22" name="area" value="22"/>重庆
                                        </label>
                                        <label class="checkbox">
                                            <input type="checkbox" id="area_23" name="area" value="23"/>四川
                                        </label>
                                        <label class="checkbox">
                                            <input type="checkbox" id="area_24" name="area" value="24"/>贵州
                                        </label></td>
                                    <td><label class="checkbox">
                                        <input type="checkbox" id="area_25" name="area" value="25"/>云南
                                    </label>
                                        <label class="checkbox">
                                            <input type="checkbox" id="area_26" name="area" value="26"/>西藏
                                        </label>
                                        <label class="checkbox">
                                            <input type="checkbox" id="area_27" name="area" value="27"/>陕西
                                        </label>
                                        <label class="checkbox">
                                            <input type="checkbox" id="area_28" name="area" value="28"/>甘肃
                                        </label>
                                        <label class="checkbox">
                                            <input type="checkbox" id="area_29" name="area" value="29"/>青海
                                        </label>
                                        <label class="checkbox">
                                            <input type="checkbox" id="area_30" name="area" value="30"/>宁夏
                                        </label>
                                        <label class="checkbox">
                                            <input type="checkbox" id="area_31" name="area" value="31"/>新疆
                                        </label>
                                        <label class="checkbox">
                                            <input type="checkbox" id="area_32" name="area" value="32"/>台湾
                                        </label></td>
                                    <td><label class="checkbox">
                                        <input type="checkbox" id="area_33" name="area" value="33"/>香港
                                    </label>
                                        <label class="checkbox">
                                            <input type="checkbox" id="area_34" name="area" value="34"/>澳门
                                        </label></td>
                                </tr>
                            </table>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="title" style="float: left;">标题：</label>

                            <div class="controls">
                                <c:if test="${json.data.title==null}">
                                    <input class="input-xlarge focused" name="title" id="title" value="大姨吗"
                                           type="text"/>
                                </c:if>
                                <c:if test="${json.data.title!=null}">
                                    <input class="input-xlarge focused" name="title" id="title"
                                           value="${json.data.title}" type="text"/>
                                </c:if>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="info" style="float: left;">文案：</label>

                            <div class="controls">
                                <textarea class="input-xlarge focused" id="info"
                                          name="info">${json.data.content }</textarea>
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" for="url" style="float: left;">链接：</label>

                            <div class="controls">
                                <input class="input-xlarge focused" name="url" id="url" value="${json.data.url }"
                                       type="text"/>
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" for="iosVer_0" style="float: left;">客户端平台：</label>

                            <div class="controls">
                                <table class="table">
                                    <tr>
                                        <td> &nbsp;&nbsp;ios&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <label class="checkbox inline">
                                                <input type="checkbox" id="iosVer_0" name="iosVer" value="0"/>全选
                                            </label>
                                            <c:forEach items="${versionList }" var="version">
                                                <c:if test="${version.platform==2}">
                                                    <label class="checkbox inline">
                                                        <input type="checkbox" name="iosVer"
                                                               id="iosVer_${version.platform }_${version.ver}"
                                                               value="${version.platform }_${version.ver}"/>${version.verName }
                                                    </label>
                                                </c:if>
                                            </c:forEach>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>android
                                            <label class="checkbox inline">
                                                <input type="checkbox" id="androidVer_0" name="androidVer" value="0"/>全选
                                            </label>
                                            <c:forEach items="${versionList }" var="version">
                                                <c:if test="${version.platform==1}">
                                                    <label class="checkbox inline">
                                                        <input type="checkbox" name="androidVer"
                                                               id="androidVer_${version.platform }_${version.ver}"
                                                               value="${version.platform }_${version.ver}"/>${version.verName }
                                                    </label>
                                                </c:if>
                                            </c:forEach>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" for="createDate" style="float: left;">推送时间：</label>
                            <div class="controls">
                                <input type="text" id="createDate" name="createDate" value="${json.data.scheduleTime}"
                                       class="Wdate"
                                       onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'%y-%M-%d %H:%m:%s',readOnly:'false'})"/>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="type" style="float: left;">类型：</label>

                            <div class="controls col-xs-2">
                                <select name="type" id="type">
                                    <option value="1" <c:if test="${json.data.type==1}">selected</c:if>>资讯类</option>
                                    <option value="2" <c:if test="${json.data.type==2}">selected</c:if>>营销类</option>
                                </select>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="memo" style="float: left;">发起者：</label>
                            <div class="controls col-xs-2">
                                <select name="memo" id="memo">
                                    <option value="1" <c:if test="${json.data.memo==1}">selected</c:if>>社区</option>
                                    <option value="2" <c:if test="${json.data.memo==2}">selected</c:if>>市场</option>
                                    <option value="3" <c:if test="${json.data.memo==3}">selected</c:if>>美月</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-actions">
                            <button type="button" id="myBtn" onclick="saveForm()" class="btn btn-primary">保存</button>
                        </div>
                    </fieldset>
                </form>
                <form action="${BasePath }/push/save" name="myForm" id="myForm" method="post">
                    <input type="hidden" name="userStatusForm" id="userStatusForm" value=""/>
                    <input type="hidden" name="periodForm" id="periodForm" value=""/>
                    <input type="hidden" name="groupsForm" id="groupsForm" value=""/>
                    <input type="hidden" name="ageForm" id="ageForm" value=""/>
                    <input type="hidden" name="featureForm" id="featureForm" value=""/>
                    <input type="hidden" name="areaForm" id="areaForm" value=""/>
                    <input type="hidden" name="contentForm" id="contentForm" value=""/>
                    <input type="hidden" name="urlForm" id="urlForm" value=""/>
                    <input type="hidden" name="dateTimeForm" id="dateTimeForm" value=""/>
                    <input type="hidden" name="titleForm" id="titleForm" value=""/>
                    <input type="hidden" name="idForm" id="idForm" value=""/>
                    <input type="hidden" name="androidVerForm" id="androidVerForm" value=""/>
                    <input type="hidden" name="iosVerForm" id="iosVerForm" value=""/>
                    <input type="hidden" name="typeForm" id="typeForm" value=""/>
                    <input type="hidden" name="memoForm" id="memoForm" value=""/>
                </form>
            </div>
        </div>
    </div>
    <!-- /block -->
</div>
<script>
    function saveForm() {
        var targetUserStatusAll = new Array();
        var userStatusFlag = false;
        $("input[name='userStatus']:checked").each(function () {
            var txt = $(this).val();
            if (txt == 0) {
                targetUserStatusAll.push(0);
                userStatusFlag = true;
            } else if (!userStatusFlag) {
                targetUserStatusAll.push(txt);
            }
        });
        if (targetUserStatusAll.length == 0) {
            alert("请选择用户状态");
            return false;
        }
        var targetUserAll = new Array();
        $("input[name='feature']:checked").each(function () {
            var txt = $(this).val();
            targetUserAll.push(txt);
        });

        var targetUserTime = new Array();
        var flagPeriod = false;
        $("input[name='period']:checked").each(function () {
            var txt = $(this).val();
            if (txt == 0) {
                targetUserTime = new Array();
                targetUserTime.push(0);
                flagPeriod = true;
            } else if (flagPeriod == false) {
                targetUserTime.push(txt);
            }
        });
        if (targetUserTime.length == 0) {
            if (targetUserStatusAll != '0' && targetUserStatusAll.indexOf("3") < 0) {
                alert("请选择经期阶段！");
                return false;
            }
        }
        var targetUserGroup = new Array();
        var flag = false;
        $("input[name='group']:checked").each(function () {
            var txt = $(this).val();
            if (txt == 0) {
                targetUserGroup = new Array();
                targetUserGroup.push(0);
                flag = true;
            } else if (flag == false) {
                targetUserGroup.push(txt);
            }
        });
        if (targetUserGroup.length == 0) {
//            alert("请选择分组！");
//            return false;
            targetUserGroup="";
        }
        var targetUserAge = new Array();
        var flagAge = false;
        $("input[name='age']:checked").each(function () {
            var txt = $(this).val();
            if (txt == 0) {
                targetUserAge = new Array();
                targetUserAge.push(0);
                flagAge = true;
            } else if (flagAge == false) {
                targetUserAge.push(txt);
            }
        });
        if (targetUserAge.length == 0) {
            alert("请选择年龄阶段！");
            return false;
        }
        var targetUserArea = new Array();
        var flagArea = false;
        $("input[name='area']:checked").each(function () {
            var txt = $(this).val();
            if (txt == 0) {
                targetUserArea = new Array();
                targetUserArea.push(0);
                flagArea = true;
            } else if (flagArea == false) {
                targetUserArea.push(txt);
            }
        });
        if (targetUserArea.length == 0) {
            alert("请选择区域！");
            return false;
        }

        var info = $("#info").val();
        var url = $("#url").val();
        var title = $("#title").val();
        var dateTime = $("#createDate").val();
        if (info == "") {
            alert("文案内容不能为空！");
            return false;
        } else if (info.length > 50) {
            alert("文案内容不能超过50字！");
            return false;
        }
        if (url != "") {
            var http = url.substr(0, 7);
            var dayima = url.substr(0, 9);
            if (http == "http://" || dayima == "dayima://") {
            } else {
                alert("链接不符合规则，请以 http://  或  dayima://开头");
                return false;
            }
        }
        if (url.length >= 100) {
            alert("链接地址长度不能超过100个字符");
            return false;

        }


// 	var platformArry = new Array(); 
// 	$("input[name='platform']:checked").each(function(){ 
//         	var txt = $(this).val();
//         	platformArry.push(txt); 
//     });

// 	if(platformArry.length==0){
// 		alert("请选择推送的客户端！");
// 		return false;
// 	}
        var iosVerArry = new Array();
        $("input[name='iosVer']:checked").each(function () {
            var txt = $(this).val();
            iosVerArry.push(txt);
        });
        var androidVerArry = new Array();
        $("input[name='androidVer']:checked").each(function () {
            var txt = $(this).val();
            androidVerArry.push(txt);
        });


        if (iosVerArry.length == 0 && androidVerArry.length == 0) {
            alert("请选择推送的客户端！");
            return false;
        }

        if (dateTime == "") {
            alert("请选择推送时间！");
            return false;
        }


        var id = $("#id").val();

        $("#userStatusForm").val(targetUserStatusAll);
        $("#periodForm").val(targetUserTime);
        $("#groupsForm").val(targetUserGroup);
        $("#ageForm").val(targetUserAge);
        $("#featureForm").val(targetUserAll);
        $("#areaForm").val(targetUserArea);
        $("#contentForm").val(info);
        $("#urlForm").val(url);
        $("#dateTimeForm").val(dateTime);
        $("#titleForm").val(title);
        $("#idForm").val(id);
        $("#androidVerForm").val(androidVerArry);
        $("#iosVerForm").val(iosVerArry);
        $("#typeForm").val($("#type").val());
        $("#memoForm").val($("#memo").val());

        $("#myBtn").attr("disabled", "disabled");
        $('#myForm').ajaxSubmit(function (data) {
            if (data.errno == 1) {
                $("#alertErr").show();
                $("#errodesc").html(data.errdesc);
                $("#myBtn").removeAttr("disabled");
            } else {
                alert("操作成功！");
                window.parent.closeModel();
            }
        });
    }
</script>
<jsp:include page="../include/bottom.jsp"/>
<script type="text/javascript">
    $(document).ready(function () {
        setCheckBoxValue("${json.data.userStatus}", "userStatus");
        setCheckBoxValue("${json.data.period}", "period");
        setCheckBoxValueNoDefault("${json.data.groups}", "group");
        setCheckBoxValue("${json.data.age}", "age");
        setCheckBoxValue("${json.data.feature}", "feature");
        setCheckBoxValue("${json.data.area}", "area");
        var userStatus = "${json.data.userStatus}";
        if (userStatus == "" || userStatus == "0") {
            $("input[name='userStatus']").each(function () {
                this.checked = true;
            });
        }
        if (userStatus == "" || userStatus == "0" || userStatus.indexOf("3") > 0) {
            $("input[name='period']").each(function () {
                $("#period_" + this.value).attr("checked", false);
                $("#period_" + this.value).attr("disabled", "disabled");
            });
        }


        var platforms = [];

        try {
            if ('${platformStr}' != null && '${platformStr}' != "") {
                platforms = eval('${platformStr}');
            }
        } catch (e) {
        }

        var vers = 0;
        for (i = 0; i < platforms.length; i++) {
            vers = platforms[i].versions;
            if (platforms[i].platform == 0) {
                if (vers.length == 0) {
                    $("input[name=androidVer]").attr("checked", true);
                } else {
                    for (j = 0; j < vers.length; j++) {
                        $("#androidVer_1_" + vers[j]).attr("checked", true);
                    }
                }
            } else if (platforms[i].platform == 1) {
                if (vers.length == 0) {
                    $("input[name=iosVer]").attr("checked", true);
                } else {
                    for (j = 0; j < vers.length; j++) {
                        $("#iosVer_2_" + vers[j]).attr("checked", true);
                    }
                }
            }
        }
        //用户状态
        $("input[name='userStatus']").click(function (obj) {//全选
            if (this.id == 'userStatus_0') {
                var flag = this.checked;
                $("input[name='userStatus']").each(function () {
                    this.checked = flag;
                });
                if (flag) {
                    $("input[name='period']").each(function () {
                        $("#period_" + this.value).attr("checked", false);
                        $("#period_" + this.value).attr("disabled", "disabled");
                    });
                } else {
                    $("input[name='period']").each(function () {
//                        $("#period_" + this.value).attr("disabled", "disabled");
                        $("#period_" + this.value).removeAttr("disabled");
                    });
                    //$("#period_" + this.value).removeAttr("disabled");
                }
            } else {
                if (this.checked) {
                    if (this.id == 'userStatus_3') {
                        if (confirm("选择\"孕期用户\"后\"经期阶段\"将不能选择，确定吗？ ")) {
                            $("input[name='period']").each(function () {
                                $("#period_" + this.value).attr("checked", false);
                                $("#period_" + this.value).attr("disabled", "disabled");
                            });
                        } else {
                            this.checked = false;
                        }
                    }
//                else {
//                    if ($("input[id='userStatus_3']:checked").val() != 1) {
//                        $("input[name='period']").each(function () {
//                            $("#period_" + this.value).removeAttr("disabled");
//                        });
//                    }
//                }

                } else if (this.id == 'userStatus_3') {
                    $("input[name='period']").each(function () {
                        $("#period_" + this.value).removeAttr("disabled");
                    });
                } else {
                    $("#userStatus_0").attr("checked", false);
                }


                var flag = this.checked;
                if (flag) {
                    var sign = true;
                    $("input[name='userStatus']").each(function () {
                        if (this.id != 'userStatus_0' && this.checked == false) {
                            sign = false;
                        }
                    });
                    if (sign) {
                        $("input[name='userStatus']").each(function () {
                            if (this.id == 'userStatus_0') {
                                this.checked = true;
                            }
                        });
                    } else {
                        $("#userStatus_0").attr("checked", false);
                    }
                } else {
                    $("#userStatus_0").attr("checked", false);
                }

            }

        });


        //区域
        $("input[name='area']").click(function (obj) {//全选
            if (this.id == 'area_0') {
                var flag = this.checked;
                $("input[name='area']").each(function () {
                    this.checked = flag;
                });
            } else {
                var flag = this.checked;
                if (flag) {
                    var sign = true;
                    $("input[name='area']").each(function () {
                        if (this.id != 'area_0' && this.checked == false) {
                            sign = false;
                        }
                    });
                    if (sign) {
                        $("input[name='area']").each(function () {
                            if (this.id == 'area_0') {
                                this.checked = true;
                            }
                        });
                    } else {
                        $("#area_0").attr("checked", false);
                    }
                } else {
                    $("#area_0").attr("checked", false);
                }
            }
        });


        //年龄阶段
        $("input[name='age']").click(function (obj) {//全选
            if (this.id == 'age_0') {
                var flag = this.checked;
                $("input[name='age']").each(function () {
                    this.checked = flag;
                });
            } else {
                var flag = this.checked;
                if (flag) {
                    var sign = true;
                    $("input[name='age']").each(function () {
                        if (this.id != 'age_0' && this.checked == false) {
                            sign = false;
                        }
                    });
                    if (sign) {
                        $("input[name='age']").each(function () {
                            if (this.id == 'age_0') {
                                this.checked = true;
                            }
                        });
                    } else {
                        $("#age_0").attr("checked", false);
                    }
                } else {
                    $("#age_0").attr("checked", false);
                }
            }
        });


        //小组
        $("input[name='group']").click(function (obj) {//全选
            if (this.id == 'group_0') {
                var flag = this.checked;
                $("input[name='group']").each(function () {
                    this.checked = flag;
                });
            } else {
                var flag = this.checked;
                if (flag) {
                    var sign = true;
                    $("input[name='group']").each(function () {
                        if (this.id != 'group_0' && this.checked == false) {
                            sign = false;
                        }
                    });
                    if (sign) {
                        $("input[name='group']").each(function () {
                            if (this.id == 'group_0') {
                                this.checked = true;
                            }
                        });
                    } else {
                        $("#group_0").attr("checked", false);
                    }
                } else {
                    $("#group_0").attr("checked", false);
                }
            }
        });

        //经期
        $("input[name='period']").click(function (obj) {//全选
            if (this.id == 'period_0') {
                var flag = this.checked;
                $("input[name='period']").each(function () {
                    this.checked = flag;
                });
            } else {
                var flag = this.checked;
                if (flag) {
                    var sign = true;
                    $("input[name='period']").each(function () {
                        if (this.id != 'period_0' && this.checked == false) {
                            sign = false;
                        }
                    });
                    if (sign) {
                        $("input[name='period']").each(function () {
                            if (this.id == 'period_0') {
                                this.checked = true;
                            }
                        });
                    } else {
                        $("#period_0").attr("checked", false);
                    }
                } else {
                    $("#period_0").attr("checked", false);
                }
            }
        });


        //平台全选
        $("input[name='iosVer']").click(function (obj) {//全选
            if (this.id == 'iosVer_0') {
                var flag = this.checked;
                $("input[name='iosVer']").each(function () {
                    this.checked = flag;
                });
            } else {
                var flag = this.checked;
                if (flag) {
                    var sign = true;
                    $("input[name='iosVer']").each(function () {
                        if (this.id != 'iosVer_0' && this.checked == false) {
                            sign = false;
                        }
                    });
                    if (sign) {
                        $("input[name='iosVer']").each(function () {
                            if (this.id == 'iosVer_0') {
                                this.checked = true;
                            }
                        });
                    } else {
                        $("#iosVer_0").attr("checked", false);
                    }
                } else {
                    $("#iosVer_0").attr("checked", false);
                }
            }
        });

        //平台全选
        $("input[name='androidVer']").click(function (obj) {//全选
            if (this.id == 'androidVer_0') {
                var flag = this.checked;
                $("input[name='androidVer']").each(function () {
                    this.checked = flag;
                });
            } else {
                var flag = this.checked;
                if (flag) {
                    var sign = true;
                    $("input[name='androidVer']").each(function () {
                        if (this.id != 'androidVer_0' && this.checked == false) {
                            sign = false;
                        }
                    });
                    if (sign) {
                        $("input[name='androidVer']").each(function () {
                            if (this.id == 'androidVer_0') {
                                this.checked = true;
                            }
                        });
                    } else {
                        $("#androidVer_0").attr("checked", false);
                    }
                } else {
                    $("#androidVer_0").attr("checked", false);
                }
            }
        });
    });
</script>

