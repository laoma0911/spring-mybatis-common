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
            uploadJson: '${BasePath}/kolTopicArticle/uploadimage',
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
    	var videoUrl = $("#videoUrl").val();
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
    	$("#videoUrlHid").val("");
    	document.getElementById("fid1").innerHTML = "";
    }
    
    function delVideo(){
    	var html = editorIntro.html();
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
                <form class="form-horizontal" id="saveArticle" name="saveArticle" action="${BasePath }/kolTopicArticle/save" enctype="multipart/form-data" method="post">
                    <input type="hidden" id="id" name="id" value="${article.id }"/>
                    <input type="hidden" id="currentTime" name="currentTime" value="${currentTime}"/>
                    
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
                          <label class="control-label" for="vote" style="float: left;">投票：</label>
                          <div class="controls">
                              <input name="voteId" id="voteId" value="${article.voteId }"   type="hidden" />
                              <input  class="btn" onclick="voteList()"  value="选择投票" type="button" class="btn"/>
                              <input  class="btn" onclick="deleteVote()"  value="删除" type="button" class="btn"/> <font color="red">删除投票时需要选择删除</font>
                          </div>
                      </div>
                    
                    
                    <div class="control-group" >
                    	<label class="control-label" for="vote" style="float: left;">上传视频：</label>
                      <div class="controls">
                      	<c:if test="${videoUrl!=null && videoUrl!=''}">
                      		<font color="red" id="fid1">已选</font>
                      	</c:if>
                      	<input class="input-xlarge focused" name="videoUrl" id="videoUrl"   type="file" accept=""/>
                      	<input type="hidden" id="videoUrlHid" name="videoUrlHid" value="${videoUrl} " />
                      	
                      	
                      	<input  class="btn" onclick="comVideoUrl()"  value="提交视频" type="button"/><font color="red">删除视频时需要选择清空,只支持mp4格式</font>
                      	<input  class="btn" onclick="clearVideo()"  value="清空视频" type="button"/>
                      </div>
                  </div>
                  
                  
                    <div class="control-group" >
                    	<label class="control-label" for="vote" style="float: left;">视频截图：</label>
                      <div class="controls">
	                   		<input class="input-xlarge focused" name="videoPic" id="videoPic" value="${videopic }"   type="file" />
	                      	<input type="hidden"   name="videoPicLive" id="videoPicLive" value="${videopic }"    />	
	                      	<c:if test="${videopic!=null && videopic!=''}">
	                              <img id="videoImgPic" name="videoImgPic" alt="" src="${imageHost }${videopic }"  width="80px"  height="80px">
	                          </c:if>
	                      	<input  class="btn" onclick="clearVideoPic(1)"  value="清空图片" type="button"/><font color="red">上传视频后请选择视频封面截图</font>
                      </div>
                    </div>
                    <div class="control-group" >
                        <label class="control-label" for="pic" style="float: left;">头图：</label>
                        <div class="controls">
                            <input class="input-xlarge focused" name="pic" id="pic" value="${article.pic }"   type="file" />
                            <c:if test="${article.pic!=null && article.pic!=''}">
                                <img alt="" src="${imageHost }${article.pic }"  width="80px"  height="80px">
                            </c:if>
                            <font color="red">尺寸为640*384</font>
                        </div>
                    </div>


                    <div class="control-group">
                        <label class="control-label" for="publishDate" style="float: left;">发布时间：</label>
                        <div class="controls">
                            <input type="text" id="publishDate" name="publishDate" value="" class="Wdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'%y-%M-%d %H:%m:%s',readOnly:'false'})"/>
                        </div>
                    </div>
                    
                    <div class="form-actions">
                        <input type="button" id="btn" class="btn btn-primary" value="保存"/>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    
    		<div class="container">
	<div class="row">
		<div class="span12">
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
			<div id="myModal3" class="modal hide fade" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"  style="width: 80%;height: 80%;left: 25%;top:7%;">
				<div class="modal-header">
					 <button type="button" id="voteListClose" name="voteListClose" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					<h3 id="myModalLabel">
						投票列表
					</h3>
				</div>
					<iframe id="myIframe" src="${BasePath}/article/tvList?voteId=${article.voteId }"  style="width: 100%;height: 85%;border: 0px" ></iframe>
			</div>
		</div>
	</div>
</div>
    
</div>
<script type="text/javascript">

    $(function () {
        setByIdFormatTime("publishDate", "${article.publishTime}");
    });
    
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
        return true;
    }
</script>