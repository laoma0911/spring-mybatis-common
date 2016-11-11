<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="/permission" prefix="pe" %>

<jsp:include page="../include/top.jsp" flush="true"/>
<!-- Body -->
<div class="container-fluid">
    <div class="row-fluid">
        <!-- Menu -->
        <jsp:include page="../include/menu.jsp" flush="true"/>
        <div class="span9" id="content">
            <jsp:include page="../include/location.jsp"/>
            <div class="row-fluid">
                <div class="span12">
                    <div class="block">
                        <div class="navbar navbar-inner block-header" style="border-bottom: none;">
                            <div class="span12 inline">
                                <button class="btn" style="margin-top: -5px;" id="left_btn">&lt;</button>
                                <input type="text" name="todayTime" id="todayTime" style="margin-top: -5px; width: 80px; margin-bottom: 0;" disabled="disabled" value="${currentDate }"/>
                                <button class="btn" style="margin-top: -5px;" id="right_btn">&gt;</button>
                                <input type="hidden" value="${upDate }" id="upDate"/>
                                <input type="hidden" value="${downDate }" id="downDate"/>
                                <%--<form  method="post" onSubmit="return false;" >--%>
                                    <c:if test="${itemId==5 }">
                                        <select id="location" name="location" style="margin-top: 5px;">
                                            <option value="1" <c:if test="${location==1 }">selected="selected"  </c:if>>焦点图1</option>
                                            <option value="2" <c:if test="${location==2 }">selected="selected"  </c:if>>焦点图2</option>
                                            <option value="3" <c:if test="${location==3 }">selected="selected"  </c:if>>焦点图3</option>
                                            <option value="4" <c:if test="${location==4 }">selected="selected"  </c:if>>焦点图4</option>
                                            <option value="5" <c:if test="${location==5}">selected="selected"  </c:if>>焦点图5</option>
                                            <option value="6" <c:if test="${location==6 }">selected="selected"  </c:if>>焦点图6</option>
                                            <option value="7" <c:if test="${location==7 }">selected="selected"  </c:if>>焦点图7</option>
                                        </select>
                                    </c:if>
                                <c:if test="${itemId==156 }">
                                    <select id="location" name="location" style="margin-top: 5px;">
                                        <option value="1" <c:if test="${location==1 }">selected="selected"  </c:if>>位置1</option>
                                        <option value="5" <c:if test="${location==5 }">selected="selected"  </c:if>>位置5</option>
                                    </select>
                                </c:if>
                                <c:if test="${itemId==157 }">
                                    <select id="location" name="location" style="margin-top: 5px;">
                                        <option value="2" <c:if test="${location==2}">selected="selected"  </c:if>>位置2</option>
                                        <option value="4" <c:if test="${location==4 }">selected="selected"  </c:if>>位置4</option>
                                    </select>
                                </c:if>
                                <c:if test="${itemId==165 }">
                                    <select id="location" name="location" style="margin-top: 5px;">
                                        <option value="1" <c:if test="${location==1 }">selected="selected"  </c:if>>位置1</option>
                                        <option value="4" <c:if test="${location==4 }">selected="selected"  </c:if>>位置4</option>
                                    </select>
                                </c:if>

                                        <pe:permission key="add">
                                            <%--id="addNav"--%>
                                            <button class="btn btn-danger" style="margin-top: -5px;" onclick="openModel('${BasePath}/resBanner/addResBanner?type=${type}&itemId=${itemId}','新增广告位','50%','50%')" >新增广告位</button>
                                        </pe:permission>
                                <%--</form>--%>
                            </div>
                        </div>
                    </div>

                    <div class="block">
                        <table class="tables" cellpadding="1" cellspacing="0">
                            <thead>
                            <tr>
                                <th>Sun</th>
                                <th>Mon</th>
                                <th>Tue</th>
                                <th>Wed</th>
                                <th>Thu</th>
                                <th>Fri</th>
                                <th>Sat</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:set value="0" var="sign"></c:set>
                            <c:forEach items="${helperList }" var="obj">
                                <c:if test="${ sign==0}">
                                    <tr>
                                </c:if>
                                <c:set value="${sign+1}" var="sign"></c:set>
                                <td <c:if test="${obj.id!=null }"> style="background:#87CEFA;" </c:if>>
                                    <div class="dates">
                                        <c:if test="${obj.id!=null }">
                                            <div class="edits">
                                                <input type="hidden" value="${obj.id }" name="t_id" class="t_id"/>
                                                <pe:permission key="update">
                                                    <span class="icon-pencil icons"></span>&nbsp;
                                                </pe:permission>
                                                <pe:permission key="delete">
                                                    <span class="icon-remove icons"></span>
                                                </pe:permission>
                                            </div>
                                        </c:if>
                                        <div class="dated">
                                                ${obj.day}
                                        </div>
                                    </div>
                                    <c:if test="${obj.id!=null }">
                                        <div class="conts">
                                            <div>
                                                <span class="status">状态：</span> <span class="statu">
										<c:if test="${obj.status==1 }">申请</c:if> 
										<c:if test="${obj.status==2}">确定</c:if> 
									</span>
                                            </div>
                                            <div>
                                                <span class="status">申请人：</span> <span class="statu">${obj.proposer }</span>
                                            </div>
                                            <div>
                                                <span class="status">项目名：</span> <span class="statu">${obj.project }</span>
                                            </div>
                                        </div>
                                    </c:if>
                                </td>
                                <c:if test="${ sign==7}">
                                    </tr>
                                    <c:set value="0" var="sign"></c:set>
                                </c:if>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <hr>
        <jsp:include page="../include/bottom.jsp"/>
        <script>
            $(function () {
                var index = parseInt();
                $("#location option:eq(" + index + ")").attr("selected", "selected");
            });

            $("#addNav").bind('click', function () {
                window.location.href = "${BasePath }/resBanner/addResBanner?type=${type}&itemId=${itemId}"
            });

            $("#left_btn").bind('click',
                    function () {
                        var upDate = $("#upDate").val();
                        var location = $("#location").val();
                        if (!isNaN(location)) {
                            window.location.href = "${BasePath }/resBanner/getList?type=${type}&itemId=${itemId}&date=" + upDate + "&location=" + location;
                        } else {
                            window.location.href = "${BasePath }/resBanner/getList?type=${type}&itemId=${itemId}&date=" + upDate;
                        }
                    });

            $("#right_btn").bind('click',
                    function () {
                        var downDate = $("#downDate").val();
                        var location = $("#location").val();
                        if (!isNaN(location)) {
                            window.location.href = "${BasePath }/resBanner/getList?type=${type}&itemId=${itemId}&date=" + downDate + "&location=" + location;
                        } else {
                            window.location.href = "${BasePath }/resBanner/getList?type=${type}&itemId=${itemId}&date=" + downDate;
                        }

                    });

            $("#location").bind("change", function () {
                var location = $("#location").val();
                var currentDate = $("#todayTime").val();
                window.location.href = "${BasePath }/resBanner/getList?type=${type}&itemId=${itemId}&date=" + currentDate + "&location=" + location;
            });

            $(".icon-pencil").bind('click', function () {
                var val = $(this).parent().find("input[type=hidden]").val();
                openModel('${BasePath }/resBanner/addResBanner?type=${type}&itemId=${itemId}&id='+ val,'新增广告位','50%','50%');
                //window.location.href = "${BasePath }/resBanner/addResBanner?type=${type}&itemId=${itemId}&id=" + val;
            });

            $(".icon-remove").bind('click',
                    function () {
                        if (confirm('是否确认删除?')) {
                            var val = $(this).parent().find("input[type=hidden]").val();
                            $.ajax({
                                type: "POST",
                                url: "${BasePath }/resBanner/deleteResBanner?id=" + val,
                                datatype: "json",
                                success: function (data) {
                                    if (data.errno == 0) {
                                        window.location.reload();
                                    } else {
                                        alert("删除失败！");
                                    }
                                },
                                error: function () {
                                    alert("操作出错，请联系管理员！");
                                }
                            });
                        }
                    });
        </script>