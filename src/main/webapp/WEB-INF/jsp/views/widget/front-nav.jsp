<style>
    .checkerboard-bg {

        background-image: linear-gradient(45deg, #bbb 25%, transparent 0),
        linear-gradient(45deg, transparent 75%, #bbb 0),
        linear-gradient(45deg, #bbb 25%, transparent 0),
        linear-gradient(45deg, transparent 75%, #bbb 0);

        background-position: 0 0, 15px 15px, 15px 15px, 30px 30px;
        background-size: 30px 30px;
    }
</style>
<ul id="side-out" class="side-nav fixed z-depth-2">
    <li>
        <div class="user-view">
            <div class="background imageColor checkerboard-bg">
                <%--<c:choose>--%>
                <%--&lt;%&ndash;@elvariable id="backgroundImg" type="java.lang.String"&ndash;%&gt;--%>
                <%--<c:when test="${backgroundImg != null}">--%>
                <%--<img src="<c:url value="${backgroundImg}"/>">--%>
                <%--</c:when>--%>
                <%--<c:otherwise>--%>
                <%--<img src="<c:url value="/image/pexels-photo-424154.jpeg"/>">--%>
                <%--</c:otherwise>--%>
                <%--</c:choose>--%>
            </div>
            <a href="#"><img src="<c:url value="/image/426H.jpg"/>" class="responsive-img circle center-block"></a>
            <div class="row center-block center-align"><span class="white-text flow-text">cizezsy</span></div>
        </div>
    </li>
    <li><a class="subheader">分类</a></li>
    <li><a class="waves-effect">默认</a></li>
    <li><a class="subheader">近期发布</a></li>
    <li><a class="waves-effect">测试</a></li>
    <li><a class="waves-effect">测试</a></li>
    <li><a class="waves-effect">测试</a></li>
    <li><a class="waves-effect">测试</a></li>
</ul>
