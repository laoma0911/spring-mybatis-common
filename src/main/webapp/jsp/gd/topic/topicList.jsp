<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="e" uri="https://www.owasp.org/index.php/OWASP_Java_Encoder_Project" %>
<%@ page isELIgnored="false"%>
<%@ taglib uri="/permission" prefix="pe"%>
<link href="${BasePath}/js/mediabox/css.css" rel="stylesheet" media="screen">
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
							<form action="${BasePath}/meiyue/topic/list?type=${type}&itemId=${itemId}" method="post" id="myform" class="form-search">
								小组分类： <select name="categoryId"  id="catId" class="input-small" >
									<option value="-1">全部</option>
								<c:forEach items="${topicCategoryList}" var="category">
									<option value="${category.id}">${category.title}</option>
								</c:forEach>
								</select>
								id： <input type="text" name="topicId" id="topicId" value="${topicId }"  class="input-small"/>
                                标题： <input type="text" name="title" id="title" value="${title}"  />
                                内容： <input type="text" name="keyWord" id="keyWord" value="${keyWord }"  />
								<%--时间： <select name="createtime"  id="createtime" class="input-small"  >--%>
														<%--<c:choose> <c:when test="${createtime==0}">--%>
																<%--<option  value="0" selected="selected">24小时</option>--%>
														<%--</c:when> <c:otherwise>--%>
																<%--<option  value="0">24小时</option>--%>
														<%--</c:otherwise></c:choose>--%>
														<%--<c:choose> <c:when test="${createtime==1}">--%>
																<%--<option  value="1" selected="selected">3天</option>--%>
														<%--</c:when> <c:otherwise>--%>
																<%--<option  value="1">3天</option>--%>
														<%--</c:otherwise></c:choose>--%>
														<%--<c:choose> <c:when test="${createtime==2}">--%>
																<%--<option  value="2" selected="selected">7天</option>--%>
														<%--</c:when> <c:otherwise>--%>
																<%--<option  value="2">7天</option>--%>
														<%--</c:otherwise></c:choose>--%>
													<%--</select>--%>
								排序： <select name="sort"  id="sort" class="input-medium" >
														<c:choose> <c:when test="${sort==0}">
																<option  value="0" selected="selected">最后回复时间</option>
														</c:when> <c:otherwise>
																<option  value="0">最后回复时间</option>
														</c:otherwise></c:choose>
														<c:choose> <c:when test="${sort==1}">
																<option  value="1" selected="selected">发表时间</option>
														</c:when> <c:otherwise>
																<option  value="1">发表时间</option>
														</c:otherwise></c:choose>
														<c:choose> <c:when test="${sort==2}">
																<option  value="2" selected="selected">浏览量</option>
														</c:when> <c:otherwise>
																<option  value="2">浏览量</option>
														</c:otherwise></c:choose>
														<c:choose> <c:when test="${sort==3}">
																<option  value="3" selected="selected">回复量</option>
														</c:when> <c:otherwise>
																<option  value="3">回复量</option>
														</c:otherwise></c:choose>
													</select>
								<input type="submit" class="btn btn-small btn-success" value="查询" />
								<input type="hidden"  name="start" id="start" value="${start }"/>
								<input type="hidden"  name="limit" id="limit" value="${limit }"/>
							</form>
						</div>
					</div>
				</div>
				<div class="block">
					<div class="navbar navbar-inner block-header">
						<div class="muted pull-left">
							话题列表<br>
						</div>
					</div>
					<div class="block-content collapse in">
						<div class="span12">
							<table class="table table-hover">
								<thead>
									<tr>
										<th>ID</th>
										<th>标题</th>
										<th>内容</th>
										<th>浏览量</th>
										<th>回复数</th>
										<th>发布时间</th>
<!-- 										<th>最后回复时间</th> -->
										<pe:permission key="update">
											<th>推荐</th>
										</pe:permission>
									</tr>
								</thead>
								<tbody id="tbodys">
									<c:forEach items="${topicList}" var="obj">
													<tr>
														<td width="10%">topicId:${obj.id}
                                                        <br>小组分类:${obj.topicCategoryName}
                                                        </td>
														<td width="20%">
															<a href="${BasePath}/meiyue/topic/topicDetail?topicId=${obj.id}&type=${type}&itemId=${itemId}" target="_blank"><e:forHtml value="${obj.title }"/></a>
														</td>
														<td width="20%">
                                                            <e:forHtml value="${obj.content }"/>
                                                            <c:forEach items="${obj.topicPicList}" var="pic">
                                                                <a href="${pic.oriPic}" rel="lightbox[ostec]">
                                                                    <img src="${pic.oriPic}" width="130px" height="130px">&nbsp;
                                                                </a>
                                                            </c:forEach>
                                                        </td>
														<td width="5%">${obj.viewNum }</td>
														<td width="5%">${obj.replyNum }</td>
														<td width="15%"><script >formatTime("${obj.dateline }");</script></td>
<!-- 														<td width="15%"><script >formatTime("${obj.lastReplyTime }");</script></td> -->
														<pe:permission key="update">
																	<td width="15%">
																			<c:choose>
																					<c:when test="${obj.ban!=1}">
																							<c:choose>
																								<c:when test="${obj.flag==0}">
																										<label class="checkbox inline"><input type="checkbox" name="flag"  onchange="hottestOnChange(this)"  value="${obj.id },${obj.catId },${obj.topicHottestId },${obj.uid}"/>最热话题</label>
																								</c:when>
																								<c:otherwise>
																										<label class="checkbox inline"><input type="checkbox"   name="flag"  checked="checked"  onchange="hottestOnChange(this)"  value="${obj.id },${obj.catId },${obj.topicHottestId },${obj.uid}"   />最热话题</label>
																								</c:otherwise>
																							</c:choose>
																					</c:when>
																					<c:otherwise>
																										<label class="checkbox inline"><input type="checkbox"  disabled="disabled" hidden="true"  name="flag"  checked="checked"  onchange=""  value=""   />用户被封禁</label>
																					</c:otherwise>
																			</c:choose>
																	</td>
														</pe:permission>
													</tr>
									</c:forEach>
								</tbody>
							</table>
							 <div class="pagination pagination-centered" id="pager"></div> 
<!-- 					             <script type="text/javascript"> 
// 						             var sign=0;
// 						              window.onbeforeunload(initPage());
// 						              function initPage(){
// 						            	  PAGER.initPager('${start}',' ${total}','50 ', 8, 'pager', getData);
// 						              }
// 						              function getData(tp) {
// 						            	  if(sign>0){
// 						            	 	window.location.href="${BasePath}/topic/list?start="+tp+"&limit=50&type=${type}&itemId=${itemId}&createtime=${createtime}&catId=${catId}&sort=${sort}";
// 						            	  }
// 						            	  sign=1;
// 						           	 } 
 					              </script> -->
					                 <script type="text/javascript">
								             var sign=0;
								              window.onload=function(){
								            	  PAGER.initPager('${start}',' ${total}','${limit}', 8, 'pager', getData);
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
					
				</div>
			</div>
		</div>
	</div>
</div>
<hr>
<jsp:include page="../../include/bottom.jsp" />
 <script type="text/javascript">
 
	var xytzLive = true;//true隐藏推荐   false显示推荐 
	
 	function xytz(obj){
 			//$("#tbodys").empty();
 			if(xytzLive){
 				xytzLive = false;
 				$("input[name=flag]").each(function(){
 					if($(this).attr("checked")){
 						$(this).parent().parent().parent().show();
 					}
 				});
 				$(obj).val("隐藏已推荐");
 			} else {
 				xytzLive = true;
 				$("input[name=flag]").each(function(){
 					if($(this).attr("checked")){
 						$(this).parent().parent().parent().hide();
 					}
 				});
 				$(obj).val("显示已推荐");
 			}
 	}
 	
 	function getD(val){
 		var dateObj = new Date(val*1000);
		var tm = dateObj.getFullYear() + '-' + addZero(dateObj.getMonth() + 1) + '-' + addZero(dateObj.getDate()) + ' ' + addZero(dateObj.getHours()) + ':' + addZero(dateObj.getMinutes()) + ':' + addZero(dateObj.getSeconds());
		return tm;
 	}
 
 	function hottestOnChange(obj){
 			var val = obj.value.split(",");
 			var topicId = val[0];
 			var groupId = val[1];
 			var topicHottestId = val[2];
 			var topicUid = val[3];
			var sod ;
			if(obj.checked){
				$(obj).attr("checked", true);
				if(xytzLive){
					$(obj).parent().parent().parent().hide();
				}
				sod = 0;
			} else {
				$(obj).attr("checked", false);
				$(obj).parent().parent().parent().show();
				sod = 1;
			}
			var path = "${BasePath }/topic/hottestChange?topicId=" + topicId + "&groupId=" + groupId + "&sod=" + sod + "&topicHottestId=" + topicHottestId + "&topicUid=" + topicUid;
			$.ajax({
				async:false,
				 type:"POST",
				 url:path,
				 datatype: "json",
				 success:function(data){
					 if(data.error != null){
							 alert(data.error);
					 } else if(data.topicHottestId != null){
						 obj.value = topicId + "," + topicId + "," + data.topicHottestId+","+topicUid;
					 } else {
						 obj.value = topicId + "," + topicId + ",'',"+topicUid;
					 }
				 } ,
				 error: function(){
				   alert("操作出错，请联系管理员！");
				 }         
			});
	}
 	
</script>
<script type="text/javascript">
    Mediabox.scanPage = function () {
        var links = $$("a").filter(function (el) {
            return el.rel && el.rel.test(/^lightbox/i);
        });
        $$(links).mediabox({/* Put custom options here */}, null, function (el) {
            var rel0 = this.rel.replace(/[[]|]/gi, " ");
            var relsize = rel0.split(" ");
            return (this == el) || ((this.rel.length > 8) && el.rel.match(relsize[1]));
        });
    };
    window.addEvent("domready", Mediabox.scanPage);
</script>