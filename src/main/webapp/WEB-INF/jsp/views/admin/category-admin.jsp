<%@ page trimDirectiveWhitespaces="true" %>
<%--@elvariable id="categories" type="java.util.List<me.cizezsy.domain.Category>"--%>
<template:admin title="目录管理" breadcrumpItems="${['仪表盘', '目录管理']}">
    <jsp:attribute name="breadcrumpEnd">
        <div class="right">
            <a class="waves-effect waves-light btn modal-trigger" href="#category-edit">添加目录</a>
        </div>
    </jsp:attribute>
    <jsp:body>
        <link href="<c:url value="/css/custom/category-admin.css"/>" type="text/css" rel="stylesheet"/>
        <script src="<c:url value="/js/custom/category-admin.js"/>"></script>

        <div class="container">
            <div class="table z-depth-1 white clearfix">
                <div class="table-header-group grey lighten-1 stripe-bg">
                    <div class="table-cell">
                        <span>目录名</span>
                    </div>
                    <div class="table-cell">
                        <span>描述</span>
                    </div>
                    <div class="table-cell">
                        <span>顺序</span>
                    </div>
                    <div class="table-cell">
                        <span>操作</span>
                    </div>
                </div>
                <div class="table-row-group">
                    <c:forEach items="${categories}" var="category">
                        <div class="table-row">
                            <div class="table-cell admin-category-title">
                                <span>${category.categoryTitle}</span>
                            </div>
                            <div class="table-cell admin-category-desc">
                                <c:choose>
                                    <c:when test="${category.categoryDesc eq '' or category.categoryDesc eq null}">
                                        <span>暂无描述~</span>
                                        <div hidden class="admin-category-desc-real"></div>
                                    </c:when>
                                    <c:otherwise>
                                        <c:choose>
                                            <c:when test="${category.categoryDesc.length() gt 20}">
                                                <span>${category.categoryDesc.substring(0, 18)}...</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span>${category.categoryDesc}</span>
                                            </c:otherwise>
                                        </c:choose>
                                        <div hidden class="admin-category-desc-real">${category.categoryDesc}</div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="table-cell admin-category-order">
                                <span>${category.categoryOrder}</span>
                            </div>
                            <div class="table-cell">
                                <input type="hidden" value="${category.categoryId}" class="admin-category-id">
                                <a href="#" class="admin-category-edit">
                                    修改
                                </a>
                                <a href="#" class="admin-category-delete">
                                    删除
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>

        <div id="category-edit" class="modal">
            <div class="modal-content">
                <h5>目录添加</h5>
                <div class="row">
                    <form class="col s12">
                        <div class="row">
                            <div class="input-field col s12">
                                <input id="category-title" type="text" class="validate" maxlength="32">
                                <label for="category-title">目录名</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="input-field col s12">
                                <textarea id="category-desc" class="materialize-textarea"></textarea>
                                <label for="category-desc">描述</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="input-field col s12">
                                <input id="category-order" type="number" class="validate" maxlength="11" minlength="1">
                                <label for="category-order">顺序</label>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="modal-footer">
                <a href="#" class="modal-action waves-effect waves-green btn-flat" id="category-edit-confirm">确定</a>
                <a href="#" class="modal-action modal-close waves-effect waves-green btn-flat">取消</a>
            </div>
        </div>
    </jsp:body>
</template:admin>