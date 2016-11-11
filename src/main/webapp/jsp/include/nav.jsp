<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="/permission" prefix="pe" %>
<div class="navbar navbar-fixed-top">
    <div class="navbar-inner">
        <div class="container-fluid">
            <a class="btn btn-navbar" data-toggle="collapse"
               data-target=".nav-collapse"> <span class="icon-bar"></span>
                <span class="icon-bar"></span> <span class="icon-bar"></span>
            </a> <a class="brand" href="${BasePath}/home">大姨吗管理后台</a>

            <div class="nav-collapse collapse">
                <ul class="nav pull-right">
                    <li class="dropdown">
                        <a href="#" role="button" class="dropdown-toggle" data-toggle="dropdown">
                            <i class="icon-user"></i> ${CURRENT_LOGIN_USER.name }
                            <i class="caret"></i>
                        </a>
                        <ul class="dropdown-menu">
                            <li><a tabindex="-1" href="javascript:loginout()">注销</a>
                            </li>
                            <li><a tabindex="1" href="${BasePath}/user/toUpdatePass">修改密码</a></li>
                        </ul>
                    </li>
                </ul>
                <ul class="nav">
                    <c:forEach var="obj" items="${sessionScope.USER_MENU.categoryList }">
                        <li id="li_1"  <c:if test="${obj.id==type}"> class="active" </c:if>   ><a href="${BasePath}/home?type=${obj.id}">${obj.name }</a></li>
                    </c:forEach>
                </ul>
            </div>
            <!--/.nav-collapse -->
        </div>
    </div>
</div>
<script type="text/javascript">
    function loginout(){
        $.ajax({
            type:"POST",
            url:"${BasePath }/logout",
            datatype: "json",
            success:function(data){
                if(data.errno==0){
                    alert("退出成功！");
                    window.location.href="${BasePath}/login.html";
                }
            } ,
            error: function(){
                alert("操作出错，请联系管理员！");
            }
        });
    }

</script>
