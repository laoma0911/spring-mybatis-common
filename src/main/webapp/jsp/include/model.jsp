<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<script type="text/javascript">
//传  url  和  标题
	function openModel(url,title,width,height,reload){
			
			$("#myIframe").attr("src",url); 
			if(width!=null && height!=null){
				$("#myModel").attr("style","width:"+width+";height:"+height+";");
			}
			if(!reload){
				$("#myModel").attr("needReload", "0");
			}else{
				$("#myModel").attr("needReload", "1");
			}
			$("#myModalLabel").html(title);
			$('#myModel').modal({backdrop: false, keyboard: false});
			$('#myModel').modal('show');
	}
	function closeModel(){
		$('#myModel').modal('hide');
		if($("#myModel").attr("needReload")=="0"){
			$("#myModel").removeAttr("needReload");
			window.location.reload(true);
		}
	}
	var _move=false;//移动标记
	var _x,_y;//鼠标离控件左上角的相对位置
	$(document).ready(function(){
		$("#myModel").click(function(){

		}).mousedown(function(e){
			_move=true;
			_x=e.pageX-parseInt($("#myModel").css("left"));
			_y=e.pageY-parseInt($("#myModel").css("top"));
			$("#myModel").fadeTo(20, 1);//点击后开始拖动并透明显示
			$("body").css("-webkit-user-select","none");
			$("body").css("-moz-user-select","none");
			$("body").css("-khtml-user-select","none");
			$("body").css("-ms-user-select","none");
		});
		$(document).mousemove(function(e){
			if(_move){
				var x=e.pageX-_x;//移动时根据鼠标位置计算控件左上角的绝对位置
				var y=e.pageY-_y;
				$("#myModel").css({top:y,left:x});//控件新位置
			}
		}).mouseup(function(){
			_move=false;
			$("body").css("-webkit-user-select","");
			$("body").css("-moz-user-select","");
			$("body").css("-khtml-user-select","");
			$("body").css("-ms-user-select","");
		});
	});
</script>
<div class="container">
			<div class="row">
				<div class="span12">
					<div id="myModel" class="modal hide fade" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"  style="width: 80%;height: 80%;left: 25%;top:7%;">
						<div class="modal-header">
<!-- 							 <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="closeModel()">X</button> -->
							 <button type="button" class="close"  onclick="closeModel()">关闭</button>
							<h4 id="myModalLabel">
							</h4>
						</div>
								<iframe id="myIframe" src=""  style="width: 100%;height: 85%;border: 0px" ></iframe>
<!-- 						<div class="modal-footer"> -->
<!-- 							 <button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button> <button class="btn btn-primary">保存设置</button> -->
<!-- 						</div> -->
					</div>
				</div>
			</div>
</div>
