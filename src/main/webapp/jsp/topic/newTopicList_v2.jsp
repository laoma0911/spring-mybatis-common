<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="/permission" prefix="pe" %>
<%@ taglib prefix="e" uri="https://www.owasp.org/index.php/OWASP_Java_Encoder_Project" %>
<jsp:include page="../include/top.jsp"/>
<link href="${BasePath}/js/mediabox/css.css" rel="stylesheet" media="screen">
<c:if test="${isAvailable==1}">
    <script >alert("任务进行中，请稍后查询！");</script>
</c:if>
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
                            <form action="${BasePath}/topic/newList_v2?type=${type}&itemId=${itemId}" method="post" id="myform" class="form-search">

                                小组分类：
                                <select name="catId" id="catId">
                                    <option value="0">全部分类</option>
                                    <c:forEach items="${tgcList}" var="obj1">
                                        <option
                                                <c:if test="${catId == obj1.id}">selected="selected" </c:if> value="${obj1.id}">
                                                ${obj1.title}
                                        </option>
                                    </c:forEach>
                                </select>

                                <input type="hidden" name="flag" id="flag"/>
                                UID：
                                <input type="text" name="uid" id="uid" style="width:120px;" value="${uid}" />

                                话题id：
                                <input type="text" name="topicId" id="topicId" style="width:120px;" value="${topicId}" />

                                <%--2016-03-14 15:30:08 运营 杨慧Say 去掉按标题查询--%>
                                <%--标题：--%>
                                <%--<input type="text" name="keyWord" id="keyWord" value="${keyWord}"/>--%>

                                开始时间：
                                <input type="text" class="Wdate" id="startDate" name="startDate"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'endDate\')}',readOnly:'false'})" />
                                结束时间：
                                <input type="text" class="Wdate" id="endDate" name="endDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'startDate\')}',maxDate:'%y-%M-%d',readOnly:'false'})" />

                                <pe:permission key="operation_department">
                                条件：
                                <select name="queryFilter" id="queryFilter" class="input-medium">
                                    <%--图片大于3张  文字多于50字  潜在用户库--%>
                                    <option value="-9">全部</option>
                                    <option
                                            <c:if test="${queryFilter==1}">selected="selected" </c:if> value="1">
                                        图片大于3张
                                    </option>
                                    <option
                                            <c:if test="${queryFilter==2}">selected="selected" </c:if> value="2">
                                        文字多于50字
                                    </option>
                                </select>
                                </pe:permission>
                                <input type="hidden" name="start" id="start" value="${start}"/>
                                <input type="hidden" name="limit" id="limit" value="${limit}"/>
                                <input type="button"  onclick="submitForm()" class="btn btn-small btn-success" value="查询"/>
                                <input type="button" class="btn btn-small btn-success" id="changeBtn" onclick="showRecommend(this)" value="显示已推荐"/>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <div class="muted pull-left">
                            话题列表<br>
                        </div>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table class="table table-hover" id="myTable">
                                <thead>
                                <tr>
                                    <th nowrap="true">ID</th>
                                    <th nowrap="true">用户信息</th>
                                    <th nowrap="true">小组分类</th>
                                    <th nowrap="true">标题</th>
                                    <th nowrap="true">内容</th>
                                    <th nowrap="true">浏览量</th>
                                    <th nowrap="true">回复数</th>
                                    <th nowrap="true">发布时间</th>
                                    <th nowrap="true">操作</th>
                                </tr>
                                </thead>
                                <tbody id="tbodys" >
                                <c:forEach items="${data}" var="obj">
                                    <tr <c:choose><c:when test="${obj.hotSign==1}"> id="isShow" style="display:none"</c:when></c:choose>>
                                        <td nowrap="true">${obj.id}</td>
                                        <td nowrap="true">
                                            <font color="#08c">UID：</font><a href="${BasePath}/custom/userList?type=4&itemId=20&uid=${obj.uid}"  target="_black">${obj.uid}</a>
                                            <br>
                                            <font color="#08c">昵称：</font> ${obj.nick}<br>
                                            <a href="${BasePath }/audit/topicList?uid=${obj.uid}&type=8&itemId=43&status=-1">她的全部话题</a><br>
                                            <a href="${BasePath }/audit/replyList?uid=${obj.uid}&type=${type}&itemId=${itemId}&status=-1">她的全部回复</a>
                                        </td>
                                        <td nowrap="true">${obj.topicGroupCategoryTitle}</td>
                                        <td nowrap="true">
                                            <c:choose>
                                                <c:when test="${obj.ban!=1}">
                                                    <a href="${BasePath}/topic/topicDetail?topicId=${obj.id}&type=${type}&itemId=${itemId}" target="_blank"><e:forHtml value="${obj.title}"/></a>
                                                </c:when>
                                                <c:otherwise>
                                                    <e:forHtml value="${obj.title}"/>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td style="width: 500px" class="tdBreak">
                                            <e:forHtml value="${obj.content}"/><br>
                                            <c:forEach items="${obj.picList}" var="pic">
                                                <a href="${pic.oriPic}" rel="lightbox[ostec]">
                                                    <img src="${pic.pic}" width="130px" height="130px">&nbsp;
                                                </a>
                                            </c:forEach>
                                        </td>
                                        <td nowrap="true">${obj.viewnum}</td>
                                        <td nowrap="true">${obj.replynum}</td>
                                        <td nowrap="true">
                                            <script>formatTime("${obj.dateline}");</script>
                                        </td>

                                        <td nowrap="true">
                                            <c:if test="${obj.hotSign==1}">
                                                <input type="button" name="flag" class="btn btn-small btn-danger" onclick="cancelHot('${obj.id}','${obj.indexSign}')" value="取消推荐热门"/>
                                            </c:if>
                                            <c:if test="${obj.hotSign==0}">
                                                <input type="button" name="flag" class="btn btn-small btn-success" onclick="openModel('${BasePaht}/topic/toRecommendTopic?topicId=${obj.id}','推荐到热门')" value="推荐热门"/>
                                            </c:if>

                                            <pe:permission key="edit">
												<a class="btn btn-small btn-success" href="${BasePath}/topic/updateTopic?${PublicParams}&topicId=${obj.id}" target="_blank">编辑</a>
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
                                    PAGER.initPager('${start}', '${10000}', '${limit}', 8, 'pager', getData);
                                }
                                function getData(currentPage, pageSize) {
                                    if (sign > 0) {
                                        $("#start").val(currentPage);
                                        $("#limit").val(pageSize);
                                        $("#flag").val(1);
                                        $("#myform").submit();
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
<script type="text/javascript">
    $(document).ready(function(){
        setByIdFormatDate("startDate",'${startDate}');
        setByIdFormatDate("endDate",'${endDate}');
    });
</script>



<script type="text/javascript">


    function checkForm() {

        var startDate = $("#startDate").val();
        var endDate = $("#endDate").val();

        var starttime = Date.parse(new Date(startDate));
        starttime = starttime / 1000;

        var endtime = Date.parse(new Date(endDate));
        endtime = endtime / 1000;

        var tm = endtime - starttime;

        if( (tm / 60 / 60 / 24) > 2){
            alert("时间最大可选3天的范围");
            return false;
        }
        return true;
    }


    function submitForm() {
        var flag = checkForm();
        if (flag == true) {
            document.getElementById("myform").submit();
        }
    }

    //取消推荐到热门
    function cancelHot(topicId, indexSign) {
        if (indexSign == 1) {
            if (confirm("该话题已经被推荐到首页，确定要取消吗？")) {
                var aj = $.ajax({
                    url: '${BasePath}/topic/cancelTagRecommend?topicId=' + topicId,
                    type: 'post',
                    cache: false,
                    dataType: 'json',
                    success: function (data) {
                        if (data.errno == 0) {
                            window.location.reload();
                        } else {
                            alert(data.errdesc);
                        }
                    },
                    error: function () {
                        alert("操作异常，请重试！");
                    }
                });
            }
        } else {
            if (confirm("确定要取消吗？")) {
                var aj = $.ajax({
                    url: '${BasePath}/topic/cancelTagRecommend?topicId=' + topicId,
                    type: 'post',
                    cache: false,
                    dataType: 'json',
                    success: function (data) {
                        if (data.errno == 0) {
                            window.location.reload();
                        } else {
                            alert(data.errdesc);
                        }
                    },
                    error: function () {
                        alert("操作异常，请重试！");
                    }
                });
            }
        }
    }
    //推荐热门
    function toOpenModel(topicId) {
        //1.$.ajax带json数据的异步请求
        var aj = $.ajax({
            url: '${BasePath}/topic/checkRecommend?topicId=' + topicId,
            type: 'post',
            cache: false,
            dataType: 'json',
            success: function (data) {
                if (data.errno == 0) {
                    openModel("${BasePaht}/topic/toRecommendTopic?topicId=" + topicId, "推荐到热门");
                } else {
                    alert(data.errdesc);
                }
            },
            error: function () {
                alert("操作异常，请重试！");
            }
        });
    }

    var xytzLive = true;//true 显示   false隐藏

    function showRecommend(obj) {
        $("#myTable").find("tr").each(function(){
            if(this.id=='isShow') {
                if (xytzLive) {
                    this.removeAttribute("style");
                } else {
                    this.setAttribute("style", "display:none");
                }
            }
        });
        if(xytzLive){
            $(obj).val("隐藏已推荐");
            xytzLive=false;
        }else{
            xytzLive=true;
            $(obj).val("显示已推荐");
        }
    }

</script>
<script type="text/javascript">
    Mediabox.scanPage = function () {
        var links = $$("a").filter(function (el) {
            return el.rel && el.rel.test(/^lightbox/i);
        });
        $$(links).mediabox({/* Put custom options here */}, null, function (el) {
            var rel0 = this.rel.replace(/[[]|]/gi, " ");
            var relsize = rel0.split(" ");
            return (this == el) || ((this.rel.length > 8) && el.rel.match(relsize[1]));
        });
    };
    window.addEvent("domready", Mediabox.scanPage);
</script>
