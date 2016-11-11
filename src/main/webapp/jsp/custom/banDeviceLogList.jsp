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
					<form action="${BasePath}/custom/banDeviceLogList?type=${type}&itemId=${itemId}" method="post" id="myform" name="myform" class="form-search">
									Device：
									<input type="text" name="device" value="${device }" />
										理由：
									<input type="text" name="reason" value="${reason }" />
									<input type="submit" value="查询" />
									
										<input type="hidden"  name="start" id="start" value="${start }"/>
												<input type="hidden"  name="limit" id="limit" value="${limit }"/>
									</form>
                           </div>
						</div>
					</div>
        <div class="block">
          <div class="navbar navbar-inner block-header">
            <div class="muted pull-left">封禁设备记录列表  <font color="#dc143c"> 总数：${json.total}</font></div>
            <%--<div class="pull-right">--%>
<%--              <button class="btn" style="margin-top: -5px" onclick="window.location='${BasePath}/custom/toAdd?type=${type}&itemId=${itemId}'">新增</button> --%>
			  <%--<span class="badge badge-info">${jsp.total}</total>--%>
		    <%--</div>--%>
          </div>
          <div class="block-content collapse in">
            <div class="span12">
              <table class="table table-hover">
                <thead>
                 <tr>
                    <th>Device</th>
                     <th>添加时间</th>
                     <th>封禁时间</th>
                      <th>理由</th>
                      <th>操作人</th>
                  </tr>
                </thead>
                <tbody id="tbodys">
                  <c:forEach items="${json.data}" var="obj">
                    <tr>
                      <td ><a  href="${BasePath}/custom/toDeviceList?device=${obj.device }" target="_blank" >${obj.device}</a> </td>
                      <td>
                          <script>formatTime("${obj.dateline}");</script></td>
                       <td>
                        <c:if test="${obj.duration==-1}"> 1min</c:if>
                        <c:if test="${obj.duration==3}"> 3天</c:if>
                        <c:if test="${obj.duration==7}"> 7天</c:if>
                         <c:if test="${obj.duration==15}"> 15天</c:if>
                         <c:if test="${obj.duration==30}"> 30天</c:if>
                         <c:if test="${obj.duration==0}">永久</c:if>
                        </td>
                        <td>${obj.reason}</td>
                        <td>${obj.adminName}</td>
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