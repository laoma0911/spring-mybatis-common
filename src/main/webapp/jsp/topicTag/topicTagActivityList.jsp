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
					<form id="myForm"  name="myForm"  action="${BasePath}/topicTagActivity/list" method="post">
									<input type="hidden"  name="start" id="start" value="${start }"/>
									<input type="hidden"  name="limit" id="limit" value="${limit }"/>
									<input type="hidden"  name="type" id="type" value="${type }"/>
									<input type="hidden"  name="itemId" id="itemId" value="${itemId }"/>
					</form>
          <div class="navbar navbar-inner block-header">
            <div class="muted pull-left">推荐用户列表</div>
            <div class="pull-right">
			  <pe:permission key="add">
              		<button class="btn btn-success btn-small" style="margin-top: -5px" onclick="openModel('${BasePath}/topicTagActivity/toAdd','新增')">新增</button>
              </pe:permission>
		    </div>
          </div>
          <div class="block-content collapse in">
            <div class="span12">
              <table class="table">
                <thead>
                  <tr>
                    <th>ID</th>
                    <th>显示日期</th>
                    <%--<th>标签</th>--%>
                      <th>用户状态</th>
                    <th>位置</th>
                    <th>标题|链接</th>
                    <th>图片</th>
                      <th>平台</th>
                      <th>点击数</th>
                    <th>推荐人</th>
                    <th>推荐时间</th>
                    <th>同步谷歌</th>
                    <th>操作</th>
                  </tr>
                </thead>
                <tbody id="tbodys">
                  <c:forEach items="${list}" var="obj">
                    <tr>
                      <td class="id">${obj.id}</td>
                      <td><script language="javascript">formatDate(${obj.startDate})</script> - <script language="javascript">formatDate(${obj.endDate})</script></td>
                      <%--<td>${obj.tag}</td>--%>
                      <td><script type="text/javascript">formatCardStatus("${obj.userStatus}")</script></td>
                        <td>位置${obj.location}</td>
                      <td>${obj.title}<br>
                          ${obj.link}
                      </td>
                      <td><img src="${imageHost }${obj.pic}" width="80" height="80" /> </td>
                        <td> <c:choose>
                            <c:when test="${obj.platform=='0'}">
                                Android
                            </c:when>
                            <c:when test="${obj.platform=='1'}">
                                IOS
                            </c:when>
                            <c:when test="${obj.platform=='2'}">
                                WP
                            </c:when>
                            <c:when test="${obj.platform=='0,1'}">
                                Android,IOS
                            </c:when>
                        </c:choose></td>
                        <td>
                            <input type="hidden" id="id"  name="id" value="${obj.id }"/>
                            <div id="clickNumDiv_${obj.id }"></div>
                        </td>

                      <td>${obj.recommendUserName}</td>
                      <td><script language="javascript">formatTime(${obj.dateline})</script></td>
                          <td>
                      	<c:if test="${obj.toGoogle == 0 }">
                      		不同步
                      	</c:if>
                      	<c:if test="${obj.toGoogle == 1 }">
                      		同步
                      	</c:if>
                      </td>
                      <td>
                        <pe:permission key="update">
                       <a class="btn btn-small btn-success" href="javascript:openModel('${BasePath}/topicTagActivity/toEdit?id=${obj.id}','修改')">修改</a>
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


                      //异步统计姐妹说点击数
                      $("input[name='id']").each(function (){
                          var id=this.value;
                          $.post('${BasePath}/topicTagActivity/getClickNum',{ 'id':id },function(data){
                              var obj = eval(data);
                              if(obj.errno==0){
//                                  var html="Android:";
//                                  if(data.androidClickNum!=null){
//                                      html+=data.androidClickNum;
//                                  }else{
//                                      html+="0";
//                                  }
//                                  html+="<br>IOS:";
//                                  if(data.iosClickNum!=null){
//                                      html+=data.iosClickNum;
//                                  }else{
//                                      html+="0";
//                                  }
//                                  html+="<br>WP:";
//                                  if(data.wpClickNum!=null){
//                                      html+=data.wpClickNum;
//                                  }else{
//                                      html+="0";
//                                  }
                                  $("#clickNumDiv_"+id).html(data.totalClickNum);
                              }
                          });
                      });

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
      
      if(!confirm('确定删除该记录么？')){
        return false;
      }
      var id = $(this).parent().parent().find(".id").text();
      var tr = $(this).parent().parent();
      $.post('${BasePath}/topicTagActivity/delete',{
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