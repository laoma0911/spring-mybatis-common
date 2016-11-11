<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page isELIgnored="false" %>
<div style="clear:both;"></div>
<footer style="text-align: center;">
  <p>&copy; Sucry By XiaoErBi's Admin Templete 2014</p>
</footer>
</div>
<!--/.fluid-container-->
<%-- <script src="${BasePath}/bootstrap/vendors/jquery-1.9.1.min.js"></script> --%>
<script src="${BasePath}/bootstrap/bootstrap/js/bootstrap.min.js"></script>
<script src="${BasePath}/js/jquery/form.js" type="text/javascript"></script>
<script src="${BasePath}/bootstrap/vendors/easypiechart/jquery.easy-pie-chart.js"></script>
<script src="${BasePath}/bootstrap/assets/scripts.js"></script>
<script>
	$(function() {
		$("#li_${sessionScope.categoryId}").addClass('active');
	});
</script>
</body>
</html>