<template:admin title="文章列表" breadcrumpItems="${['仪表盘', '文章管理', '文章列表']}">
    <jsp:attribute name="breadcrumpEnd">
        <script>
            $(document).ready(function () {

                $(".add-article").click(function () {
                    location.href = "/admin/article/edit";
                });

                function publishSuccess(ele) {
                    Materialize.toast("设置成功", 2000);
                    ele.text(ele.text().trim() === "公布" ? "隐藏" : "公布")
                }

                $(".admin-article-action-publish").click(function () {
                    var ele = $(this);
                    var articleId = ele.next().val();
                    $.ajax({
                        method: 'post',
                        url: '/admin/article',
                        data: {'articleId': articleId, 'action': 'publish'},
                        success: publishSuccess(ele),
                        error: function () {
                            Materialize.toast("设置失败", 2000);
                        }
                    });
                });
                function topSuccess(ele) {
                    Materialize.toast("设置成功", 2000);
                    ele.text(ele.text().trim() === "置顶" ? "取消置顶" : "置顶")
                }
                $('.admin-article-action-top').click(function () {
                    var ele = $(this);
                    var articleId = ele.next().next().val();
                    $.post({
                        method: 'post',
                        url: '/admin/article',
                        data: {'articleId': articleId, 'action': 'top'},
                        dataType: 'text',
                        success: topSuccess(ele),
                        error: function () {
                            Materialize.toast("设置失败", 2000)
                        }
                    });
                });

            });
        </script>
        <div class="right">
            <button class="btn add-article">
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
                            <a href="#" class="admin-article-action admin-article-action-top">
                                <c:choose>
                                    <c:when test="${article.top}">
                                        取消置顶
                                    </c:when>
                                    <c:otherwise>
                                        置顶
                                    </c:otherwise>
                                </c:choose>
                            </a>
                            <a href="#" class="admin-article-action admin-article-action-publish">
                                <c:choose>
                                    <c:when test="${article.publish}">
                                        隐藏
                                    </c:when>
                                    <c:otherwise>
                                        公布
                                    </c:otherwise>
                                </c:choose>
                            </a>
                            <input type="hidden" value="${article.articleId}">
                            <a href="<c:url value="/admin/article/edit?articleId=${article.articleId}"/>"
                               class="admin-article-action">编辑</a>
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
                    fadeTime += 1000;
                })
            })
        </script>
    </jsp:body>
</template:admin>