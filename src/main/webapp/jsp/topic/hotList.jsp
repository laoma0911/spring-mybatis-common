<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="e" uri="https://www.owasp.org/index.php/OWASP_Java_Encoder_Project#advanced" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="/permission" prefix="pe" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 

<jsp:include page="../include/top.jsp" />
<script>
<c:if test="${CHECKUSER==false }">
	alert("用户没有登录，请登录！");
	window.location.href="${BasePath}";
</c:if>
</script>
<!-- Body -->
<div class="container-fluid">
	<div class="row-fluid">
		<!-- Menu -->
		<jsp:include page="../include/menu.jsp" />
		<div class="span9" id="content">
			<jsp:include page="../include/location.jsp" />
			<div class="row-fluid">
         
          <div id="fixedBar" class="block" style="clear:both;">
                    <div class="navbar navbar-inner block-header">
                            <a class="btn cancel btn btn-primary btn-small"
                               href="javascript:openModel('${BasePath}/topic/toExportHotList','导出最热话题','45%','45%')">导出最热话题</a>
                    </div>
                </div>
         
        <div class="block">
            <div class="navbar navbar-inner block-header">
                <div class="muted pull-left">最热话题列表</div>
            </div>
          <div class="block-content collapse in">
            <div class="span12">
                  <table class="table table-hover">
                <thead>
                  <tr>
                    <th>ID</th>
                    <th width="15%">标题</th>
                    <th>小组分类</th>
                    <th>发布时间</th>
                    <th>最后回复时间</th>
                    <th>浏览量</th>
                    <th>回复量</th>
                      <pe:permission key="delete"><th>推荐</th></pe:permission>
                      <pe:permission key="update"><th>操作</th></pe:permission>
                  </tr>
                </thead>
                <tbody id="tbodys">
                  <c:forEach items="${json.data}" var="obj">
                    <tr >
                      <td class="uid">${obj.id}</td>
                      <td>
                          <a href="${BasePath}/topic/topicDetail?topicId=${obj.topicId}&type=${type}&itemId=${itemId}" target="_blank"><e:forHtml value="${obj.title}" /></a>
                      </td>
                      <td>
                          ${obj.group }
                      </td>
                      <td>
                          <script >formatTime("${obj.startTime}");</script>
                      </td>
                      <td>
                          <script >formatTime("${obj.lastReply}");</script>
                      </td>
                      <td>
                            ${obj.viewnum }
                      </td>
                      <td>
                            ${obj.replynum }
                      </td>
                      <td>
                          <label class="checkbox">
                              <pe:permission key="delete">
                              <input type="checkbox" id="area_30"　id="chkTopicID" checked="checked" onclick="cancelHot('${obj.id}','${obj.topicId}')"　/>最热话题
                              </pe:permission>
                          </label>
                      </td>
                      <td>
                      <pe:permission key="update">
                      	<a class="btn btn btn-success" href="javascript:stickTopic('${obj.topicId}')">置顶</a>
                      </pe:permission>
                      </td>
                    </tr>
                  </c:forEach>
                </tbody>
                      <input type="hidden"  name="start" id="start" value="${start }"/>
                      <input type="hidden"  name="limit" id="limit" value="${limit }"/>
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
                            window.location.href="${BasePath}/topic/hotlist?start="+currentPage+"&limit="+pageSize+"&type=${type}&itemId=${itemId}";
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


    <div class="modal fade "  id="NoPermissionModal" >
        <div class="modal-dialog" >
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title" id="NoPermissionModalLabel">系统消息</h4>
                </div>
                <div class="modal-body" style="height: auto; width: auto;" >
                    <iframe id="NoPermissioniframe" width="600" frameborder="0"></iframe>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default " data-dismiss="modal">    关  闭    </button>
                </div>
            </div>
        </div>
    </div>
</div>
    <script type="text/javascript">
        function openIframe(frameSrc){
            $("#NoPermissioniframe").attr("src", frameSrc);
            $('#NoPermissionModal').modal({ show: true, backdrop: 'static' });
        }



    </script>
  <hr>
  
<jsp:include page="../include/bottom.jsp" />


<script>
    function cancelHot(id,topicId){
        $.post('${BasePath}/topic/delTopicHottest',{'id':id,'topicId':topicId
        },function(data){
            var obj = eval(data);
            if(obj.errno==0){
                window.location.reload();
            }else{
                alert(obj.errdesc);
            }
        });
    }

    function stickTopic(id){
        $.post('${BasePath}/topic/stickTopic',{'topicId':id
        },function(data){
            var obj = eval(data);
            if(obj.errno==0){
                window.location.reload();
            }else{
                alert(obj.errdesc);
            }
        });
    }

</script>