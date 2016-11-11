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
         
         <div class="block"  >
					<div class="navbar navbar-inner block-header"  style="border-bottom: none;" >
					<form action="${BasePath}/custom/nickLogList?type=${type}&itemId=${itemId}" method="post" id="myform" name = "myform" class="form-search">
									UID：<input type="text" name="uid" id="uid" value="${uid }" />
									新昵称：<input type="text" name="newNick" value="${newNick }">
									旧昵称：<input type="text" name="oldNick" value="${oldNick }">
									
									<select name="search_style">
										<c:choose> <c:when test="${search_style=='0'}">
												<option value="0" selected="selected">精确</option>
										</c:when> <c:otherwise>
												<option value="0" >精确</option>
										</c:otherwise></c:choose>
										<c:choose> <c:when test="${search_style=='1'}">
												<option value="1" selected="selected">模糊匹配，请慎用</option>
										</c:when> <c:otherwise>
												<option value="1" >模糊匹配，请慎用</option>
										</c:otherwise></c:choose>
									<select>
									<input type="button" onclick="find()" class="btn"  value="查询" />
									
												<input type="hidden"  name="start" id="start" value="${start }"/>
												<input type="hidden"  name="limit" id="limit" value="${limit }"/>
												
									<script type="text/javascript">
											function find(){
												var uid = $("#uid").val().trim();
												if(isNaN(uid)){
													alert("uid只能是数字!");
													 $("#uid").val('');
													return ;
												}
												$("#myform").submit();
											}
									</script>
												
									
									</form>
                           </div>
						</div>
					</div>
        <div class="block">
          <div class="navbar navbar-inner block-header">
            <div class="muted pull-left">列表</div>
            <div class="pull-right">
			  <span class="badge badge-info">${json.total}</span>
		    </div>
          </div>
          <div class="block-content collapse in">
            <div class="span12">
              <table class="table table-hover">
                <thead>
                  <tr>
                    <th>ID</th>
                    <th>uid</th>
                    <th>旧昵称</th>
                    <th>新昵称</th>
                     <th>修改时间</th>
                      <th>来源</th>
                  </tr>
                </thead>
                <tbody id="tbodys">
                  <c:forEach items="${json.data}" var="log">
                    <tr>
                      <td class="id">${log.id}</td>
                      <td>${log.uid}</td>
                      <td>${log.oldNick}</td>
                      <td>${log.newNick}</td>
                       <td><script >formatTime("${log.dateline}");</script></td>
                        <td>
                            <c:if test="${log.source==0}">
                                客户端
                            </c:if>
                            <c:if test="${log.source==1}">
                                线上
                            </c:if>

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
								              };
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
<jsp:include page="../include/bottom.jsp" />


<script>
$("#domainId").bind("change", function () {
	var domainId = $("#domainId").val();
	window.location.href = "${BasePath }/url/query?type=${type}&itemId=${itemId}&domainId="+ domainId;
});


  $(function(){
    $(".del").bind('click',function(){
      
      if(!confirm('确定删除该条记录吗？')){
        return false;
      }
      var uid = $(this).parent().parent().find(".id").text();
      var tr = $(this).parent().parent();
      $.post('${BasePath}/url/delete',{
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