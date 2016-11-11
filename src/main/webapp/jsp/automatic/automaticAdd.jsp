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
            <div class="muted pull-left">添加 | 编辑 </div>
        </div>

        <div class="alert alert-error" id="alertErr" style="display: none;">
            <button class="close" data-dismiss="alert">×</button>
            <strong>Error!</strong> <span id="errodesc">This is an error message.</span>
        </div>
        <div class="block-content collapse in">
            <div class="span12">
                <form class="form-horizontal" id="addForm" name="addForm" action="${BasePath }/automatic/save" method="post">
                    <input type="hidden" id="type" name="type" value="${type }"/>
                    <input type="hidden" id="itemId" name="itemId" value="${itemId }"/>
                    
                    <input type="hidden" id="id" name="id" value="${automaticFocus.id }"/>
                    <fieldset>
                        <div class="control-group">
                            <label class="control-label"  style="float: left;">用户状态：</label>
                            <div class="controls">
                            		<select name="userStatus"  id="userStatus" >
											<option  value="-1" <c:if test="${automaticFocus.userStatus==-1 }"> selected="selected"</c:if>>全部</option>
											<option  value="0" <c:if test="${automaticFocus.userStatus==0 }"> selected="selected"</c:if>>记经期</option>
											<option  value="1" <c:if test="${automaticFocus.userStatus==1 }"> selected="selected"</c:if>>备孕</option>
											<option  value="2" <c:if test="${automaticFocus.userStatus==2 }"> selected="selected"</c:if>>怀孕中</option>
											<option  value="3" <c:if test="${automaticFocus.userStatus==3 }"> selected="selected"</c:if>>宝妈</option>
									</select>                                        
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"  style="float: left;">持续时间：</label>
                            <div class="controls">
									<input type="text" id="startTime" name="startTime"
                                       value="${automaticFocus.startTime}" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'%y-%M-%d',maxDate:'#F{$dp.$D(\'endTime\')}',readOnly:'false'})"/>
									至
									<input type="text" id="endTime" name="endTime"
                                       value="${automaticFocus.endTime}" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'startTime\')}',readOnly:'false'})"/>
                            </div>
                        </div>
                          <div class="control-group">
                            <label class="control-label"  style="float: left;">城市：</label>
                            <div class="controls">
                            	<select name="province"  id="province"  onchange="getCity2List()">
                            		<option  value="0" >全部</option>
                            		<c:forEach items="${provinceList}" var="obj">
											<option  value="${obj.id }" <c:if test="${automaticFocus.province==obj.id }"> selected="selected"</c:if>>${obj.name }</option>
                            		</c:forEach>
                            	</select>
                            	<select name="city"  id="city"  onchange="getCity3List()">
                            		<option  value="0" >全部</option>
	                            	<c:forEach items="${cityList}" var="obj">
												<option  value="${obj.id }" <c:if test="${automaticFocus.city==obj.id }"> selected="selected"</c:if>>${obj.name }</option>
	                            		</c:forEach>
                            	</select>
                            		<select name="county"  id="county" >
                            			<option  value="0" >全部</option>
		                            	<c:forEach items="${countyList}" var="obj">
													<option  value="${obj.id }" <c:if test="${automaticFocus.county==obj.id }"> selected="selected"</c:if>>${obj.name }</option>
		                            		</c:forEach>
	                            	</select>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"  style="float: left;">平台：</label>
                            <div class="controls">
                            	<select name="platform"  id="platform" >
											<option  value="-1" <c:if test="${automaticFocus.platform==-1 }"> selected="selected"</c:if>>全部</option>
											<option  value="0" <c:if test="${automaticFocus.platform==0 }"> selected="selected"</c:if>>Android</option>
											<option  value="1" <c:if test="${automaticFocus.platform==1 }"> selected="selected"</c:if>>ios</option>
									</select>          
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"  style="float: left;">年龄：</label>
                            <div class="controls">
                            	<select name="ageType"  id="ageType" >
											<option  value="0" <c:if test="${automaticFocus.ageType==0 }"> selected="selected"</c:if>>全部</option>
											<option  value="1" <c:if test="${automaticFocus.ageType==1 }"> selected="selected"</c:if>>20岁以下</option>
											<option  value="2" <c:if test="${automaticFocus.ageType==2 }"> selected="selected"</c:if>>20到30岁</option>
											<option  value="3" <c:if test="${automaticFocus.ageType==3 }"> selected="selected"</c:if>>30岁以上</option>
									</select>          
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"  style="float: left;">注册方式：</label>
                            <div class="controls">
                            	<select name="registerType"  id="registerType" >
											<option  value="0" <c:if test="${automaticFocus.registerType==0 }"> selected="selected"</c:if>>全部</option>
											<option  value="1" <c:if test="${automaticFocus.registerType==1 }"> selected="selected"</c:if>>qq</option>
											<option  value="2" <c:if test="${automaticFocus.registerType==2 }"> selected="selected"</c:if>>微信</option>
											<option  value="3" <c:if test="${automaticFocus.registerType==3 }"> selected="selected"</c:if>>微博</option>
											<option  value="4" <c:if test="${automaticFocus.registerType==4 }"> selected="selected"</c:if>>手机</option>
									</select>          
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"  style="float: left;">加入小组UID：</label>
                            <div class="controls">
									<textarea id="groupIds" name="groupIds" rows="3" cols="3">${automaticFocus.groupIds}</textarea>
                            </div>
                            <div class="controls">
                            		<font color="red">批量输入请使用英文逗号分隔</font>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"  style="float: left;">关注用户UID：</label>
                            <div class="controls">
									<textarea id="userIds" name="userIds" rows="3" cols="3">${automaticFocus.userIds}</textarea>
                            </div>
                            <div class="controls">
                            		<font color="red">批量输入请使用英文逗号分隔</font>
                            </div>
                        </div>
                        
                        <div class="form-actions">
                            <button type="button" id="myBtn" onclick="saveForm()" class="btn btn-primary">保存</button>
                        </div>
                    </fieldset>
                </form>
            </div>
        </div>
    </div>
    <!-- /block -->
</div>
<script>

	function getCity2List(){
		//清空city2 city3
		document.getElementById('city').length = 0;
		document.getElementById('county').length = 0;
		
		
		document.getElementById("city").add(new Option("全部",0));
		document.getElementById("county").add(new Option("全部",0));
		
		var city1Id = $("#province").val();
		var path = "${BasePath }/automatic/getCity?level=2&id=" + city1Id;
		$.ajax({
			 type:"POST",
			 url:path,
			 datatype: "json",
			 success:function(data){
				 $.each(data.cList,function(i,item){
					 document.getElementById("city").add(new Option(item.name,item.id));
				 });
			 }   
		});
	}
	
	function getCity3List(){
		//清空city3
		document.getElementById('county').length = 0;
		
		
		document.getElementById("county").add(new Option("全部",0));
		var city2Id = $("#city").val();
		var path = "${BasePath }/automatic/getCity?level=3&id=" + city2Id;
		$.ajax({
			 type:"POST",
			 url:path,
			 datatype: "json",
			 success:function(data){
				 $.each(data.cList,function(i,item){
					 document.getElementById("county").add(new Option(item.name,item.id));
				 });
			 }   
		});
	}
	
	
	
	

    function saveForm() {
        var startTime = $("#startTime").val();
        var endTime = $("#endTime").val();
        var groupIds = $("#groupIds").val();
        var userIds = $("#userIds").val();
        if (startTime == "") {
            alert("持续时间不能为空！");
            return false;
        }
        if (endTime == "") {
            alert("持续时间不能为空！");
            return false;
        }
        if (groupIds == "" && userIds == "") {
            alert("加入小组UID,关注用户UID至少添加一个！");
            return false;
        }
        
        $("#myBtn").attr("disabled", "disabled");
        $('#addForm').ajaxSubmit(function (data) {
            if (data.errno == 1) {
                $("#myBtn").removeAttr("disabled");
                $("#alertErr").show();
                $("#errodesc").html(data.errdesc);
            } else {
                alert("操作成功！");
                window.parent.closeModel();
            }
        });
    }
</script>

