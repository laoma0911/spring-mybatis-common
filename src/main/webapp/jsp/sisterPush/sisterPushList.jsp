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
							<form class="form-search" id="myForm"  name="myForm"  action="${BasePath}/sisterPush/list" method="post">
								<select name="userStatus"  id="userStatus" class="input-medium search-query inline" >
									<option value="-1"    >全部用户状态</option>
									<option value="5"   <c:if test="${userStatus==5 }"> selected="selected"</c:if> >通用</option>
									<option  value="0" <c:if test="${userStatus==0 }"> selected="selected"</c:if> >记经期</option>
									<option value="1"  <c:if test="${userStatus==1 }"> selected="selected"</c:if>>备孕</option>
									<option value="2"  <c:if test="${userStatus==2 }"> selected="selected"</c:if>>怀孕中</option>
									<option value="3" <c:if test="${userStatus==3 }"> selected="selected"</c:if> >宝妈</option>
									<option value="4"   <c:if test="${userStatus==4 }"> selected="selected"</c:if> >魔瘦</option>
									
								</select>
								<select name="platform"  id="platform"  class="input-medium search-query inline" >
									<option value="-1"  >全部设备</option>
									<option  value="0"  <c:if test="${platform==0 }"> selected="selected"</c:if> >Android</option>
									<option value="1"  <c:if test="${platform==1 }"> selected="selected"</c:if>>IOS</option>
									<option value="2"  <c:if test="${platform==2 }"> selected="selected"</c:if>>WP</option>
								</select>
								上线时间：
								<input type="text"  style="width: auto;" id="upTime"  name="upTime" value="${upTime }" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:'false'})" class="Wdate" onClick="WdatePicker()" />
								<input type="text" class="input-medium search-query inline" name="title" value="${title }"  />
								<input type="hidden"  name="start" id="start" value="${start }"/>
								<input type="hidden"  name="limit" id="limit" value="${limit }"/>
								<input type="hidden"  name="type" id="type" value="${type }"/>
								<input type="hidden"  name="itemId" id="itemId" value="${itemId }"/>
  								<button type="submit" class="btn btn-small btn-success">Search</button>
					</form>
                           </div>
						</div>
					</div>
         
        <div class="block">
          <div class="navbar navbar-inner block-header">
            <div class="muted pull-left">姐妹说推荐列表</div>
            <div class="pull-right">
             <pe:permission key="add">
           		 <button class="btn btn-success btn-small" style="margin-top: -5px" onclick="openModel('${BasePath}/sisterPush/toAdd','新增')">新增</button>
            </pe:permission>
			  <span class="badge badge-info">${userCount}</span>
			  <br>
		    </div>
          </div>
          <div class="block-content collapse in">
            <div class="span12">
              <table class="table table-hover">
                <thead>
                  <tr>
                    <th>ID</th>
                    <th width="10%">用户状态</th>
    				<th>位置|banner</th>
                    <th  width="10%" >标题|TopicId</th>
                    <th>平台</th>
                    <th>曝光率</th>
                    <th>点击数</th>
                    <th>回复数</th>
                    <th>上线时间</th>
                     <th>同步最热话题</th>
                     <th>同步谷歌</th>
                    <th>操作</th>
                  </tr>
                </thead>
                <tbody id="tbodys">
                  <c:forEach items="${json.data}" var="obj">
                    <tr >
                       <td class="uid">${obj.id}</td>
                      <td>
                      <script type="text/javascript">formatUserStatus('${obj.userStatus }');</script>
                      </td>
                      <td>
                      	<c:if test="${obj.place==1 }">
					  		<img alt="" src="${imageHost }${obj.pic }" width="84px" height="40px" />
					  	</c:if>
					  	<c:if test="${obj.place!=1 }">
					  		位置${obj.place }
					  	</c:if>
                      </td>
					  <td>
					  <c:choose>
					  <c:when test="${obj.topicId>0 }">
					  		${obj.title }
					  		<br>
					  		<a href="${BasePath}/topic/topicDetail?topicId=${obj.topicId}&type=${type}&itemId=${itemId}" target="_blank">${obj.topicId }</a>
					  		
					  </c:when>
					  <c:otherwise>
					  	    ${obj.title }<br>
					  	    <a href="${obj.link }" target="_blank">${obj.link }</a>
					  </c:otherwise>
					  </c:choose>
					 </td>
					  <td><script type="text/javascript">formatPlatform('${obj.platform}');</script></td>
					  <td>${obj.showNum }</td>
					  <td>
					  		 <input type="hidden" id="id"  name="id" value="${obj.id }"/>
					  		 <div id="clickNumDiv_${obj.id }"></div>
					  </td>
					  <td>${obj.replyNum }</td>
					   
                      <td><script >formatTime("${obj.startTime}");</script></td>
                      <td>
					   <c:if test="${obj.flag==1 }">
					   <font  color="green">是</font>
					   </c:if>
					   <c:if test="${obj.flag==0 }">
					   <font  color="red">否</font>
					   </c:if>
					   </td>
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
                      		<a class="btn btn-success btn-small" href="javascript:openModel('${BasePath}/sisterPush/toModify?id=${obj.id}','修改')">修改</a> 
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
      var uid = $(this).parent().parent().find(".uid").text();
      var tr = $(this).parent().parent();
      $.post('${BasePath}/sisterPush/delete',{
        'id':uid,'status':-1
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
    
    $(".up").bind('click',function(){
        var uid = $(this).parent().parent().find(".uid").text();
        var tr = $(this).parent().parent();
        $.post('${BasePath}/activity/changStatus',{
          'id':uid,'status':1
        },function(data){
          var obj = eval(data);
          if(obj.errno==0){
            alert('操作成功');
            window.location.reload();
          }else{
            alert(obj.errdesc);
          }
        });
      });

    $(".down").bind('click',function(){
        var uid = $(this).parent().parent().find(".uid").text();
        $.post('${BasePath}/activity/changStatus',{
          'id':uid,'status':0
        },function(data){
          var obj = eval(data);
          if(obj.errno==0){
            alert('操作成功');
            window.location.reload();
          }else{
            alert(obj.errdesc);
          }
        });
      });
  });
  var sign=0;
  window.onload=function(){
	  //分页
	  PAGER.initPager('${start}',' ${json.total}','${limit}', 8, 'pager', getData);
	  
	  
	  //异步统计姐妹说点击数
	        $("input[name='id']").each(function (){
	        	var id=this.value;
	    		$.post('${BasePath}/sisterPush/getClickNum',{ 'id':id },function(data){
	    	          var obj = eval(data);
	    	          if(obj.errno==0){
	    	        	  var html="Android:";
	    	        	  if(data.androidClickNum!=null){
	    	        		  html+=data.androidClickNum;
	    	        	  }else{
	    	        		  html+="0";
	    	        	  }
	    	        	  html+="<br>IOS:";
	    	        	  if(data.iosClickNum!=null){
	    	        		  html+=data.iosClickNum;
	    	        	  }else{
	    	        		  html+="0";
	    	        	  }
	    	        	  html+="<br>WP:";
	    	        	  if(data.wpClickNum!=null){
	    	        		  html+=data.wpClickNum;
	    	        	  }else{
	    	        		  html+="0";
	    	        	  }
	    	           $("#clickNumDiv_"+id).html(html);
	    	          }
	    	      });
	    	}); 
  		}
  //分页
  function getData(currentPage,pageSize) {
  	  if(sign>0){
  	 	$("#start").val(currentPage);
  	 	$("#limit").val(pageSize);
  	 	$("#myForm").submit();
  	  }
  	  sign=1;
 	 } 
</script>