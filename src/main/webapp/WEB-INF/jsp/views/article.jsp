<%--@elvariable id="article" type="me.cizezsy.domain.Article"--%>
<template:main htmlTitle="${article.articleTitle}">
    <jsp:attribute name="nav">
        <c:set var="backgroundImg" value="/image/pexels-photo-424163.jpeg" scope="request"/>
        <%@include file="widget/front-nav.jsp" %>
    </jsp:attribute>
    <jsp:attribute name="footer">
        <%@include file="widget/front-footer.jsp" %>
    </jsp:attribute>
    <jsp:body>
        <script src="<c:url value="/js/highlight.pack.js"/>"></script>
        <style>
            .article-header-content {
                position: relative;
            }

            .article-header, .article-header-content ::before {
                background: url("/image/pexels-photo-424163.jpeg") 0 / cover fixed;
            }

            .article-header-content {
                width: 80%;
                margin: 0 auto;
                position: relative;
                background: hsla(0,0%,100%,.3);
                overflow: hidden;
                z-index: 1;
            }

            .article-header-content ::before {
                content: '';
                position: absolute;
                top: 0;
                right: 0;
                bottom: 0;
                left: 0;
                z-index: -1;
                filter: blur(20px);
                margin: -30px;
            }

            .tag-panel {
                display: flex;
                flex-wrap: wrap;
                padding: 5px !important;
            }

            .tag-panel .chip {
                flex: initial;
                cursor: pointer;
                -webkit-user-select: none;
            }

            .tag-panel .chip:hover {
                cursor: pointer;
            }
        </style>
        <%--TODO 此处url以后改成动态--%>
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
                <div class="col s12 m10 article-content">
                    <div>
                            ${article.articleContent}
                    </div>
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
                        <ul class="section table-of-contents" id="scroll-spy-ul">

                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <script>
            $(document).ready(function () {

                $(document).ready(function () {
                    $('.scrollspy').scrollSpy();
                });
                var set = false;
                var width;
                $(window).scroll(function () {
                    var scrollTop = $(window).scrollTop();
                    var scrollSpyNav = $('#pin-scroll');
                    if (scrollTop < 400) {
                        if(!set) {
                            width =scrollSpyNav.width();
                            set = true;
                        }
                        scrollSpyNav.removeClass("pinned");
                        return;
                    }
                    if (scrollTop + 42 >= scrollSpyNav.offset().top) {
                        if(set) {
                            scrollSpyNav.width(width);
                            set = false;
                        }
                        scrollSpyNav.addClass('pinned');
                    }
                });
            })
        </script>
        <img src="<c:url value="${backgroundImg}"/>" class="color-thief-target" style="display: none">
    </jsp:body>
</template:main>