<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../include/head.jsp"/>
<style>
    body{
        padding-top: 0px;
    }
</style>
<!-- Body -->
<div class="container-fluid">
    <!-- block -->
    <div class="block">
        <div class="navbar navbar-inner block-header">
        </div>

        <div class="alert alert-error" id="alertErr" style="display: none;">
            <button class="close" data-dismiss="alert">×</button>
            <strong>Error!</strong> <span id="errodesc">This is an error message.</span>
        </div>
        <div class="block-content collapse in">
            <div class="span12">
                <form class="form-horizontal" id="myForm" name="myForm"  action="${BasePath }/tips/save"  enctype="multipart/form-data"   method="post">
                    <input type="hidden" id="id" name="id" value="${obj.id }"/>
                    <input type="hidden" name="hiddenPic" id="hiddenPic" value="${obj.pic}"/>
                    <fieldset>
                        <div class="control-group">
                            <label class="control-label" for="tipsCategoryId" style="float: left;">分类：</label>
                            <div class="controls">
                                <select id="tipsCategoryId"  name="tipsCategoryId" >
                                    <c:forEach items="${tipcCategoryList.data}" var="category">
                                        <option value="${category.id}" <c:if test="${category.id==obj.tipsCategoryId}" >selected="selected" </c:if>  >${category.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="displayOrder" style="float: left;">排序ID：</label>
                            <div class="controls">
                                <input type="text"  id="displayOrder" name="displayOrder" value="${obj.displayOrder}"  />
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" for="title" style="float: left;">贴士标题：</label>
                            <div class="controls">
                                <input type="text"  id="title" name="title" value="${obj.title}"  />
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="content" style="float: left;">贴士内容：</label>
                            <div class="controls">
                                <textarea id="content" class="input-xlarge focused" name="content">${obj.content}</textarea><span style="color: #ff0000">输入贴士内容（限180字以内）</span>
                            </div>
                        </div>


                        <div class="control-group" id="uploadDiv"   >
                            <label class="control-label" for="pic" style="float: left;">上传图片：</label>
                            <div class="controls">
                                <input class="input-xlarge focused" name="pic" id="pic" value="${obj.pic }"   type="file" /><span style="color: #ff0000">(尺寸：640*300)</span>
                                <br>
                                <c:if test="${obj.pic!=null && obj.pic!=''}">
                                    <div id="picDiv">
                                    <img alt="" src="${imageHost }${obj.pic }"  width="80px"  height="80px"><input type="button" class="btn btn-small btn-danger" onclick="delPic()" value="删除图片" />
                                    </div>
                                </c:if>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="keyword" style="float: left;">关键字：</label>
                            <div class="controls">
                                <textarea class="input-xlarge focused"  name="keyword"  id="keyword">${obj.keyword }</textarea><span style="color: #ff0000">关键字之间用‘,’隔开</span>
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" for="keyword" style="float: left;">用户状态：</label>
                            <div class="controls">
                                <label class="checkbox inline">
                                    <input type="checkbox" id="userStatus_0" name="userStatus" value="0" <c:if test="${obj==null}"> checked </c:if>/>通用
                                </label>
                                <label class="checkbox inline">
                                    <input type="checkbox" id="userStatus_1" name="userStatus" value="1"/>记经期
                                </label>
                                <label class="checkbox inline ">
                                    <input type="checkbox" id="userStatus_2" name="userStatus" value="2"/>备孕
                                </label>
                                <label class="checkbox inline">
                                    <input type="checkbox" id="userStatus_3" name="userStatus" value="3"/>怀孕
                                </label>
                                <label class="checkbox inline">
                                    <input type="checkbox" id="userStatus_4" name="userStatus" value="4"/>宝妈
                                </label>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="keyword" style="float: left;">用户年龄：</label>
                            <div class="controls">
                                <table>
                                    <tr>
                                        <td>
                                            <label class="checkbox inline">
                                                <input type="checkbox" id="userAge_0"  name="userAge" <c:if test="${obj==null}"> checked </c:if> value="0"/>通用
                                            </label>
                                        </td>
                                        <td>
                                            <label class="checkbox">
                                                <input type="checkbox" id="userAge_1" name="userAge" value="1"/>14岁前
                                            </label>
                                        </td>
                                        <td>
                                            <label class="checkbox">
                                                <input type="checkbox" id="userAge_2" name="userAge" value="2"/>15~20岁
                                            </label>
                                        </td>
                                        <td>
                                            <label class="checkbox">
                                                <input type="checkbox" id="userAge_3" name="userAge" value="3"/>21~26岁
                                            </label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>

                                        </td>
                                        <td>
                                            <label class="checkbox">
                                                <input type="checkbox" id="userAge_4" name="userAge" value="4"/>27～35岁
                                            </label>
                                        </td>
                                        <td>
                                            <label class="checkbox">
                                                <input type="checkbox" id="userAge_5" name="userAge" value="5"/>36～45岁
                                            </label>
                                        </td>
                                        <td>
                                            <label class="checkbox">
                                                <input type="checkbox" id="userAge_6" name="userAge" value="6"/>45岁后
                                            </label>
                                        </td>
                                    </tr>
                                    </table>
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" for="userPeriod_0" style="float: left;">用户时期：</label>
                            <div class="controls">
                                <label class="checkbox inline">
                                    <input type="checkbox" id="userPeriod_0" name="userPeriod" value="0" <c:if test="${obj==null}"> checked </c:if>/>通用
                                </label>
                                <label class="checkbox inline">
                                    <input type="checkbox" id="userPeriod_1" name="userPeriod" value="1"/>月经期
                                </label>
                                <label class="checkbox inline ">
                                    <input type="checkbox" id="userPeriod_2" name="userPeriod" value="2"/>卵泡期
                                </label>
                                <label class="checkbox inline">
                                    <input type="checkbox" id="userPeriod_3" name="userPeriod" value="3"/>排卵期
                                </label>
                                <label class="checkbox inline">
                                    <input type="checkbox" id="userPeriod_4" name="userPeriod" value="4"/>黄体期
                                </label>
                                <label class="checkbox inline">
                                    <input type="checkbox" id="userPeriod_5" name="userPeriod" value="5"/>孕期
                                </label>
                            </div>
                        </div>


                        <div class="control-group">
                            <label class="control-label" for="keyword" style="float: left;">特殊日期：</label>
                            <div class="controls">
                                <table>
                                    <tr>
                                        <td>
                                            <label class="checkbox">
                                                <input type="checkbox" id="specialDate_1" name="specialDate" value="1"/>经期开始
                                            </label>
                                        </td>
                                        <td>
                                            <label class="checkbox">
                                                <input type="checkbox" id="specialDate_2" name="specialDate" value="2"/>经期结束
                                            </label>
                                        </td>
                                        <td>
                                            <label class="checkbox">
                                                <input type="checkbox" id="specialDate_3" name="specialDate" value="3"/>排卵期第1天
                                            </label>
                                        </td>
                                        <td>
                                           <label class="checkbox">
                                                <input type="checkbox" id="specialDate_4" name="specialDate" value="4"/>排卵期倒数第2天
                                            </label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <label class="checkbox">
                                                <input type="checkbox" id="specialDate_5" name="specialDate" value="5"/>排卵日
                                            </label>
                                        </td>
                                        <td>
                                            <label class="checkbox">
                                                <input type="checkbox" id="specialDate_6" name="specialDate" value="6"/>排卵前5天
                                            </label>
                                        </td>
                                        <td>
                                            <label class="checkbox">
                                                <input type="checkbox" id="specialDate_7" name="specialDate" value="7"/>排卵前1天
                                            </label>
                                        </td>
                                        <td>
                                            <label class="checkbox">
                                                <input type="checkbox" id="specialDate_8" name="specialDate" value="8"/>排卵后1天
                                            </label>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <label class="checkbox">
                                                <input type="checkbox" id="specialDate_9" name="specialDate" value="9"/>黄体期第1天
                                            </label>
                                        </td>
                                        <td>
                                            <label class="checkbox">
                                                <input type="checkbox" id="specialDate_10" name="specialDate" value="10"/>黄体期第2天
                                            </label>
                                        </td>
                                        <td>
                                            <label class="checkbox">
                                                <input type="checkbox" id="specialDate_11" name="specialDate" value="11"/>黄体期倒数第1天
                                            </label>
                                        </td>
                                        <td>
                                            <label class="checkbox">
                                                <input type="checkbox" id="specialDate_12" name="specialDate" value="12"/>黄体期倒数第2天
                                            </label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>


                        <div class="control-group">
                            <label class="control-label" for="keyword" style="float: left;">经期症状：</label>
                            <div class="controls">
                                <label class="checkbox inline">
                                    <input type="checkbox" id="periodDetail_1" name="periodDetail" value="1"/>经期延长
                                </label>
                                <label class="checkbox inline">
                                    <input type="checkbox" id="periodDetail_2" name="periodDetail" value="2"/>经期缩短
                                </label>
                                <label class="checkbox inline">
                                    <input type="checkbox" id="periodDetail_3" name="periodDetail" value="3"/>周期延长
                                </label>
                                <label class="checkbox inline">
                                    <input type="checkbox" id="periodDetail_4" name="periodDetail" value="4"/>周期缩短
                                </label>
                            </div>
                        </div>


                        <div class="control-group">
                            <label class="control-label" for="userStatus_0" style="float: left;">身体症状：</label>
                            <div class="controls">
                                <table>
                                    <tr>
                                        <td>
                                            <label class="checkbox">
                                                <input type="checkbox" id="bodyDetail_1" name="bodyDetail" value="1"/>头痛
                                            </label>
                                        </td>
                                        <td>
                                            <label class="checkbox">
                                                <input type="checkbox" id="bodyDetail_2" name="bodyDetail" value="2"/>眩晕
                                            </label>
                                        </td>
                                        <td>
                                            <label class="checkbox">
                                                <input type="checkbox" id="bodyDetail_3" name="bodyDetail" value="3"/>粉刺
                                            </label>
                                        </td>
                                        <td>
                                            <label class="checkbox">
                                                <input type="checkbox" id="bodyDetail_4" name="bodyDetail" value="4"/>发热
                                            </label>
                                        </td>
                                        <td>
                                            <label class="checkbox">
                                                <input type="checkbox" id="bodyDetail_5" name="bodyDetail" value="5"/>乳房胀痛
                                            </label>
                                        </td>
                                        <td>
                                            <label class="checkbox">
                                                <input type="checkbox" id="bodyDetail_6" name="bodyDetail" value="6"/>身体酸痛
                                            </label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <label class="checkbox">
                                                <input type="checkbox" id="bodyDetail_7" name="bodyDetail" value="7"/>小腹坠胀
                                            </label>
                                        </td>
                                        <td>
                                            <label class="checkbox">
                                                <input type="checkbox" id="bodyDetail_8" name="bodyDetail" value="8"/>腹痛
                                            </label>
                                        </td>
                                        <td>
                                            <label class="checkbox">
                                                <input type="checkbox" id="bodyDetail_29" name="bodyDetail" value="29"/>腰酸
                                            </label>
                                        </td>
                                        <td>
                                            <label class="checkbox">
                                                <input type="checkbox" id="bodyDetail_9" name="bodyDetail" value="9"/>贪冷饮
                                            </label>
                                        </td>
                                        <td>
                                            <label class="checkbox">
                                                <input type="checkbox" id="bodyDetail_10" name="bodyDetail" value="10"/>嗜辛辣
                                            </label>
                                        </td>
                                        <td>
                                            <label class="checkbox">
                                                <input type="checkbox" id="bodyDetail_11" name="bodyDetail" value="11"/>食欲不佳
                                            </label>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <label class="checkbox">
                                                <input type="checkbox" id="bodyDetail_12" name="bodyDetail" value="12"/>恶心
                                            </label>
                                        </td>
                                        <td>
                                            <label class="checkbox">
                                                <input type="checkbox" id="bodyDetail_13" name="bodyDetail" value="13"/>呕吐
                                            </label>
                                        </td>
                                        <td>
                                            <label class="checkbox">
                                                <input type="checkbox" id="bodyDetail_14" name="bodyDetail" value="14"/>腹泻
                                            </label>
                                        </td>
                                        <td>
                                            <label class="checkbox">
                                                <input type="checkbox" id="bodyDetail_15" name="bodyDetail" value="15"/>便秘
                                            </label>
                                        </td>
                                        <td>
                                            <label class="checkbox">
                                                <input type="checkbox" id="bodyDetail_16" name="bodyDetail" value="16"/>烦躁
                                            </label>
                                        </td>
                                        <td>
                                            <label class="checkbox">
                                                <input type="checkbox" id="bodyDetail_17" name="bodyDetail" value="17";/>失眠
                                            </label>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <label class="checkbox">
                                                <input type="checkbox" id="bodyDetail_18" name="bodyDetail" value="18"/>多梦
                                            </label>
                                        </td>
                                        <td>
                                            <label class="checkbox">
                                                <input type="checkbox" id="bodyDetail_19" name="bodyDetail" value="19"/>瘙痒
                                            </label>
                                        </td>
                                        <td>
                                            <label class="checkbox">
                                                <input type="checkbox" id="bodyDetail_20" name="bodyDetail" value="20"/>异味
                                            </label>
                                        </td>
                                        <td>
                                            <label class="checkbox">
                                                <input type="checkbox" id="bodyDetail_21" name="bodyDetail" value="21"/>非经期出血
                                            </label>
                                        </td>
                                        <td>
                                            <label class="checkbox">
                                                <input type="checkbox" id="bodyDetail_22" name="bodyDetail" value="22"/>白带粘稠
                                            </label>
                                        </td>
                                        <td>
                                            <label class="checkbox">
                                                <input type="checkbox" id="bodyDetail_28" name="bodyDetail" value="28"/>黄绿色白带
                                            </label>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <label class="checkbox">
                                                <input type="checkbox" id="bodyDetail_23" name="bodyDetail" value="23"/>白带拉丝
                                            </label>
                                        </td>
                                        <td>
                                            <label class="checkbox">
                                                <input type="checkbox" id="bodyDetail_24" name="bodyDetail" value="24"/>白带量多
                                            </label>
                                        </td>
                                        <td>
                                            <label class="checkbox">
                                                <input type="checkbox" id="bodyDetail_25" name="bodyDetail" value="25"/>白带渣块状
                                            </label>
                                        </td>
                                        <td>
                                            <label class="checkbox">
                                                <input type="checkbox" id="bodyDetail_27" name="bodyDetail" value="27"/>白带泡沫状
                                            </label>
                                        </td>
                                        <td>
                                            <label class="checkbox">
                                                <input type="checkbox" id="bodyDetail_26" name="bodyDetail" value="26"/>白带带血色
                                            </label>
                                        </td>
                                    </tr>


                                </table>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="topicId" style="float: left;">topic_Id：</label>
                            <div class="controls">
                                <input type="text" name="topicId" id="topicId" value="${obj.topicId}" />
                            </div>
                        </div>
                        <div class="form-actions">
                            <button type="button" id="myBtn"  onclick="saveForm()" class="btn btn-primary">保存</button>
                        </div>
                    </fieldset>
                    <input type="hidden"   name="statusForm" id="statusForm"  value=""/>
                    <input type="hidden"   name="ageForm" id="ageForm"  value=""/>


                </form>
            </div>
        </div>
    </div>
    <!-- /block -->
</div>
<script>
    function delPic(){
        if(confirm("确定要删除图片吗？")){
            $("#picDiv").hide();
            $("#hiddenPic").val("");
        }
    }
    function saveForm(){
        var id=$("#id").val();
        var order=$("#displayOrder").val();
        if(order==''){
            alert("排序值不能为空！");
            return false;
        }else if(isNaN(order)){
            alert("排序值必须为数字!");
            return false;
        }
        var title=$("#title").val();
        if(title==""){
            alert("标题不能为空！");
            return false;
        }else if(title.length>30){
            alert("标题长度不能超过30个字符！");
            return false;
        }
        var content=$("#content").val();
        if(content==''){
            alert("内容不能为空！");
            return false;
        }else if(content.length>180){
            alert("内容不能超过180字！");
            return false;
        }
//        var pic=$("#pic").val();
//        if(id=="" && pic==""){
//            alert("图片不能为空！");
//            return false;
//        }
        var keyword=$("#keyword").val();
        if(keyword==''){
            alert("关键字不能为空！");
            return false;
        }

        var userStatus = new Array();
        $("input[name='userStatus']:checked").each(function () {
            var txt = $(this).val();
            userStatus.push(txt);
        });
        if (userStatus.length == 0) {
            alert("请选择用户状态");
            return false;
        }

        var userAge = new Array();
        $("input[name='userAge']:checked").each(function () {
            var txt = $(this).val();
            userAge.push(txt);
        });
        if (userAge.length == 0) {
            alert("请选择用户年龄");
            return false;
        }


        var userPeriod = new Array();
        $("input[name='userPeriod']:checked").each(function () {
            var txt = $(this).val();
            userPeriod.push(txt);
        });
        if (userPeriod.length == 0) {
            alert("请选择用户时期");
            return false;
        }
        $("#myBtn").attr("disabled","disabled");
        $('#myForm').ajaxSubmit(function(data){
            if(data.errno==1){
                $("#alertErr").show();
                $("#errodesc").html(data.errdesc);
                $("#myBtn").removeAttr("disabled");
            }else{
                alert("操作成功！");
                window.parent.closeModel();
            }
        });
    }
</script>
<script type="text/javascript">
    $(document).ready(function () {
        setCheckBoxValueNoDefault("${obj.userStatus}", "userStatus");
        setCheckBoxValueNoDefault("${obj.userAge}", "userAge");
        setCheckBoxValueNoDefault("${obj.userPeriod}", "userPeriod");
        setCheckBoxValueNoDefault("${obj.specialDate}", "specialDate");
        setCheckBoxValueNoDefault("${obj.periodDetail}", "periodDetail");
        setCheckBoxValueNoDefault("${obj.bodyDetail}", "bodyDetail");

        //用户状态
        $("input[name='userStatus']").click(function (obj) {//全选
            if(this.id=='userStatus_0'){
                var sign=this.checked;
                $("input[name='userStatus']").each(function () {
                    if(this.id!='userStatus_0') {
                        this.checked = sign?false:false;
                    }
                });
            }else{
                var result=checkAllSelected("userStatus");
                $("input[name='userStatus']").each(function () {
                    if(result==1 || result==2){
                        if(this.id=='userStatus_0') {
                            this.checked = true;
                        }else{
                            this.checked=false;
                        }
                    }else if(result==0){
                        if(this.id=='userStatus_0') {
                            this.checked = false;
                        }
                    }
                });
            }
        });
        //用户年龄
        $("input[name='userPeriod']").click(function (obj) {//全选
            if(this.id=='userPeriod_0'){
                var sign=this.checked;
                $("input[name='userPeriod']").each(function () {
                    if(this.id!='userPeriod_0') {
                        this.checked = sign?false:false;
                    }
                });
            }else{
                var result=checkAllSelected("userPeriod");
                $("input[name='userPeriod']").each(function () {
                    if(result==1 || result==2){
                        if(this.id=='userPeriod_0') {
                            this.checked = true;
                        }else{
                            this.checked=false;
                        }
                    }else if(result==0){
                        if(this.id=='userPeriod_0') {
                            this.checked = false;
                        }
                    }
                });
            }
        });

        //用户经期
        $("input[name='userAge']").click(function (obj) {//全选
            if(this.id=='userAge_0'){
                var sign=this.checked;
                $("input[name='userAge']").each(function () {
                    if(this.id!='userAge_0') {
                        this.checked = sign?false:false;
                    }
                });
            }else{
                var result=checkAllSelected("userAge");
                $("input[name='userAge']").each(function () {
                    if(result==1 || result==2){
                        if(this.id=='userAge_0') {
                            this.checked = true;
                        }else{
                            this.checked=false;
                        }
                    }else if(result==0){
                        if(this.id=='userAge_0') {
                            this.checked = false;
                        }
                    }
                });
            }
        });
    });
    //0-有选中的   1-全部选中  2-全部未选中
    function checkAllSelected(name){
        var ok=false;
        var no=false;
        $("input[name="+name+"]").each(function () {
            if(this.id!=name+'_0') {
                if(this.checked){
                    ok=true;
                }else{
                    no=true;
                }
            }
        });
        if(ok && no){
            return 0;
        }else if(ok && !no){
            return 1;
        }else if(!ok && no){
            return 2;
        }
    }


</script>
