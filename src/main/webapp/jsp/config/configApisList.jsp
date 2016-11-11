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
					<form id="myForm" name="myForm" action="${BasePath}/configApis/list" method="post" class="form-inline">
									项目：
									<input type="text" name="project" value="${project }" />
									名称：
									<input type="text" name="name" value="${name }" />
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
            <div class="muted pull-left"> API配置列表<br></div>
            <div class="pull-right">
              <pe:permission key="add">
             	<button class="btn btn-success btn-small" style="margin-top: -5px" onclick="openModel('${BasePath}/configApis/toAdd','新增','40%','40%')">新增</button>
             </pe:permission>
<%-- 			  <span class="badge badge-info">${json.total}</span> --%>
			  
		    </div>
          </div>
          <div class="block-content collapse in">
            <div class="span12">
              <table class="table table-hover">
                <thead>
                  <tr>
                    <th>ID</th>
                    <th  width="20%">项目</th>
                    <th>名称</th>
                    <th>添加时间</th>
                  </tr>
                </thead>
                <tbody id="tbodys">
                  <c:forEach items="${configApisList}" var="obj">
                    <tr>
                      <td class="uid">${obj.id }</td>
                      <td width="20%">${obj.project }</td>
                      <td>${obj.name }</td>
                      <td> <script >formatTime("${obj.dateline}");</script></td>
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
