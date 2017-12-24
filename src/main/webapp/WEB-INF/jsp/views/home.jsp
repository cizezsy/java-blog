<%--@elvariable id="articleList" type="java.util.List<Article>"--%>
<%--@elvariable id="site" type="me.cizezsy.domain.Site"--%>
<template:main htmlTitle="${site.siteName}">
    <jsp:attribute name="nav">
         <c:set var="backgroundImg" value="${site.siteBg}" scope="request"/>
        <%@include file="widget/front-nav.jsp" %>
    </jsp:attribute>
    <jsp:attribute name="footer">
        <%@include file="widget/front-footer.jsp" %>
    </jsp:attribute>
    <jsp:body>
        <style>
            .article-header, .article-header-content ::before {
                background: url("${backgroundImg}") 0 / cover fixed;
            }
        </style>
        <link href="<c:url value="/css/custom/home.css"/>" type="text/css" rel="stylesheet"/>
        <script src="<c:url value="/js/custom/home.js"/>"></script>
        <div class="article-header valign-wrapper center-align">
            <div class="article-header-content">
                <h4 class="white-text">${site.siteMotto}</h4>
            </div>
        </div>
        <div class="container">
            <div class="row">
                <c:forEach var="article" items="${articleList}">
                    <div class="scrollspy section article-item-section">
                        <h4>
                            <a class="color-scheme-strongest-text"
                               href="<c:url value="/article/detail?articleId=${article.articleId}"/>">${article.articleTitle}</a>
                        </h4>
                        <c:choose>
                            <c:when test="${article.articleAbstract eq null or article.articleAbstract eq ''}">
                                <div class="article-abstract">
                                        ${article.articleContent}
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="article-abstract">
                                        ${article.articleAbstract}
                                </div>
                            </c:otherwise>
                        </c:choose>
                        <div class="left article-more valign-wrapper">
                            <span>查看更多</span><i class="material-icons">arrow_drop_down</i>
                        </div>
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