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
            <div class="muted pull-left">首页广告【新增】|【修改】</div>
        </div>

        <div class="alert alert-error" id="alertErr" style="display: none;">
            <button class="close" data-dismiss="alert">×</button>
            <strong>Error!</strong> <span id="errodesc">This is an error message.</span>
        </div>
        <div class="block-content collapse in">
            <div class="span12">
                <form class="form-horizontal" id="myForm" name="myForm" action="${BasePath }/appindexadopen/save"
                      enctype="multipart/form-data" method="post">
                    <input type="hidden" id="type" name="type" value="${type }"/>
                    <input type="hidden" id="id" name="id" value="${obj.id }"/>
                    <input type="hidden" id="itemId" name="itemId" value="${itemId }"/>
                    <input type="hidden" id="adtype_3" name="adtype" value="1"/>
                    <input type="hidden" id="area" name="area" value=""/>
                    <input type="hidden" id="city" name="city" value="${city}"/>
                    <input type="hidden" id="direcType" name="direcType" value=""/>


                    <fieldset>
                        <div class="control-group">
                            <label class="control-label" for="adname" style="float: left;">广告名称：</label>

                            <div class="controls">
                                <input type="text" id="adname" name="adname" value="${obj.adName }"/><font color="red"></font>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="type" style="float: left;">平台：</label>

                            <div class="controls">
                                <select name="platform" id="platform" onchange="selectFuction(this.value)">
                                    <%--   <option value="99"
                                               <c:if test="${ (obj.platform!=0 && obj.platform!=1 &&obj.platform!=2 )|| obj.platform==99 }">selected="selected"</c:if>  >通用
                                       </option>--%>
                                    <option value="0"
                                            <c:if test="${obj.platform==0 }">selected="selected"</c:if> >
                                        Android
                                    </option>
                                    <option value="1"
                                            <c:if test="${obj.platform==1}">selected="selected"</c:if>  >IOS
                                    </option>
                                    <option value="2"
                                            <c:if test="${obj.platform==2 }">selected="selected"</c:if> >
                                        WP
                                    </option>
                                </select>
                            </div>
                        </div>


                        <%--                  <div class="control-group  form-inline">
                                              <label class="control-label" for="type" style="float: left;">平台：</label>

                                              <div class="controls">

                                                  <label class="checkbox">
                                                      <input type="radio" name="typeBtn" id="typeBtn" value="0"  <c:if test="${(obj.platform!=0 && obj.platform!=1)||obj.platform==0 }">checked</c:if> >android
                                                  </label>
                                                  <label class="checkbox">
                                                      <input type="radio" name="typeBtn" id="typeBtn1" value="1" <c:if test="${obj.platform==1 }">checked</c:if> >ios
                                                  </label>

                                              </div>
                                          </div>--%>

                        <div class="control-group  form-inline">
                            <label class="control-label" for="type" style="float: left;">同步到谷歌客户端：</label>

                            <div class="controls">
                                <label class="checkbox">
                                    <input type="checkbox" name="googleLink" id="googleLink" value="0"
                                           <c:if test="${obj.googleLink==0 }">checked</c:if> >
                                </label>
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" for="links" style="float: left;">链接：</label>

                            <div class="controls">
                                <input type="text" id="links" name="links" value="${obj.links }"/><font color="red"></font>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="viewmonitorlink" style="float: left;">MonitorLink：</label>

                            <div class="controls">
                                <input type="text" id="viewmonitorlink" name="viewmonitorlink" value="${obj.viewMonitorLink }"/><font color="red"></font>
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" for="startDate" style="float: left;">在线时间：</label>

                            <div class="controls  form-inline">
                                <input type="text" class="Wdate" id="startDate" name="startDate"
                                       onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'endDate\')}',readOnly:'false'})"/>
                                至： <input type="text" class="Wdate" id="endDate" name="endDate"
                                          onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'startDate\')}',readOnly:'false'})"/>
                            </div>
                            <br/>
                        </div>
                        <%--                     <div class="control-group">
                                                 <label class="control-label" for="type" style="float: left;">定向类型：</label>

                                                 <div class="controls">
                                                     <select name="typeBtn2" id="typeBtn2" onchange="selectFuction(this.value)">
                                                         <option value="0"
                                                                 <c:if test="${obj.direcType==0 }">selected="selected"</c:if> >
                                                             全部
                                                         </option>
                                                         <option value="1"
                                                                 <c:if test="${obj.direcType==1}">selected="selected"</c:if>  >经期
                                                         </option>

                                                         <option value="2"
                                                                 <c:if test="${obj.direcType==2 }">selected="selected"</c:if> >
                                                             区域
                                                         </option>
                                                     </select>
                                                 </div>
                                             </div>--%>
                        <%--                     <div class="control-group  form-inline" id="userStateFlag">
                                                 <label class="control-label" for="status1" style="float: left;">经期:&nbsp;&nbsp;
                                                 </label>
                                                 &nbsp;&nbsp; &nbsp;

                                                 <label class="checkbox">
                                                     <input type="checkbox" name="status" id="status_1" value="1" &lt;%&ndash;<c:if test="${obj.userStatus==1 }">checked</c:if> &ndash;%&gt; >月经期
                                                 </label>
                                                 <label class="checkbox">
                                                     <input type="checkbox" name="status" id="status_2" value="2" &lt;%&ndash;<c:if test="${obj.userStatus==2 }">checked</c:if>&ndash;%&gt;  >卵泡期
                                                 </label>
                                                 <label class="checkbox">
                                                     <input type="checkbox" name="status" id="status_4" value="4" &lt;%&ndash;<c:if test="${obj.userStatus==4 }">checked</c:if>&ndash;%&gt;  >排卵期
                                                 </label>
                                                 <label class="checkbox">
                                                     <input type="checkbox" name="status" id="status_8" value="8" &lt;%&ndash;<c:if test="${obj.userStatus==8 }">checked</c:if>&ndash;%&gt;  >黄体期
                                                 </label>
                                                 &lt;%&ndash;                                    <label class="checkbox">
                                                                                         <input type="checkbox" name="status" id="status_5" value="5">魔瘦
                                                                                     </label>&ndash;%&gt;
                                             </div>--%>


                        <div class="control-group" id="clientVerFlag">
                            <label class="control-label" for="sheng" style="float: left;">投放城市：</label>

                            <div class="controls">
                                <select id="selProvince" onChange="getCity(this.options[this.selectedIndex].value)">
                                    <%--         <select name="sheng" id="sheng">--%>
                                    <%--      <option value="" <c:if test="${obj.direcType==0 }">selected="selected"</c:if> >
                                              全部
                                          </option>--%>
                                    <option value="" value=""  <c:if test="${provice==null  || provice=='' }"></c:if> >全部</option>
                                    <%--         <c:forEach items="${provinceList}" var="obj1">

                                             <option value="${obj1.key}"    &lt;%&ndash; <c:if test="${obj.area!=null  &&  obj.area==obj1.id  }">selected="selected"</c:if> &ndash;%&gt;>${obj1.value}</option>
                                             </c:forEach>--%>

                                    <%--                                     <c:forEach items="${provinceList}" var="obj1">
                                     <option value="${obj1.id}"     <c:if test="${obj.area!=null  &&  obj.area==obj1.id  }">selected="selected"</c:if> >${obj1.name}</option>
                                 </c:forEach>--%>


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

                            <%--        <option  <c:if test="${provice!=null  && provice=='' }">selected="selected" </c:if> value="其它">其它</option>--%>

                                </select>

                                <%--             <select id="selCity">

                                                 <option>-城市-</option>

                                             </select>

                                             </select>--%>

                                <select name="selCity" id="selCity">

                                </select>
                            </div>
                        </div>
                        <div class="control-group  form-inline">
                            <label class="control-label" for="type" style="float: left;">显示次数：</label>

                            <div class="controls">
                                <label class="checkbox">
                                    <input type="radio" name="displaynum"  value="1"
                                           <c:if test="${obj.displayNum==null  ||  obj.displayNum==1 }">checked</c:if> >每天一次
                                </label>
                                <label class="checkbox">
                                    <input type="radio" name="displaynum" id="" value="-1"
                                           <c:if test="${obj.displayNum==0 }">checked</c:if> >每次均显示
                                </label>
                            </div>
                        </div>
                        <div class="control-group" id="uploadDiv">
                            <label class="control-label" for="adpics" style="float: left;">图片：</label>
                            <input type="hidden" id="p1" name="p1" value="${adpics}"/>
                            <input type="hidden" id="p2" name="p2" value="${adpics1}"/>
                            <input type="hidden" id="p3" name="p3" value="${adpics2}"/>
                            <div class="controls">
                                <input class="input-xlarge focused" name="adpics" id="adpics" value="${adpics }"
                                       type="file"/><font id="imageLimit" color="red" >图片规格：600*240 </font>
                                <br>
                                <c:if test="${adpics!=null && adpics!=''}">
                                    <img alt="" id="img1" src="${imageHost }${adpics}" width="80px" height="80px">
                                </c:if>
                            </div>
                            <div class="controls" id="imagepics1">
                                <input class="input-xlarge focused" name="adpics1" id="adpics1" value="${adpics1 }"
                                       type="file"/><font id="imageLimit1" color="red">图片规格：600*240 </font>
                                <br>
                                <c:if test="${adpics1!=null && adpics1!=''}">
                                    <img alt=""  id="img2" src="${imageHost }${adpics1}" width="80px" height="80px">
                                </c:if>
                            </div>
                            <div class="controls" id="imagepics2">
                                <input class="input-xlarge focused" name="adpics2" id="adpics2" value="${adpics2 }"
                                       type="file"/><font id="imageLimit2" color="red" >图片规格：600*240 </font>
                                <br>
                                <c:if test="${adpics2!=null && adpics2!=''}">
                                    <img alt=""  id="img3" src="${imageHost }${adpics2}" width="80px" height="80px">
                                </c:if>
                            </div>
                        </div>
                        <div class="form-actions">
                            <button type="button" id="myBtn" onclick="saveForm()" class="btn btn-primary">提交</button>
                        </div>
                    </fieldset>
                    <input type="hidden" name="statusForm" id="statusForm" value=""/>
                    <input type="hidden" name="flag" id="flag" value=""/>


                </form>
            </div>
        </div>
    </div>
    <!-- /block -->
</div>
<script>

    /**
     *去掉空格 以及计算长度 中文长度2 英文 数字为1  16个字符 意味长度32
     * @param str
     * @returns {*}
     */
    function strlen(str) {
        if (str == null) return 0;
        if (typeof str != "string") {
            str += "";
        }
        return str.replace(/^\s+|\s+$/g, "").replace(/[^\x00-\xff]/g, "01").length;
    }
    var flag = '0';
    function selectFuction(value) {
        // $("#imageLimit").val( );
        if (value == '0') {
            $("#imagepics1").show();
            $("#imagepics2").show();
            $("#p1").val("");
            $("#p2").val("");
            $("#p3").val("");
            $("#img1").attr("src","");
            $("#img2").attr("src","");
            $("#img3").attr("src","");
            $("#adpics").val("");
            $("#adpics1").val("");
            $("#adpics2").val("");
            document.getElementById("imageLimit").innerHTML = "图片规格：320*480";
            document.getElementById("imageLimit1").innerHTML = "图片规格：480*800";
            document.getElementById("imageLimit2").innerHTML = "图片规格：1080*1920";
        } else if (value == '1') {
            $("#imagepics1").show();
            $("#imagepics2").show();
            $("#p1").val("");
            $("#p2").val("");
            $("#p3").val("");
            $("#img1").attr("src","");
            $("#img2").attr("src","");
            $("#img3").attr("src","");
            $("#adpics").val("");
            $("#adpics1").val("");
            $("#adpics2").val("");
            document.getElementById("imageLimit").innerHTML = "图片规格：640*960";
            document.getElementById("imageLimit1").innerHTML = "图片规格：640*1136";
            document.getElementById("imageLimit2").innerHTML = "图片规格：1080*1920";
        } else {
            $("#p1").val("");
            $("#p2").val("");
            $("#p3").val("");
            $("#img1").attr("src","");
            $("#img2").attr("src","");
            $("#img3").attr("src","");
            $("#adpics").val("");
            $("#adpics1").val("");
            $("#adpics2").val("");
            document.getElementById("imageLimit").innerHTML = "";
            document.getElementById("imageLimit1").innerHTML = "";
            document.getElementById("imageLimit2").innerHTML = "";
            $("#imagepics1").hide();
            $("#imagepics2").hide();
            $("#imagepics").hide();
        }
        //  $("#flag").val(flag);//空设置为-1
    }
    function saveForm() {
        var adname = $.trim($("#adname").val());
        var title = $.trim($("#title").val());
        var startDate = $("#startDate").val();
        var endDate = $("#endDate").val();
        var link = $.trim($("#link").val());
        var buttonText = $.trim($("#buttonText").val());
        var type = $("#typeBtn").val();
        var type2 = $("#typeBtn2").val();
        var sheng = $("#selProvince").val();
        var shi = $("#selCity").val();
        var viewmonitorlink = $.trim($("#viewmonitorlink").val());
        var links = $.trim($("#links").val());
        $("#direcType").val(type2);
        if (sheng == null || sheng == '') {
            $("#area").val("");
        } else {
            if (shi == null || shi == '') {
                $("#area").val(sheng + "#");
            } else {
                $("#area").val(sheng + "#" + shi);
            }
        }
        var id = $("#id").val();
        var pic = $("#adpics").val();//用户图标
        var pic1 = $("#adpics1").val();//用户图标
        var pic2 = $("#adpics2").val();//用户图标

        var p1 = $("#p1").val();//用户图标
        var p2 = $("#p2").val();//用户图标
        var p3 = $("#p3").val();//用户图标
        var value = $("#platform").val();
        if (value == '0') {
            if (( pic == '' &&p1=='' ) || ( pic1 == '' && p2=='') || (p3==''&& pic2== '')) {
                alert("请上传图片！");
                return false;
            }

        } else if (value == '1') {
            if (( pic == '' &&p1=='' ) || ( pic1 == '' && p2=='') || (p3==''&& pic2== '')) {
                alert("请上传图片！");
                return false;
            }
        } else{
            if (p1=='' && pic == '') {
                alert("请上传图片！");
                return false;
            }
        }

        if (adname == "") {
            alert("请输入广告名称！");
            return false;
        }

        if (links == "") {
            alert("请输入Links！");
            return false;
        }
 /*       if (viewmonitorlink == "") {
            alert("请输入monitorlink！");
            return false;
        }*/
        if (startDate == "") {
            alert("请输入开始时间！");
            return false;
        }


        if (endDate == "") {
            alert("请输入结束时间！");
            return false;
        }
        /*
         if (adname == "") {
         alert("请输入标题！");
         return false;
         }else if (strlen(title)> 30) {
         alert("标题不能超过15个字符！");
         return false;
         }

         $("#title").val(title);
         if (content == "") {
         alert("请输入内容！");
         return false;
         }else if (strlen(content)>400 ) {
         alert("内容最多200字");
         return false;
         }
         $("#content").val(content);
         if (buttonText == "") {
         alert("按钮文案不能为空！");
         return false;
         } else if  (strlen(buttonText)> 20) {
         alert("按钮文字不能超过10个字符！");
         return false;
         }
         $("#buttonText").val(buttonText);
         if (link == "" && link == "") {
         alert("请输入链接！");
         return false;
         }
         $("#link").val(link);
         if (startDate == "") {
         alert("请输入开始时间！");
         return false;
         }
         if (endDate == "") {
         alert("请输入结束时间！");
         return false;
         }*/

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
<script type="text/javascript">
    $(document).ready(function () {

        getCity( "${provice}");
       // alert(1);
        var value = $("#platform").val();
        if (value == '0') {
            $("#imagepics1").show();
            $("#imagepics2").show();

            document.getElementById("imageLimit").innerHTML = "图片规格：320*480";
            document.getElementById("imageLimit1").innerHTML = "图片规格：480*800";
            document.getElementById("imageLimit2").innerHTML = "图片规格：1080*1920";
        } else if (value == '1') {
            $("#imagepics1").show();
            $("#imagepics2").show();
            document.getElementById("imageLimit").innerHTML = "图片规格：640*960";
            document.getElementById("imageLimit1").innerHTML = "图片规格：640*1136";
            document.getElementById("imageLimit2").innerHTML = "图片规格：1080*1920";
        } else {
            document.getElementById("imageLimit").innerHTML = "";
            document.getElementById("imageLimit1").innerHTML = "";
            document.getElementById("imageLimit2").innerHTML = "";
            $("#imagepics1").hide();
            $("#imagepics2").hide();
        }

        setByIdFormatTime("startDate", '${startDate}');  //startDate
        setByIdFormatTime("endDate", '${endDate}');

    });


</script>
<script language="javascript" type="text/javascript">

    //定义 城市 数据数组

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
