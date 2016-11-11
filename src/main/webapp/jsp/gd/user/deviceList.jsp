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

/* box */
.box{position:absolute;width:600px;left:50%;height:auto;z-index:100;background-color:#fff;border:1px #ddd solid;padding:1px;}
.box h2{height:25px;font-size:14px;background-color:#aaa;position:relative;padding-left:10px;line-height:25px;color:#fff;}
.box h2 a{position:absolute;right:5px;font-size:12px;color:#fff;}
.box .list{padding:10px;}
.box .list li{height:24px;line-height:24px;}
.box .list li span{margin:0 5px 0 0;font-family:"宋体";font-size:12px;font-weight:400;color:#ddd;}
.showbtn {font:bold 24px '微软雅黑';}
#bg{background-color:#666;position:absolute;z-index:99;left:0;top:0;display:none;width:100%;height:100%;opacity:0.5;filter: alpha(opacity=50);-moz-opacity: 0.5;}

</style>
<div class="container-fluid">
         <div class="block"  >
					<div class="navbar navbar-inner block-header"  style="border-bottom: none;" >
 					<form action="${BasePath}/meiyue/user/toDeviceList" method="post" id="myform" name="myform">
                        UID：<input type="text" name="uid" value="${uid }" />
                        设备：<input type="text" name="device" value="${device }" />
                        昵称：<input type="text" name="nick" value="${nick }" />
                        <input type="submit" value="查询" />
                        <input type="hidden"  name="start" id="start" value="${start }"/>
                        <input type="hidden"  name="limit" id="limit" value="${limit }"/>
                        </form>
                    </div>
					</div>
		</div>
        <div class="block">
          <div class="navbar navbar-inner block-header">
            <div class="muted pull-left">设备列表</div>
            <div class="pull-right">
              <pe:permission key="add">
             <button class="btn" style="margin-top: -5px" onclick="window.location='${BasePath}/meiyue/user/toAddBanDevice?type=${type}&itemId=${itemId}'">新增</button>
             </pe:permission>
			  <span class="badge badge-info">${json.total}</span>
		    </div>
          </div>
          <div class="block-content collapse in">
              <table class="table table-hover">
                <thead>
                  <tr>
                      <th>UID</th>
                      <th>昵称</th>
                     <th>device</th>
                     <th>是否被封</th>
                     <th>登录次数</th>
                     <th>最后登录时间</th>
                     <%--<th>最后登录IP</th>--%>
                     <th>model</th>
                     <th  width="5%">sdkver</th>
                     <th  width="5%">ver</th>
                      <th width="5%">releasever</th>
                      <th width="5%"> 平台</th>
                      <th width="10%">操作</th>
                  </tr>
                </thead>
                <tbody id="tbodys">
                  <c:forEach items="${userDeviceList}" var="obj">
                    <tr>
                      <td > <a href="${BasePath }/meiyue/user/userList?type=4&itemId=20&uid=${obj.uid}"  target="_black">${obj.uid}</a></td>
                        <td>${obj.nick}</td>
                      <td><a href="${BasePath}/meiyue/user/toDeviceList?device=${obj.device }&uid="  target="_black" >${obj.device }</a></td>
                      <td>
	                      <c:if test="${obj.sign==1 }">
	                      			<font color="red">是</font>
	                      </c:if>
	                      <c:if test="${obj.sign==0 }">
	                      			<font color="green">否</font>
	                      </c:if>
                      </td>
                      
                      <td>${obj.count}</td>
                      <td><script language="javascript">formatTime("${obj.lasttime}");</script></td>
                       <%--<td></td>--%>
                      <td>${obj.model }</td>
                      <td>${obj.sdkver }</td>
                        <td>${obj.ver }</td>
                      <td>${obj.releasever }</td>

                      <td>
	                		<c:if test="${obj.platform==0}">android</c:if>
							<c:if test="${obj.platform==1 }">iPhone</c:if>
							<c:if test="${obj.platform==2 }">wp</c:if>
                      </td>
                        <td>
                        	<c:choose>
                        		<c:when test="${obj.sign==1}">
                        			<button   class="btn btn-small btn-success" onclick="deleteDevice('${obj.device }','${obj.uid}')">解封</button>
                        		</c:when>
                        		<c:otherwise>
                        			<button   class="btn btn-small btn-danger" onclick="openForm('${obj.device}','${obj.uid}')">新封禁</button>
                        		</c:otherwise>
                        	</c:choose>
                         	 <a class="btn btn-small btn-success"  href="${BasePath}/meiyue/user/toHistory?uid=${obj.uid}&device=${obj.device }">历史</a></td>
                    </tr>
                  </c:forEach>
                </tbody>
              </table>
              <%--<div class="pagination pagination-centered" id="pager"></div>--%>
              <%--<script type="text/javascript">--%>
                  <%--var sign=0;--%>
                  <%--window.onload=function(){--%>
                      <%--PAGER.initPager('${start}',' ${total}','${limit}', 20, 'pager', getData);--%>
                  <%--}--%>
                  <%--function getData(currentPage,pageSize) {--%>
                      <%--if(sign>0){--%>
                          <%--$("#start").val(currentPage);--%>
                          <%--$("#limit").val(pageSize);--%>
                          <%--$("#myform").submit();--%>
                      <%--}--%>
                      <%--sign=1;--%>
                  <%--}--%>
              <%--</script>--%>
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
										
										<input type="hidden" id="uidss" name="uidss" />
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
    	function openForm(device,uid){
    		$("#device").val(device);
    		$("#uidss").val(uid);
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






	function deleteDevice(device,uid){
		if(!confirm('确定解封该条记录吗？')){
	        return false;
	      }
	      $.post('${BasePath}/meiyue/user/banDeviceDelete',{ 'device':device,'uid':uid },function(data){
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
		 var uid=$("#uidss").val();
		 if(device==""){
			 alert("设备不能为空！");
			 return;
		 }
		$("#saveCustom").submit(function() {
				  alert($(this).serialize());
				  return false;
			});
			var path="${BasePath }/meiyue/user/banDeviceSave?device="+device+"&period="+period+"&remark="+remark+"&uid="+uid;
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