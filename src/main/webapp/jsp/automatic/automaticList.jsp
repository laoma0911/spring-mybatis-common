<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="/permission" prefix="pe" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="../include/top.jsp"/>
<!-- Body -->
<div class="container-fluid">
    <div class="row-fluid">
        <!-- Menu -->
        <jsp:include page="../include/menu.jsp"/>
        <div class="span9" id="content">
            <jsp:include page="../include/location.jsp"/>
            <div class="row-fluid">
                <div class="span12">
                    <div class="block">
                        <div class="navbar navbar-inner block-header" style="border-bottom: none;">
                            <form id="myForm" name="myForm" action="${BasePath}/automatic/list" method="post" class="form-inline">
                                <table>
                                    <tr>
                                        <td style="vertical-align: middle;">用户状态：</td>
                                        <td>
													<select name="userStatus"  id="userStatus" >
															<option  value="-1" <c:if test="${userStatus==-1 }"> selected="selected"</c:if>>全部</option>
															<option  value="0" <c:if test="${userStatus==0 }"> selected="selected"</c:if>>记经期</option>
															<option  value="1" <c:if test="${userStatus==1 }"> selected="selected"</c:if>>备孕</option>
															<option  value="2" <c:if test="${userStatus==2 }"> selected="selected"</c:if>>怀孕中</option>
															<option  value="3" <c:if test="${userStatus==3 }"> selected="selected"</c:if>>宝妈</option>
													</select>                                        
                                        </td>
                                        <td><input type="submit" class="btn btn-success btn-small" value="查询"  /></td>
                                    </tr>
                                </table>

                                <input type="hidden" name="start" id="start" value="${start }"/>
                                <input type="hidden" name="limit" id="limit" value="${limit }"/>
                                <input type="hidden" name="type" id="type" value="${type }"/>
                                <input type="hidden" name="itemId" id="itemId" value="${itemId }"/>
                            </form>
                        </div>
                    </div>
                </div>

                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <div class="muted pull-left">列表</div>
                        <div class="pull-right">
                            <pe:permission key="add">
                                <button class="btn btn-success btn-small" style="margin-top: -5px" onclick="openModel('${BasePath}/automatic/toAdd','新增')">新增</button>
                            </pe:permission>
                        </div>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table class="table table-hover">
                                <thead>
                                <tr>
                                    <th>序号</th>
                                    <th>状态</th>
                                    <th>持续时间</th>
                                    <th>城市</th>
                                    <th>平台</th>
                                    <th>年龄</th>
                                    <th>注册方式</th>
                                    <th>加入小组UID</th>
                                    <th>关注用户UID</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody id="tbodys">
                                <c:forEach items="${data}" var="obj">
                                    <tr>
                                        <td class="id">${obj.id}</td>
                                        <td>${obj.userStatusName }</td>
                                        <td>
											<script>formatDate("${obj.startTime}");</script> - <script>formatDate("${obj.endTime}");</script>                                        
                                        </td>
                                        <td>${obj.cityName}</td>
                                        <td>${obj.platFormName}</td>
                                        <td>${obj.ageDesc}</td>
                                        <td>${obj.registerName}</td>
                                        
                                        <td><textarea rows="3" cols="3" disabled="disabled" >${obj.groupIds}</textarea></td>
                                        <td><textarea rows="3" cols="3"  disabled="disabled">${obj.userIds}</textarea></td>
                                        
                                        <td>
                                        		<pe:permission key="update">
                                        	   		<button class="btn btn-success btn-small"  onclick="openModel('${BasePath}/automatic/toAdd?id=${obj.id}','编辑')">编辑</button>
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
                            <script type="text/javascript">
                                var sign = 0;
                                window.onload = function () {
                                    PAGER.initPager('${start}', ' ${total}', '${limit}', 8, 'pager', getData);
                                }
                                function getData(currentPage, pageSize) {
                                    if (sign > 0) {
                                        $("#start").val(currentPage);
                                        $("#limit").val(pageSize);
                                        $("#myForm").submit();
                                    }
                                    sign = 1;
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

<jsp:include page="../include/bottom.jsp"/>


<script>
$(function () {
    $(".del").bind('click', function () {
        if (!confirm('确定删除该条记录吗？')) {
            return false;
        }
        var id = $(this).parent().parent().find(".id").text();
        $.post('${BasePath}/automatic/delete', {
            'id': id
        }, function (data) {
            var obj = eval(data);
            if (obj.errno == 0) {
                window.location.reload();
            } else {
                alert(obj.errdesc);
            }
        });
    });
});
</script>