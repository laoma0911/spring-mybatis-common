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
                            <form action="${BasePath}/custom/checkUser?type=${type}&itemId=${itemId}" method="post" id="myform" name="myform" class="form-search">
                                <select name="uid" >
                                    <option value="40" <c:if test="${uid==40}"> selected="selected" </c:if> >【40验证专用】</option>
                                    <option value="39" <c:if test="${uid==39}"> selected="selected" </c:if> >【39驗證專用】</option>
                                    <option value="98659849" <c:if test="${uid==98659849}"> selected="selected" </c:if> >【98659849 验1】</option>
                                    <option value="98659931" <c:if test="${uid==98659931}"> selected="selected" </c:if> >【98659931 验2】</option>
                                    <option value="98660025" <c:if test="${uid==98660025}"> selected="selected" </c:if> >【98660025 验3】</option>
                                    <option value="98660105" <c:if test="${uid==98660105}"> selected="selected" </c:if> >【98660105 验4】</option>
                                    <option value="98660309" <c:if test="${uid==98660309}"> selected="selected" </c:if> >【98660309 验5】</option>
                                    <option value="98660373" <c:if test="${uid==98660373}"> selected="selected" </c:if> >【98660373 验6】</option>
                                    <option value="98660439" <c:if test="${uid==98660439}"> selected="selected" </c:if> >【98660439 验7】</option>
                                    <option value="98660459" <c:if test="${uid==98660459}"> selected="selected" </c:if> >【98660459 验8】</option>
                                    <option value="98660373" <c:if test="${uid==98660393}"> selected="selected" </c:if> >【98660393 验9】</option>
                                </select>
                                <input type="submit"  onclick="find()" class="btn  btn-small btn-success" value="查询" />

                                <input type="hidden"  name="start" id="start" value="${start }"/>
                                <input type="hidden"  name="limit" id="limit" value="${limit }"/>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <div class="muted pull-left">设备列表	</div>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table class="table table-hover">
                                <thead>
                                <tr>
                                    <th>UID</th>
                                    <th>device</th>
                                    <%--<th>是否被封</th>--%>
                                    <th>登录次数</th>
                                    <th>最后登录时间</th>
                                    <%--<th>最后登录IP</th>--%>
                                    <th>model</th>
                                    <th  width="5%">sdkver</th>
                                    <th  width="5%">ver</th>
                                    <th width="5%">releasever</th>
                                    <th width="5%"> 平台</th>
                                </tr>
                                </thead>
                                <tbody id="tbodys">
                                <c:forEach items="${list}" var="obj">
                                    <tr>
                                        <td >
                                            <a href="${BasePath }/custom/userList?type=4&itemId=20&uid=${obj.uid}"  target="_black">${obj.uid}</a>
                                        </td>
                                        <td><a href="${BasePath}/custom/toDeviceList?device=${obj.device}" target="_blank">${obj.device }</a></td>
                                        <%--<td>--%>
                                            <%--<c:if test="${obj.sign==1 }">--%>
                                                <%--<font color="red">是</font>--%>
                                            <%--</c:if>--%>
                                            <%--<c:if test="${obj.sign==0 }">--%>
                                                <%--<font color="green">否</font>--%>
                                            <%--</c:if>--%>
                                        <%--</td>--%>

                                        <td>${obj.count}</td>
                                        <td><script language="javascript">formatTime("${obj.lasttime}");</script></td>
                                            <%--<td></td>--%>
                                        <td>${obj.model }</td>
                                        <td>${obj.sdkver }</td>
                                        <td>${obj.ver }</td>
                                        <td>${obj.releasever }</td>
                                        <td>
                                            <c:if test="${obj.platform==0}">android</c:if>
                                            <c:if test="${obj.platform==1 }">iPhone</c:if>
                                            <c:if test="${obj.platform==2 }">wp</c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                            <div class="pagination pagination-centered" id="pager"></div>
                            <script type="text/javascript">
                                var sign=0;
                                window.onload=function(){
                                    PAGER.initPager('${start}',' ${json.total}','${limit}', 8, 'pager', getData);
                                };
                                function getData(currentPage,pageSize) {
                                    if(sign>0){
                                        $("#start").val(currentPage);
                                        $("#limit").val(pageSize);
                                        $("#myform").submit();
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
    function deleteDevice(uid){
        if(!confirm('确定解封该条记录吗？')){
            return false;
        }
        $.post('${BasePath}/custom/banUserDelete',{ 'uid':uid },function(data){
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