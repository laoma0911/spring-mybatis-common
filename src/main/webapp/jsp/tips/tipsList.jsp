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
					<form id="myForm"  name="myForm"  action="${BasePath}/tips/list" method="post" class="form-inline">
                        分类：<select id="tipsCategoryId" name="tipsCategoryId" >
                        <option value="-1" >全部</option>
                        <c:forEach items="${tipcCategoryList.data}" var="obj">
                            <option value="${obj.id}" <c:if test="${obj.id==tipsCategoryId}" >selected="selected" </c:if>  >${obj.name}</option>
                        </c:forEach>
                    </select>
                        标题：<input type="text" name="title" value="${title }" />

                        内容：<input type="text" name="content" value="${content }" />

                        关键字：<input type="text" name="keyword" value="${keyword}" />

                        <input type="submit" class="btn btn-success btn-small" value="查询" />
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
            <div class="muted pull-left">贴士列表</div>
            <div class="pull-right">
	            <pe:permission key="add">
           	 	<a class="btn btn-success btn-small inline" style="margin-top: -5px" href="javascript:openModel('${BasePath}/tips/toAdd','新增贴士')" >新增</a>
    	        </pe:permission>
		    </div>
          </div>
          <div class="block-content collapse in">
            <div class="span12">
              <table class="table table-hover">
                <thead>
                  <tr>
                    <th>ID</th>
                    <th>
                        标题<br>
                        分类<br>排序值</th>
                    <th>配图</th>
                    <th>匹配条件</th>
                    <th>匹配症状</th>
                    <th>关键字</th>
                    <th>内容摘要</th>
                    <%--<th>链接话题</th>--%>
                     <th>
                         拉取次数<br>
                         收藏数<br>
                         不适合数<br>
                     </th>
                    <th>操作</th>
                  </tr>
                </thead>
                <tbody id="tbodys">
                  <c:forEach items="${tipsList}" var="obj">
                    <tr >
                        <td class="id">
                           ${obj.id}
						<td>
                                ${obj.title}<br>
						            <span <c:if test="${obj.tipsCategoryName=='分类已删除'}">  style="color: #ff0000"  </c:if> >${obj.tipsCategoryName}</span>
                                    <br>
                                ${obj.displayOrder}
                        </td>
                        <td>
                            <c:if test="${obj.pic!=null && obj.pic!=''}">
                                <img src="${imageHost}${obj.pic}" width="100px" height="100px">
                            </c:if>
                        </td>
                      <td>
                          <span style="color: chartreuse;">用户状态：</span> ${obj.userStatus}
                          <br>
                          <span style="color: #ff0000;">用户年龄：</span>${obj.userAge}
                          <br>
                          <span style="color: #c09853">用户时期：</span>${obj.userPeriod}
                          <br>
                          <span style="color: #ff0000">特殊日期：</span>${obj.specialDate}
                          <br>
                          <span style="color: #003bb3">经期症状：</span>${obj.periodDetail}
                      </td>
                      <td><textarea  readonly style="height: 100%">${obj.bodyDetail}</textarea>  </td>
                      <td>
                          <textarea  readonly style="height: 100%">${obj.keyword}</textarea>
                      </td>
                      <td><textarea  readonly style="height: 100%">${obj.content}</textarea></td>
                      <td>
                          <%--<c:if test="${obj.topicId>0}">--%>
                              <%--<a href="${BasePath}/topic/topicDetail?topicId=${obj.topicId}&type=${type}&itemId=${itemId}" target="_blank">${obj.topicTitle }</a>--%>
                          <%--</c:if>--%>
                              <span style="color: #ff0000">拉：${obj.times}</span>
                              <span style="color: forestgreen">藏：${obj.fav}</span>
                              <span style="color:blue">适：${obj.unlike}</span>


                      </td>
                      <td>
                         <pe:permission key="update">
                      	   <a class="btn btn-success btn-small" href="javascript:openModel('${BasePath}/tips/toEdit?id=${obj.id}','修改贴士分类')" >修改</a>
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
// 删除记录
$(function(){
	$(".del").bind('click',function(){
		if(!confirm('确定删除该条记录吗？')){
			return false;
     	}
     	var id = $(this).parent().parent().find(".id").text();
     	var tr = $(this).parent().parent();
     	$.post('${BasePath}/tips/delete',{'id':id},function(data){
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