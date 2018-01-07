<%@tag body-content="scriptless" dynamic-attributes="dynamicAttributes" trimDirectiveWhitespaces="true"
       pageEncoding="utf-8" %>
<%@attribute name="htmlTitle" type="java.lang.String" rtexprvalue="true" required="true" %>
<%@attribute name="userViewBackgroundUrl" type="java.lang.String" rtexprvalue="true" required="false" %>
<%@ attribute name="nav" fragment="true" required="true" %>
<%@ attribute name="footer" fragment="true" required="true" %>
<%@ include file="/WEB-INF/jsp/base.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <%@ include file="/WEB-INF/jsp/component/default-css-and-js.jsp" %>
    <link rel="icon" href="<c:url value="/image/favicon.png"/>">
    <title><c:out value="${htmlTitle}"/></title>
</head>
<body class="color-scheme-lighten">
<header>
    <jsp:invoke fragment="nav"/>
</header>
<main>
    <jsp:doBody/>
    <jsp:invoke fragment="footer"/>
</main>
</body>
</html>