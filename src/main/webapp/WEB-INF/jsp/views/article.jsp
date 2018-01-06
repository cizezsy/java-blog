<%--@elvariable id="article" type="me.cizezsy.domain.Article"--%>
<template:main htmlTitle="${article.articleTitle}">
    <jsp:attribute name="nav">
        <c:set var="backgroundImg" value="${article.articleBgUrl}" scope="request"/>
        <%@include file="widget/front-nav.jsp" %>
    </jsp:attribute>
    <jsp:attribute name="footer">
        <%@include file="widget/front-footer.jsp" %>
    </jsp:attribute>
    <jsp:body>
        <link href="<c:url value="/css/custom/article.css"/>" type="text/css" rel="stylesheet"/>
        <script src="<c:url value="/js/color-adapt.js"/>"></script>
        <script src="http://libs.cdnjs.net/highlight.js/9.9.0/highlight.min.js"></script>
        <style>
            main, .article-header-content ::before {
                background: url("${article.articleBgUrl}") 0 / cover fixed;
            }
        </style>
        <div class="article-header valign-wrapper">
            <div class="container article-header-content">
                <div class="article-header-title">
                    <h3 class="white-text">${article.articleTitle}</h3>
                </div>
                <div class="article-header-info"><h6 class="grey-text text-lighten-3">create
                    on ${cf:formatLocalDateTime(article.createTime, "yyyy MM dd ")}</h6>
                </div>
            </div>
        </div>
        <div class="container clearfix">
            <div class="row">
                <div class="col s12 m10 article-content z-depth-2 hoverable">
                    <div>${article.articleContent}</div>
                    <hr>
                    <div class="article-info valign-wrapper right">
                        <img class="icon-block" src="<c:url value="/image/ic_time.png"/>">
                        <time>${cf:formatLocalDateTime(article.createTime, "yyyy-MM-dd HH:mm")}</time>
                        <img class="icon-block" src="<c:url value="/image/ic_view.png"/>">
                        <span>${article.viewCount}</span>
                        <img class="icon-block" src="<c:url value="/image/ic_comment.png"/>">
                            <%--TODO 评论数量--%>
                        <span>0</span>
                        &nbsp; &nbsp;&nbsp;
                    </div>
                </div>
                <div class="col hide-on-small-only m2">
                    <div class="pin-top pin-scroll" id="pin-scroll">
                        <div class="tag-panel">
                            <%--@elvariable id="tags" type="java.util.List"--%>
                            <c:forEach items="${article.tagList}" var="tag">
                                <div class="chip color-scheme-light-text color-scheme-strong rounded hoverable">
                                    ${tag.tagName}
                                </div>
                            </c:forEach>
                        </div>
                        <ul class="section table-of-contents z-depth-2 hoverable" id="scroll-spy-ul">
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <script src="<c:url value="/js/custom/article.js"/>"></script>
        <img src="<c:url value="${backgroundImg}"/>" class="color-thief-target" style="display: none">
    </jsp:body>
</template:main>