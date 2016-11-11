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
    <div class="block">
        <div class="navbar navbar-inner block-header">
            <div class="muted pull-left">姐妹说焦点图 添加|修改</div>
        </div>

        <div class="alert alert-error" id="alertErr" style="display: none;">
            <button class="close" data-dismiss="alert">×</button>
            <strong>Error!</strong> <span id="errodesc">This is an error message.</span>
        </div>
        <div class="block-content collapse in">
            <div>
                <form class="form-horizontal" id="myform" name="myform" action="${BasePath }/topicBannerAd/save"
                      enctype="multipart/form-data" method="post">
                    <input type="hidden" id="type" name="type" value="${type }"/>
                    <input type="hidden" id="id" name="id" value="${data.id }"/>
                    <input type="hidden" id="itemId" name="itemId" value="${itemId }"/>
                    <input type="hidden" id="oldPic" name="oldPic" value="${data.adPictureUrl}"/>
                    <input type="hidden" id="area" name="area" value=""/>
                    <input type="hidden" id="city" name="city" value="${city}"/>
                    <fieldset>

                        <div class="control-group">
                            <label class="control-label" for="name" style="float: left;">类型：
                            </label>

                            <div class="controls">
                                <label class="radio inline">
                                    <input type="radio" name="bannerType" id="type1" onclick="typeChange(this)"
                                           value="1" checked>话题
                                </label>

                                <label class="radio inline" id="activityRadio">
                                    <input type="radio" name="bannerType" id="type2" onclick="typeChange(this)" value="0"
                                           <c:if test="${data.topicId==0 }">checked
                                    </c:if> >活动
                                </label>
                            </div>
                        </div>

                        <div class="control-group" id="topicDiv"
                             <c:if test="${data.topicId!=null && data.topicId==0 }">style="display: none;"</c:if> >
                            <label class="control-label" for="name" style="float: left;">Topic ID：</label>

                            <div class="controls">
                                <input class="input-xlarge focused" name="topicId" id="topicId"
                                       value="${data.topicId}" onblur="getTopic()" type="text"/>
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" for="name" style="float: left;">标题：</label>

                            <div class="controls">
                                <input class="input-xlarge focused" name="title" id="title"
                                       <c:if test="${data==null || data.topicId>0 }">readonly</c:if>
                                       value="${data.title}" type="text"/>
                            </div>
                        </div>

                        <div class="control-group" id="linkDiv"
                                <c:choose>
                                    <c:when test="${data == null || data.topicId > 0}">
                                        style="display:none;"
                                    </c:when>
                                    <c:otherwise>
                                        style="display: block;"
                                    </c:otherwise>
                                </c:choose>
                                >
                            <label class="control-label" for="linkurl" style="float: left;">活动链接：</label>

                            <div class="controls">
                                <input class="input-xlarge focused" name="linkurl" id="linkurl" value="${data.linkurl }"
                                       type="text"/>
                            </div>
                        </div>

                        <div class="control-group" id="MonitorlinkDiv">
                            <label class="control-label" for="monitorlink" style="float: left;">Monitorlink：</label>

                            <div class="controls">
                                <input class="input-xlarge focused" name="mnitorlink" id="monitorlink"
                                       value="${data.viewmonitorlink }" type="text"/>
                                <font color="green">选填</font>
                            </div>
                        </div>


                        <div class="control-group" id="adPictureUrlDiv">
                            <label class="control-label" for="adPictureUrl" style="float: left;">上传图片：</label>

                            <div class="controls">
                                <input class="input-xlarge focused" name="adPictureUrl" id="adPictureUrl"
                                       value="${data.adPictureUrl }" type="file"/>
                                <font color="green">图片规格：640*300 并且图片小于80kb</font>
                                <br>
                                <c:if test="${data.adPictureUrl!=null && data.adPictureUrl!=''}">
                                    <img alt="" src="${data.adPictureUrl }" width="200" height="94px">
                                </c:if>
                            </div>
                        </div>


                        <div class="control-group">
                            <label class="control-label" for="position" style="float: left;">位置：</label>

                            <div class="controls">
                                <input id="startDate" name="startDate" class="Wdate" type="text"
                                       onfocus="WdatePicker({minDate:'%y-%M-{%d}',readOnly:'false',maxDate:'#F{$dp.$D(\'endDate\')}'})"
                                       style="width: 90px"/>
                                至
                                <input id="endDate" name="endDate" class="Wdate" type="text"
                                       onfocus="WdatePicker({readOnly:'false',minDate:'#F{$dp.$D(\'startDate\')}'})"
                                       style="width: 90px"/>
                                <input class="input-xlarge focused" name="position" id="position1"
                                       value="${data.position }" type="text" style="width: 70px"/>
                            </div>


                            <c:if test="${data.id == null}"><span style="display: block">
                            <div class="controls">
                                <input id="startDate2" name="startDate" class="Wdate" type="text"
                                       onfocus="WdatePicker({minDate:'#F{$dp.$D(\'endDate\')}',readOnly:'false',maxDate:'#F{$dp.$D(\'endDate2\')}'})"
                                       style="width: 90px"/>
                                至
                                <input id="endDate2" name="endDate" class="Wdate" type="text"
                                       onfocus="WdatePicker({readOnly:'false',minDate:'#F{$dp.$D(\'startDate2\')}'})"
                                       style="width: 90px"/>
                                <input class="input-xlarge focused" name="position" id="position2" type="text"
                                       style="width: 70px"/>
                            </div>


                            <div class="controls">
                                <input id="startDate3" name="startDate" class="Wdate" type="text"
                                       onfocus="WdatePicker({minDate:'#F{$dp.$D(\'endDate2\')}',readOnly:'false',maxDate:'#F{$dp.$D(\'endDate3\')}'})"
                                       style="width: 90px"/>
                                至
                                <input id="endDate3" name="endDate" class="Wdate" type="text"
                                       onfocus="WdatePicker({readOnly:'false',minDate:'#F{$dp.$D(\'startDate3\')}'})"
                                       style="width: 90px"/>
                                <input class="input-xlarge focused" name="position" id="position3" type="text"
                                       style="width: 70px"/>
                            </div>


                            <div class="controls">
                                <input id="startDate4" name="startDate" class="Wdate" type="text"
                                       onfocus="WdatePicker({minDate:'#F{$dp.$D(\'endDate3\')}',readOnly:'false',maxDate:'#F{$dp.$D(\'endDate4\')}'})"
                                       style="width: 90px"/>
                                至
                                <input id="endDate4" name="endDate" class="Wdate" type="text"
                                       onfocus="WdatePicker({readOnly:'false',minDate:'#F{$dp.$D(\'startDate4\')}'})"
                                       style="width: 90px"/>
                                <input class="input-xlarge focused" name="position" id="position4" type="text"
                                       style="width: 70px"/>
                            </div>




                            <div class="controls">
                                <input id="startDate5" name="startDate" class="Wdate" type="text"
                                       onfocus="WdatePicker({minDate:'#F{$dp.$D(\'endDate4\')}',readOnly:'false',maxDate:'#F{$dp.$D(\'endDate5\')}'})"
                                       style="width: 90px"/>
                                至
                                <input id="endDate5" name="endDate" class="Wdate" type="text"
                                       onfocus="WdatePicker({readOnly:'false',minDate:'#F{$dp.$D(\'startDate5\')}'})"
                                       style="width: 90px"/>
                                <input class="input-xlarge focused" name="position" id="position5" type="text"
                                       style="width: 70px"/>
                            </div>

                            </c:if>
                        </div>


                        <div class="control-group">
                            <label class="control-label" for="platform" style="float: left;">平台：</label>

                            <div class="controls">
                                <label class="checkbox inline">
                                    <input type="checkbox" id="platform_1" name="platform" value="1"/>IOS
                                </label>
                                <label class="checkbox inline">
                                    <input type="checkbox" id="platform_0" name="platform" value="0"/>Android
                                </label>
                                <label class="checkbox inline">
                                    <input type="checkbox" id="platform_2" name="platform" value="2"/>WP
                                </label>
                                <label class="checkbox inline">
                                    <input type="checkbox" id="platform_3" name="platform" value="3"/>小米盒子
                                </label>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="type" style="float: left;">用户状态：</label>

                            <div class="controls">
                                <select name="userStatus" id="userStatus"  >
                                    <option value="0"
                                            <c:if test="${data.userStatus==0 }">selected="selected"</c:if>  >全部
                                    </option>
                                    <option value="1"
                                            <c:if test="${data.userStatus==1 }">selected="selected"</c:if>  >记经期
                                    </option>
                                    <option value="2"
                                            <c:if test="${data.userStatus==2 }">selected="selected"</c:if>  >备孕
                                    </option>
                                    <option value="3"
                                            <c:if test="${data.userStatus==3 }">selected="selected"</c:if>  >怀孕中
                                    </option>
                                    <option value="4"
                                            <c:if test="${data.userStatus==4 }">selected="selected"</c:if>  >宝妈
                                    </option>
                                </select>
                            </div> </div>
                        <div class="control-group" id="clientVerFlag">
                            <label class="control-label" for="sheng" style="float: left;">投放城市：</label>

                            <div class="controls">
                                <select id="selProvince" onChange="getCity(this.options[this.selectedIndex].value)">
                                    <option value="" value=""  <c:if test="${provice==null  || provice=='' }"></c:if> >全部</option>
                                    <option value="北京市"  <c:if test="${provice!=null  && provice=='北京市' }">selected="selected" </c:if> >北京市</option>
                                    <option  <c:if test="${provice!=null  && provice=='上海市' }">selected="selected" </c:if> value="上海市">上海市</option>
                                    <option  <c:if test="${provice!=null  && provice=='天津市' }">selected="selected" </c:if> value="天津市">天津市</option>
                                    <option  <c:if test="${provice!=null  && provice=='重庆市' }">selected="selected" </c:if> value="重庆市">重庆市</option>
                                    <option  <c:if test="${provice!=null  && provice=='河北省' }">selected="selected" </c:if> value="河北省">河北省</option>
                                    <option  <c:if test="${provice!=null  && provice=='山西省' }">selected="selected" </c:if> value="山西省">山西省</option>
                                    <option  <c:if test="${provice!=null  && provice=='内蒙古自治区' }">selected="selected" </c:if> value="内蒙古自治区">内蒙古自治区</option>
                                    <option  <c:if test="${provice!=null  && provice=='辽宁省' }">selected="selected" </c:if> value="辽宁省">辽宁省</option>
                                    <option  <c:if test="${provice!=null  && provice=='吉林省' }">selected="selected" </c:if> value="吉林省">吉林省</option>
                                    <option  <c:if test="${provice!=null  && provice=='黑龙江省' }">selected="selected" </c:if> value="黑龙江省">黑龙江省</option>
                                    <option  <c:if test="${provice!=null  && provice=='江苏省' }">selected="selected" </c:if> value="江苏省">江苏省</option>
                                    <option  <c:if test="${provice!=null  && provice=='浙江省' }">selected="selected" </c:if> value="浙江省">浙江省</option>
                                    <option  <c:if test="${provice!=null  && provice=='安徽省' }">selected="selected" </c:if> value="安徽省">安徽省</option>
                                    <option  <c:if test="${provice!=null  && provice=='福建省' }">selected="selected" </c:if> value="福建省">福建省</option>
                                    <option  <c:if test="${provice!=null  && provice=='江西省' }">selected="selected" </c:if> value="江西省">江西省</option>
                                    <option  <c:if test="${provice!=null  && provice=='山东省' }">selected="selected" </c:if> value="山东省">山东省</option>
                                    <option   <c:if test="${provice!=null  && provice=='河南省' }">selected="selected" </c:if> value="河南省">河南省</option>
                                    <option  <c:if test="${provice!=null  && provice=='湖北省' }">selected="selected" </c:if> value="湖北省">湖北省</option>
                                    <option  <c:if test="${provice!=null  && provice=='湖南省' }">selected="selected" </c:if> value="湖南省">湖南省</option>
                                    <option  <c:if test="${provice!=null  && provice=='广东省' }">selected="selected" </c:if> value="广东省">广东省</option>
                                    <option  <c:if test="${provice!=null  && provice=='广西壮族自治区' }">selected="selected" </c:if> value="广西壮族自治区">广西壮族自治区</option>
                                    <option  <c:if test="${provice!=null  && provice=='海南省' }">selected="selected" </c:if> value="海南省">海南省</option>
                                    <option  <c:if test="${provice!=null  && provice=='四川省' }">selected="selected" </c:if>value="四川省">四川省</option>
                                    <option   <c:if test="${provice!=null  && provice=='贵州省' }">selected="selected" </c:if> value="贵州省">贵州省</option>
                                    <option  <c:if test="${provice!=null  && provice=='云南省' }">selected="selected" </c:if> value="云南省">云南省</option>
                                    <option  <c:if test="${provice!=null  && provice=='西藏自治区' }">selected="selected" </c:if> value="西藏自治区">西藏自治区</option>
                                    <option  <c:if test="${provice!=null  && provice=='陕西省' }">selected="selected" </c:if> value="陕西省">陕西省</option>
                                    <option  <c:if test="${provice!=null  && provice=='甘肃省' }">selected="selected" </c:if> value="甘肃省">甘肃省</option>
                                    <option  <c:if test="${provice!=null  && provice=='宁夏回族自治区' }">selected="selected" </c:if> value="宁夏回族自治区">宁夏回族自治区</option>
                                    <option   <c:if test="${provice!=null  && provice=='青海省' }">selected="selected" </c:if> value="青海省">青海省</option>
                                    <option  <c:if test="${provice!=null  && provice=='新疆维吾尔族自治区' }">selected="selected" </c:if> value="新疆维吾尔族自治区">新疆维吾尔族自治区</option>
                                    <option  <c:if test="${provice!=null  && provice=='香港特别行政区' }">selected="selected" </c:if> value="香港特别行政区">香港特别行政区</option>
                                    <option  <c:if test="${provice!=null  && provice=='澳门特别行政区' }">selected="selected" </c:if> value="澳门特别行政区">澳门特别行政区</option>
                                    <option  <c:if test="${provice!=null  && provice=='台湾省' }">selected="selected" </c:if> value="台湾省">台湾省</option>
                                </select>
                                <select name="selCity" id="selCity">

                                </select>
                            </div>
                        </div>
                        <div class="control-group  form-inline">
                            <label class="control-label" for="type" style="float: left;">同步到谷歌客户端：</label>
                            <div class="controls">
                                <label class="checkbox">
                                    <input type="checkbox" name="toGoogle" id="toGoogle" value="1"  <c:if test="${data.toGoogle==1 }">checked</c:if> >
                                </label>
                            </div>
                        </div>

                        <div class="form-actions">
                            <button type="button" id="btn" name="btn" class="btn btn-primary">保存</button>
                        </div>
                    </fieldset>
                </form>
            </div>
        </div>
    </div>
    <!-- /block -->
</div>
<script>
    //ajax提交表单
    $(function () {
        $('#btn').click(function () {
            var flag = checkForm();
            if (flag) {
                $("#btn").attr("disabled", "disabled");
                $('#myform').ajaxSubmit(function (data) {
                    if (data.errno == 0) {
                        alert("操作成功！");
                        window.parent.closeModel();
                    } else if (data.errno == 1) {
                        $("#alertErr").show();
                        $("#errodesc").html(data.errdesc);
                        $("#btn").removeAttr("disabled");
                    }
                });
            }
        });
    });
    function placeChange(obj) {
        var id = obj.value;
        if (id != 1) {
            $("#uploadDiv").hide();
            $("#activityRadio").hide();
            $("#type1").attr("checked", 'checked');
        } else {
            $("#uploadDiv").show();
            $("#activityRadio").show();
        }
    }
    function typeChange(obj) {
        var id = obj.value;
        if (id == 1) {
            $("#topicDiv").show();
            $("#linkDiv").hide();
            $("#title").attr("readonly", "true");
            $("#flag").attr("checked", false);
            $("#flag").removeAttr("disabled");
        } else {
            $("#topicDiv").hide();
            $("#linkDiv").show();
            $("#title").removeAttr("readonly");
            $("#flag").attr("checked", false);
            $("#flag").attr("disabled", "disabled");
        }
    }

    //验证表单数据
    function checkForm() {
        var oldPic = $("#oldPic").val();
        var place = $("#place").val();
        var adPictureUrl = $("#adPictureUrl").val();
        var position = $("#position1").val();
        if (position == "") {
            alert("请填写位置！");
            return false;
        }
        if (oldPic == "" && adPictureUrl == "") {
            alert("请上传图片！");
            return false;
        }
        var bannerType = $("input[name='bannerType']:checked").val();
        var title = $("#title").val();
        var topicId = $("#topicId").val();
        var linkurl = $("#linkurl").val();
        if (title == "") {
            alert("标题不能为空！");
            return false;
        }
        if (bannerType == 1) {
            if (topicId == "") {
                alert("topicId不能为空！");
                return false;
            } else if (isNaN(topicId)) {
                alert("TopicId请输入数字");
                return false;
            }
        }
        if (bannerType == 0 && linkurl == "") {
            alert("活动链接不能为空！");
            return false;
        }
        var platformArry = new Array();
        $("input[name='platform']:checked").each(function () {
            var txt = $(this).val();
            platformArry.push(txt);
        });
        if (platformArry.length == 0) {
            alert("平台不可以为空,请勾选平台！");
            return false;
        }
        var sheng = $("#selProvince").val();
        var shi = $("#selCity").val();
        if (sheng == null || sheng == '') {
            $("#area").val("");
        } else {
            if (shi == null || shi == '') {
                $("#area").val(sheng + "#");
            } else {
                $("#area").val(sheng + "#" + shi);
            }
        }
        var startDate = $("#startDate").val();
        var endDate = $("#endDate").val();
        if (startDate == "" || endDate == "") {
            alert("请输入开始日期、结束日期！");
            return false;
        }
        return true;
    }
</script>


<script>

    $(function () {
        getCity( "${provice}");
        setByIdFormatDate("startDate", "${data.start}");
        setByIdFormatDate("endDate", "${data.end}");

        //初始化平台
        var vals = "${data.platform}";
        if (vals != "") {
            var val = vals.split(",");
            for (var i = 0; i < val.length; i++) {
                $("#platform_" + val[i]).attr("checked", true);
            }
        }
    });
    //根据Topic id获取Titile
    function getTopic() {
        var id = $("#topicId").val();
        if (id == "") {
            $("#alertErr").show();
            $("#title").val("");
            $("#errodesc").html("topicId不能为空！");
            return false;
        } else if (isNaN(id)) {
            $("#alertErr").show();
            $("#title").val("");
            $("#errodesc").html("TopicId请输入数字!");
            return false;
        }
        $.ajax({
            type: "POST",
            url: "${BasePath }/sisterPush/getTopic?id=" + id,
            datatype: "json",
            success: function (data) {
                if (data.errno == 1) {
                    $("#alertErr").show();
                    $("#title").val("");
                    $("#errodesc").html(data.errdesc);
                } else {
                    if (data.data.title == null || data.data.title == "") {
                        $("#alertErr").show();
                        $("#title").val("");
                        $("#errodesc").html("话题的标题为空！");
                    } else {
                        $("#alertErr").hide();
                        $("#title").val(data.data.title);
                    }
                }
            },
            error: function () {
                alert("操作出错，请联系管理员！");
            }
        });
    }
</script>

<script language="javascript" type="text/javascript">
    //定义 城市 数据
    cityArray = new Array();
    cityArray[0] = new Array("", "全部");
    cityArray[1] = new Array("北京市", "东城区|西城区|崇文区|宣武区|朝阳区|丰台区|石景山区|海淀区|门头沟区|房山区|通州区|顺义区|昌平区|大兴区|平谷区|怀柔区|密云县|延庆县");
    cityArray[2] = new Array("上海市", "黄浦区|卢湾区|徐汇区|长宁区|静安区|普陀区|闸北区|虹口区|杨浦区|闵行区|宝山区|嘉定区|浦东区|金山区|松江区|青浦区|南汇区|奉贤区|崇明县");
    cityArray[3] = new Array("天津市", "和平区|东丽区|河东区|西青区|河西区|津南区|南开区|北辰区|河北区|武清区|红挢区|塘沽区|汉沽区|大港区|宁河县|静海县|宝坻|蓟县");
    cityArray[4] = new Array("重庆市", "万州区|涪陵区|渝中区|大渡口区|江北区|沙坪坝区|九龙坡区|南岸区|北碚区|万盛区|双挢区|渝北区|巴南区|黔江区|长寿区|綦江县|潼南县|铜梁县|大足县|荣昌县|壁山县|梁平县|城口县|丰都县|垫江县|武隆县|忠县|开县|云阳县|奉节县|巫山县|巫溪县|石柱土家族自治县|秀山土家族苗族自治县|酉阳土家族苗族自治县|彭水苗族土家族自治县|江津市|合川市|永川市|南川市");
    cityArray[5] = new Array("河北省", "石家庄市|邯郸市|邢台市|保定市|张家口市|承德市|廊坊市|唐山市|秦皇岛市|沧州市|衡水市");
    cityArray[6] = new Array("内蒙古自治区", "呼和浩特市|包头市|乌海市|赤峰市|呼伦贝尔盟市|阿拉善盟|哲里木盟|兴安盟|乌兰察布盟|锡林郭勒盟|巴彦淖尔盟|伊克昭盟");
    cityArray[7] = new Array("辽宁省", "沈阳市|大连市|鞍山市|抚顺市|本溪市|丹东市|锦州市|营口市|阜新市|辽阳市|盘锦市|铁岭市|朝阳市|葫芦岛");
    cityArray[8] = new Array("吉林省", "长春市|吉林市|四平市|辽源市|通化市|白山市|松原市|白城市|延边朝鲜族自治州");
    cityArray[9] = new Array("黑龙江省", "哈尔滨市|齐齐哈尔市|牡丹江市|佳木斯市|大庆市|绥化市|鹤岗市|鸡西市|黑河市|双鸭山市|伊春市|七台河市|大兴安岭市");
    cityArray[10] = new Array("江苏省", "南京市|镇江市|苏州市|南通市|扬州市|盐城市|徐州市|连云港市|常州市|无锡市|宿迁市|泰州市|淮安市");
    cityArray[11] = new Array("浙江省", "杭州市|宁波市|温州市|嘉兴市|湖州市|绍兴市|金华市|衢州市|舟山市|台州市|丽水市");
    cityArray[12] = new Array("安徽省", "合肥市|芜湖市|蚌埠市|马鞍山市|淮北市|铜陵市|安庆市|黄山市|滁州市|宿州市|池州市|淮南市|巢湖市|阜阳市|六安市|宣城市|亳州市");
    cityArray[13] = new Array("福建省", "福州市|厦门市|莆田市|三明市|泉州市|漳州市|南平市|龙岩市|宁德市");
    cityArray[14] = new Array("江西省", "南昌市市|景德镇市|九江市|鹰潭市|萍乡市|新馀市|赣州市|吉安市|宜春市|抚州市|上饶市");
    cityArray[15] = new Array("山东省", "济南市|青岛市|淄博市|枣庄市|东营市|烟台市|潍坊市|济宁市|泰安市|威海市|日照市|莱芜市|临沂市|德州市|聊城市|滨州市|菏泽市");
    cityArray[16] = new Array("河南省", "郑州市|开封市|洛阳市|平顶山市|安阳市|鹤壁市|新乡市|焦作市|濮阳市|许昌市|漯河市|三门峡市|南阳市|商丘市|信阳市|周口市|驻马店市|济源市");
    cityArray[17] = new Array("湖北省", "武汉市|宜昌市|荆州市|襄樊市|黄石市|荆门市|黄冈市|十堰市|恩施土家族苗族自治州|潜江市|天门市|仙桃市|随州市|咸宁市|孝感市|鄂州市|神农架林区");
    cityArray[18] = new Array("湖南省", "长沙市|常德市|株洲市|湘潭市|衡阳市|岳阳市|邵阳市|益阳市|娄底市|怀化市|郴州市|永州市|湘西土家族苗族自治州|张家界市");
    cityArray[19] = new Array("广东省", "广州市|深圳市|珠海市|汕头市|东莞市|中山市|佛山市|韶关市|江门市|湛江市|茂名市|肇庆市|惠州市|梅州市|汕尾市|河源市|阳江市|清远市|潮州市|揭阳市|云浮市");
    cityArray[20] = new Array("广西壮族自治区", "南宁市|柳州市|桂林市|梧州市|北海市|防城港市|钦州市|贵港市|玉林市|南宁地区市|柳州地区市|贺州市|百色市|河池市");
    cityArray[21] = new Array("海南省", "海口市|三亚市|五指山市|琼海市|儋州市|文昌市|万宁市|东方市|定安县|屯昌县|澄迈县|临高县|白沙黎族自治县|昌江黎族自治县|乐东黎族自治县|陵水黎族自治县|保亭黎族苗族自治县|琼中黎族苗族自治县|西沙群岛|南沙群岛|中沙群岛的岛礁及其海域");
    cityArray[22] = new Array("四川省", "成都市|绵阳市|德阳市|自贡市|攀枝花市|广元市|内江市|乐山市|南充市|宜宾市|广安市|达川市|雅安市|眉山市|甘孜藏族自治州|凉山彝族自治州|泸州市|阿坝藏族羌族自治州");
    cityArray[23] = new Array("贵州省", "贵阳市|六盘水市|遵义市|安顺市|铜仁地区|黔西南布依族苗族自治州|毕节地区|黔东南苗族侗族自治州|黔南布依族苗族自治州");
    cityArray[24] = new Array("山西省", "太原市|大同市|阳泉市|长治市|晋城市|朔州市|吕梁市|忻州市|晋中市|临汾市|运城市");
    cityArray[25] = new Array("西藏自治区", "拉萨市|日喀则地区|山南地区|林芝地区|昌都地区|阿里地区|那曲地区");
    cityArray[26] = new Array("陕西省", "西安市|宝鸡市|咸阳市|铜川市|渭南市|延安市|榆林市|汉中市|安康市|商洛市");
    cityArray[27] = new Array("甘肃省", "兰州市|嘉峪关市|金昌市|白银市|天水市|酒泉市|张掖市|武威市|定西市|陇南市|平凉市|庆阳市|临夏回族自治州|甘南藏族自治州");
    cityArray[28] = new Array("宁夏回族自治区", "银川市|石嘴山市|吴忠市|固原市|中卫市");
    cityArray[29] = new Array("青海省", "西宁市|海东地区|海南藏族自治州|海北藏族自治州|黄南藏族自治州|玉树藏族自治州|果洛藏族自治州|海西蒙古族藏族自治州");
    cityArray[30] = new Array("新疆维吾尔族自治区", "乌鲁木齐市|石河子市|克拉玛依市|伊犁哈萨克自治州|巴音郭楞蒙古自治州|昌吉回族自治州|克孜勒苏柯尔克孜自治州|博尔塔拉市|吐鲁番地区|哈密地区|喀什地区|和田地区|阿克苏地区|塔城地区|阿勒泰地区");
    cityArray[31] = new Array("云南省", "昆明市|大理白族自治州|曲靖市|玉溪市|昭通市|楚雄彝族自治州|红河哈尼族彝族自治州|文山壮族苗族自治州|思茅市|西双版纳傣族自治州|保山市|德宏傣族景颇族自治州|丽江市|怒江傈僳族自治州|迪庆藏族自治州|临沧市");
    cityArray[32] = new Array("香港特别行政区", "香港特别行政区");
    cityArray[33] = new Array("澳门特别行政区", "澳门特别行政区");
    cityArray[34] = new Array("台湾省", "台北市|高雄市|台中市|台南市|屏东市|南投市|云林市|新竹市|彰化市|苗栗市|嘉义市|花莲市|桃园县|宜兰县|基隆市|台东市|金门市|马祖市|澎湖市");
    function getCity(currProvince) {
//当前 所选择 的 省
        var city= $("#city").val();
        var currProvincecurrProvince = currProvince;
        if(currProvincecurrProvince==null  ||currProvincecurrProvince==''){
            currProvincecurrProvince="";
        }
        var i, j, k;
//清空 城市 下拉选单
        document.all.selCity.length = 0;
        for (i = 0; i < cityArray.length; i++) {
//得到 当前省 在 城市数组中的位置
            if (cityArray[i][0] == currProvince) {
//得到 当前省 所辖制的 地市
                tmpcityArray = cityArray[i][1].split("|")
                for (j = 0; j < tmpcityArray.length; j++) {
//填充 城市 下拉选单
                    if (j == 0) {
                        if (city == '') {
                            document.all.selCity.options[document.all.selCity.length] = new Option("全部", "",true,true);
                            document.all.selCity.options[document.all.selCity.length] = new Option(tmpcityArray[j], tmpcityArray[j]);
                        }else{
                            document.all.selCity.options[document.all.selCity.length] = new Option("全部", "");
                            document.all.selCity.options[document.all.selCity.length] = new Option(tmpcityArray[j], tmpcityArray[j],true,true);
                        }
                    } else {
                        if(city==tmpcityArray[j]){
                            document.all.selCity.options[document.all.selCity.length] = new Option(tmpcityArray[j], tmpcityArray[j],true,true);
                        }else{
                            document.all.selCity.options[document.all.selCity.length] = new Option(tmpcityArray[j], tmpcityArray[j]);
                        }
                    }
                }
            }
        }
    }
</script>
