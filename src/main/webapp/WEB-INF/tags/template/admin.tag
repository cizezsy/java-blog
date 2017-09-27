<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/template" %>
<%@tag body-content="scriptless" dynamic-attributes="dynamicAttributes" trimDirectiveWhitespaces="true"
       pageEncoding="utf-8" %>
<%@attribute name="title" required="true" %>
<%@attribute name="breadcrumpItems" type="java.util.List<java.lang.String>" required="true" %>
<%@attribute name="breadcrumpEnd" fragment="true" required="false" %>
<template:main htmlTitle="${title}">
    <jsp:attribute name="nav">
        <%@include file="/WEB-INF/jsp/views/widget/admin-nav.jsp" %>
    </jsp:attribute>
    <jsp:attribute name="footer">
    </jsp:attribute>
    <jsp:body>

        <div class="admin-header red lighten-2 stripe-bg valign-wrapper z-depth-2">
            <div class="container valign-wrapper">
                <h4 class="white-text">${title}</h4>
            </div>
        </div>

        <nav class="nav container z-depth-0 admin-nav">
            <div class="nav-wrapper">
                <div class="col s10">
                    <c:forEach items="${breadcrumpItems}" var="breadcrump">
                        <a href="#" class="breadcrumb red-text text-lighten-2">${breadcrump}</a>
                    </c:forEach>
                    <jsp:invoke fragment="breadcrumpEnd"/>
                </div>
            </div>
        </nav>
        <jsp:doBody/>
    </jsp:body>
</template:main>
