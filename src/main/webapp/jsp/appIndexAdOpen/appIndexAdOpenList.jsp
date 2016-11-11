<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="/permission" prefix="pe" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="../include/top.jsp"/>
<!-- Body -->
<script src="${BasePath}/js/json.js"></script>
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
                            <form id="myForm" name="myForm" action="${BasePath}/appindexadopen/list" method="post"
                                  class="form-inline">
                                时间：
                                <select name="time" id="time" >
                                    <option value="0" <c:if test="${time==null ||  time=='0'  }">selected="selected"</c:if> >
                                        广告时间
                                    </option>
                                    <option value="1"  <c:if test="${time !=null &&time=='1' }">selected="selected"</c:if> >发布时间
                                    </option>
                                </select>
                             <%--   时间：
                                <select name="time" id="time" >
                                    <option value="0"
                                            <c:if test="${time==0 }">selected="selected"</c:if> >
                                         广告时间
                                    </option>
                                    <option value="1"
                                            <c:if test="${time==1 }">selected="selected"</c:if> >发布时间
                                    </option>
                                </select>
                                平台：
                                <select name="platform" id="platform" >
                                    <option value=""
                                            <c:if test="${platform=='' }">selected="selected"</c:if> >  全部
                                    </option>
                                    <option value="99"
                                            <c:if test="${platform==99 }">selected="selected"</c:if> >  通用
                                    </option>
                                    <option value="0"
                                            <c:if test="${platform==0 }">selected="selected"</c:if> >Android
                                        广告时间
                                    </option>
                                    <option value="1"
                                            <c:if test="${platform==1 }">selected="selected"</c:if> >IOS
                                    </option>
                                    <option value="2"
                                            <c:if test="${platform==2 }">selected="selected"</c:if> >WP
                                    </option>

                                </select>--%>
                                平台：
                                <select name="platform" id="platform" >
                                    <option value=""
                                            <c:if test="${platform==-1}">selected="selected"</c:if> >  全部
                                    </option>
                             <%--       <option value="99"
                                            <c:if test="${platform==99 }">selected="selected"</c:if> >  通用
                                    </option>--%>
                                    <option value="0"
                                            <c:if test="${platform==0 }">selected="selected"</c:if> >Android
                                    </option>
                                    <option value="1"
                                            <c:if test="${platform==1 }">selected="selected"</c:if> >IOS
                                    </option>
                                    <option value="2"
                                            <c:if test="${platform==2 }">selected="selected"</c:if> >WP
                                    </option>

                                </select>
                                广告名称：<input type="text" name="title" value="${adname}"/>

                                <input type="submit"
                                                                                             value="查询"
                                                                                             class="btn btn-success btn-small"/>

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
                                        onclick="openModel('${BasePath}/appindexadopen/toAdd','新增')">新增
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
                                    <th>广告名称</th>
                                    <th>图片</th>
                                    <th>在线时间</th>
                                    <th>状态</th>
                                    <th>平台</th>
                                    <th>展示次数</th>

                                    <th>缓存曝光量</th>
                                    <th>实际展示次数</th>
                               <%--     <th>点击量</th>--%>
                                    <th>添加时间</th>
                                    <th>是否同步谷歌平台</th>

                                    <th style="width: 8%;" >投放城市</th>
                                    <th style="width: 8%;" > 操作  </th>
                                </tr>
                                </thead>
                                <tbody id="tbodys">
                                <c:forEach items="${json.list}" var="obj">
                                    <tr>
                                        <td class="id">${obj.id}</td>
                                        <td >${obj.adname}</td>

                                        <td>
                                            <c:if test="${obj.platform !=null && obj.platform =='0' }">
                                                <c:if test="${obj.adpicsAn320 !=null && obj.adpicsAn320  !='' }">
                                                    <a href="${obj.content.url}" rel="lightbox[ostec]">
                                                        <img src="${imageHost }${obj.adpicsAn320}" width="80px" height="80px" />
                                                    </a>

                                                </c:if>
                                                <c:if test="${obj.adpicsAn480 !=null && obj.adpicsAn480 !='' }">
                                                    <a href="${obj.content.url}" rel="lightbox[ostec]">
                                                        <img src="${imageHost }${obj.adpicsAn480}" width="80px" height="80px" />
                                                    </a>

                                                </c:if>
                                                <c:if test="${obj.adpicsAn1080 !=null && obj.adpicsAn1080  != '' }">
                                                    <a href="${obj.content.url}" rel="lightbox[ostec]">
                                                        <img src="${imageHost }${obj.adpicsAn1080}" width="80px" height="80px" />
                                                    </a>

                                                </c:if>
                                                <br/>
                                                ${obj.links}
                                                <br/>
                                                ${obj.viewmonitorlink}
                                            </c:if>

                                            <c:if test="${obj.platform !=null && obj.platform =='1' }">
                                                <c:if test="${obj.adpicsIos960 !=null && obj.adpicsIos960  !='' }">
                                                    <a href="${obj.content.url}" rel="lightbox[ostec]">
                                                        <img src="${imageHost }${obj.adpicsIos960}" width="80px" height="80px" />
                                                    </a>

                                                </c:if>
                                                <c:if test="${obj.adpicsIos1080 !=null && obj.adpicsIos1080 !='' }">
                                                    <a href="${obj.content.url}" rel="lightbox[ostec]">
                                                        <img src="${imageHost }${obj.adpicsIos1080}"  width="80px" height="80px" />
                                                    </a>

                                                </c:if>
                                                <c:if test="${obj.adpicsIos1136 !=null && obj.adpicsIos1136  != '' }">
                                                    <a href="${obj.content.url}" rel="lightbox[ostec]">
                                                        <img src="${imageHost }${obj.adpicsIos1136}"width="80px" height="80px" />
                                                    </a>

                                                </c:if>
                                                <br/>
                                                ${obj.links}
                                                <br/>
                                                ${obj.viewmonitorlink}
                                            </c:if>

                                            <c:if test="${obj.platform !=null && obj.platform =='2' }">
                                                <c:if test="${obj.adpics !=null && obj.adpics!=''}">
                                                    <img src="${imageHost }${obj.adpics}" width="80px" height="80px" />
                                                </c:if>
                                                <br/>
                                                ${obj.links}
                                                <br/>
                                                ${obj.viewmonitorlink}
                                            </c:if>


                                        </td>
                                        <td>
                                            <c:if test="${obj.startdate !=null && obj.startdate!=''}">
                                            <script>formatDate("${obj.startdate}");</script>
                                            </c:if>
                                            ~
                                            <c:if test="${obj.enddate !=null && obj.enddate!=''}">
                                            <script>formatDate("${obj.enddate}");</script>
                                            </c:if>
                                        </td>
                                        <td>
                                            <c:if test="${obj.online !=null && obj.online =='1' }">
                                                <font color="green">上线</font>
                                            </c:if>
                                            <c:if test="${obj.online !=null && obj.online =='0' }">
                                            <font color="red"> 未上线</font>
                                            </c:if>
                                            <c:if test="${obj.online !=null && obj.online =='2' }">
                                                <font color="red"> 已下线</font>
                                            </c:if>
                                        </td>
                                        <td>
                                            <c:if test="${obj.platform !=null && obj.platform =='99' }">
                                                通用
                                            </c:if>
                                            <c:if test="${obj.platform !=null && obj.platform =='2' }">
                                                WP
                                            </c:if>
                                            <c:if test="${obj.platform !=null && obj.platform =='0' }">
                                                Android
                                            </c:if>
                                            <c:if test="${obj.platform !=null && obj.platform =='1' }">
                                                IOS
                                            </c:if>
                                        </td>
                                       <td>
                                           <c:if test="${ obj.displaynum ==1 }">
                                               每天1次
                                           </c:if>
                                           <c:if test="${ obj.displaynum !=1 }">
                                               每次都显示
                                           </c:if>
                                        </td>

                                        <td style="width: 100px;vertical-align:top" class="tdBreak">
                                                <%--总量:${obj.totalExposure}<br>--%>
                                                <%--Android:${obj.androidExposure}<br>--%>
                                                <%--IOS:${obj.iosExposure}<br>--%>
                                                <%--WP:${obj.wpExposure}--%>
                                            <input type="hidden" id="id"  name="id" value="${obj.id }"/>
                                            <div id="clickNumDiv_${obj.id }"></div>
                                        </td>
                                        <td>

                                                ${obj.displaycount}
                                        </td>
                                    <%--    <td>
                                            <input type="hidden" id="id1" name="id1"
                                                   value="${obj.id },${obj.platform },c"/>

                                            <div id="clickNumDiv1_${obj.id }"></div>
                                        </td>--%>
                                    
                                        <td>    <script>formatDate("${obj.createtime}");</script></td>
                                        <td>
                                            <c:if test="${obj.googleLink==1}"><font color="green">否</font></c:if>
                                            <c:if test="${obj.googleLink==0}"><font color="red">是</font></c:if>
                                        </td>
                                        <td width="15%">
                                                ${obj.area}
                                        </td>

                                        <td>
                                            <pe:permission key="update">
                                                <a class="btn btn-success btn-small"
                                                   href="javascript:openModel('${BasePath}/appindexadopen/toEdit?id=${obj.id}','修改')">修改</a>
                                            </pe:permission>
                                            <pe:permission key="delete">
                                                <button class="btn del btn-danger btn-small">删除</button>
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
<jsp:include page="../include/bottom.jsp"/>


<script>
    $(function () {

        //异步统计曝光率
        $("input[name='id']").each(function (){
            var id=this.value;
            $.post('${BasePath}/appindexadopen/getView',{ 'id':id },function(data){
                var obj = eval(data);
                if(obj.errno==0){
                    var html="总量:";
                    if(data.totalExposure!=null){
                        html+=data.totalExposure;
                    }else{
                        html+="0";
                    }
                    html+="<br>Android:";
                    if(data.androidExposure!=null){
                        html+=data.androidExposure;
                    }else{
                        html+="0";
                    }
                    html+="<br>IOS:";
                    if(data.iosExposure!=null){
                        html+=data.iosExposure;
                    }else{
                        html+="0";
                    }
                    html+="<br>WP:";
                    if(data.wpExposure!=null){
                        html+=data.wpExposure;
                    }else{
                        html+="0";
                    }
                    $("#clickNumDiv_"+id).html(html);
                }
            });
        });

/*        //异步统计点击量
        $("input[name='id1']").each(function () {
            var id = this.value;
            $.post('${BasePath}/appindexadopen/getClickNum', {'id': id}, function (data) {
                var obj = eval(data);
                if (obj.errno == 0) {
                    $("#clickNumDiv1_" + id).html(data.totalClickNum ? data.totalClickNum :0);
                }
            });
        });*/


        $(".del").bind('click', function () {

            if (!confirm('确定删除该条记录吗？')) {
                return false;
            }
            var uid = $(this).parent().parent().find(".id").text();
            var tr = $(this).parent().parent();
            $.post('${BasePath}/appindexadopen/delete', {
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