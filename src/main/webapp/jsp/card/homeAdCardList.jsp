<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="/permission" prefix="pe" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="../include/top.jsp" />
<!-- Body -->
<script src="${BasePath}/js/json.js"></script>


<script type="text/javascript">
	                                        function exposuresum(action,sublabel){
	                                        	var num = 0;
	                                        	$.ajax({
	                                    			type: "POST",
	                                    			url: '${BasePath}/card/exposuresum?action=' + action + "&sublabel=" + sublabel,
	                                    			datatype: "json",
	                                    			async:false ,
	                                    			success: function (data) {
	                                    				num = data.data;
	                                    			},
	                                    			error: function () {
	                                    				alert("操作出错，请联系管理员！");
	                                    			}
	                                    		});
	                                        	document.write(num);
	                                        }
                                        </script>

<div class="container-fluid">
    <div class="row-fluid">
        <!-- Menu -->
        <jsp:include page="../include/menu.jsp" />
        <div class="span9" id="content">
            <jsp:include page="../include/location.jsp" />
            <div class="row-fluid">
                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <div class="muted pull-left">首页广告卡片列表</div>
                        <div class="pull-right">
                            <pe:permission key="add">
                                <button class="btn btn-success btn-small" style="margin-top: -5px"
                                        onclick="openModel('${BasePath}/card/toAddCard','新增','50%','73%')">新增</button>
                            </pe:permission>
                        </div>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table class="table table-hover">
                                <thead>
                                <tr>
                                    <th nowrap="true">ID</th>
                                    <th nowrap="true">卡片名称</th>
                                    <th nowrap="true">卡片封面</th>
                                    <th nowrap="true">卡片标题</th>
                                    <th nowrap="true">卡片指向链接</th>
                                    <th nowrap="true">爆光链接</th>
                                    <th nowrap="true">卡片上更多ICON指向的链接</th>
                                    <th nowrap="true">爆光量</th>
                                    <th nowrap="true">点击量</th>
                                    <th nowrap="true">在线时间</th>
                                    <th nowrap="true">卡片状态</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody id="tbodys">
                                <c:forEach items="${json.data}" var="obj">

                                    <%--`id` bigint(20) NOT NULL AUTO_INCREMENT,--%>
                                    <%--`title` varchar(50) NOT NULL DEFAULT '' COMMENT '卡片标题',--%>
                                    <%--`pic` varchar(100) NOT NULL DEFAULT '' COMMENT '卡片封面',--%>
                                    <%--`name` varchar(100) NOT NULL DEFAULT '' COMMENT '卡片名称',--%>
                                    <%--`url` varchar(1000) NOT NULL DEFAULT '' COMMENT '卡片指向链接',--%>
                                    <%--`more_link` varchar(1000) NOT NULL DEFAULT '' COMMENT '卡片上更多ICON指向的链接',--%>
                                    <%--`start_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '开始时间',--%>
                                    <%--`end_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '结束时间',--%>
                                    <%--`dateline` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建时间',--%>
                                    <%--`status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0上线 1下线',--%>
                                    <tr >
                                        <td nowrap="true" class="id">${obj.id}</td>

                                        <td style="width: 100px;">
                                           ${obj.name}
                                        </td>

                                        <td nowrap="true">
                                            <img  src="${imageHost }${obj.pic}"   width="80px" height="80px" />
                                        </td>

                                        <td style="width: 100px;">
                                            ${obj.title}
                                        </td>

                                        <td style="width: 300px;" class="tdBreak">
                                            ${obj.url }
                                        </td>
                                        
                                        <td style="width: 300px;" class="tdBreak">
                                            ${obj.monitorLink }
                                        </td>
                                        
                                        <td style="width: 300px;" class="tdBreak">
                                            ${obj.moreLink }
                                        </td>
                                        
                                         <td style="width: 300px;" class="tdBreak">
                                        	<script type="text/javascript">	
                                        		exposuresum("v","${obj.url }")
                                        	</script>
                                        </td>
                                        
                                        <td style="width: 300px;" class="tdBreak">
                                            <script type="text/javascript">
                                            	exposuresum("c","${obj.url }")
                                            </script>
                                        </td>

                                        <td nowrap="true">
                                            <script type="text/javascript">formatTime('${obj.startTime}')</script>
                                            <br/>
                                            <script type="text/javascript">formatTime('${obj.endTime}')</script>
                                        </td>

                                        <td nowrap="true">
                                            <c:if test="${obj.status == 0 && obj.endTime >= nowDate}">
                                                <font color="green">已上线</font>
                                            </c:if>
                                            <c:if test="${obj.status == 1 && obj.endTime >= nowDate}">
                                                <font color="red">未上线</font>
                                            </c:if>
                                            <c:if test="${obj.endTime < nowDate}">
                                                <font color="red">已结束</font>
                                            </c:if>
                                        </td>
                                        
                                        <td>
                                            <pe:permission key="update">
                                                <a class="btn btn-success btn-small"
                                                   href="javascript:openModel('${BasePath}/card/toModify?id=${obj.id}','修改','50%','73%')"
                                                        >修改</a>
                                            </pe:permission>

                                                <c:if test="${obj.status == 0 && obj.endTime >= nowDate}">
                                                    <pe:permission key="offline">
                                                        <button class="btn del btn-success btn-small" id="unOnline"
                                                                onclick="unOnline(${obj.id})">下线</button>
                                                    </pe:permission>
                                                </c:if>


                                                <c:if test="${obj.status == 1 && obj.endTime >= nowDate}">
                                                    <pe:permission key="online">
                                                        <button class="btn del btn-success btn-small" id="online"
                                                                onclick="online(${obj.id})">上线</button>
                                                    </pe:permission>
                                                </c:if>
                                            <pe:permission key="delete">
                                                <button class="btn del btn-danger btn-small" id="del">删除</button>
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
                                    PAGER.initPager('${start}',' ${json.total}','${limit}', 8, 'pager', getData);
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
<hr>
<jsp:include page="../include/bottom.jsp" />


<script>
    //删除
    $(function(){
        $("#del").bind('click',function(){
            if(!confirm('确定删除该条记录吗？')){
                return false;
            }
            var id = $(this).parent().parent().find(".id").text();
            $.post('${BasePath}/card/deleteAdCard',{
                'id':id
            },function(data){
                var obj = eval(data);
                if(obj.errno==0){
                    alert('操作成功');
                    window.location.reload();
                }else{
                    alert(obj.errdesc);
                }
            });

        });
    });
    
    

    //下线
    function unOnline(id) {
        if (confirm("确定下线该条记录吗？")) {
            $.post('${BasePath}/card/setadCardStatus?id=' + id + "&status=1",
               function (data) {
                   var obj = eval(data);
                   if (obj.errno == 0) {
                       alert('操作成功');
                       window.location.reload(true);
                   } else {
                       alert(obj.errdesc);
                   }
               });
        }
    }


    //上线
    function online(id) {
        if (confirm("确定上线该条记录吗？")) {
            $.post('${BasePath}/card/setadCardStatus?id=' + id + "&status=0",
                    function (data) {
                        var obj = eval(data);
                        if (obj.errno == 0) {
                            alert('操作成功');
                            window.location.reload(true);
                        } else {
                            alert(obj.errdesc);
                        }
                    });
        }
    }
</script>