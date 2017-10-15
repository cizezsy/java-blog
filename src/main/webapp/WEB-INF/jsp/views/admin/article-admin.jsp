<template:admin title="文章列表" breadcrumpItems="${['仪表盘', '文章管理', '文章列表']}">
    <jsp:attribute name="breadcrumpEnd">
        <style>
            .dropdown-content li > a, .dropdown-content li > span {
                color: #EF5350;
            }

            .table-cell .select-wrapper input.select-dropdown {
                margin: 0;
                border: none;
                height: 30px;
            }

            .table-cell .input-field , .article-admin-filter .input-field{
                margin-top: 0;
            }

            .container .article-admin-filter {
                margin: 0;
            }

            .container .article-admin-filter > .col{
                margin-left: 0;
            }
        </style>
        <script>
            $(document).ready(function () {

                $('select').material_select();

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
        <div class="container">
            <div class="row article-admin-filter valign-wrapper">
                <div class="col m1">
                    <span>筛选：</span>
                </div>
                <div class="col m3">
                    <input type="text" class="datepicker" placeholder="日期">
                </div>
                <div class="input-field col m3">
                    <select multiple>
                        <option value="" selected>所有目录</option>
                            <%--@elvariable id="categories" type="java.util.List<me.cizezsy.domain.Category>"--%>
                        <c:forEach items="${categories}" var="category">
                            <option value="${category.categoryId}"
                                    class="red-text lighten-text-2">${category.categoryTitle}</option>
                        </c:forEach>
                        <option value="" class="">测试</option>
                    </select>
                </div>
            </div>
            <div class="table z-depth-1 white clearfix">
                <div class="table-header-group grey lighten-1 stripe-bg">
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
                        <span>目录</span>
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
                                <div class="input-field">
                                        <%--@elvariable id="categories" type="java.util.List<me.cizezsy.domain.Category>"--%>
                                    <select>
                                        <c:choose>
                                            <c:when test="${article.category eq null}">
                                                <option value="" disabled selected>选择目录</option>
                                                <c:forEach items="${categories}" var="category">
                                                    <option value="${category.categoryId}"
                                                            class="red-text lighten-text-2">${category.categoryTitle}</option>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <c:forEach items="${categories}" var="category">
                                                    <option value="${category.categoryId}"
                                                            <c:if test="${category.categoryId eq article.category.categoryId}">selected</c:if>
                                                            class="red-text lighten-text-2">${category.categoryTitle}</option>
                                                </c:forEach>
                                            </c:otherwise>
                                        </c:choose>

                                        <option value="" class="">测试</option>
                                    </select>
                                </div>
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