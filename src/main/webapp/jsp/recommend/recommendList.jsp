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

            <div class="navbar navbar-inner block-header"  style="border-bottom: none;" >
                <form class="form-search" id="myForm"  name="myForm"  action="${BasePath}/topicTagRecommend/list" method="post">
<!--                     标签： <select name="tagId"  id="tagId" class="input-medium search-query inline" > -->
<!--                         <option value=""    >全部</option> -->
<%--                         <c:forEach items="${tagList}" var="tag"> --%>
<%--                             <option value="${tag.id}"   <c:if test="${tagId==tag.id}"> selected="selected"</c:if> >${tag.tag}</option> --%>
<%--                         </c:forEach> --%>
<!--                     </select> -->
                    推荐热门时间：
                    <input type="text"   style="width: auto;" id="recommendDate"  name="recommendDate" value="${recommendDate}" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:'false'})" class="Wdate" onClick="WdatePicker()" />
                    推荐首页时间：
                    <input type="text"   style="width: auto;" id="indexDate"  name="indexDate" value="${indexDate}" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:'false'})" class="Wdate" onClick="WdatePicker()" />
                    <select id="queryType" name="queryType">
                        <option value="0" >全部</option>
                        <option value="1"<c:if test="${queryType==1}">selected="selected" </c:if> >推荐到首页</option>
                    </select>
                    topicId:<input type="text"  name="topicId" id="topicId" value="${topicId}"/>
                    <input type="hidden"  name="start" id="start" value="${start }"/>
                    <input type="hidden"  name="limit" id="limit" value="${limit }"/>
                    <input type="hidden"  name="type" id="type" value="${type }"/>
                    <input type="hidden"  name="itemId" id="itemId" value="${itemId }"/>
                    <button type="submit" class="btn btn-small btn-success">Search</button>
                </form>
            </div>
          <div class="navbar navbar-inner block-header">
            <div class="muted pull-left">热门列表</div>
              <div class="muted pull-right"><font color="red">共有${total}条</font></div>

              <pe:permission key="download">
                  <div class="pull-right">
                      <a class="btn cancel btn btn-primary btn-small" style="margin-top: auto;"
                         href="javascript:openModel('/topicTagRecommend/toExportTagRecommend','导出数据','45%','45%')">导出数据</a>
                      &nbsp;&nbsp;&nbsp;
                  </div>
              </pe:permission>
          </div>
          <div class="block-content collapse in">
            <div class="span12">
              <table class="table">
                <thead>
                  <tr>
                    <th>ID</th>
                    <th width="15%">标题</th>
                      <th width="10%">头图</th>
                      <th width="10%">首图</th>
<!--                     <th>标签</th> -->
                    <th>发布时间</th>
                      <th>操作人<br>推荐热门时间</th>
                      <th>推荐到首页</th>
                      <th>操作人<br>推荐首页时间</th>
                      <th>浏览量|回复量</th>
                      <th>UV|UR</th>
                    <th>操作</th>
                  </tr>
                </thead>
                <tbody id="tbodys">
                  <c:forEach items="${list}" var="obj">
                    <tr>
                      <td class="id">${obj.id}</td>
                      <td>
                          <a target="_blank" href="${BasePath }/topic/topicDetail?topicId=${obj.topicId}&type=${type}&itemId=${itemId}">${obj.title }</a>
                      </td>
                        <td>
                            <c:if test="${obj.type==0}">
                                <img src="${imageHost}${obj.pic}" width="100px" height="100px">
                            </c:if>
                        </td>
                        <td>
                            <c:if test="${obj.type==1}">
                                <img src="${imageHost}${obj.firstPic}" width="100px" height="100px">
                            </c:if>
                        </td>
<%--                       <td>${obj.tag}</td> --%>
                        <td> <script type="text/javascript">formatTime('${obj.dateline}')</script></td>
                        <td>
                                ${obj.recommendUserName}<br>
                            <script type="text/javascript">formatTime('${obj.recommendDate}')</script></td>
                        <td>
                            <c:if test="${obj.indexRecommendDate==0}">
                                <font color="#dc143c" >否</font>
                            </c:if>
                            <c:if test="${obj.indexRecommendDate>0}">
                                <font color="green">是</font>
                            </c:if>
                        </td>
                        <td>
                            ${obj.indexRecommendUserName}<br>
                            <c:choose>
                                <c:when test="${obj.indexRecommendDate>0}">
                                    <script type="text/javascript">formatTime('${obj.indexRecommendDate}')</script>
                                </c:when>
                            </c:choose>
                        </td>
                        <td>${obj.viewNum} | ${obj.replyNum}</td>
                        <td>${obj.uv} | ${obj.ur}</td>
                      <td>
                        <pe:permission key="index">
                          <c:choose>
                              <c:when test="${obj.indexRecommendDate>0}">
                                  <a class="btn btn-small btn-danger" onclick="cancelIndex(${obj.id})">取消到首页</a>
                              </c:when>
                              <c:otherwise>
                                  <a class="btn btn-small btn-success" onclick="openDate(${obj.id})">推荐到首页</a>
                              </c:otherwise>
                          </c:choose>
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




<div class="container-fluid">
    <div class="row-fluid">
        <div class="span12">
            <div id="dateModel" class="modal hide fade" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h3 id="myModalLabel">
                        推荐到首页
                    </h3>
                </div>
                <div class="modal-body">
                    <p>
                        推荐日期：<input type="text"  style="width: auto;" id="date"  name="date"
                                    onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:'false'})" class="Wdate"
                                    onClick="WdatePicker()"  />
                        <input type="hidden" id="id" name="id" value=""/>
                    </p>
                </div>
                <div class="modal-footer">
                    <button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button> <button onclick="saveForm()" class="btn btn-primary">保存</button>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function openDate(id){
        $("#id").val(id);
        $('#dateModel').modal('show');
    }
    function closeDate(){
        $('#dateModel').modal('hide');
        window.location.reload(true);
    }

//     function saveDate(){
//         var date=$("#date").val();
//         var id=$("#id").val();
//         if(date==""){
//             alert("请选择时间！");
//             return false;
//         }
//         $.post('${BasePath}/topicTagRecommend/checkIndex',{'date':date,'id':id},
//                 function(data){
//                     if(data.errno==0){
//                         saveForm(0);
//                     }else{
//                         if(confirm("当天同标签已经存在文章，是否要覆盖？")){
//                             saveForm(1);
//                         }
//                     }
//         });
//     }

    function saveForm(){
        var date=$("#date").val();
        if(date==""){
            alert("请选择时间！");
            return false;
        }
        var id=$("#id").val();
        //覆盖保存
        $.post('${BasePath}/topicTagRecommend/toRecommendIndex',{'date':date,'id':id},
                function(data){
                    if(data.errno==0){
                        window.location.reload(true);
                    }else{
                        alert(data.errdesc);
                    }
                });
    }



    function cancelIndex(id){
        if(confirm("确定要取消到是首页吗？")){
            $.post('${BasePath}/topicTagRecommend/cancelIndex?id='+id,
                    function(data){
                    var obj = eval(data);
                    if(obj.errno==0){
                        window.location.reload(true);
                    }else{
                        alert(data.errdesc);
                    }
            });
        }
    }

  $(function(){
    $(".del").bind('click',function(){
      
      if(!confirm('确定删除该用户么？')){
        return false;
      }
      var uid = $(this).parent().parent().find(".id").text();
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