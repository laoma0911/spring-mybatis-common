<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="/permission" prefix="pe" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../include/top.jsp"/>
<link href="${BasePath}/js/mediabox/css.css" rel="stylesheet" media="screen">

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
							<form id="myForm" class="form-inline" name="myForm" action="${BasePath}/calendar/list" method="post">
								用户UID： <input type="text" id="uid" name="uid" value="${uid}"/>
                                <span >周期：${cycle}天    经期：${period}天</span>
								<input type="button" onclick="submitForm()" value="查询" class="btn btn-success btn-small"/>
                                <%--<input type="checkbox" name="open" id="open" value="1" />开启智能模式--%>
								<input type="hidden" name="sign" value="2" id="sign"/>
                                <br>
                                <br>
                                年：<input type="text" name="year" id="year" value="${year}"/>
                                月：<input type="text" name="month" id="month" value="${month}"/>


                                <input type="hidden" id="type" name="type" value="${type }"/>
                                <input type="hidden" id="itemId" name="itemId" value="${itemId }"/>

                                <input type="button" class="btn btn-small btn-success inline" onclick="submitForm(-1)" value="上一月"/>
                                <input type="button" class="btn btn-small btn-success inline" onclick="submitForm(1)"  value="下一月"/>
							</form>
						</div>
					</div>
				</div>
				<div class="block">
					<div class="navbar navbar-inner block-header inline">
						<%--<div class="muted pull-left inline">日历待办事项列表</div>--%>
                        <div class="muted pull-left inline">

                        </div>
					</div>
					<div class="block-content collapse in">
						<div class="span12">
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
                                <c:set value="0" var="sign" ></c:set>
                                <c:forEach items="${helperList }" var="obj">
                                    <c:if test="${sign==0}">
                                        <tr>
                                    </c:if>
                                    <c:set value="${sign+1}" var="sign" ></c:set>
                                    <td
                                            <c:choose>
                                                <c:when test="${obj.period==1 && obj.dayNum==1}">
                                                    style="background-color: #FFC1C1;color: #ddd;"
                                                </c:when>
                                                <c:when test="${obj.period==0 && obj.dayNum==1}">
                                                    style="color: #ddd;"
                                                </c:when>
                                                <c:when test="${obj.period==1 && obj.dayNum==0}">
                                                    style="background-color: #FFC1C1;"
                                                </c:when>
                                            </c:choose>
                                            >
                                        <div class="dates" >
                                            <c:if test="${obj.yunStart==1}"><span >孕起</span>  </c:if>
                                            <c:if test="${obj.yunEnd==1}"><span >孕止</span>  </c:if>
                                            <span  <c:if test="${obj.periodStart==1}" >style="color: #ff0000;"</c:if>  <c:if test="${obj.periodEnd==1}" > style="color: blue"</c:if>  >${obj.day}</span>
                                        </div>
                                            <div style="width: 100%;height:120px;" >
                                                <span style="width: 25%;">
                                                    <c:if test="${obj.yun==1}">孕</c:if>
                                                </span>
                                                <span style="width: 25%;"><c:if test="${obj.xiang==1}">详</c:if></span>
                                                <span style="width: 25%;"><c:if test="${obj.tong==1}">同</c:if></span>
                                                <span style="width: 25%;"><c:if test="${obj.yao==1}">药</c:if></span>
                                                <br>
                                                <span ><c:if test="${obj.zhong==1}">重</c:if></span>
                                                <span ><c:if test="${obj.zheng==1}">症</c:if></span>
                                                <span ><c:if test="${obj.yundong==1}">运</c:if></span>
                                                <span ><c:if test="${obj.bian==1}">便</c:if></span>

                                                <br>
                                                <span ><c:if test="${obj.qing==1}">情</c:if></span>
                                                <span ><c:if test="${obj.shui==1}">睡</c:if></span>
                                                <span ><c:if test="${obj.ti==1}">体</c:if></span>
                                                <span ><c:if test="${obj.bei==1}">备</c:if></span>
                                                <br>
                                                <span ><c:if test="${obj.wen==1}">温</c:if></span>
                                                <span ><c:if test="${obj.luan==1}">卵</c:if></span>
                                                <span ><c:if test="${obj.zao==1}">早</c:if></span>
                                                <span ><c:if test="${obj.shou==1}">手</c:if></span>
                                            </div>
                                    </td>
                                    <c:if test="${sign==7}">
                                        </tr>
                                        <c:set value="0" var="sign" ></c:set>
                                    </c:if>
                                </c:forEach>
                                </tbody>
                            </table>
						</div>
					</div>

				</div>
			</div>
		</div>
	</div>
</div>
<script>
    function submitForm(type){
        var month=$("#month").val().trim();
        var year=$("#year").val().trim();
        if(type==1){
            if(month==12) {
                month=1;
                year=Number(year)+1;
            }else{
                month=Number(month)+1;
            }
        }else if(type==-1){
            if(year==1970 && month==1){
                alert("前边没有了^v^！");
                return false;
            }
            if(month==1){
                month=12;
                year=year-1;
            }else{
                month=month-1;
            }
        }
        $("#month").val(month);
        $("#year").val(year);
        if(year>=1970 && year<=2050){

        }else{
            alert("请输入正确的年！");
            return false;
        }
        if(month>=1 && month<=12){

        }else{
            alert("请输入正确的月份！");
            return false;
        }
        $("#myForm").submit();
    }

</script>
<hr>
<jsp:include page="../include/bottom.jsp"/>
