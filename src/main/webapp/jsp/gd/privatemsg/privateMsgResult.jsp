<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<%@ taglib uri="/permission" prefix="pe"%>
<jsp:include page="../../include/head.jsp" />
<style>
body {
	padding-top: 0px;
}
textarea{
	background: #ffffff!important;
	border-style: none!important;
	border: 1px solid #ccc!important;
}
</style>
<!-- Body -->
<div class="container-fluid">
	<div class="row-fluid">
				<div class="row-fluid">
				<div class="span12">
					<div class="block">
						<div class="navbar navbar-inner block-header" style="border-bottom: none;">
							<form action="${BasePath}/meiyue/privateMsg/sendResult?type=${type}&itemId=${itemId}" method="post" id="searchForm"  name="searchForm" class="form-search">
								发送者: <input type="text" name="sendId" id="sendId" value="${sendId }"  />
								接收者: <input type="text" name="acceptId" id="acceptId" value="${acceptId }"  />
								发送内容：<input type="text" name="content" id="content"   value="${content}"/>
								<input type="hidden"  name="start" id="start" value="${start }"/>
								<input type="hidden"  name="limit" id="limit" value="${limit }"/>
								<input type="hidden"  name="type" id="type" value="${type }"/>
								<input type="hidden"  name="itemId" id="itemId" value="${itemId }"/>
								 <input type="button" class="btn btn-small btn-success" onclick="submitForm()" value="查询" />
									<script type="text/javascript">
											function submitForm(){
												$("#searchForm").submit();
											}
									</script>
							</form>
						</div>
					</div>
				</div>
				  <div class="block">
          <div class="navbar navbar-inner block-header">
            <div class="muted pull-left">姐妹说推荐列表</div>
            <div class="pull-right">
			  <span class="badge badge-info">${userCount}</span>
			  <br>
		    </div>
          </div>
          <div class="block-content collapse in">
            <div class="span12">
              <table class="table table-hover">
                <thead>
                  <tr>
                	<th>发送者</th>
					<th>接收者</th>
    				<th>私信内容</th>
					 <th>发送时间</th>
					 <th>未成功UID</th>
                  </tr>
                </thead>
                <tbody id="tbodys">
                  <c:forEach items="${pmList}" var="obj">
                    <tr >
	                    <td>${obj.sendName}</td>
	                    <td><textarea style="width:400px;height:50px;" readonly>${obj.receiveUid} </textarea></td>
	                    <td><textarea style="width:400px;height:50px;" readonly>${obj.content} </textarea></td>
	                    <td><script type="text/javascript">formatTime('${obj.dateline }');</script></td>
	                    <td><textarea style="width:100px;height:50px" readonly>${obj.failedUid } </textarea></td>
                    </tr>
                  </c:forEach>
                </tbody>
              </table>
                <div class="pagination pagination-centered" id="pager"></div> 
            </div>
          </div>
        </div>
				<script type="text/javascript">
				  var sign=0;
				  window.onload=function(){
					  //分页
					  PAGER.initPager('${start}',' ${total}','${limit}', 8, 'pager', getData);
				  }
					  //分页
					  function getData(currentPage,pageSize) {
					  	  if(sign>0){
					  	 	$("#start").val(currentPage);
					  	 	$("#limit").val(pageSize);
					  	 	$("#searchForm").submit();
					  	  }
					  	  sign=1;
					 	 }   
				
				
				</script>
				
			</div>
		</div>
	</div>
</div>

