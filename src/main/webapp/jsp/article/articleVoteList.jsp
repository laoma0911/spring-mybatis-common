<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<%@ taglib uri="/permission" prefix="pe"%>
<jsp:include page="../include/head.jsp" />
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
							<form action="${BasePath}/article/tvList?type=${type}&itemId=${itemId}" method="post" id="searchForm"  name="searchForm" class="form-search">
								投票标题: <input type="text" name="title" id="sendId" value="${title }"  />
								<input type="hidden"  name="voteId" id="voteId" value="${voteId }"/>
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
            <div class="muted pull-left">投票列表</div>
            <div class="pull-right">
			  <br>
		    </div>
          </div>
          <div class="block-content collapse in">
            <div class="span12">
              <table class="table table-hover">
                <thead>
                  <tr>
                  	<th>选择</th>
                	<th>投票id</th>
					<th>投票标题</th>
    				<th>结束时间</th>
					 <th>创建时间</th>
                  </tr>
                </thead>
                <tbody id="tbodys">
                  <c:forEach items="${tvList}" var="obj">
                    <tr >
                    	<td><input type="radio" id="selR" name="selR"  value="${obj.id}"  <c:if test="${obj.id==voteId}">checked</c:if> ></td>
	                    <td>${obj.id}</td>
	                    <td>${obj.title}</td>
	                    <td><script type="text/javascript">formatTime('${obj.endDate }');</script></td>
	                    <td><script type="text/javascript">formatTime('${obj.dateline }');</script></td>
                    </tr>
                  </c:forEach>
                </tbody>
              </table>
                <div class="pagination pagination-centered" id="pager"></div>
                <div class="pull-right">
		            		<input type="button" class="btn btn-small btn-success" onclick="selectR()" value="确定" />
				    </div> 
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

<script type="text/javascript">

	function selectR(){
		var selR = $('input[name="selR"]:checked').val();
		
		if(selR == null || selR == ''){
			alert("请选择投票!");
			return ;
		}
		
		parent.selectVoteId(selR);
	}
</script>

