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
                        <div class="navbar navbar-inner block-header"
                             style="border-bottom: none;">
                            <form class="form-search" name="myForm" id="myForm" action="${BasePath}/coins/list" onsubmit="return checkForm()" method="post">
                                UID:<input type="text" name="uid" id="uid" value="${uid }"/>
                                时间：<input type="text" style="width: auto;" id="beginDate" name="beginDate" value="${startDate }" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'${endData }',readOnly:'false'})" class="Wdate"
                                          onClick="WdatePicker()"/>
                                <input type="hidden" id="type" name="type" value="${type }"/>
                                <input type="hidden" id="itemId" name="itemId" value="${itemId }"/>
                                lastDate: <input type="text" id="lastDate" name="lastDate" value="${lastDate}"/>
                               firstDate: <input type="text" id="firstDate" name="firstDate" value="${firstDate}"/>
                                <input type="hidden" id="pageType" name="pageType" value=""/>
                                <button type="submit" id="btn" name="btn" class="btn">Search</button>
                            </form>
                        </div>
                    </div>
                </div>

                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <div class="muted pull-left">用户金币列表</div>
                        <div class="muted pull-right" style="color:red;">用户当前总金币：${coinInfo.coins}</div>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table class="table table-hover">
                                <thead>
                                <tr>
                                    <th>序号</th>
                                    <th>金币规则</th>
                                    <th>金币</th>
                                    <th>时间</th>
                                </tr>
                                </thead>
                                <tbody id="tbodys">
                                <c:forEach items="${coinsList}" var="obj" varStatus="status">
                                    <tr class="success">
                                        <td>${status.index+1}</td>
                                        <td>${obj.ruleName}</td>
                                        <td><span  <c:if test="${obj.coins>0}">  color="green" </c:if>  <c:if test="${obj.coins<0 }">  color="red" </c:if> >${obj.coins}</span></td>
                                        <td>${obj.dateline}</td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                            <div class="span12 inline">
                                <input type="button" onclick="nextPage(1)" value="上一页"/>
                                <input type="button" onclick="nextPage(2)" value="下一页"/>
                            </div>
                            <script type="text/javascript">
                                function nextPage(type){
                                    $("#pageType").val(type);
                                    $("#myForm").submit();
                                }
                            </script>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
<hr>
<script type="text/javascript">
    function openDetail(id) {
        var sign = $("#sign_" + id).val();
        $.each($("#" + id), function (i) {
            if (sign == 0) {
                this.style.display = 'none';
            } else {
                this.style.display = '';
            }

        });
        if (sign == 0) {
            $("#sign_" + id).val("1");
        } else {
            $("#sign_" + id).val("0");
        }
    }
    function checkForm() {
        var uid = $("#uid").val().trim();
        if (uid == "") {
            alert("请输入UID！");
            return false;
        }

        if (isNaN(uid)) {
            alert("uid只能为数字");
            return false;
        }

        var startDate = $("#beginDate").val();
        if (startDate == "") {
            alert("请输入开始时间！");
            return false;
        }
// 		var endDate=$("#endDate").val();
// 		if(endDate=="") {
// 			alert("请输入结束时间！");
// 			return false;
// 		}
        return true;
    }
</script>
<jsp:include page="../include/bottom.jsp"/>