<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<%@ taglib uri="/permission" prefix="pe"%>


<jsp:include page="../../include/top.jsp" />
<!-- Body -->
<div class="container-fluid">
	<div class="row-fluid">
		<!-- Menu -->
		<jsp:include page="../../include/menu.jsp" />
		<div class="span9" id="content">
			<jsp:include page="../../include/location.jsp" />
			<div class="row-fluid">
				<div class="span12">
					<div class="block">
						<div class="navbar navbar-inner block-header" style="border-bottom: none;">
							<form action="${BasePath}/meiyue/privateMsg/list?type=${type}&itemId=${itemId}" method="post" id="myform"  name="myform" class="form-search">
								用户：
									 <input type="text" name="uid" id="uid" value="${uid }"  />
									 
									  <input type="button" class="btn btn-small btn-success" onclick="find(0)" value="搜索发送者" /><input type="button"  class="btn btn-small btn-success" onclick="find(1)"  value="搜索接收者" />
									<input type="hidden" name="seeker" id="seeker" value="${seeker}" />
									<input type="hidden" name="cursor" id="cursor"  value="${cursor}"/>
									<script type="text/javascript">
											function find(seeker){
												
												var uid = $("#uid").val().trim();
												
												if(uid == ""){
													alert("用户ID不可以为空!");
													return ;
												}
												
												if(isNaN(uid)){
													alert("uid只能是数字!");
													return ;
												}
												$("#seeker").val(seeker);
												$("#myform").submit();
											}
									</script>
							</form>
						</div>
					</div>
				</div>
			
			
			


				<!-- ========================== -->
				<div class="block">
					<div class="navbar navbar-inner block-header">
							<div class="muted pull-left">
								私信列表<br>
							</div>
							<div class="pull-right">
							<a   onclick="openModel('${BasePath}/meiyue/privateMsg/sendResult','发送结果列表')"  class="btn btn-small btn-success"  >发送结果列表</a>
								<pe:permission key="add">
									<a id="modal-570269"  onclick="reply()"  class="btn btn-small btn-success" role="button" data-toggle="modal">发送</a>
								</pe:permission>
							</div>
					</div>
					<div class="row-fluid">
						<div class="span3">
										<div class="block-content collapse in">
											<div class="span12" style="background-color: #eee">
												<table class="table table-hover" id="table_sr_id">
													<thead>
														<tr>
															<th>发送者</th>
															<th>接收者</th>
														</tr>
													</thead>
													<tbody id="tbodys">
														<c:forEach items="${conversationId}" var="obj" >
															<tr onclick="addtable(this,'${obj.id}','${obj.uid}','')">
																	<c:choose>
																		<c:when test="${obj.senderFlag=='0'}">
																				<td width="10%">${obj.sender }</td>
																		</c:when>
																		 <c:otherwise> 
																				<td width="10%"><p class="text-error">${obj.sender }</p></td>												
																		 </c:otherwise>
																	</c:choose>
																	<c:choose>
																		<c:when test="${obj.receiverFlag=='0'}">
																				<td width="10%">${obj.receiver }</td>
																		</c:when>
																		 <c:otherwise> 
																				<td width="10%"><p class="text-error">${obj.receiver }</p></td>												
																		 </c:otherwise>
																	</c:choose>
															</tr>
														</c:forEach>
													</tbody>
												</table>
												
												<div class="" >
													<ul class="pager">
													    <li><a href="#" onclick="page(0)">首页</a></li>
													    <li><a href="#" onclick="page('${createAt }')">下一页</a></li>
												    </ul>
<!-- 													<button class="btn"  onclick="page(0)">首页</button> -->
<%-- 													<button class="btn"  onclick="page('${createAt }')">下一页</button> --%>
													<script type="text/javascript">
															function page(cursor){
																$("#cursor").val(cursor);
																$("#myform").submit();
															}
													</script>
												</div>
											</div>
										</div>
						</div>
						<div class="span8">
										<div class="block-content collapse in">
											<div class="span12">
												<table class="table table-hover">
													<thead>
														<tr>
															<th>私信内容</th>
															<th>发送时间</th>
															<th>操作</th>
														</tr>
													</thead>
													<tbody id="table_tbodys">
													</tbody>
												</table>
												<div class="" >
														<ul class="pager">
														    <li><a href="#" id="privatemsg_index_id" onclick="">首页</a></li>
														    <li><a href="#" id="privatemsg_next_id" onclick="">下一页</a></li>
													    </ul>
<!-- 													<button class="btn"  onclick="alert('还没做');">首页</button> -->
<!-- 													<button class="btn"  onclick="alert('还没做');">下一页</button> -->
												</div>
											</div>
										</div>
										
						</div>
					</div>
				</div>
<hr>
<jsp:include page="../../include/bottom.jsp" />
			
	<div class="container-fluid">
	<div class="row-fluid">
		<div class="span6">
			
			<div id="modal-container-570269" class="modal hide fade" style="width:600px" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-header">
					 <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					<h3 id="myModalLabel">
						发送
					</h3>
				</div>
				<div class="" style="margin-top: 10px;">
						<form class="form-horizontal" id="saveCustom" name="saveCustom"  >
										<fieldset>
										 <div class="control-group">
												<label class="control-label" for="name" style="float: left;">发送者：</label>
												<div class="controls">
												 	 <select name="sendUid"  id="sendUid" class="input-xlarge focused" >
												 	 	<c:forEach items="${userInfo}" var="obj" >
												 	 		<option  value="${obj.uid }">${obj.nick }</option>
												 	 	</c:forEach>
													</select>
												</div>
                                          </div>

											<div class="control-group">
												<label class="control-label" for="name" style="float: left;">接收者UID：</label>
												<div class="controls">
												  <textarea class="input-xlarge focused" id="receiveUid" name="receiveUid" ></textarea>
												  <br> <label class="control-label" for="name" style="float:left ;width:80%;color: red; ">请使用英文逗号分隔开(最多100个uid)</label>
												</div>
                                            </div>
                                            
                                            <div class="control-group">
												<label class="control-label" for="name" style="float: left;">私信内容：</label>
												<div class="controls">
												  <textarea class="input-xlarge focused" id="content1" name="content1" ></textarea>
<!-- 												  <label class="control-label" for="name" style="color: red;width:100%;">	Max=500字</label> -->
													<br>
													 <label class="control-label" for="name" style="color: red;width:80%;">
												  				Max=500字<br>
												  				[[url=http://www.dayima.com]]大姨吗[[/url]]<br> 
												  				文案“大姨吗”增加超链接,跳转至wap页面(内部浏览器)</label>
												</div>
                                            </div>
                                            
                                            
                                            <div class="control-group">
												<label class="control-label" for="name" style="float: left;">链接：</label>
												<div class="controls">
												  <input class="input-xlarge focused" name="link" id="link"  onkeydown="if(event.keyCode==13){return false;}" type="text" />
												  <br>
												   <label class="control-label" for="name" style="color: red;width:80%;">选填</label>
												</div>
                                            </div>
                                         
										</fieldset>
									</form>
									<div class="modal-footer">
									 <button class="btn btn-small btn-inverse" data-dismiss="modal" aria-hidden="true">关闭</button><input type="button" onclick="send2()" value="发送" class="btn btn-small btn-primary"/> 
									</div> 
				</div>
<!-- 				<div class="modal-footer"> -->
<!-- 					 <button class="btn btn-small btn-inverse" data-dismiss="modal" aria-hidden="true">关闭</button><input type="button" onclick="send()" value="发送" class="btn btn-small btn-primary"/>  -->
<!-- 				</div> -->
			</div>
		</div>
		<div class="span6">
		</div>
	</div>
</div>
	
	
	
	<div class="container-fluid">
	<div class="row-fluid">
		<div class="span6">
			
			<div id="modal-container-570268" class="modal hide fade" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-header">
					 <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					<h3 id="myModalLabel">
						回复
					</h3>
				</div>
				<div class="modal-body">
						<form class="form-horizontal" id="saveCustom" name="saveCustom"  >
										<fieldset>
										 <div class="control-group">
												<label class="control-label" for="name" style="float: left;">发送者：</label>
												<div class="controls">
												 	 <select name="sendUid1"  id="sendUid1" class="input-xlarge focused" >
														<c:forEach items="${userInfo}" var="obj" >
												 	 		<option  value="${obj.uid }">${obj.nick }</option>
												 	 	</c:forEach>
													</select>
												</div>
                                          </div>

											<div class="control-group">
												<label class="control-label" for="name" style="float: left;">被回复UID：</label>
												<div class="controls">
													<input class="input-xlarge focused" name="receiveUid1" id="receiveUid1"   type="text"  value="" disabled="disabled"/>
												</div>
                                            </div>
                                            
                                            <div class="control-group">
												<label class="control-label" for="name" style="float: left;">回复内容：</label>
												<div class="controls">
												  <textarea class="input-xlarge focused" id="content11" name="content11" ></textarea>
												</div>
                                            </div>
                                            
                                             <div class="control-group">
												  <label class="control-label" for="name" style="color: red;width:100%;">
												  				Max=500字<br>
												  				[[url=http://www.dayima.com]]大姨吗[[/url]]<br> 
												  				文案“大姨吗”增加超链接,跳转至wap页面(内部浏览器)</label>
                                            </div>
                                            
										</fieldset>
							</form>
				</div>
				<div class="modal-footer">
					 <button class="btn btn-small btn-inverse" data-dismiss="modal" aria-hidden="true">关闭</button><input type="button" onclick="send1()" value="发送" class="btn btn-small btn-primary"/> 
				</div>
			</div>
		</div>
		<div class="span6">
		</div>
	</div>
</div>
   
   
 <script type="text/javascript">
 
 	function abc(){
 		alert(23342342);
 	}
 
 		function addtable(obj,cId,uid,cursorTm){
 			$("#table_tbodys").empty();
 			$("#table_sr_id tr:gt(0)").each(function(i){
 				$(this).attr("class","");
 			});
 			$(obj).attr("class","info");
 			var path = "${BasePath }/meiyue/privateMsg/conversation?conversationId=" + cId + "&cursorTm=" + cursorTm+"&uid="+uid;
 			$.ajax({
				async:false,
				 type:"POST",
				 url:path,
				 datatype: "json",
				 success:function(data){
					 if(data.error != null){
						 alert(data.error);
					 }else if(data.rList != null){
						 $.each(data.rList,function(i,item){
							 var createdAt = item.createdAt;
// 							 createdAt = createdAt.replace("T", " ").replace("Z", "");
							 var conversationId = item.conversationId;
							 var cid = conversationId.split(":");
							 var sendUid = item.openId;//发送者uid
							 var receiverUid = "";
							 if(sendUid == cid[0]){
									receiverUid = cid[1];
								} else {
									receiverUid = cid[0];
								}

							  
							 var con = item.content.content;
							 var reg="/\\>/g";
							  reg=eval(reg); 
							 var  count= 0; 
							 if(con.match(reg) != null){
								 count = con.match(reg).length;
							 }
							 
							 var reg1="/</g";
							  reg1=eval(reg1); 
							 var  count1= 0; 
							 if(con.match(reg1) != null){
								 count1=con.match(reg1).length;
							 }
							 if(count1 != 0 && count != count1){
								 re=new RegExp("<","g");
								 con = con.replace(re,"&lt;");
							 }
							 
							 var tableVal = "<tr class=''>";
							 tableVal +="<td width='45%'>" + con + "</td>";
							 tableVal +="<td>" + createdAt + "</td>";
							 tableVal +="<td><button onclick='reply1(this,"+sendUid+")' class='btn btn-mini btn-info' >回复发送者</button>&nbsp;<button onclick='reply1(this,"+receiverUid+")' class='btn btn-mini btn-info'>回复接收者</button></td>";
							 tableVal += "</tr>";
							 $("#table_tbodys").append(tableVal);
							 $("#privatemsg_index_id").attr("onclick","addtable(this,'"+cId+"','" + uid + "','')");
							 $("#privatemsg_next_id").attr("onclick","addtable(this,'"+cId+"','" + uid + "','"+createdAt+"')");
						 });
					 }
				 } ,
				 error: function(){
				   alert("操作出错，请联系管理员！");
				 }         
			});
 		}
 
 
		function reply1(obj,uid){
			$("#content11").val('');
			$("#receiveUid1").val(uid);
			$('#modal-container-570268').modal('show')
		}
		
		function reply(){
			$("#content1").val('');
			$("#receiveUid").val('');
			$("#link").val('');
			
			$('#modal-container-570269').modal('show')
		}

		function send2(){
		    var sendUid = $("#sendUid").val();
		    var receiveUid = $("#receiveUid").val();
		    var content = $("#content1").val();

		    if(sendUid == ""){
			    alert("发送者不能为空");
			    return ;
		    }
		    if(receiveUid == ""){
			    alert("接收者不能为空");
			    return ;
		    }
		    if(content == ""){
			    alert("私信内容不能为空");
			    return ;
		    }
		    if(content.length > 500){
			    alert("私信内容不能超过500字,现在长度" + content.length);
			    return ;
		    }
		    var link = $("#link").val();
            if(link!=""){
                if(link.charAt(link.length-1)=="/"){
                    alert("链接不能以“/”结尾！");
                    return false;
                }else if(link.indexOf(" ")>=0){
                    alert("链接不能包含空格！");
                    return false;
                }
            }
		    var params={
			    "content":content,
			    "sendUid":sendUid,
			    "receiveUid":receiveUid,
			    "link":link,
			    "tag":2
		    };
		    //content=encodeURI(content);
		    //content=encodeURI(content);
		    //var link = $("#link").val();
		    //var path = "${BasePath }/privateMsg/send?sendUid=" + sendUid + "&receiveUid=" + receiveUid + "&content=" + content + "&link=" + link + "&tag=2";
		    var path = "${BasePath }/meiyue/privateMsg/send";
		    sd(path, params);
		}

		function send1(){
		    var sendUid = $("#sendUid1").val();
		    var receiveUid = $("#receiveUid1").val();
		    var content = $("#content11").val();

		    if(sendUid == ""){
			    alert("发送者不能为空");
			    return ;
		    }
		    if(receiveUid == ""){
			    alert("被回复用户不能为空");
			    return ;
		    }
		    if(content == ""){
			    alert("回复内容不能为空");
			    return ;
		    }
		    if(content.length > 500){
			    alert("回复内容不能超过300字,现在长度" + content.length);
			    return ;
		    }
		    //content=encodeURI(content);
		    //content=encodeURI(content);
		    var params={
			    "content":content,
			    "sendUid":sendUid,
			    "receiveUid":receiveUid,
			    "tag":2
		    };
		    //var path = "${BasePath }/privateMsg/send?sendUid=" + sendUid + "&receiveUid=" + receiveUid + "&content=" + content + "&tag=2";
		    var path = "${BasePath }/meiyue/privateMsg/send";
		    sd(path, params);
		}

		function sd(path,params){
		    $.ajax({
			    async:false,
			    type:"POST",
			    url:path,
			    datatype: "json",
			    timeout:60000,
			    data:params,
			    success:function(data){
				    if(data.error ==1){
					    alert(data.error);
				    }else {
					    alert("发送成功");
				    }
			    } ,
			    error: function(){
				    alert("操作出错，请联系管理员！");
			    }
		    });
		};

	</script>

