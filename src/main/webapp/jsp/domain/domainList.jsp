<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
         
        <div class="block">
          <div class="navbar navbar-inner block-header">
            <div class="muted pull-left">域名列表</div>
            <div class="pull-right">
              <pe:permission key="add">
              	<button class="btn btn-small btn-success" style="margin-top: -5px" onclick="openModel('${BasePath}/domain/toAdd','新增','50%','50%')">新增</button>
              </pe:permission>
		    </div>
          </div>
          <div class="block-content collapse in">
            <div class="span12">
              <table class="table table-hover">
                <thead>
                  <tr>
                    <th>ID</th>
                    <th>域名</th>
                    <th>操作</th>
                  </tr>
                </thead>
                <tbody id="tbodys">
                  <c:forEach items="${json.data}" var="domain">
                    <tr>
                      <td class="id">${domain.id}</td>
                      <td>${domain.domain}</td>
                      <td>
                      <pe:permission key="update">
                      	<a class="btn btn-small btn-success" href="javascript:openModel('${BasePath}/domain/get?id=${domain.id}','修改','50%','50%')">修改</a> 
                      	</pe:permission>
					 <pe:permission key="delete">
                      	<button class="btn del btn-small btn-danger">删除</button> 
                      	</pe:permission>
                       </td>
                    </tr>
                  </c:forEach>
                </tbody>
              </table>
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
      if(!confirm('确定删除该条记录吗？')){
        return false;
      }
      var uid = $(this).parent().parent().find(".id").text();
      var tr = $(this).parent().parent();
      $.post('${BasePath}/domain/delete',{ 'id':uid  },function(data){
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