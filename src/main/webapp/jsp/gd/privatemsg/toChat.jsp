<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:include page="../../include/head.jsp" />


<style type="text/css">

.sendDiv
{
width: 100%;
position: relative;
padding: 0px 50px;
margin-top: 20px;
box-sizing: border-box;
min-height: 50px;
}

.sendDivCenter
{
width: 100%;
padding: 0px 50px;
box-sizing: border-box;
min-height: 50px;
word-break: break-all;
word-wrap: break-word;
}
.sendDivLeftImg
{
height: 100px;
position: absolute;
left: 0px;
top: 0px;
}
.sendDivRightImg
{
position: absolute;
right: 0px;
height: 100px;
top: 0px;
}

.sendZj
{
background-color: #FAD8DE;
}

.sendPt
{
background-color: #D6EDF3;
}

</style>

<div class="block navbar-inner">
	<div class="block-content collapse in">
		<div class="" style="overflow: scroll; width: 100%; height: 300px; overflow: auto; border: 0px solid #000000;" id="div_table_news" name="div_table_news">
					<div style="width: 100%; text-align: center;"><a onclick="prePage()">上 一 页</a></div>
		</div>
	</div>
</div>

<div class="block navbar-inner">
   <div class="block-content collapse in block-header">
   <form class="form-horizontal" id="myForm" name="myForm" action="${BasePath}/meiyue/privateMsg/sendMessage" enctype="multipart/form-data" method="post">
         <div>
         		<input type="hidden" value="${receiveUid }" id="receiveUid" name="receiveUid" >
         		<textarea id="content" name="content"  rows="2" style="width:95%;" ></textarea>
         	
         </div>
       	<div>
			       		<strong>发言UID：</strong>
			       		 <select name="sendUid"  id="sendUid" >
                                    <c:forEach items="${uList}" var="obj" >
                                        <option  value="${obj.id}">${obj.nick}</option>
                                    </c:forEach>
                                </select>
             			&nbsp;&nbsp;
             			<button type="button" id="myBtn" onclick="saveForm()" class="btn btn-success btn-small">发送</button>&nbsp;&nbsp;
             			<button type="button" id="myBtn" onclick="cPic()" class="btn btn-success btn-small">发送图片</button>&nbsp;&nbsp;
       	</div>
       	<input name="pic" id="pic" type="file" onchange="saveForm()"  style="visibility:hidden;" accept="image/*"/>
       	</form>
       </div>
   </div>


<script type="text/javascript">

function cPic(){
	$('#pic').trigger("click");
}

function saveForm() {
    $("#myBtn").attr("disabled", "disabled");
    $('#myForm').ajaxSubmit(function (data) {
        if (data.errno == 1) {
            $("#alertErr").show();
            $("#errodesc").html(data.errdesc);
        } else {
//             alert("操作成功！");
				$("#content").val("");
        }
    });
    
    $("#pic").val("");
    $("#myBtn").removeAttr("disabled");
}

//上一页
function prePage(){
// 	alert("上一页maxId:" + maxId + "    minId:" + minId);
	
	var path = "${BasePath}/meiyue/privateMsg/getChatList?uid=${receiveUid}&id=" + minId + "&orderBy=1";
	$.ajax({
		 type:"POST",
		 url:path,
		 datatype: "json",
		 success:function(data){
			 if(minId < 0){
				 maxId = data.startId;
				 minId = data.endId;
			 } else {
				 minId = data.endId;
			 }
			 assHtml(data.item,false);
		 }
	});
}

	var maxId = -1;//最大id
	var minId = -1;//最小id

	function consoleInfo(cb){
		
// 		alert("定时刷新maxId:" + maxId + "    minId:" + minId);
		
		var path = "${BasePath}/meiyue/privateMsg/getChatList?uid=${receiveUid}&id=" + maxId + "&orderBy=0";
		$.ajax({
			 type:"POST",
			 url:path,
			 datatype: "json",
			 success:function(data){
				 if(maxId < 0){
					 maxId = data.startId;
					 minId = data.endId;
				 } else {
					 maxId = data.endId;
				 }
				 assHtml(data.item,true);
			 }
		});
		cb();
	}
	
	function assHtml(rows,ascLive){
		var html = "";
		$.each(rows,function(i,item){
			var divVal = new Array();
			
			//判断左侧还是右侧 普通用户左侧  专家用户右侧
			if(item.type == 0){//左侧
				divVal.push( "<div class='sendDiv'>");
				divVal.push( "<div class='sendDivLeftImg'><img class='img-circle' src='"+item.icon+"' width='40px' height='40px' /></div>");
				divVal.push( "<div class='sendDivCenter sendPt'>");
				divVal.push( "<B>" + item.nick + "</B>&nbsp;&nbsp;&nbsp;");
				divVal.push( "<div style='float:right;'>"+item.dateline + "</div><br>");
				//判断是否是文字
				 if(item.messageType == 1){//文字
					 divVal.push( item.message);
				 } else if(item.messageType == 2){//图片
					 divVal.push( "<a href='"+item.message+"' ><img src='"+item.message+"' width='200px' height='50px' /></a><br>");
				 } else {
					 divVal.push( item.message);
				 }
				 divVal.push( "</div>");
				 divVal.push( "</div>");
			} else {
				//添加div
				divVal.push( "<div class='sendDiv'>");
				divVal.push( "<div class='sendDivCenter sendZj'>");
				divVal.push( "<B>"+item.nick+"</B>&nbsp;&nbsp;&nbsp;");
				divVal.push( "<div style='float:right;'>"+item.dateline+"</div><br>");
								
				//判断是否是文字
				 if(item.messageType == 1){//文字
					 divVal.push( item.message);
				 } else if(item.messageType == 2){//图片
					 divVal.push( "<a href='"+item.message+"' ><img src='"+item.message+"' width='200px' height='50px' /></a>");
				 } else {
					 divVal.push( item.message);
				 }
				
				divVal.push( "</div>");
				divVal.push( "<div class='sendDivRightImg'><img class='img-circle' src='" + item.icon + "' width='40px' height='40px' /></div>");
				divVal.push( "</div>");
				
			}
			html  += divVal.join('');
		});

		if(html != ""){
			if(ascLive){
				ascAdd(html);
				 var n = rows.length;
				 if(n > 0){
					 $("#div_table_news")[0].scrollTop = $("#div_table_news")[0].scrollHeight;	 
				 }
			} else {
				descAdd(html);
			}			
		}
	}
	
	//追加div
	function ascAdd(html){
		$("#div_table_news").append(html);
	}
	//插入div
	function descAdd(html){
		var $htmlnew = $(html);
		var $first = $("#div_table_news").find(".sendDiv").eq(0);
		$htmlnew.insertBefore($first);
	}
	

	var getNewFool = function() {
		var timer = null;
		var handle = function() {
			if (timer)
				clearTimeout(timer);
			consoleInfo(function() {
				timer = setTimeout(handle, 3000);
			});
		}
		timer = setTimeout(handle, 1000);
	}
	getNewFool();
</script>