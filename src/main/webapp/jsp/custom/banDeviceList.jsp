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
					<form action="${BasePath}/custom/banDeviceList?type=${type}&itemId=${itemId}" method="post" id="myform" name="myform">
									Device：
									<input type="text" name="device" value="${device }" />
									<input type="submit" value="查询" />
									
									<input type="hidden"  name="start" id="start" value="${start }"/>
												<input type="hidden"  name="limit" id="limit" value="${limit }"/>
									</form>
                           </div>
						</div>
					</div>
        <div class="block">
          <div class="navbar navbar-inner block-header">
            <div class="muted pull-left"> 封禁设备列表	 <font color="#dc143c"> 总数：${json.total}</font></div>

            <div class="pull-right">
              <pe:permission key="add">
                <button class="btn" style="margin-top: -5px" onclick="window.location='${BasePath}/custom/toAddBanDevice?type=${type}&itemId=${itemId}'">新增</button>
             </pe:permission>
		    </div>
          </div>
          <div class="block-content collapse in">
            <div class="span12">
              <table class="table table-hover">
                <thead>
                  <tr>
                    <th>Device</th>
                     <th>到期时间</th>
                      <th>操作</th>
                  </tr>
                </thead>
                <tbody id="tbodys">
                  <c:forEach items="${json.data}" var="obj">
                    <tr>
                      <td >
                          <a  href="${BasePath}/custom/toDeviceList?device=${obj.device }" target="_blank" >${obj.device}</a>
                      </td>
                      <td>
                           <c:if test="${obj.expires==0}">
                               永久
                           </c:if>
                          <c:if test="${obj.expires!=0}">
                          <script language="javascript">formatTime("${obj.expires}");</script>
                          </c:if>
                      </td>
                        <td>
                        <a href="javascript:deleteDevice('${obj.device }')">解封</a> &nbsp; |&nbsp;  <a href="${BasePath}/custom/banDeviceLogList?device=${obj.device }&type=${type}&itemId=${itemId}">历史</a></td>
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
	function deleteDevice(device){
		if(!confirm('确定解封该条记录吗？')){
	        return false;
	      }
	      $.post('${BasePath}/custom/banDeviceDelete',{'device':device },function(data){
	        var obj = eval(data);
	        if(obj.errno==0){
	          alert('操作成功');
	          window.location.reload();
	        }else{
	          alert(obj.errdesc);
	        }
	      });
	}
</script>