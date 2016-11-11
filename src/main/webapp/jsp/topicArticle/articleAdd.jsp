<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../include/head.jsp"/>
<script type="text/javascript" src="${BasePath }/js/kindeditor/kindeditor-min.js"></script>
<script type="text/javascript" src="${BasePath }/js/kindeditor/lang/zh_CN.js"></script>


<!-- Bootstrap -->
    <script src="${BasePath}/bootstrap/bootstrap/js/bootstrap.min.js"></script>
    <script src="${BasePath}/bootstrap/vendors/jquery-1.9.1.min.js"></script>
    <link href="${BasePath}/bootstrap/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
    <link href="${BasePath}/bootstrap/bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet" media="screen">
    <link href="${BasePath}/bootstrap/vendors/easypiechart/jquery.easy-pie-chart.css" rel="stylesheet" media="screen">
    <link href="${BasePath}/bootstrap/assets/styles.css" rel="stylesheet" media="screen">
    <link href="${BasePath}/bootstrap/assets/table.css" rel="stylesheet" media="screen">
    <link href="${BasePath}/css/css.css" rel="stylesheet" media="screen">

    <%-- <link rel="stylesheet" href="${BasePath}/plugin/pages/pagination.css" media="all"/> --%>
    <!--分页样式-->
    <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
    <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

    <script src="${BasePath}/js/fixedtoolbar.js"></script>
    <script src="${BasePath}/js/pager.js"></script>
    <script src="${BasePath}/js/utils.js"></script>
    <script src="${BasePath}/js/My97DatePicker/WdatePicker.js"></script>
    <script src="${BasePath}/bootstrap/vendors/modernizr-2.6.2-respond-1.1.0.min.js"></script>
    <script src="${BasePath}/js/mediabox/mootools-core.js"></script>
    <script src="${BasePath}/js/mediabox/mediabox.js"></script>


    <script src="${BasePath}/js/jquery/form.js"></script>

	<script src="${BasePath}/js/jquery/form.js"></script>
<script>
    var editorIntro;
    KindEditor.ready(function (K) {
        editorIntro = K.create('textarea[name="article"]', {
            filterMode: true,
            htmlTags: {
                span: ['.color'],
                //p: [],
                strong: [],
                a: ["href", "target"],
                br: [],
                img: ["src", "width", "height"],
                input:["type","value","url","onclick","data-toggle","href","id","name","alt"],
        		embed:['src', 'name','id','width', 'height', 'type', 'loop', 'autostart', 'quality','style', 'align', 'allowscriptaccess', 'flashvars','allowfullscreen','/'],
        		vote:['vote','/'],
        		video:['id','name','src','controls','width', 'height'],
                div:['style']
            },
            newlineTag: "br",
            uploadJson: '${BasePath}/article/uploadimage',
            items: ['undo', 'redo', 'image', 'multiimage', 'forecolor', 'bold', 'link', 'source', 'preview', 'fullscreen','justifycenter'],
            afterChange: function () {
                this.sync();
            }
        });
        
        
        var obj = document.getElementsByTagName("div");//先得到所有的SPAN标记
        for(var i=0;i<obj.length;i++)
        {
        if(obj[i].className == 'ke-toolbar')//找出span标记中class=ke-toolbar的那个标记
        {
        var getObj = obj[i];
			getObj.innerHTML =  getObj.innerHTML + "<span><input type='button' onclick='fValue()'  value='添加铵钮'  data-toggle='modal' href='#myModal2' /></span>";
        }
        }
        
        var src=editorIntro.html();
        var re = /<embed.+id=\"(.*?)\".+name=\"(.*?)\".+src=\"(.*?)\"\s+.+?>/;
			while(true){
 			       var t = re.exec(src);
 			       if(t == null){
 			    	   break;
 			       }
                     src = src.replace(t[0].toString(), "&nbsp;&nbsp;<video id='"+t[1]+"' name='"+t[2]+"' src='"+t[3]+"' width='500' height='200' controls='controls' ></video>&nbsp;&nbsp;");
                }
        editorIntro.html(src);
        
    });
    
    
    
    var qobj = null;
    
    function fValue(obj){
    	if(obj != null){
			$("#buttontext").val(obj.value);
			$("#buttonurl").val(obj.alt);
			qobj = obj;
			$('#addButtons').trigger("click");
    	} else {
    		qobj = null;
    		$("#buttontext").val("");
			$("#buttonurl").val("");
    	}
    }
    
    function clearObj(){
    	qobj = null;
    }
    
    function addButton(){
    	var buttontext = $("#buttontext").val();
    	var buttonurl = $("#buttonurl").val();
    	
    	
    	if(buttontext.length <= 0){
    		alert("自定义按钮不为空!");
    		return;
    	}
    	
    	if(buttontext.indexOf(",") > 0){
    		alert("不能包含逗号!");
    		return;
    	}
    	
    	if(buttontext.length > 10){
    		alert("自定义按钮不能超过10个汉字!");
    		return ;
    	}
    	
    	if(buttonurl.trim().length <= 0){
    		alert("按钮链接不能为空!");
    		return ;
    	}
    	
    	if(buttonurl.indexOf(",") > 0){
    		alert("按钮链接中不能包含逗号!");
    		return;
    	}
    	
    	if(qobj == null){
    		editorIntro.insertHtml("<input type='button' OnClick='parent.fValue(this)' value='"+buttontext+"' alt='"+buttonurl+"' />");	
    	} else {
    		qobj.value = buttontext;
    		qobj.alt = buttonurl;
    		qobj = null;
    	}
    	
    	
    	$('#modclose').trigger("click");
    	
    }
    
    //提交视频 
    function comVideoUrl(){
    	
//     	//清除视频 标签 
//     	delVideoIndex();
    	
    	var videoUrl = $("#videoUrl").val();
    	var videoUrl2 = $("#videoUrl2").val();
    	var videoUrl3 = $("#videoUrl3").val();
    	var videoUrl4 = $("#videoUrl4").val();
    	var videoUrl5 = $("#videoUrl5").val();

    	//判断是否选择文件
    	if(videoUrl5 != ''){
    		//清除视频 
    		delVideoIndex(5);
    		//添加视频 
    		editorIntro.insertHtml("&nbsp;&nbsp;<video id=\"video5\" name=\"video5\" src=\""+videoUrl5+"\" width='500' height='200' controls=\"controls\" ></video>&nbsp;&nbsp;");
    		$("#videoUrlHid5").val(videoUrl5);
    	}
    	
    	//判断是否选择文件
    	if(videoUrl4 != ''){
    		//清除视频 
    		delVideoIndex(4);
    		//添加视频 
    		editorIntro.insertHtml("&nbsp;&nbsp;<video id=\"video4\" name=\"video4\" src=\""+videoUrl4+"\" width='500' height='200' controls=\"controls\" ></video>&nbsp;&nbsp;");
    		$("#videoUrlHid4").val(videoUrl4);
    	}
    	
    	//判断是否选择文件
    	if(videoUrl3 != ''){
    		//清除视频 
    		delVideoIndex(3);
    		//添加视频 
    		editorIntro.insertHtml("&nbsp;&nbsp;<video id=\"video3\" name=\"video3\" src=\""+videoUrl3+"\" width='500' height='200' controls=\"controls\" ></video>&nbsp;&nbsp;");
    		$("#videoUrlHid3").val(videoUrl3);
    	}
    	
    	//判断是否选择文件
    	if(videoUrl2 != ''){
    		//清除视频 
    		delVideoIndex(2);
    		//添加视频 
    		editorIntro.insertHtml("&nbsp;&nbsp;<video id=\"video2\" name=\"video2\" src=\""+videoUrl2+"\" width='500' height='200' controls=\"controls\" ></video>&nbsp;&nbsp;");
    		$("#videoUrlHid2").val(videoUrl2);
    	}
    	
    	//判断是否选择文件
    	if(videoUrl != ''){
    		//清除视频 
    		delVideoIndex(1);
    		//添加视频 
    		editorIntro.insertHtml("&nbsp;&nbsp;<video id=\"video1\" name=\"video1\" src=\""+videoUrl+"\" width='500' height='200' controls=\"controls\" ></video>&nbsp;&nbsp;");
    		$("#videoUrlHid").val(videoUrl);
    	}
    	
    	alert("上传成功");
    	
    }
    
    //清空视频 
    function clearVideo(){
    	delVideo();
    	$("#videoUrl").val("");
    	$("#videoUrl2").val("");
    	$("#videoUrl3").val("");
    	$("#videoUrl4").val("");
    	$("#videoUrl5").val("");
    	
    	$("#videoUrlHid").val("");
    	$("#videoUrlHid2").val("");
    	$("#videoUrlHid3").val("");
    	$("#videoUrlHid4").val("");
    	$("#videoUrlHid5").val("");
    	
    	
    	document.getElementById("fid1").innerHTML = "";
    	document.getElementById("fid2").innerHTML = "";
    	document.getElementById("fid3").innerHTML = "";
    	document.getElementById("fid4").innerHTML = "";
    	document.getElementById("fid5").innerHTML = "";
    }
    
    function delVideo(){
    	var html = editorIntro.html();
    	html = html.replace(/<video(.*?)>/,"");
    	html = html.replace(/<video(.*?)>/,"");
    	html = html.replace(/<video(.*?)>/,"");
    	html = html.replace(/<video(.*?)>/,"");
    	html = html.replace(/<video(.*?)>/,"");
    	editorIntro.html(html);
    	editorIntro.sync();
    }
    
    function delVideoIndex(videoIndex){
    	var html = editorIntro.html();
    	var ngx = "/<video[^<]*name=\"video"+videoIndex+"\"[^>]*>/";
    	html = html.replace(eval(ngx),"");
    	editorIntro.html(html);
    	editorIntro.sync();
    }
    
    
    //删除投票
    function deleteVote(){
    	var html = editorIntro.html();
    	html = html.replace("{{vote}}","");
    	editorIntro.html(html);
    	editorIntro.sync();
    	$("#voteId").val("");
    }
    
    function voteList(){
    	$('#addVote').trigger("click");
    }
    
    function selectVoteId(voteId){
    	$("#voteId").val(voteId);
    	
    	var html = editorIntro.html();
    	html = html.replace("{{vote}}","");
    	editorIntro.html(html);
    	editorIntro.sync();
    	editorIntro.insertHtml("{{vote}}");
    	
    	$('#voteListClose').trigger("click");
    }
    
    //清除图片
    function clearVideoPic(index){
    	if(index == 1){
    		$("#videoPic").val("");
        	$("#videoPicLive").val("");
        	$("#videoImgPic").attr("hidden","true");
    	} else {
    		$("#videoPic" + index).val("");
        	$("#videoPicLive" + index).val("");
        	$("#videoImgPic" + index).attr("hidden","true");        		
    	}
    }
    
</script>
<style>
    body {
        padding-top: 0px;
    }
</style>
<!-- Body -->
<div class="container-fluid">
    <div class="block">
        <div class="navbar navbar-inner block-header">
            <div class="muted pull-left">添加文章</div>
        </div>

        <div class="alert alert-error" id="alertErr" style="display: none;">
            <button class="close" data-dismiss="alert">×</button>
            <strong>Error!</strong> <span id="errodesc">This is an error message.</span>
        </div>
        <div class="block-content collapse in">
            <div>
            <input type='button' id='addButtons' name='addButtons'   data-toggle='modal' href='#myModal2'  value="abc" style='display:none'/>
            <input  type='button' id='addVote' name='addVote'   data-toggle='modal' href='#myModal3'  value="abc" style='display:none'/>
                <form class="form-horizontal" id="saveArticle" name="saveArticle" action="${BasePath }/topicArticle/save" enctype="multipart/form-data" method="post">
                    <input type="hidden" id="id" name="id" value="${article.id }"/>
                    <input type="hidden" id="currentTime" name="currentTime" value="${currentTime}"/>
                    
                    <input type="hidden" id="weixinId" name="weixinId" value="${weixinId }"/>
                    
                    <div class="control-group">
                        <label class="control-label" for="url" style="float: left;">链接：</label>

                        <div class="controls">
                            <input class="input-xlarge focused" name="url" id="url" value="${article.url }" type="text"/> &nbsp;
                            <button type="button" class="btn btn-primary btn-success btn-small" onclick="getParseJson()">提交</button>
                        </div>
                    </div>
                    
                    <div class="control-group" >
                                            <label class="control-label" for="vote" style="float: left;">投票：</label>
                                            <div class="controls">
                                                <input name="voteId" id="voteId" value="${article.voteId }"   type="hidden" />
                                                <input  class="btn" onclick="voteList()"  value="选择投票" type="button" class="btn"/>
                                                <input  class="btn" onclick="deleteVote()"  value="删除" type="button" class="btn"/> <font color="red">删除投票时需要选择删除</font>
                                            </div>
                                        </div>
                    
                    <div class="control-group">
                        <label class="control-label" for="title" style="float: left;">标题：</label>

                        <div class="controls">
                            <input class="input-xlarge focused" name="title" id="title" value="${article.title }" type="text"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="article" style="float: left;">正文：</label>

                        <div class="controls">
                            <textarea id="article" name="article" cols="100" rows="8" style="position:fixed;padding-top: 100px; width:100%;height:600px;visibility:hidden;">${article.oriContent }</textarea>
                        </div>
                    </div>
                    
                    
                    <div class="control-group" >
                                            <div class="controls">
                                            	选择视频：
                                            	<c:if test="${videoUrl!=null && videoUrl!=''}">
                                            		<font color="red" id="fid1">已选</font>
                                            	</c:if>
                                            	<input class="input-xlarge focused" name="videoUrl" id="videoUrl"   type="file" accept=""/>
                                            	<input type="hidden" id="videoUrlHid" name="videoUrlHid" value="${videoUrl} " />
                                            	
                                            	视频截图：
                                            	<input class="input-xlarge focused" name="videoPic" id="videoPic" value="${videopic }"   type="file" />
                                            	<input type="hidden"   name="videoPicLive" id="videoPicLive" value="${videopic }"    />	
                                            	<c:if test="${videopic!=null && videopic!=''}">
                                                    <img id="videoImgPic" name="videoImgPic" alt="" src="${imageHost }${videopic }"  width="80px"  height="80px">
                                                </c:if>
                                            	<input  class="btn" onclick="clearVideoPic(1)"  value="清空图片" type="button"/><font color="red">上传视频后请选择视频封面截图</font>
                                            </div>
                                        </div>
                                        
                                          <div class="control-group" >
                                            <div class="controls">
                                            	选择视频：
                                            	<c:if test="${videoUrl2!=null && videoUrl2!=''}">
                                            		<font color="red" id="fid2">已选</font>
                                            	</c:if>
                                            	<input class="input-xlarge focused" name="videoUrl2" id="videoUrl2"   type="file" />
                                            	<input type="hidden" id="videoUrlHid2" name="videoUrlHid2" value="${videoUrl2} " />
                                            	
                                            	视频截图：
                                            	<input class="input-xlarge focused" name="videoPic2" id="videoPic2" value="${videopic2 }"   type="file" />
                                            	<input type="hidden"   name="videoPicLive2" id="videoPicLive2" value="${videopic2 }"    />
                                            	<c:if test="${videopic2!=null && videopic2!=''}">
                                                    <img id="videoImgPic2" name="videoImgPic2" alt="" src="${imageHost }${videopic2 }"  width="80px"  height="80px">
                                                </c:if>	
                                            	<input  class="btn" onclick="clearVideoPic(2)"  value="清空图片" type="button"/><font color="red">上传视频后请选择视频封面截图</font>
                                            </div>
                                        </div>
                                        
                                        <div class="control-group" >
                                            <div class="controls">
                                            	选择视频：
                                            	<c:if test="${videoUrl3!=null && videoUrl3!=''}">
                                            		<font color="red" id="fid3">已选</font>
                                            	</c:if>
                                            	<input class="input-xlarge focused" name="videoUrl3" id="videoUrl3"   type="file" />
                                            	<input type="hidden" id="videoUrlHid3" name="videoUrlHid3" value="${videoUrl3} " />
                                            	
                                            	视频截图：
                                            	<input class="input-xlarge focused" name="videoPic3" id="videoPic3" value="${videopic3 }"   type="file" />
                                            	<input type="hidden"   name="videoPicLive3" id="videoPicLive3" value="${videopic3 }"    />
                                            	<c:if test="${videopic3!=null && videopic3!=''}">
                                                    <img id="videoImgPic3" name="videoImgPic3" alt="" src="${imageHost }${videopic3 }"  width="80px"  height="80px">
                                                </c:if>
                                            	<input  class="btn" onclick="clearVideoPic(3)"  value="清空图片" type="button"/><font color="red">上传视频后请选择视频封面截图</font>
                                            </div>
                                        </div>
                                        
                                          <div class="control-group" >
                                            <div class="controls">
                                            	选择视频：
                                            	<c:if test="${videoUrl4!=null && videoUrl4!=''}">
                                            		<font color="red" id="fid4">已选</font>
                                            	</c:if>
                                            	<input class="input-xlarge focused" name="videoUrl4" id="videoUrl4"   type="file" />
                                            	<input type="hidden" id="videoUrlHid4" name="videoUrlHid4" value="${videoUrl4} " />
                                            	
                                            	视频截图：
                                            	<input class="input-xlarge focused" name="videoPic4" id="videoPic4" value="${videopic4 }"   type="file" />
                                            	<input type="hidden"   name="videoPicLive4" id="videoPicLive4" value="${videopic4 }"    />
                                            	<c:if test="${videopic4!=null && videopic4!=''}">
                                                    <img id="videoImgPic4" name="videoImgPic4" alt="" src="${imageHost }${videopic4 }"  width="80px"  height="80px">
                                                </c:if>
                                            	<input  class="btn" onclick="clearVideoPic(4)"  value="清空图片" type="button"/><font color="red">上传视频后请选择视频封面截图</font>
                                            </div>
                                        </div>
                                        
                                          <div class="control-group" >
                                            <div class="controls">
                                            	选择视频：
                                            		<c:if test="${videoUrl5!=null && videoUrl5!=''}">
                                            		<font color="red" id="fid5">已选</font>
                                            	</c:if>
                                            	<input class="input-xlarge focused" name="videoUrl5" id="videoUrl5"   type="file" />
                                            	<input type="hidden" id="videoUrlHid5" name="videoUrlHid5" value="${videoUrl5} " />
                                            	
                                            	视频截图：
                                            	<input class="input-xlarge focused" name="videoPic5" id="videoPic5" value="${videopic5 }"   type="file" />
                                            	<input type="hidden"   name="videoPicLive5" id="videoPicLive5" value="${videopic5 }"    />
                                            	<c:if test="${videopic5!=null && videopic5!=''}">
                                                    <img id="videoImgPic5" name="videoImgPic5" alt="" src="${imageHost }${videopic5 }"  width="80px"  height="80px">
                                                </c:if>
                                            	<input  class="btn" onclick="clearVideoPic(5)"  value="清空图片" type="button"/><font color="red">上传视频后请选择视频封面截图</font>
                                            </div>
                                        </div>
                                            
                                          <div class="control-group" >
		                                          <div class="controls">
		                                          				<input  class="btn" onclick="clearVideo()"  value="清空视频" type="button"/>
                                         						<input  class="btn" onclick="comVideoUrl()"  value="提交视频" type="button"/><font color="red">删除视频时需要选择清空,只支持mp4格式</font>
		                                          </div>
                                          </div>
                    
                    
                    
<!-- 						   <div class="control-group" > -->
<!--                                             <label class="control-label" for="videoUrl" style="float: left;">选择视频：</label> -->
<!--                                             <div class="controls"> -->
<!--                                             	<input class="input-xlarge focused" name="videoUrl" id="videoUrl"   type="file" /> -->
<%--                                             	<input type="hidden" id="videoUrlHid" name="videoUrlHid" value="${article.videourl} " /> --%>
<!--                                                 <input  class="btn" onclick="clearVideo()"  value="清空" type="button"/> -->
<!--                                                 <input  class="btn" onclick="comVideoUrl()"  value="提交" type="button"/><font color="red">删除视频时需要选择清空,只支持mp4格式</font> -->
<!--                                             </div> -->
<!--                                         </div> -->



<!--                                          <div class="control-group" > -->
<!--                                             <label class="control-label" for="videoUrl" style="float: left;">视频截图：</label> -->
<!--                                             <div class="controls"> -->
<%--                                             	<input class="input-xlarge focused" name="videoPic" id="videoPic" value="${article.videopic }"   type="file" />	 --%>
<%--                                             	<input type="hidden"   name="videoPicLive" id="videoPicLive" value="${article.videopic }"    />	 --%>
<!--                                             	<input  class="btn" onclick="clearVideoPic()"  value="清空" type="button"/><font color="red">上传视频后请选择视频封面截图</font> -->
<!--                                                 <br> -->
<%--                                                 <c:if test="${article.videopic!=null && article.videopic!=''}"> --%>
<%--                                                     <img id="videoImgPic" name="videoImgPic"  alt="" src="${imageHost }${article.videopic }"  width="80px"  height="80px"> --%>
<%--                                                 </c:if> --%>
<!--                                             </div> -->
<!--                                         </div> -->
                    
                    
                    <div class="control-group" >
                        <label class="control-label" for="pic" style="float: left;">头图：</label>
                        <div class="controls">
                            <input class="input-xlarge focused" name="pic" id="pic" value="${article.pic }"   type="file" />图片为正方形，最小为600*600
                            <br>
                            <c:if test="${article.pic!=null && article.pic!=''}">
                                <img alt="" src="${imageHost }${article.pic }"  width="80px"  height="80px">
                            </c:if>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="majiaUid" style="float: left;">马甲UID：</label>
                        <div class="controls">
                            <select  onchange="getCategory(this)" >
                                <c:forEach items="${userTagsList}" var="userTags">
                                    <option value="${userTags.id}"  <c:if test="${userTagsId==userTags.id}">selected="selected"</c:if>    >   ${userTags.tagsName}</option>
                                </c:forEach>
                            </select>

                            <select id="majiaUid1" name="majiaUid1" >
                                <c:forEach items="${majiaList}" var="user">
                                    <option value="${user.uid}"  <c:if test="${user.uid==article.majiaUid}"> selected="selected" </c:if>  >${user.nick}</option>
                                </c:forEach>
                            </select>
                            or
                            <input class="input-xlarge focused" name="majiaUid" id="majiaUid" value="${article.majiaUid }" type="text"/><span style="color: #ff0000">(请填写马甲UID)</span>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="tagId" style="float: left;">标签：</label>
                        <div class="controls">
                            <select id="tagId" name="tagId" >
                                <c:forEach items="${topicTagList }" var="tag">
                                        <option value="${tag.id}" <c:if test="${tag.id==article.tagId }">selected="selected" </c:if>    >${tag.tag }</option>
                                </c:forEach>
                            </select>
                            <%--<input type="checkbox" <c:if test="${article.flag==1 || article==null }">checked</c:if> value="1" name="flag" id="flag" />推荐到热门中相应的标签--%>
                        </div>
                    </div>


                    <div class="control-group">
                        <label class="control-label" for="publishDate" style="float: left;">发布时间：</label>

                        <div class="controls">
                            <input type="text" id="publishDate" name="publishDate" value="" class="Wdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'%y-%M-%d %H:%m:%s',readOnly:'false'})"/>
                            <label class="checkbox inline">
                                <input type="checkbox" name="syncMeiyue" id="syncMeiyue" value="1" <c:if test="${obj.syncGd==1}">checked</c:if> />同步到美月
                            </label>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="label" style="float: left;">小标签：</label>
                        <div class="controls">
                            <table>
                                <c:forEach items="${lableList}" var="label" varStatus="status">
                                    <c:if test="${status.index%3==0}">
                                        <tr>
                                    </c:if>
                                    <td>
                                        <label class="checkbox inline">
                                            <input class="checkbox inline" type="checkbox" id="label_${label.id}" name="label" value="${label.id}"/>${label.labelName}
                                        </label>
                                    </td>
                                    <c:if test="${status.index%3==2}">
                                        </tr>
                                    </c:if>
                                </c:forEach>
                            </table>
                        </div>
                    </div>
                    <div class="form-actions">
                        <input type="button" id="btn" class="btn btn-primary" value="保存"/>
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
    
    
    		<div class="container">
	<div class="row">
		<div class="span12">
<!-- 			 <a id="modal-575443" href="#myModal2" role="button" class="btn" data-toggle="modal">触发遮罩窗体</a> -->
			<div id="myModal2" class="modal hide fade" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-header">
					 <button type="button" class="close" onclick="clearObj()" data-dismiss="modal" aria-hidden="true">×</button>
					<h3 id="myModalLabel">
						编辑按钮
					</h3>
				</div>
				<div class="modal-body">
					<table>
						<tr><td>按钮名称: <input type="text" name="buttontext" id="buttontext"/></td></tr>
						<tr><td>按钮链接: <input type="text" name="buttonurl" id="buttonurl"/></td></tr>
					</table>
				</div>
				<div class="modal-footer">
					 <button class="btn" id="modclose" name="modclose" onclick="clearObj()" data-dismiss="modal" aria-hidden="true">关闭</button> <button class="btn btn-primary" onclick="addButton()">保存设置</button>
				</div>
			</div>
		</div>
	</div>
</div>
    
    
    	<div class="container">
	<div class="row">
		<div class="span12">
<!-- 			 <a id="modal-575443" href="#myModal2" role="button" class="btn" data-toggle="modal">触发遮罩窗体</a> -->
			<div id="myModal3" class="modal hide fade" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"  style="width: 80%;height: 80%;left: 25%;top:7%;">
				<div class="modal-header">
					 <button type="button" id="voteListClose" name="voteListClose" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					<h3 id="myModalLabel">
						投票列表
					</h3>
				</div>
<!-- 				<div class="modal-body"> -->
					<iframe id="myIframe" src="${BasePath}/article/tvList?voteId=${article.voteId }"  style="width: 100%;height: 85%;border: 0px" ></iframe>
<!-- 				</div> -->
			</div>
		</div>
	</div>
</div>
    
</div>
<script type="text/javascript">

    function getCategory(obj){
        var id=obj.value;
        var aj = $.ajax( {
            url:'${BasePath}/topicArticle/getMajiaJson?id='+id,
            type:'post',
            cache:false,
            dataType:'json',
            success:function(data) {
                if(data.errno==0){
                    $("#majiaUid1").empty();
                    var size=data.data.length;
                    for(var i=0;i<size;i++){
                        $("#majiaUid1").append("<option value='"+data.data[i].uid+"' >"+data.data[i].nick+"</option>");
                    }
                    if(size==0){
                        alert("该分类下没有小组，请重新选择！");
                    }
                }else{
                    alert(data.errdesc);
                }
            },
            error : function() {
                alert("异常！");
            }
        });

    }


    // 验证小组名称
    function checkGroupName() {
        var groupName = $("#groupName").val();
        $("#hiddenGroupName").val(groupName);
        if (groupName != null && groupName != "") {
            $('#checkGroupNameForm').ajaxSubmit(function (data) {
                if (data.errno == 1) {
                    $("#alertErr").show();
                    $("#errodesc").html(data.errdesc);
                    $("#groupNameImage").attr("src", "${BasePath}/image/no.png");
                } else {
                    $("#alertErr").hide();
                    $("#errodesc").html("");
                    $("#groupId").val(data.groupId);
                    $("#groupNameImage").attr("src", "${BasePath}/image/ok.png");
                }
            });
        } else {
            $("#alertErr").hide();
            $("#errodesc").html("");
            $("#groupId").val("");
            $("#groupNameImage").attr("src", "${BasePath}/image/ok.png");
        }
    }
    //验证马甲昵称
    function checkMajiaNick() {
        var majiaNick = $("#majiaNick").val();
        $("#hiddenMajiaNick").val(majiaNick);
        if (majiaNick != null && majiaNick != "") {
            $('#checkMajiaNickForm').ajaxSubmit(function (data) {
                if (data.errno == 1) {
                    $("#alertErr").show();
                    $("#errodesc").html(data.errdesc);
                    $("#majiaNickImage").attr("src", "${BasePath}/image/no.png");
                } else {
                    $("#alertErr").hide();
                    $("#errodesc").html("");
                    $("#majiaUid").val(data.majiaUid);
                    $("#majiaNickImage").attr("src", "${BasePath}/image/ok.png");
                }
            });
        } else {
            $("#alertErr").hide();
            $("#errodesc").html("");
            $("#majiaUid").val("");
            $("#majiaNickImage").attr("src", "${BasePath}/image/ok.png");
        }
    }


    $(function () {
        setByIdFormatTime("publishDate", "${article.publishTime}");
    });
    //ajax 提交
    function getParseJson() {
        var url = $("#url").val();
        if (url == '') {
            alert("链接不能为空！");
            return false;
        }
        $("#hiddenUrl").val(url);
        $('#hiddenForm').ajaxSubmit(function (data) {
            if (data.errno == 1) {
                $("#alertErr").show();
                $("#errodesc").html(data.errdesc);
            } else {
                $("#title").val(data.data.title);
                editorIntro.html(data.data.body);
            }
        });
    }
    $('#btn').click(function () {
        var flag = checkForm();
        if (flag) {
            $("#btn").attr("disabled", "disabled");
            $('#saveArticle').ajaxSubmit(function (data) {
                if (data.errno == 0) {
                    alert("操作成功！");
                    $("#btn").removeAttr("disabled");
                    //  window.parent.closeModel();
                } else if (data.errno == 1) {
                    $("#alertErr").show();
                    $("#errodesc").html(data.errdesc);
                    $("#btn").removeAttr("disabled");
                }
            });
        }
    });

    function checkForm() {
// 	var startDate=$("#url").val();
// 	if(startDate=="") {
// 		alert("请输入URL！");
// 		return false;
// 	}
        var title = $("#title").val();
        if (title == "") {
            alert("活动标题不能为空！");
            return false;
        }else if(title.length>20){
            alert("标题长度不能超过20个字！");
            return false;
        }
        var endDate = $("#article").val();
        if (endDate == "") {
            alert("请输入正文！");
            return false;
        }
        var groupIdName = $("#groupIdName").val();
        var upTime = $("#groupName").val();
        var groupId = $("#groupId").val();
        if (groupIdName == "-1" && upTime == "") {
            alert("请选择小组！");
            return false;
        }
        if (upTime != "" && groupId == "") {
            alert("小组匹配不正确！");
            return false;
        }
// 	var majiaUid=$("#majiaUid").val();
// 	var downTime=$("#majiaNick").val();
// 	if(downTime!="" && majiaUid=="") {
// 		alert("马甲匹配不正确！");
// 		return false;
// 	}
//        var pic = $("#publishDate").val();
//        if (pic == "") {
//            alert("请选择发布时间!");
//            return false;
//        }
        return true;
    }
</script>