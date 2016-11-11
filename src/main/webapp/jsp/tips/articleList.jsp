<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="/permission" prefix="pe" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 

<jsp:include page="../include/top.jsp" />
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
					<form id="myForm"  name="myForm"  action="${BasePath}/article/list" method="post" class="form-inline">
						<table>
							<tr>
								<td style="vertical-align: middle;">话题标题：</td><td><input type="text" name="title" value="${title }" /></td>
								<td>&nbsp;<input type="submit" value="查询" /></td>
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
            <div class="muted pull-left">话题列表</div>
            <div class="pull-right">
	            <pe:permission key="add">
           	 	<a class="btn btn-success btn-small inline" style="margin-top: -5px" href="${BasePath}/article/toAdd" target="_black">新增</a>
    	        </pe:permission>
		    </div>
          </div>
          <div class="block-content collapse in">
            <div class="span12">
              <table class="table table-hover">
                <thead>
                  <tr>
                    <th>文章ID</th>
					<th>话题ID</th>
                    <th>封面图</th>
                    <th>所在小组</th>
                    <th>发布时间</th>
                    <th>浏览量</th>
                    <th>回复量</th>
                    <th>UV</th>
                    <th>UR</th>
                    <%--<th>推荐</th>--%>
                    <th>操作</th>
                  </tr>
                </thead>
                <tbody id="tbodys">
                  <c:forEach items="${articleList}" var="obj">
                    <tr >
                      <td class="id">${obj.id}</td>
						<td>
                         <c:choose>
                                <c:when test="${obj.topicId!=null && obj.topicId>0 }">
                                    ${obj.topicId}<br>
                                    <a target="_blank" href="${BasePath }/topic/topicDetail?topicId=${obj.topicId}&type=${type}&itemId=${itemId}">${obj.title }</a>
                                </c:when>
                                <c:otherwise>
                                    ${obj.title }
                                </c:otherwise>
                         </c:choose>
                      
                      </td>
                        <td>
                            <c:if test="${obj.pic!=null && obj.pic!=''}">
                                <img src="${imageHost}${obj.pic}" width="100px" height="100px">
                            </c:if>
                        </td>
                      <td>${obj.topicCategoryName}</td>
                      <td>
                      	<script>formatTime("${obj.publishTime}");</script>
                      </td>
                      <td>${obj.viewNum}</td>
                      <td>${obj.replyNum}</td>
                        <td>${obj.uv}</td>
                        <td>${obj.ur}</td>
                      <%--<td>--%>
                      		<%--<label class="checkbox"><input type="checkbox"  <c:if test="${obj.flag==1 }">checked="checked"  </c:if>  name="check"  onclick="syncHotTopic(this,'${obj.topicId}','${obj.id }')"  />最热话题</label>--%>
                      <%--</td>--%>
                      
                      <td>
                         <pe:permission key="update">
                      	   <a class="btn btn-success btn-small" href="${BasePath}/article/toModify?id=${obj.id}" target="_black">修改</a> 
                         </pe:permission>
                         <pe:permission key="delete">
                      	   <button class="btn del btn-danger btn-small">删除</button> 
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
function syncHotTopic(check,topicId,id){
	if(check.checked==true){
		$.post('${BasePath}/article/syncHotTopic',{
       		'topicId':topicId	,'type':1,'id':id},function(data){
       		var obj = eval(data);
       		if(obj.errno==0){
         		//alert('操作成功');
         		window.location.reload(true);
       		}else{
         		alert(obj.errdesc);
       		}
     	});
	}else{
		$.post('${BasePath}/article/syncHotTopic',{
       		'topicId':topicId	,'type':2,'id':id},function(data){
       		var obj = eval(data);
       		if(obj.errno==0){
         		//alert('操作成功');
         		window.location.reload(true);
       		}else{
         		alert(obj.errdesc);
       		}
     	});
	}
}

// 删除记录
$(function(){
	$(".del").bind('click',function(){
		if(!confirm('确定删除该条记录吗？')){
			return false;
     	}
     	var id = $(this).parent().parent().find(".id").text();
     	var tr = $(this).parent().parent();
     	$.post('${BasePath}/article/changeStatus',{
       		'id':id,'status':-1
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