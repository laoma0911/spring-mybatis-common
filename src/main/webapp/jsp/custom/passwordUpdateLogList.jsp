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
					<form action="${BasePath}/custom/passwordUpdateLogList?type=${type}&itemId=${itemId}" method="post" id="myform" name="myform" class="form-search">
									UID：
									<input type="text" name="uid" id="uid" value="${uid }" />
<!-- 									修改时间： -->
<%-- 									<input type="text"  style="width: auto;" id="startTm"  name="startTm" value="${startTm }" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',readOnly:'false'})" class="Wdate" />~ --%>
<%-- 									<input type="text"  style="width: auto;" id="endTm"  name="endTm" value="${endTm }" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',readOnly:'false'})" class="Wdate"  /> --%>
									<%--password：<input type="text" name="password" id="password" value="${password }" />--%>
									<input type="button" onclick="find()" class="btn" value="查询" />
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
<%--              <button class="btn" style="margin-top: -5px" onclick="window.location='${BasePath}/custom/toAdd?type=${type}&itemId=${itemId}'">新增</button> --%>
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
                    <%--<th>密码</th>--%>
                     <th>修改时间</th>
                      <th>修改来源</th>
                  </tr>
                </thead>
                <tbody id="tbodys">
                  <c:forEach items="${json.data}" var="log">
                    <tr>
                      <td class="id" style="width:20%;">${log.id}</td>
                      <td style="width:20%;">${log.uid}</td>
                      <%--<td style="width:20%;">${log.password}</td>--%>
                      <td style="width:20%;"><script >formatTime("${log.dateline}");</script></td>
                        <td style="width:20%;">
                            <c:if test="${log.source==0}">客户端</c:if>
                            <c:if test="${log.source==1}">线上</c:if>
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