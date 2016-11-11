<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="/permission" prefix="pe" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 

<jsp:include page="../include/top.jsp" />
<style>
    .dashan{
        overflow: hidden;
        text-overflow: ellipsis;
        display: -webkit-box;
        -webkit-line-clamp: 1;
        -moz-line-clamp: 1;
        -webkit-box-orient: vertical;
        -moz-box-orient: vertical;
    }
</style>
<!-- Body -->
<div class="container-fluid">
	<div class="row-fluid">
		<!-- Menu -->
		<jsp:include page="../include/menu.jsp" />
		<div class="span9" id="content">
			<jsp:include page="../include/location.jsp" />
			<div class="row-fluid">
				<div class="span12">
				  <div class="block"  >
					<div class="navbar navbar-inner block-header"  style="border-bottom: none;" >
					<form id="myForm" name="myForm" action="${BasePath}/push/pushList" method="post">
									<table >
										<tr valign="middle">
											<td>文案：</td><td><input type="text" name="content" value="${content }" /></td>
											<td>链接：</td><td><input type="text" name="url" value="${url }" /></td>
											<td>
<!-- 											<select name="platform"  id="platform" > -->
<!-- 												<option   value="-1">全部</option> -->
<%-- 												<option  <c:if test="${platform==0 }">selected="selected"</c:if>  value="0">Android</option> --%>
<%-- 												<option  <c:if test="${platform==1 }">selected="selected"</c:if> value="1" >IOS</option> --%>
<%-- 												<option  <c:if test="${platform=='1,0' }">selected="selected"</c:if>  value="1,0">IOS,Android</option> --%>
<!-- 											</select> -->
											</td>
											<td>
											状态:
											</td>
											<td>
											<select name="status"  id="status" >
												<option   value="-1">全部</option>
												<option  <c:if test="${status==0 }">selected="selected"</c:if>   value="0">新建</option>
												<option  <c:if test="${status==1 }">selected="selected"</c:if>  value="1">正在准备</option>
												<option  <c:if test="${status==2 }">selected="selected"</c:if> value="2" >准备完毕</option>
												<option  <c:if test="${status==3 }">selected="selected"</c:if> value="3">正在执行（正在推送）</option>
												<option  <c:if test="${status==4 }">selected="selected"</c:if> value="4">推送完成</option>
												<option  <c:if test="${status==5 }">selected="selected"</c:if> value="5">任务挂起</option>
												<option  <c:if test="${status==6 }">selected="selected"</c:if> value="6">准备过程出错</option>
												<option  <c:if test="${status==7 }">selected="selected"</c:if> value="7">推送失败</option>
												<option  <c:if test="${status==8 }">selected="selected"</c:if> value="8">取消</option>
											</select>
										</td>
										<td><input type="submit" value="查询" /></td>
										</tr>
									
									</table>
									<input type="hidden"  name="start" id="start" value="${start }"/>
									<input type="hidden"  name="limit" id="limit" value="${limit }"/>
									<input type="hidden"  name="type" id="type" value="${type }"/>
									<input type="hidden"  name="itemId" id="itemId" value="${itemId }"/>
					</form>
                           </div>
						</div>
					</div>
         
        <div class="block">
          <div class="navbar navbar-inner block-header">
            <div class="muted pull-left">Push列表</div>
            <div class="pull-right">
             <pe:permission key="add">
            	<button class="btn btn-success btn-small" style="margin-top: -5px" onclick="openModel('${BasePath}/push/toAdd','新增')">新增</button>
            </pe:permission>
		    </div>
          </div>
          <div class="block-content collapse in">
            <div class="span12">
              <table class="table table-hover">
                <thead>
                  <tr>
                    <th>ID</th>
                    <th width="20%">目标用户</th>
                    <th width="10%">文案<br>链接</th>
                    <th>客户平台</th>
                    <th>时间</th>
                    <th>push数量</th>
                    <th>push到达数</th>
                    <th>push点击量</th>
                    <th>类型</th>
                    <th>发起者</th>
                    <th>状态</th>
                    <th>操作</th>
                  </tr>
                </thead>
                <tbody id="tbodys">
                  <c:forEach items="${pushList}" var="push">
                    <tr >
                      <td class="uid">${push.id}</td>
                      <td>
                              <font color="green">状态：<script type="text/javascript">formatCardStatus("${push.userStatus}")</script></font>
                      			<font color="#006400">经期：
                                    <c:if test="${push.period==null || push.period==''}">无<br></c:if><script type="text/javascript">formatTargetUserPeriod("${push.period}")</script></font>
                      			<font color="#8a2be2">小组：<script type="text/javascript">formatTargetUserGroup("${push.groups}")</script></font>
                      			<font color="#d2691e">年龄： <script type="text/javascript">formatTargetUserAge("${push.age}")</script></font>
                      			<font color="#ff7f50">特征： <c:if test="${push.feature==null || push.feature==''}">无<br></c:if> <script type="text/javascript">formatTargetUserFeature("${push.feature}")</script></font>
                      			<font color="#00ced1">区域： <script type="text/javascript">formatTargetUserArea("${push.area}")</script></font>
                      	</td>
                      <td >${push.content}
                      <br>
                          <textarea  style="border: none;width: 100%">${push.url}</textarea>
                      </td>
                      <td>
                     			 ${push.platform }
                      </td>
                      <td> ${push.scheduleTime}</td>
                      <td>${push.pushedNum}</td>
                      <td>${push.arrivedNum }</td>
                      <td>${push.clickNum}</td>
                        <td><c:if test="${push.type==0}">无</c:if><c:if test="${push.type==1}">资讯类</c:if><c:if test="${push.type==2}">营销类</c:if></td>
                        <td><c:if test="${push.memo==0}">无</c:if><c:if test="${push.memo==1}">社区</c:if><c:if test="${push.memo==2}">市场</c:if><c:if test="${push.memo==3}">美月</c:if></td>
                      <td>
                     <script type="text/javascript"> formatPushStatus('${push.status}');</script>
                      </td>
                      <td>
                      <pe:permission key="update">
                      		<c:choose>
                      			<c:when test="${push.status==0 }">
                      			        <a class="btn btn-success btn-small" href="javascript:openModel('${BasePath}/push/toModify?id=${push.id}','修改')" >修改</a> 
                      			</c:when>
                      			<c:otherwise>
                      				<button type="button" class="btn btn-success btn-small"  disabled="disabled">修改</button>
                      			</c:otherwise>
                      		</c:choose>
                      </pe:permission>
                       <pe:permission key="delete">
                       <c:choose>
                      			<c:when test="${push.status==0 }">
                      			<button class="btn del btn-danger btn-small">删除</button> 
                      		</c:when>
                      			<c:otherwise>
                      				<button type="button" class="btn btn-danger btn-small"  disabled="disabled">删除</button>
                      			</c:otherwise>
                      		</c:choose>
                      	</pe:permission>
                      </td>
                    </tr>
                  </c:forEach>
                </tbody>
              </table>
                <div class="pagination pagination-centered" id="pager"></div> 
                <script type="text/javascript">
	             var sign=0;
	              window.onload=function(){
	            	  PAGER.initPager('${start}',' ${total}','${limit}', 8, 'pager', getData);
	              }
	              function getData(currentPage,pageSize) {
	            	  if(sign>0){
	            	 	$("#start").val(currentPage);
	            	 	$("#limit").val(pageSize);
	            	 	$("#myForm").submit();
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
<jsp:include page="../include/bottom.jsp" />


<script>
  $(function(){
    $(".del").bind('click',function(){
      
      if(!confirm('确定删除该条记录吗？')){
        return false;
      }
      var uid = $(this).parent().parent().find(".uid").text();
      var tr = $(this).parent().parent();
      $.post('${BasePath}/push/delete',{
        'id':uid
      },function(data){
        var obj = eval(data);
        if(obj.errno==0){
          alert('操作成功');
          tr.remove();
        }else{
          alert(obj.errdesc);
        }
      });
      
    });
  });
</script>