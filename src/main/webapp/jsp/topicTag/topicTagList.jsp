<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="/permission" prefix="pe" %>

<%--
  ~ /**
  ~  *dashan
  ~  */
  --%>

<%--
  ~ /**
  ~  *dashan
  ~  */
  --%>

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
         
        <div class="block">
					<form id="myForm"  name="myForm"  action="${BasePath}/topicTag/list" method="post">
									<input type="hidden"  name="start" id="start" value="${start }"/>
									<input type="hidden"  name="limit" id="limit" value="${limit }"/>
									<input type="hidden"  name="type" id="type" value="${type }"/>
									<input type="hidden"  name="itemId" id="itemId" value="${itemId }"/>
					</form>
          <div class="navbar navbar-inner block-header">
            <div class="muted pull-left">话题标签分类列表</div>
            <div class="pull-right">
			  <pe:permission key="add">
              		<button class="btn btn-success btn-small" style="margin-top: -5px" onclick="openModel('${BasePath}/topicTag/toAdd','新增')">新增</button>
              </pe:permission>
		    </div>
          </div>
          <div class="block-content collapse in">
            <div class="span12">
              <table class="table">
                <thead>
                  <tr>
                    <th>ID</th>
                    <th>小组</th>
                    <th>标签</th>
                    <th>排序值</th>
                      <th>最后修改时间</th>
                    <th>操作</th>
                  </tr>
                </thead>
                <tbody id="tbodys">
                  <c:forEach items="${list}" var="obj">
                    <tr>
                      <td class="id">${obj.id}</td>
                      <td>${obj.groupName}</td>
                      <td>${obj.tag}</td>
                      <td>${obj.displayOrder}</td>
                        <td><script type="text/javascript">formatTime('${obj.dateline}')</script></td>
                      <td>
                        <pe:permission key="update">
                       <a class="btn btn-small btn-success" href="javascript:openModel('${BasePath}/topicTag/toEdit?id=${obj.id}','修改')">修改</a>
                       </pe:permission>
                       <pe:permission key="delete">
                         <button class="btn del btn-small btn-danger">删除</button> 
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
</div>
  <hr>
  
<jsp:include page="../include/bottom.jsp" />


<script>
  $(function(){
    $(".del").bind('click',function(){
      
      if(!confirm('确定删除吗？')){
        return false;
      }
      var id = $(this).parent().parent().find(".id").text();
      var tr = $(this).parent().parent();
      $.post('${BasePath}/topicTag/delete',{
        'id':id
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