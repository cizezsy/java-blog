<ul id="side-out" class="side-nav fixed z-depth-2">
    <li>
        <div class="user-view">
            <div class="background color-scheme-strongest stripe-bg">
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
            <div class="row center-block center-align"><span class="color-scheme-light-text flow-text">cizezsy</span>
            </div>
        </div>
    </li>
    <li><a class="subheader">Category</a></li>
    <%--@elvariable id="categoryList" type="java.util.List<me.cizezsy.domain.Category>"--%>
    <c:forEach items="${categoryList}" var="category" end="6">
        <li><a class="waves-effect" href="<c:url value="/home?categoryId=${category.categoryId}"/>">${category.categoryTitle}</a></li>
    </c:forEach>
    <li><a class="subheader">近期发布</a></li>
</ul>
