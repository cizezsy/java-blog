<template:main htmlTitle="主页">
    <jsp:attribute name="nav">
         <c:set var="backgroundImg" value="/image/pexels-photo-424154.jpeg" scope="request"/>
        <%@include file="widget/front-nav.jsp" %>
    </jsp:attribute>
    <jsp:attribute name="footer">
        <%@include file="widget/front-footer.jsp" %>
    </jsp:attribute>
    <jsp:body>
        <div class="article-header valign-wrapper center-align"
             style="background-image: url('/image/pexels-photo-424154.jpeg')">
            <h4 class="center-in-container white-text">未有知而不行者，知而不行，只是未知</h4>
        </div>
        <div class="container">
            <div class="row">
                    <%--@elvariable id="articleList" type="java.util.List<Article>"--%>
                <c:forEach var="article" items="${articleList}">
                    <div class="scrollspy section">
                        <h4>
                            <a href="<c:url value="/article/detail?articleId=${article.articleId}"/>">${article.articleTitle}</a>
                        </h4>
                        <p class="article-abstract">${article.articleAbstract}</p>
                        <time class="right article-time">
                                ${cf:formatLocalDateTime(article.createTime, 'yyyy-MM-dd')}
                        </time>
                    </div>
                </c:forEach>
            </div>
        </div>
        <img src="<c:url value="${backgroundImg}"/>" class="color-thief-target" style="display: none">
    </jsp:body>
</template:main>