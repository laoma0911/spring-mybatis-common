<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="/permission" prefix="pe" %>

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
					<form id="myForm" name="myForm" action="${BasePath}/advert/list" method="post" class="form-inline">
									标题：
									<input type="text" name="title" value="${title }" />
									<input type="submit" value="查询" />
									
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
            <div class="muted pull-left"> 话题广告列表<br></div>
            <div class="pull-right">
              <pe:permission key="add">
             	<button class="btn btn-success btn-small" style="margin-top: -5px" onclick="openModel('${BasePath}/advert/toAdd','新增')">新增</button>
             </pe:permission>
<%-- 			  <span class="badge badge-info">${json.total}</span> --%>
			  
		    </div>
          </div>
          <div class="block-content collapse in">
            <div class="span12">
              <table class="table table-hover">
                <thead>
                  <tr>
                    <th nowrap="true">ID</th>
                    <th nowrap="true">标题</th>
                    <th nowrap="true">图片</th>
                    <th nowrap="true">投放目标</th>
                    <th nowrap="true">关键词</th>
                    <th nowrap="true">链接地址</th>
                    <th nowrap="true">平台</th>
                    <th nowrap="true">曝光率</th>
                    <th nowrap="true">点击率</th>
                    <th nowrap="true">在线时间</th>
                    <th nowrap="true">状态</th>
                    <th nowrap="true">是否同步谷歌平台</th>
                    <th nowrap="true">操作</th>
                  </tr>
                </thead>
                <tbody id="tbodys">
                  <c:forEach items="${json.data}" var="obj">
                    <tr>
                      <td nowrap="true" class="uid">${obj.id }</td>
                      <td style="width: 100px;" class="tdBreak">${obj.title }</td>
                      <td nowrap="true"><img alt="" src="${obj.picpath }" width="60px" height="40px"> </td>
                      <td nowrap="true">
                      		<c:if test="${obj.allPage==1 }">全部话题页面</c:if>
                      		<script type="text/javascript">formatAdvertStatus("${obj.groupCatId}");	</script>
                      </td>
                      
                      <td style="width: 200px;" class="tdBreak">${obj.keywords }</td>
                      <td style="width: 200px;" class="tdBreak"><a href="${obj.linkUrl }" target="_blank">${obj.linkUrl }</a></td>
                      <td nowrap="true">
                      			<script type="text/javascript">formatAdvertPlatform("${obj.platform}");	</script>
                      </td>
                      <td nowrap="true">${obj.showCount }</td>
                      <td nowrap="true">${obj.clickCount }</td>
                      <td nowrap="true">
                      <script >formatDate("${obj.fromDate}");</script><br>
                      至
                      <script >formatDate("${obj.toDate}");</script>
                      <td nowrap="true">
                      <c:choose>
                      	<c:when test="${obj.fromDate>nowDate}">
                      		<font >未上线</font>
                      	</c:when>
                      	<c:when test="${obj.fromDate<=nowDate && nowDate<=obj.toDate }">
                      		<font color="green">在线</font>
                      	</c:when>
                      	<c:when test="${obj.toDate<nowDate }">
                      		<font color="red">已结束</font>
                      	</c:when>
                      </c:choose>
                      </td>
                        <td nowrap="true">
                            <c:if test="${obj.toGoogle==1}"><font color="green">已同步</font></c:if>
                            <c:if test="${obj.toGoogle==0}"><font color="red">未同步</font></c:if>
                        </td>
                        <td  nowrap="true">
                         <pe:permission key="update">
                          <button onclick="openModel('${BasePath}/advert/toModify?id=${obj.id}','修改')" class="btn btn-succes btn-small">修改</button>
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
	            	  PAGER.initPager('${start}',' ${json.total}','${limit}', 8, 'pager', getData);
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
		      $.post('${BasePath}/advert/delete',{
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
