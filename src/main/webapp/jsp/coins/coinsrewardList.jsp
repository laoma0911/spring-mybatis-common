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
                            <form class="form-inline" id="myForm" name="myForm" action="${BasePath}/coins/reward" method="post">
                                选择期别:
                                <select name="num" id="num">
                                	 <option value=""></option>
                                    <c:forEach items="${serialNumberList}" var="obj">
                                        <option  <c:if test="${num == obj.num}">selected="selected" </c:if> value="${obj.num}">${obj.num}</option>
                                    </c:forEach>
                                </select>
                                uid: <input type="text" id="uid" name="uid" value="${uid }">
                                <button type="button" onclick="submitForm()" class="btn btn-success btn-small">查询
                                </button>
                                <input type="hidden" name="start" id="start" value="${start }"/>
                                <input type="hidden" name="limit" id="limit" value="${limit }"/>
                                <input type="hidden" name="type" id="type" value="${type }"/>
                                <input type="hidden" name="itemId" id="itemId" value="${itemId }"/>
                            </form>
                        </div>
                    </div>
                </div>


				<div id="fixedBar" class="navbar navbar-inner" style="clear:both;">
					<div class="muted pull-left inline">
						<pe:permission key="add">
							<button class="btn btn-danger btn-small" onclick="openModel('${BasePath}/coins/addcoins?${PublicParams}','添加金币','50%','50%')">添加金币</button>
						</pe:permission>
					</div>
				</div>

                <!--kaishi -->
                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <div class="muted pull-left">金币奖惩列表</div>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table class="table table-hover">
                                <thead>
                                <tr>
                                    <th>id</th>
                                    <th>期别</th>
                                    <th>uid</th>
                                    <th>金币</th>
                                    <th>成功/失败</th>
                                    <th>添加时间</th>
                                    <th>备注缘由</th>
                                </tr>
                                </thead>
                                <tbody id="tbodys">
                                <c:forEach items="${list}" var="obj">
                                    <tr>
                                        <td>${obj.id}</td>
                                        <td>${obj.serialNo}</td>
                                        <td>${obj.uid}</td>
                                        <td>${obj.coins}</td>
                                        <td>
                                        	<c:if test="${obj.result==0 }">失败</c:if>
                                        	<c:if test="${obj.result==1 }">成功</c:if>
                                        </td>
                                        <td><script >formatTime("${obj.dateline}");</script></td>
                                        <td>${obj.memo}</td>
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

    function submitForm() {
    	var uid=$("#uid").val();
    	if(uid!="" && isNaN(uid)){
    		alert("uid只能为数字");
			return false;
    	}
        $("#myForm").submit();
    }

</script>