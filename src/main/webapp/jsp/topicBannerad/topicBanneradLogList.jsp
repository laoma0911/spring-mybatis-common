<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="/permission" prefix="pe" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 

<jsp:include page="../include/head.jsp" />
<style>
body {
	padding-top: 0px;
}
</style>
<!-- Body -->
        <div class="block">
          <div class="navbar navbar-inner block-header">
            <div class="muted pull-left">日志列表</div>
          </div>
          <div class="block-content collapse in">
            <div class="span12">
              <table class="table table-hover">
                <thead>
                  <tr>
                    <th>日期</th>
                    <th>点击量</th>
                  </tr>
                </thead>
                <tbody id="tbodys">
                  <c:forEach items="${data.data}" var="obj">
                    <tr >
                        <td>
                                ${obj.everyday}
                        </td>
                        <td>
                                ${obj.num }
                        </td>
                    </tr>
                  </c:forEach>
                </tbody>
              </table>
            </div>
          </div>
        </div>
  <hr>
<jsp:include page="../include/bottom.jsp" />