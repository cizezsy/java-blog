<template:admin title="文章列表" breadcrumpItems="${['仪表盘', '文章管理', '文章列表']}">
    <jsp:attribute name="breadcrumpEnd">
        <div class="right">
            <button class="btn">
                添加文章
            </button>
        </div>
    </jsp:attribute>
    <jsp:body>
        <div class="container table z-depth-1 white clearfix">
            <div class="table-header-group">
                <div class="table-cell">
                    <span>标题</span>
                </div>
                <div class="table-cell">
                    <span>作者</span>
                </div>
                <div class="table-cell">
                    <span>创建时间</span>
                </div>
                <div class="table-cell">
                    <span>操作</span>
                </div>
            </div>
            <div class="table-row-group">
                <div class="table-row">
                    <div class="table-cell">
                        <span>测试标题</span>
                    </div>
                    <div class="table-cell">
                        <span>作者</span>
                    </div>
                    <div class="table-cell">
                        <span>创建时间</span>
                    </div>
                    <div class="table-cell">
                        <a href="#" class="admin-article-action">置顶</a>
                        <a href="#" class="admin-article-action">公布</a>
                        <a href="#" class="admin-article-action">编辑</a>
                    </div>
                </div>
                    <%--@elvariable id="articles" type="java.util.List<me.cizezsy.domain.Article>"--%>
                <c:forEach items="${articles}" var="article">
                    <div class="table-row">
                        <div class="table-cell">
                            <span>${article.articleTitle}</span>
                        </div>
                        <div class="table-cell">
                            <span>${article.user.userName}</span>
                        </div>
                        <div class="table-cell">
                            <span>${cf:formatLocalDateTime(article.createTime, "yyyy-mm-dd HH:mm:ss")}</span>
                        </div>
                        <div class="table-cell">
                            <a href="#" class="admin-article-action">置顶</a>
                            <a href="#" class="admin-article-action">公布</a>
                            <a href="#" class="admin-article-action">编辑</a>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
        <script>
            $(document).ready(function () {
                var fadeTime = 1000;
                $(".table-row").hover(function () {
                    $(this).addClass("table-hover");
                }, function () {
                    $(this).removeClass("table-hover");
                }).hide().each(function () {
                    $(this).fadeIn(fadeTime);
                    fadeTime+=1000;
                })
            })
        </script>
    </jsp:body>
</template:admin>