<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="/permission" prefix="pe" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 

<jsp:include page="../include/top.jsp" />
<!-- Body -->
<script src="${BasePath}/js/json.js"></script>
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
					<form id="myForm" name="myForm" action="${BasePath}/mei/list" method="post">
									<table >
										<tr valign="middle">
											<td>文案：</td><td><input type="text" name="title"  id="title"  value="${title }" /></td>
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
            <div class="muted pull-left">美月图标列表</div>
            <div class="pull-right">
             <pe:permission key="add">
            	<button class="btn btn-success btn-small" style="margin-top: -5px" onclick="openModel('${BasePath}/mei/toAdd','新增')">新增</button>
            </pe:permission>
		    </div>
          </div>
          <div class="block-content collapse in">
            <div class="span12">
              <table class="table table-hover">
                <thead>
                  <tr>
                    <th>ID</th>
                    <th>文案</th>
                    <th>未选中图标</th>
                    <th>选中图标</th>
                    <th>时间</th>
                    <th>平台</th>
                    <th>点击数</th>
                    <th>状态</th>
                    <th>是否同步谷歌平台</th>
                    <th>操作</th>
                  </tr>
                </thead>
                <tbody id="tbodys">
                  <c:forEach items="${json.data}" var="obj">
                    <tr >
                      <td  class="uid">${obj.id}</td>
                       <td  >${obj.title}</td>
                      <td><img  src="${imageHost }${obj.picNo}"   width="80px" height="80px" /></td>
                      <td><img  src="${imageHost }${obj.picOk}"   width="80px" height="80px" /></td>
                      <td><script type="text/javascript">formatDate('${obj.startDate}')</script> 至 <script type="text/javascript">formatDate('${obj.endDate}')</script>   </td>
                      <td>
                      		<c:if test="${obj.platform==0 }">Android</c:if>
                      		<c:if test="${obj.platform==1 }">IOS</c:if>
                      </td>
                      <td>${obj.clickNum } </td>
                      <td>
                      	   <c:choose>
                      	   		<c:when test="${nowDate<obj.startDate }"> 
                      	   				<font  color="red">未上线</font>
                      	   		</c:when>
                      	   		<c:when test="${nowDate>=obj.startDate && nowDate<=obj.endDate }">
                      	   				<font color="green">在线</font>
                      	   		</c:when>
                      	   		 <c:when test="${nowDate>obj.endDate }">
                      	   				<font color="green">已下线</font>
                      	   		</c:when>
                      	   </c:choose>
                     </td>
                      <td>
                        <c:if test="${obj.toGoogle==1}"><font color="green">已同步</font></c:if>
                        <c:if test="${obj.toGoogle==0}"><font color="red">未同步</font></c:if>
                      </td>
                      <td>
                      <pe:permission key="update">
                      			        <a class="btn btn-success btn-small" href="javascript:openModel('${BasePath}/mei/toEdit?id=${obj.id}','修改')" >修改</a> 
                      </pe:permission>
                       <pe:permission key="delete">
                      			<button class="btn del btn-danger btn-small">删除</button> 
                      	</pe:permission>
                      	 <pe:permission key="log">
							<a class="btn btn-info btn-small" href="javascript:openModel('${BasePath}/mei/toMeiImageLog?id=${obj.id}','查看每日')">查看每日</a> 
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
      $.post('${BasePath}/mei/delete',{
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