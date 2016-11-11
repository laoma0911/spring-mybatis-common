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
					<form id="myForm"  name="myForm"  action="${BasePath}/tipsCategory/list" method="post" class="form-inline">
						<table>
							<tr>
								<td style="vertical-align: middle;">分类：</td><td><input type="text" name="title" value="${title }" /></td>
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
            <div class="muted pull-left">话题分类列表</div>
            <div class="pull-right">
	            <pe:permission key="add">
           	 	<a class="btn btn-success btn-small inline" style="margin-top: -5px" href="javascript:openModel('${BasePath}/tipsCategory/toAdd','新增贴士分类')" target="_black">新增</a>
    	        </pe:permission>
		    </div>
          </div>
          <div class="block-content collapse in">
            <div class="span12">
              <table class="table table-hover">
                <thead>
                  <tr>
                    <th>ID</th>
                    <th>分类</th>
                    <th>Logo</th>
                    <th>顺序值</th>
                    <th>关键字</th>
                    <th>操作</th>
                  </tr>
                </thead>
                <tbody id="tbodys">
                  <c:forEach items="${json.data}" var="obj">
                    <tr >
                      <td class="id">${obj.id}</td>
						<td>${obj.name}</td>
                        <td>
                            <c:if test="${obj.pic!=null && obj.pic!=''}">
                                <img src="${imageHost}${obj.pic}" width="100px" height="100px">
                            </c:if>
                        </td>
                      <td>${obj.displayOrder}</td>
                      <td>${obj.keywords}</td>
                      <td>
                         <pe:permission key="update">
                      	   <a class="btn btn-success btn-small" href="javascript:openModel('${BasePath}/tipsCategory/toEdit?id=${obj.id}','修改贴士分类')" >修改</a>
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
// 删除记录
$(function(){
	$(".del").bind('click',function(){
		if(!confirm('确定删除该条记录吗？')){
			return false;
     	}
     	var id = $(this).parent().parent().find(".id").text();
     	var tr = $(this).parent().parent();
     	$.post('${BasePath}/tipsCategory/delete',{'id':id},function(data){
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