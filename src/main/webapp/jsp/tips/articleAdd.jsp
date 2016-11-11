<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<jsp:include page="../include/head.jsp"/>
	<script type="text/javascript" src="${BasePath }/js/kindeditor/kindeditor-min.js"></script>
	<script type="text/javascript" src="${BasePath }/js/kindeditor/lang/zh_CN.js"></script>
<script>
        var editorIntro;
        KindEditor.ready(function (K) {
           editorIntro = K.create('textarea[name="article"]', {
               filterMode: true,
               htmlTags: {
                   span: ['.color'],
                   p: [],
                   strong: [],
                   a: ["href", "target"],
                   //br: [],
                   img: ["src", "width", "height"]
               },
	            newlineTag:"p",
                uploadJson : '${BasePath}/article/uploadimage',
			    items: [ 'undo','redo','image','multiimage','forecolor','bold', 'link','source','preview','fullscreen'],
                afterChange: function () {
                    this.sync();
                }
            });
        });
	</script>
	<style>
		body{
			padding-top: 0px;
		}
	</style>
<!-- Body -->
<div class="container-fluid">
						<div class="block">
							<div class="navbar navbar-inner block-header">
								<div class="muted pull-left">添加文章 </div>
							</div>
							
							<div class="alert alert-error" id="alertErr" style="display: none;">
							<button class="close" data-dismiss="alert">×</button>
							<strong>Error!</strong> <span id="errodesc">This is an error message.</span>
						</div>
							<div class="block-content collapse in">
								<div >
									<form class="form-horizontal" id="saveArticle" name="saveArticle" action="${BasePath }/article/save" method="post" enctype="multipart/form-data">
										<input type="hidden" id="id" name="id" value="${article.id }"/>
 										<input type="hidden" id="majiaUid" name="majiaUid" value="${article.majiaUid }"/>
										<input type="hidden" id="groupId" name="groupId" value="${article.topicCategoryId }"/>
                                        <div class="control-group">
											<label class="control-label" for="url" style="float: left;">链接：</label>
											<div class="controls">
											 	 <input class="input-xlarge focused" name="url" id="url" value="${article.url }" type="text" /> &nbsp; 
											 	 <button type="button" class="btn btn-primary btn-success btn-small" onclick="getParseJson()">提交</button>
											</div>
                                        </div>
										<div class="control-group">
											<label class="control-label" for="title" style="float: left;">标题：</label>
											<div class="controls">
											 	 <input class="input-xlarge focused" name="title" id="title" value="${article.title }" type="text" />
											</div>
                                         </div>
										<div class="control-group">
											<label class="control-label" for="article" style="float: left;">正文：</label>
											<div class="controls" >
												<textarea id="article" name="article" cols="100" rows="8" style="position:fixed;padding-top: 100px; width:100%;height:600px;visibility:hidden;">${article.oriContent }</textarea>
											</div>
                                        </div>
                                        <div class="control-group" >
                                            <label class="control-label" for="pic" style="float: left;">头图：</label>
                                            <div class="controls">
                                                <input class="input-xlarge focused" name="pic" id="pic" value="${article.pic }"   type="file" />图片为正方形，最少600X600
                                                <br>
                                                <c:if test="${article.pic!=null && article.pic!=''}">
                                                    <img alt="" src="${imageHost }${article.pic }"  width="80px"  height="80px">
                                                </c:if>
                                            </div>
                                        </div>
                                  	 	<div class="control-group">
											<label class="control-label" for="groupName" style="float: left;">小组：</label>
											<div class="controls">
												<select   id="groupIdName"  name="groupIdName">
														<option  value="-1"></option>
														<c:forEach items="${groupList }" var="group">
																<option  value="${group.id }_${group.title}"     >${group.title }</option>
														</c:forEach>
												</select>
													or 	<input class="input-xlarge focused inline" name="groupName" id="groupName" value="${article.topicCategoryName }" type="text" onchange="checkGroupName()"/>&nbsp;&nbsp;&nbsp;<img id="groupNameImage"   alt="" src="${BasePath }/image/blank.gif"/>
											</div>
                                         </div>
                                         <div class="control-group">
											<label class="control-label" for="majiaIdName" style="float: left;">马甲：</label>
											<div class="controls">
												<select   id="majiaIdName"  name="majiaIdName">
                                                    <option></option>
														<c:forEach items="${userList }" var="user">
																<c:if test="${user.nick!=null && user.nick!='' }">
																	<option  value="${user.uid}_${user.nick}"   <c:if test="${user.uid==article.majiaUid }">selected="selected" </c:if>    >${user.nick }</option>
																</c:if>
														</c:forEach>
												</select>
                                                <%--or  <input class="input-xlarge focused" name="majiaUid" id="majiaUid" value="${article.majiaUid }" type="text" />()--%>
                                                or  <input class="input-xlarge focused" name="majiaNick" id="majiaNick" value="${article.majiaNick }" type="text" onchange="checkMajiaNick()"/>&nbsp;&nbsp;&nbsp;<img id="majiaNickImage"  alt="" src="${BasePath }/image/blank.gif"/><font color="red">(请输入马甲昵称)</font>
											</div>
                                         </div>
                                         <div class="control-group">
										 	<label class="control-label" for="publishDate" style="float: left;">发布时间：</label>
											<div class="controls">
												<input type="text" id="publishDate" name="publishDate" value="" class="Wdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'%y-%M-%d %H:%m:%s',readOnly:'false'})" />
											</div>
                                         </div>
										<div class="form-actions">
											<input type="button" id="btn" class="btn btn-primary" value="保存" />
										</div>
									</form>
									<form id="hiddenForm" name="hiddenForm" action="${BasePath }/article/parse" method="post">
										<input type="hidden" name="hiddenUrl" id="hiddenUrl"/>
									</form>
									<form id="checkGroupNameForm" name="checkGroupNameForm" action="${BasePath }/article/checkGroupName" method="post">
										<input type="hidden" name="hiddenGroupName" id="hiddenGroupName"/>
									</form>
									<form id="checkMajiaNickForm" name="checkMajiaNickForm" action="${BasePath }/article/checkMajiaNick" method="post">
										<input type="hidden" name="hiddenMajiaNick" id="hiddenMajiaNick"/>
									</form>
								</div>
							</div>
						</div>
					</div>
<script type="text/javascript">

// 验证小组名称
function checkGroupName() {
	var groupName = $("#groupName").val();
	$("#hiddenGroupName").val(groupName);
	if (groupName != null && groupName != "") {
	  $('#checkGroupNameForm').ajaxSubmit(function(data){
      	 if(data.errno==1){
			  $("#alertErr").show();
			  $("#errodesc").html(data.errdesc);
			  $("#groupNameImage").attr("src","${BasePath}/image/no.png");
		  }else{
			  $("#alertErr").hide();
			  $("#errodesc").html("");
			  $("#groupId").val(data.groupId);
			  $("#groupNameImage").attr("src","${BasePath}/image/ok.png");
		 }
      });
	}else{
		$("#alertErr").hide();
		$("#errodesc").html("");
		$("#groupId").val("");
		$("#groupNameImage").attr("src","${BasePath}/image/ok.png");
	}
}
//验证马甲昵称
function checkMajiaNick() {
	var majiaNick = $("#majiaNick").val();
	$("#hiddenMajiaNick").val(majiaNick);
	if (majiaNick != null && majiaNick != "") {
	  $('#checkMajiaNickForm').ajaxSubmit(function(data){
      	 if(data.errno==1){
			  $("#alertErr").show();
			  $("#errodesc").html(data.errdesc);
             $("#majiaUid").val("");
			  $("#majiaNickImage").attr("src","${BasePath}/image/no.png");
		  }else{
			  $("#alertErr").hide();
			  $("#errodesc").html("");
			  $("#majiaUid").val(data.majiaUid);
			  $("#majiaNickImage").attr("src","${BasePath}/image/ok.png");
		 }
      });
	}else{
		$("#alertErr").hide();
		$("#errodesc").html("");
		$("#majiaUid").val("");
		$("#majiaNickImage").attr("src","${BasePath}/image/ok.png");
	}
}


$(function() {
	setByIdFormatTime("publishDate","${article.publishTime}");
});
//ajax 提交
function getParseJson(){
	var url=$("#url").val();
	if(url==''){
		alert("链接不能为空！");
		return false;
	}
	$("#hiddenUrl").val(url);
    $('#hiddenForm').ajaxSubmit(function(data){
       	 if(data.errno==1){
			  $("#alertErr").show();
			  $("#errodesc").html(data.errdesc);
		  }else{
			 $("#title").val(data.data.title);
			 editorIntro.html(data.data.body);
		 }
    });
}
$('#btn').click(function(){
	var flag=checkForm();
	if(flag){
		$("#btn").attr("disabled","disabled");
        $('#saveArticle').ajaxSubmit(function(data){
          if(data.errno==0){
        	  alert("操作成功！");
              $("#btn").removeAttr("disabled");
        	//  window.parent.closeModel();
          }else  if(data.errno==1){
        	  $("#alertErr").show();
    		  $("#errodesc").html(data.errdesc);
    		  $("#btn").removeAttr("disabled");
          }
        });
	}
});

function checkForm(){
// 	var startDate=$("#url").val();
// 	if(startDate=="") {
// 		alert("请输入URL！");
// 		return false;
// 	}
	var title=$("#title").val();
	if(title==""){
		alert("活动标题不能为空！");
		return false;
	}
	var endDate=$("#article").val();
	if(endDate=="") {
		alert("请输入正文！");
		return false;
	}
	var groupIdName=$("#groupIdName").val();
	var upTime=$("#groupName").val();
	var groupId=$("#groupId").val();
	if(groupIdName=="-1" && upTime==""){
		alert("请选择小组！");
		return false;
	}
	if(upTime!="" && groupId=="" ) {
		alert("小组匹配不正确！");
		return false;
	}
	var majiaUid=$("#majiaUid").val();
	var majiaNick=$("#majiaNick").val();
	if(majiaNick!="" && majiaUid=="") {
		alert("马甲匹配不正确！");
		return false;
	}
	var pic=$("#publishDate").val();
	if(pic==""){
		alert("请选择发布时间!");
		return false;
	}
	return true;
}
</script>