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
					<form action="${BasePath}/custom/checkWukong" method="post" id="myform" name="myform" class="form-search">
									UID：
									<input type="text" name="uid" id="uid" value="" />
									昵称：<input type="text" name="nick" id="nick" value="" />
									<input type="button" class="btn btn-small btn-success" onclick="submitForm()" class="btn" value="查询" />
									<input type="button" class="btn btn-small btn-success" onclick="submitWukong()" class="btn" value="同步数据到悟空" />
									</form>
                           </div>
						</div>
					</div>
        <div class="block">
          <div class="navbar navbar-inner block-header">
            <div class="muted pull-left"> 查看列表	</div>
          </div>
          <div class="block-content collapse in">
            <div class="span12">
              <table class="table table-hover">
                <thead>
                  <tr>
                    <th>是否支持悟空</th>
                  </tr>
                </thead>
                <tbody id="tbodys">
                    <tr>
                      	<td id="resultTd">
                      		
                      	</td>
                    </tr>
                </tbody>
              </table>
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
function submitForm(){
		var uid=$("#uid").val();
		var nick=$("#nick").val();
		
		if(uid=="" && nick==""){
			alert("请输入搜索条件！");
			return false;
		}
		  $("#resultTd").html("");
        $('#myform').ajaxSubmit(function(data){
          if(data.errno==2){
        	  $("#resultTd").html("<button  class='btn btn-small btn-success'>是</button>");
          }else  if(data.errno==3){
        	  $("#resultTd").html("<button  class='btn btn-small btn-danger'>否</button>");
          }else{
        	  alert(data.errdesc);
          }
        });
}

    function submitWukong(){
        var uid=$("#uid").val();
        $.post('${BasePath}/custom/syncDateTowukong',{ 'uid':uid },function(data){
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