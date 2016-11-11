<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="/permission" prefix="pe" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="../../include/top.jsp"/>
<!-- Body -->
<script src="${BasePath}/js/json.js"></script>
<div class="container-fluid">
    <div class="row-fluid">
        <!-- Menu -->
        <jsp:include page="../../include/menu.jsp"/>
        <div class="span9" id="content">
            <jsp:include page="../../include/location.jsp"/>

           <div class="row-fluid">
                <div class="span12">
                    <div class="block"  >
                        <div class="navbar navbar-inner block-header"  style="border-bottom: none;" >
                            <form class="form-search" name="myForm" id="myForm1" action="${BasePath}/meiyue/datebaoCoupon/getTopicJson" method="post">
                                开始：
                                <input type="text"  style="width: auto;" id="beginDate"  name="beginDate" value="${startDate }" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:'false'})" class="Wdate" onClick="WdatePicker()" />
                                结束：
                                <input type="text"  style="width: auto;" id="endDate"  name="endDate" value="${endDate }" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:'false'})" class="Wdate" onClick="WdatePicker()" />
                                <select name="dateType"  id="dateType" class="input-medium search-query inline"  >
                                    <option value="day">日</option>
                                    &lt;%&ndash;<option value="month">月</option>&ndash;%&gt;
                                </select>
                          <%--      <select name="tagId"  id="tagId"  class="input-medium search-query inline"  >
                                    <option value="-1" >总量</option>
                                    <option value="0" >全部标签</option>
                                    <c:forEach items="${tagList}" var="tag">
                                        <option  value="${tag.id}">${tag.tag}</option>
                                    </c:forEach>
                                </select>--%>
                             <%--   <select name="platform1"  id="platform1"  class="input-medium search-query inline"  >
                                    <option value="-1"  >全部平台</option>
                                    <option  value="android">Android</option>
                                    <option value="ios">IOS</option>
                                    <option value="wp">WP</option>
                                </select>--%>
                                <button type="button" id="btn" name="btn" class="btn btn-success">Search</button>
                            </form>
                        </div>
                    </div>
                </div>

                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <div class="muted pull-left">大特保统计</div>
                        <div class="pull-right">
                       <%--     &lt;%&ndash;              <pe:permission key="add"> &ndash;%&gt;
                            &lt;%&ndash;             <button class="btn btn-success" style="margin-top: -5px" onclick="window.location='${BasePath}/sisterPush/toAdd?type=${type}&itemId=${itemId}'">新增</button> &ndash;%&gt;
                            &lt;%&ndash;             </pe:permission> &ndash;%&gt;--%>
                           <%-- <span class="badge badge-info">${userCount}</span>--%>
                            <br>
                        </div>
                    </div>

                    <div class="block-content collapse in">
                        <script type="text/javascript">
                            $(function () {
                                $('#btn').click(function(){
                                    $('#myForm1').ajaxSubmit(function(data){
                                        initChart(data);
                                    });
                                    return false;
                                });
                            });
                            function initChart(data){
                                $('#container').highcharts({
                                    title: {
                                        text: '大特保统计',
                                        x: -20 //center
                                    },
                                    subtitle: {
                                        text: 'Source: 美月数据库',
                                        x: -20
                                    },
                                    xAxis: {
                                        categories: data.tag.categories
                                    },
                                    yAxis: {
                                        title: {
                                            text: '人'
                                        },
                                        plotLines: [{
                                            value: 0,
                                            width: 1,
                                            color: '#808080'
                                        }]
                                    },
                                    tooltip: {
                                        valueSuffix: '人'
                                    },
                                    legend: {
                                        layout: 'horizontal',
                                        align: 'center',
                                        verticalAlign: 'bottom',
                                        borderWidth: 0
                                    },
                                    series: data.tag.series
                                });
                            }
                        </script>
                        <script type="text/javascript" src="${BasePath }/js/highcharts/highcharts.js"></script>
                        <script type="text/javascript" src="${BasePath}/js/highcharts/modules/exporting.js"></script>
                        <div id="container" style="min-width:600px;height:400px"></div>
                    </div>
                </div>
            </div>

            <div class="row-fluid">
                <div class="span12">
                    <div class="block">
                        <div class="navbar navbar-inner block-header" style="border-bottom: none;">
                            <form id="myForm" name="myForm" action="${BasePath}/meiyue/datebaoCoupon/list" method="post"
                                  class="form-inline">
                                UID：<input type="text" name="uid" value="${uid}"/>
                                优惠名称：<input type="text" name="couponName" value="${couponName}"/>
                                &nbsp;    &nbsp;  领取日期排序：    <input type="radio" name="sort"  value="1"   <c:if test="${sort ==1 }">checked</c:if> >  正序
                                <input type="radio" name="sort" id="sort" value="0"  <c:if test="${sort !=1 &&sort !=0 }">checked</c:if>  <c:if test="${sort==0 }">checked</c:if>  >倒序
                                &nbsp;    &nbsp; &nbsp;    &nbsp;    <input type="submit" value="查询"    class="btn btn-success btn-small"/>

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
                                <button class="btn btn-success btn-small" style="margin-top: -5px"
                                        onclick="openModel('${BasePath}/userCoupon/toAdd','新增')">新增
                                </button>
                            </pe:permission>
                        </div>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table class="table table-hover">
                                <thead>
                                <tr>


                                    <th>ID</th>
                                    <th>用户昵称<br/>UID  </th>
                                    <th>优惠名称</th>
                                    <th>优惠时长/量</th>
                                    <th>领取日期</th>
                                 <%--    <th>使用日期</th>--%>
                                    <th>生效日期</th>
                                    <th>失效日期</th>
                                    <th>使用状态</th>
                                    <th>操作</th>
                             <%--       <th style="width: 8%;" >操作  </th>--%>
                                </tr>
                                </thead>
                                <tbody id="tbodys">
                                <c:forEach items="${list}" var="obj">
                                    <tr>
                                            <%--                  private Long id;
private Long uid;  //uq
private String couponName; //优惠名称
private Long couponLength;//优惠时长
private Long useDate;//使用日期
private Long dateline;  // 领取日期
private Long startDate;//生效日期
private Long expiredDate; //过期日期
private Integer status;  //状态1:生效 2：已使用 3：过期，其他待定--%>

                                        <td class="id">${obj.id}</td>
                                        <td >${obj.nick} <br/>${obj.uid}</td>
                                        <td > ${obj.couponName}</td>
                                                <td > 1年</td>
                                         <%--       <td >   <script>formatDate("${obj.useDate}");</script></td>--%>
                                                <td >  <script>formatDate("${obj.dateline}");</script></td>
                                                <td >  <script>formatDate("${obj.startDate}");</script></td>
                                                <td >  <script>formatDate("${obj.expiredDate}");</script></td>
                                                <td >
                                                    <c:if test="${obj.status==1}"><font color="green">生效</font></c:if>
                                                    <c:if test="${obj.status==2}"><font color="red">未生效</font></c:if>
                                                    <c:if test="${obj.status==3}"><font color="red">失效</font></c:if>
                                                </td>


                                <%--        <td>
                                            <pe:permission key="update">
                                                <a class="btn btn-success btn-small"
                                                   href="javascript:openModel('${BasePath}/userCoupon/toEdit?id=${obj.id}','修改')">修改</a>
                                            </pe:permission>
                                            <pe:permission key="delete">
                                                <button class="btn del btn-danger btn-small">删除</button>
                                            </pe:permission>

                                        </td>--%>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                            <div class="pagination pagination-centered" id="pager"></div>
                            <script type="text/javascript">
                                var sign = 0;
                                window.onload = function () {
                                    PAGER.initPager('${start}', ' ${json.total}', '${limit}', 8, 'pager', getData);
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
<jsp:include page="../../include/bottom.jsp"/>


<script>
    $(function () {

        //异步统计曝光量
        $("input[name='id']").each(function () {
            var id = this.value;
            $.post('${BasePath}/userCoupon/getClickNum', {'id': id}, function (data) {
                var obj = eval(data);
                if (obj.errno == 0) {
                    $("#clickNumDiv_" + id).html(data.totalClickNum ? data.totalClickNum :0 );
                }
            });
        });
        //异步统计点击量
        $("input[name='id1']").each(function () {
            var id = this.value;
            $.post('${BasePath}/userCoupon/getClickNum', {'id': id}, function (data) {
                var obj = eval(data);
                if (obj.errno == 0) {
                    $("#clickNumDiv1_" + id).html(data.totalClickNum ? data.totalClickNum :0);
                }
            });
        });


        $(".del").bind('click', function () {

            if (!confirm('确定删除该条记录吗？')) {
                return false;
            }
            var uid = $(this).parent().parent().find(".id").text();
            var tr = $(this).parent().parent();
            $.post('${BasePath}/userCoupon/delete', {
                'id': uid
            }, function (data) {
                var obj = eval(data);
                if (obj.errno == 0) {
                    alert('操作成功');
                    tr.remove();
                } else {
                    alert(obj.errdesc);
                }
            });

        });
    });
</script>