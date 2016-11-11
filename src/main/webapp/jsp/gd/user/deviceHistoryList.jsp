<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="/permission" prefix="pe" %>
<jsp:include page="../../include/head.jsp" />
<!-- Body -->
<style>
body {
	padding-top: 0px;
}
</style>
<div class="container-fluid">
         <div class="block"  >
					<div class="navbar navbar-inner block-header"  style="border-bottom: none;" >
 					<form action="${BasePath}/meiyue/user/toHistory" method="post" id="myform" name="myform">
                        UID：<input type="text" name="uid" value="${uid }" />
                        设备：<input type="text" name="device" value="${device }" />
                        <input type="submit" class="btn btn-small btn-success" value="查询" />
                        <input type="hidden"  name="start" id="start" value="${start }"/>
                        <input type="hidden"  name="limit" id="limit" value="${limit }"/>
                        </form>
                    </div>
					</div>
		</div>
        <div class="block">
          <div class="navbar navbar-inner block-header">
            <div class="muted pull-left">设备历史</div>
          </div>
          <div class="block-content collapse in">
              <table class="table table-hover">
                <thead>
                  <tr>
                      <th>UID</th>
                      <th>昵称</th>
                     <th>device</th>
                     <th>是否被封</th>
                     <th>登录天数|登录次数</th>
                      <th>首次登录</th>
                     <th>最后登录</th>
                     <%--<th>最后登录IP</th>--%>
                     <th>model</th>
                     <th  width="5%">sdkver</th>
                     <th  width="5%">ver</th>
                      <th width="5%">releasever</th>
                      <th width="5%"> 平台</th>
                  </tr>
                </thead>
                <tbody id="tbodys">
                  <c:forEach items="${userDeviceList}" var="obj">
                    <tr>
                      <td >${obj.uid}</td>
                        <td>${obj.nick}</td>
                      <td>${obj.device }</td>
                      <td>
	                      <c:if test="${obj.sign==1 }">
	                      			<font color="red">是</font>
	                      </c:if>
	                      <c:if test="${obj.sign==0 }">
	                      			<font color="green">否</font>
	                      </c:if>
                      </td>
                      
                        <td>${obj.logindays}/${obj.count}</td>
                        <td><script language="javascript">formatTime("${obj.begintime}");</script></td>
                        <td><script language="javascript">formatTime("${obj.lasttime}");</script></td>

                      <td>${obj.model }</td>
                      <td>${obj.sdkver }</td>
                      <td>${obj.ver }</td>
                      <td>${obj.releasever }</td>

                      <td>
	                		<c:if test="${obj.platform==0}">android</c:if>
							<c:if test="${obj.platform==1 }">iPhone</c:if>
							<c:if test="${obj.platform==2 }">wp</c:if>
                      </td>
                    </tr>
                  </c:forEach>
                </tbody>
              </table>
              <div class="pagination pagination-centered" id="pager"></div>
              <script type="text/javascript">
                  var sign=0;
                  window.onload=function(){
                      PAGER.initPager('${start}',' ${total}','${limit}', 20, 'pager', getData);
                  }
                  function getData(currentPage,pageSize) {
                      if(sign>0){
                          $("#start").val(currentPage);
                          $("#limit").val(pageSize);
                          $("#myform").submit();
                      }
                      sign=1;
                  }
              </script>
          </div>
        </div>
<div id="bg"></div>
<div class="box" style="display:none">
   <div class="container-fluid">
						<div class="block">
							<div class="navbar navbar-inner block-header">
								<div class="muted pull-left">添加封禁设备</div><div class="muted pull-right"><a  href="#"  onclick="closeForm()">X</a></div>
							</div>
							<div class="alert alert-error" id="alertErr" style="display: none;">
							<button class="close" data-dismiss="alert">×</button>
							<strong>Error!</strong> <span id="errodesc">This is an error message.</span>
						</div>
							<div class="block-content collapse in">
								<div class="span12">
									<form class="form-horizontal" id="saveCustom" name="saveCustom"  action="${BasePath }/meiyue/user/save" method="post">
										<input type="hidden" id="type" name="type" value="${type }"/>
										<input type="hidden" id="itemId" name="itemId" value="${itemId }"/>
										<fieldset>
											<div class="control-group">
												<label class="control-label" for="name" style="float: left;">设备：</label>
												<div class="controls">
												  <input class="input-xlarge focused" name="device" id="device"  readonly="readonly"  type="text"  value="" />
												</div>
                                            </div>
											  <div class="control-group">
                                              <label class="control-label" for="groupId" style="float: left;">时间：</label>
                                              <div class="controls">
                                                  <select class="input-xlarge" id="period" name="period">
													<option value="3">3天</option>
													<option value="7">7天</option>
													<option value="15">15天</option>
													<option value="30">30天</option>
													<option value="0">永久</option>
													</select>
                                              </div>
                                            </div>						
                                  	 	<div class="control-group">
												<label class="control-label" for="name" style="float: left;">备注：</label>
												<div class="controls">
												  <textarea class="input-xlarge focused" id="remark" name="remark"></textarea>
												</div>
                                            </div>
											<div class="form-actions">
												<button type="button"  onclick="saveCustom11()" class="btn btn-primary">保存</button>
											</div>
										</fieldset>
									</form>

								</div>
							</div>
						</div>
						<!-- /block -->
					</div>
</div>


<script>
    	function openForm(device){
    		$("#device").val(device);
    		$("#remark").val("");
    		 $("#alertErr").hide();
   		  	$("#errodesc").html("");
        $("#bg").css({
            display: "block", height: $(document).height()
        });
        var $box = $('.box');
        $box.css({
            //设置弹出层距离左边的位置
            left: ($("body").width() - $box.width()) / 2 - 20 + "px",
            //设置弹出层距离上面的位置
            top: ($(window).height() - $box.height()) / 2 + $(window).scrollTop() + "px",
            display: "block"
        });
    	}
    	
    	
    //点击关闭按钮的时候，遮罩层关闭
    
    function closeForm(){
        $("#bg,.box").css("display", "none");
    }






	function deleteDevice(device){
		if(!confirm('确定解封该条记录吗？')){
	        return false;
	      }
	      $.post('${BasePath}/meiyue/user/banDeviceDelete',{ 'device':device },function(data){
	        var obj = eval(data);
	        if(obj.errno==0){
	          alert('操作成功');
	          window.location.reload();
	        }else{
	          alert(obj.errdesc);
	        }
	      });
	}
	function saveCustom11(){
		 var device=$("#device").val();
		 var period=$("#period").val();
		 var remark=$("#remark").val();
		 
		 if(device==""){
			 alert("设备不能为空！");
			 return;
		 }
		$("#saveCustom").submit(function() {
				  alert($(this).serialize());
				  return false;
			});
			var path="${BasePath }/meiyue/user/banDeviceSave?device="+device+"&period="+period+"&remark="+remark;
			path=encodeURI(path);
			path=encodeURI(path); 
		  $.ajax({
	          type:"POST",
	          url:path,
	          datatype: "json",
	          success:function(data){
	        	  if(data.errno==1){
	        		  $("#alertErr").show();
	        		  $("#errodesc").html(data.errdesc);
	        	  }else{
	       			 window.location.reload(true);
				 }
	          } ,
	          error: function(){
	            alert("操作出错，请联系管理员！");
	          }         
	       });
		  }

</script>