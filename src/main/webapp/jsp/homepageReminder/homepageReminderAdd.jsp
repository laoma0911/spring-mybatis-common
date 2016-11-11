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
            <div class="muted pull-left">首页提醒 【新增】|【修改】</div>
        </div>

        <div class="alert alert-error" id="alertErr" style="display: none;">
            <button class="close" data-dismiss="alert">×</button>
            <strong>Error!</strong> <span id="errodesc">This is an error message.</span>
        </div>
        <div class="block-content collapse in">
            <div class="span12">
                <form class="form-horizontal" id="myForm" name="myForm" action="${BasePath }/homepageReminder/save"
                      enctype="multipart/form-data" method="post">
                    <input type="hidden" id="type" name="type" value="${type }"/>
                    <input type="hidden" id="id" name="id" value="${json.data.id }"/>
                    <input type="hidden" id="itemId" name="itemId" value="${itemId }"/>
                    <fieldset>

                        <div class="control-group  form-inline">
                            <label class="control-label" for="type" style="float: left;">平台：</label>

                            <div class="controls">

                                <label class="checkbox">
                                    <input type="radio" name="typeBtn" id="typeBtn" value="0"  <c:if test="${(json.data.platform!=0 && json.data.platform!=1)||json.data.platform==0 }">checked</c:if> >android
                                </label>
                                <label class="checkbox">
                                    <input type="radio" name="typeBtn" id="typeBtn1" value="1" <c:if test="${json.data.platform==1 }">checked</c:if> >ios
                                </label>

                            </div>
                        </div>

                        <div class="control-group  form-inline">
                            <label class="control-label" for="type" style="float: left;">同步到谷歌客户端：</label>
                            <div class="controls">
                                <label class="checkbox">
                                    <input type="checkbox" name="toGoogle" id="toGoogle" value="1"  <c:if test="${json.data.toGoogle==1 }">checked</c:if> >
                                </label>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="type" style="float: left;">用户群：</label>

                            <div class="controls">
                                <select name="typeBtn2" id="typeBtn2" onchange="selectFuction(this.value)">
                                    <option value="1"
                                            <c:if test="${json.data.clientVer==-1 }">selected="selected"</c:if>  >用户状态
                                    </option>
                                    <option value="0" <c:if test="${json.data.clientVer!=-1 }">selected="selected"</c:if> >
                                        客户端版本
                                    </option>
                                </select>
                            </div> </div>
                        <div class="control-group  form-inline" id="userStateFlag">
                            <label class="control-label" for="status1" style="float: left;">用户状态:&nbsp;&nbsp;

                            </label>
                            &nbsp;&nbsp; &nbsp;
                            <label class="checkbox">
                                <input type="radio" name="status" id="status_0" value="0" <c:if test="${json.data.userStatus==0 }">checked</c:if>      >全部
                            </label>
                            <label class="checkbox">
                                <input type="radio" name="status" id="status_1" value="1" <c:if test="${json.data.userStatus==1 }">checked</c:if>  >记经期
                            </label>
                            <label class="checkbox">
                                <input type="radio" name="status" id="status_2" value="2" <c:if test="${json.data.userStatus==2 }">checked</c:if>  >备孕
                            </label>
                            <label class="checkbox">
                                <input type="radio" name="status" id="status_3" value="3" <c:if test="${json.data.userStatus==3 }">checked</c:if>  >怀孕中
                            </label>
                            <label class="checkbox">
                                <input type="radio" name="status" id="status_4" value="4" <c:if test="${json.data.userStatus==4 }">checked</c:if>  >宝妈
                            </label>
                            <%--                                    <label class="checkbox">
                                                                    <input type="checkbox" name="status" id="status_5" value="5">魔瘦
                                                                </label>--%>
                        </div>




                        <div class="control-group" id="clientVerFlag" >
                            <label class="control-label" for="clientVer" style="float: left;">客户端版本号：</label>

                            <div class="controls">
                                <input type="text" id="clientVer" name="clientVer" value="${json.data.clientVer }"/> <font color="red"> ver</font>
                            </div>
                        </div>



                        <div class="control-group">
                            <label class="control-label" for="title" style="float: left;">标题：</label>

                            <div class="controls">
                                <input type="text" id="title" name="title" value="${json.data.title }"/><font color="red">不超过15个字</font >
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="content" style="float: left;">内容：</label>

                            <div class="controls">
                                <textarea class="input-xlarge focused" name="content"
                                          id="content">${json.data.content }</textarea><font color="red">支持换行 一行代表一条记录,最多200字</font>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="buttonText" style="float: left;">按钮文案：</label>

                            <div class="controls">
                                <input type="text" id="buttonText" name="buttonText" value="${json.data.buttonText }"/><font color="red">不超过10个字</font>
                            </div>
                        </div>
                        
                        <div class="control-group">
                            <label class="control-label" for="link" style="float: left;">链接：</label>

                            <div class="controls">
                                <input type="text" id="link" name="link" id="iosUrl" value="${json.data.link}"/>
                            </div>
                        </div>

                        <div class="control-group" id="uploadDiv">
                            <label class="control-label" for="pic" style="float: left;">上传图片：</label>

                            <div class="controls">
                                <input class="input-xlarge focused" name="pic" id="pic" value="${json.data.pic }"
                                       type="file"/>图片规格：600*240
                                <br>
                                <c:if test="${json.data.pic!=null && json.data.pic!=''}">
                                    <img alt="" src="${imageHost }${json.data.pic }" width="80px" height="80px">
                                </c:if>
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" for="startDate" style="float: left;">在线时间：</label>

                            <div class="controls  form-inline">
                                <input type="text" class="Wdate" id="startDate" name="startDate"
                                       onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'endDate\')}',readOnly:'false'})"/>
                                至：          <input type="text" class="Wdate" id="endDate" name="endDate"
                                                   onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'startDate\')}',readOnly:'false'})"/>
                            </div>
                            <br/>
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
    var flag='0';
    function  selectFuction( value){
        if(value=='0'){
            flag='0';

            //客户端版本
            $("#clientVerFlag").show();
            $("#userStateFlag").hide();
        }else{
            flag='1';
            $("#clientVerFlag").hide();
            $("#userStateFlag").show();
        }
        $("#flag").val(flag);//空设置为-1
    }
    function saveForm() {
        var clientVer = $.trim($("#clientVer").val());
        var content = $.trim($("#content").val());
        var title = $.trim($("#title").val());
        var startDate = $("#startDate").val();
        var endDate = $("#endDate").val();
        var link = $.trim($("#link").val());
        var buttonText = $.trim($("#buttonText").val());
        var type = $("#typeBtn").val();
        var type2 = $("#typeBtn2").val();

        //用户状态
        var targetUserTime = new Array();
        var flagPeriod = false;
        $("input[name='status']:checked").each(function () {
            var txt = $(this).val();
            if (txt == 0) {
                targetUserTime = new Array();
                targetUserTime.push(0);
                flagPeriod = true;
            } else if (flagPeriod == false) {
                targetUserTime.push(txt);
            }
        });
        var id = $("#id").val();
        var pic = $("#pic").val();//用户图标
        if (type == "" || type2 == "" ) {
            alert("请选择平台！");
            return false;
        }

        if(type2=='1'){
            //用户状态的判断
            if (targetUserTime.length == 0) {
                alert("请选择用户状态！");
                return false;
            }
            $("#statusForm").val(targetUserTime);  //用户状态
            $("#clientVer").val("-1");//空设置为-1
        }else{
            $("#statusForm").val("-1");//空设置为-1

            if (clientVer == "") {
                alert("请输入客户端版本号！");
                return false;
            }
            if (isNaN(clientVer)){
                alert("请输入客户端版本号！");
                return false;
            }
            if ((clientVer.indexOf("-") == 0)||!(clientVer.indexOf(".") == -1)){
                alert("客户端版本号必须是整数");
                return false;
            }


        }

        if (title == "") {
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
        }

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
        $("#userStateFlag").hide();
        // alert(${json.data.clientVer}=="-1" );
        if("${json.data.clientVer}"=="-1"){
            $("#clientVerFlag").hide();
            $("#userStateFlag").show();
        }
        if("${json.data.userStatus}"=="-1"){
            $("#clientVerFlag").show();
            $("#userStateFlag").hide();
        }
        if("${json.data.platform}"!="0" ||  "${json.data.platform}"!="1"  ){
            $("#typeBtn").val("0");
        }


        //setCheckBoxValue("${json.data.userStatus}", "status");
        setByIdFormatTime("startDate", '${json.data.startDate}');
        setByIdFormatTime("endDate", '${json.data.endDate}');
        //年龄阶段
        /* $("input[name='status']").click(function (obj) {//全选
         if (this.id == 'status_0') {
         var flag = this.checked;
         $("input[name='status']").each(function () {
         this.checked = flag;
         });
         } else {
         var flag = this.checked;
         if (flag) {
         var sign = true;
         $("input[name='status']").each(function () {
         if (this.id != 'status_0' && this.checked == false) {
         sign = false;
         }
         });
         if (sign) {
         $("input[name='status']").each(function () {
         if (this.id == 'status_0') {
         this.checked = true;
         }
         });
         } else {
         $("#status_0").attr("checked", false);
         }
         } else {
         $("#status_0").attr("checked", false);
         }
         }
         });
         */
    });



</script>
