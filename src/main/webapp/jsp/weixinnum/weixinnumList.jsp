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
                    		<pe:permission key="add">
                            	<a class="btn cancel btn btn-primary btn-small" href="javascript:openModel('${BasePath}/weixinnum/toSave','保存','45%','45%')">新增</a>
                            </pe:permission>
                    </div>
                </div>
         
        <div class="block">
            <div class="navbar navbar-inner block-header">
                <div class="muted pull-left">公众号列表</div>
            </div>
          <div class="block-content collapse in">
            <div class="span12">
                  <table class="table table-hover">
                <thead>
                  <tr>
                    <th>ID</th>
                    <th>uid</th>
                    <th>昵称</th>
                    <th>公众号</th>
                    <th>操作</th>
                  </tr>
                </thead>
                <tbody id="tbodys">
                  <c:forEach items="${list}" var="obj">
                    <tr >
                      <td>${obj.id}</td>
                      <td>${obj.uid}</td>
                      <td>${obj.nick}</td>
                      <td>${obj.name}</td>
                      <td>
                      		 <pe:permission key="update">
		                      	<a class="btn cancel btn btn-primary btn-small" href="javascript:openModel('${BasePath}/weixinnum/toSave?id=${obj.id }','编辑','45%','45%')">编辑</a>
		                      </pe:permission>
		                      <pe:permission key="delete">
		                      	<a class="btn cancel btn btn-primary btn-small" href="javascript:delWpn('${obj.id}')">删除</a>
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
                            window.location.href="${BasePath}/weixinnum/list?start="+currentPage+"&limit="+pageSize+"&type=${type}&itemId=${itemId}";
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
    function delWpn(id){
        $.post('${BasePath}/weixinnum/delWpn',{'id':id
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