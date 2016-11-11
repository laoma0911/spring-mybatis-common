<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../include/head.jsp"/>
<style>
    body {
        padding-top: 0px;
    }
</style>
<!-- Body -->
<div class="container-fluid">

    <!-- block -->
    <div class="block">
        <div class="navbar navbar-inner block-header">
            <div class="muted pull-left">编辑</div>
        </div>

        <div class="alert alert-error" id="alertErr" style="display: none;">
            <button class="close" data-dismiss="alert">×</button>
            <strong>Error!</strong> <span id="errodesc">This is an error message.</span>
        </div>
        <div class="block-content collapse in">
            <div class="span12">
                <form class="form-horizontal" id="saveCustom" name="saveCustom" action="${BasePath }/weixinnum/save" method="post">
                    <input type="hidden" id="type" name="type" value="${type }"/>
                    <input type="hidden" id="itemId" name="itemId" value="${itemId }"/>
                    
                    <input type="hidden" id="id" name=id value="${data.id }"/>
                    <fieldset>
                        <div class="control-group">
                            <label class="control-label" for="name" style="float: left;">uid：</label>
                            <div class="controls">
                                <input type="text" id="uid" name="uid" value="${data.uid }" />
                            </div>
                            <br>
                            <label class="control-label" for="name" style="float: left;">公众号：</label>
                            <div class="controls">
                                <input type="text" id="name" name="name" value="${data.name }" />
                            </div>
                        </div>
                        <div class="form-actions">
                            <button type="button" id="myBtn" onclick="submitForm()" class="btn btn-primary">保存</button>
                        </div>
                    </fieldset>
                </form>
            </div>
        </div>
    </div>
    <!-- /block -->


</div>
<jsp:include page="../include/bottom.jsp"/>
<script>
    function submitForm() {
    	
    	var uid = $("#uid").val();
    	if(uid == ""){
    		alert("uid不能为空!");
    		return false;
    	}
    	
    	var name = $("#name").val();
    	if(name == ""){
    		alert("公众号不能为空!");
    		return false;
    	}
    	
    	  $('#saveCustom').ajaxSubmit(function(data){
  	        if(data.errno==0){
  	      	  alert("操作成功！");
					window.parent.closeModel();
  	        }else  if(data.errno==1){
  	      	  	$("#alertErr").show();
  	    		  $("#errodesc").html(data.errdesc);
  	    		  $("#btn").removeAttr("disabled");
  	        }
  	      });
    	
    }

</script>