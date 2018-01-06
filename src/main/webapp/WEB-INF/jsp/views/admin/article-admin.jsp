<%--@elvariable id="categories" type="java.util.List<me.cizezsy.domain.Category>"--%>
<template:admin title="文章列表" breadcrumpItems="${['仪表盘', '文章管理', '文章列表']}">
    <jsp:attribute name="breadcrumpEnd">
        <div class="right">
            <button class="btn add-article">
                添加文章
            </button>
        </div>
    </jsp:attribute>
    <jsp:body>
        <link href="<c:url value="/css/custom/article-admin.css"/>" type="text/css" rel="stylesheet"/>
        <script src="<c:url value="/js/custom/article-admin.js"/>"></script>
        <div class="container">
            <div class="row article-admin-filter valign-wrapper">
                <div class="col s3">
                    <input type="text" class="datepicker" placeholder="起始日期（默认无）" id="startDatePicker">
                </div>
                <div class="col s3">
                    <input type="text" class="datepicker" placeholder="截至日期（默认今日）" id="endDatePicker">
                </div>
                <div class="input-field col s3">
                    <select multiple class="category-filter-select" id="category-filter-select">
                        <option value="all" selected>所有目录</option>
                        <c:forEach items="${categories}" var="category">
                            <option value="${category.categoryId}"
                                    class="red-text lighten-text-2">${category.categoryTitle}</option>
                        </c:forEach>
                        <label>目录</label>
                    </select>
                </div>
                <div class="right">
                    <button class="btn article-filter-btn">筛选</button>
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
                    <div class="table-cell table-cell-category">
                        <span>目录</span>
                        <span class="table-cell-create-category">创建</span>
                        <div class="z-depth-1 create-category-div">
                            <span class=""></span>
                            <div>
                                <input type="text" class="create-category-input">
                            </div>
                        </div>
                    </div>
                    <div class="table-cell">
                        <span>置顶</span>
                    </div>
                    <div class="table-cell">
                        <span>公布</span>
                    </div>
                    <div class="table-cell">
                        <span>操作</span>
                    </div>
                </div>
                <div class="table-row-group">
                        <%--@elvariable id="articles" type="java.util.List<me.cizezsy.domain.Article>"--%>
                    <c:forEach items="${articles}" var="article">
                        <div class="table-row">
                            <div class="table-cell article-admin-title">
                            <span class="truncate">${article.articleTitle}</span>
                            </div>
                            <div class="table-cell">
                                <span>${article.user.userName}</span>
                            </div>
                            <div class="table-cell">
                                <span>${cf:formatLocalDateTime(article.createTime, "yyyy-MM-dd HH:mm")}</span>
                            </div>
                            <div class="table-cell">
                                <div class="input-field">
                                    <select class="article-category-select">
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
                                    </select>
                                </div>
                            </div>
                            <div class="table-cell">
                                <div class="switch admin-article-action admin-article-action-top"
                                     style="display: inline-block">
                                    <label>
                                        <c:choose>
                                            <c:when test="${article.top}">
                                                <input type="checkbox" checked class="admin-article-action-is-top-box">
                                            </c:when>
                                            <c:otherwise>
                                                <input type="checkbox" class="admin-article-action-is-top-box">
                                            </c:otherwise>
                                        </c:choose>
                                        <span class="lever"></span>
                                    </label>
                                </div>
                            </div>
                            <div class="table-cell">
                                <div class="switch admin-article-action admin-article-action-publish"
                                     style="display: inline-block">
                                    <label>
                                        <c:choose>
                                            <c:when test="${article.publish}">
                                                <input type="checkbox" checked
                                                       class="admin-article-action-is-publish-box">
                                            </c:when>
                                            <c:otherwise>
                                                <input type="checkbox" class="admin-article-action-is-publish-box">
                                            </c:otherwise>
                                        </c:choose>
                                        <span class="lever"></span>
                                    </label>
                                </div>
                            </div>
                            <div class="table-cell">
                                <input type="hidden" value="${article.articleId}" class="admin-article-id">
                                <a href="<c:url value="/admin/article/edit?articleId=${article.articleId}"/>"
                                   class="admin-article-action">编辑</a>
                                <a href="#" class="/admin-article-action admin-article-action-delete">删除</a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
        <script>
        </script>
    </jsp:body>
</template:admin>