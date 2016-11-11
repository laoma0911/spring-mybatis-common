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
        <jsp:include page="../include/menu.jsp" />
        <div class="span9" id="content">
            <jsp:include page="../include/location.jsp" />
            <div class="row-fluid">
                <div class="span12">
                    <div class="block"  >
                        <div class="navbar navbar-inner block-header"  style="border-bottom: none;" >
                            <form id="myForm"  name="myForm"  action="${BasePath}/koluser/list" method="post" class="form-inline">
                                <table>
                                    <tr>
                                        <td style="vertical-align: middle;">用户名：</td>
                                        <td><input type="text" name="nick" value="${nick}" /></td>
                                        <td style="vertical-align: middle;">公众号：</td>
                                        <td><input type="text" name="publicNum" value="${publicNum }" /></td>
                                        <td>&nbsp;<input type="submit" value="查询" /></td>
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
                        <div class="muted pull-left">用户列表</div>
                        <div class="pull-right">
                            <pe:permission key="add">
                                <button class="btn btn-success btn-small" style="margin-top: -5px" onclick="openModel('${BasePath}/koluser/toAdd','新增')">新增</button>
                            </pe:permission>
                        </div>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table class="table table-hover">
                                <thead>
                                <tr>
                                    <th>序号</th>
                                    <th>用户名</th>
                                    <th>公众号</th>
                                    <th>绑定UID</th>
                                    <th>绑定小组ID</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody id="tbodys">
                                <c:forEach items="${list}" var="obj">
                                    <tr>
                                        <td class="id">${obj.id}</td>
                                        <td>${obj.nick }</td>
										<td>${obj.publicNum }</td>
										<td>${obj.bindUid }</td>
										<td>${obj.bindGroupId }</td>
                                        <td>
                                            <pe:permission key="update">
                                                <button class="btn btn-success btn-small" style="margin-top: -5px" onclick="openModel('${BasePath}/koluser/toEdit?id=${obj.id}','新增')">修改</button>
                                            </pe:permission>
                                            <pe:permission key="delete">
                                                <button class="btn del btn-danger btn-small" onclick="del(${obj.id})">删除</button>
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
    // 删除记录
    function del(id){
    	if (!confirm('确定删除该条记录吗？')) {
            return false;
        }
    	   $.post('${BasePath}/koluser/delete', {
               'id': id
           }, function (data) {
               var obj = eval(data);
               if (obj.errno == 0) {
                   alert('操作成功');
                   window.location.reload();
               } else {
                   alert(obj.errdesc);
               }
           });
    }
</script>