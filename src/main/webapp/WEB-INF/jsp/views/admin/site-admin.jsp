<%--@elvariable id="site" type="me.cizezsy.domain.Site"--%>
<template:admin title="站点管理" breadcrumpItems="${['仪表盘', '站点管理']}">
    <script src="<c:url value="/js/custom/site-admin.js"/>"></script>
    <div class="container">
        <div class="row">
            <form class="col s12" method="post" action="<c:url value="/admin/site"/>">
                <div class="row">
                    <div class="input-field col s6">
                        <input id="site-name" type="text" class="validate" minlength="1" maxlength="32" value="${site.siteName}">
                        <label for="site-name">站点名</label>
                    </div>
                    <div class="input-field col s6">
                        <input id="site-motto" type="text" class="validate" minlength="1" maxlength="32" value="${site.siteMotto}">
                        <label for="site-motto">站点Motto</label>
                    </div>
                </div>
                <div class="row">
                    <div class="input-field col s12">
                        <textarea id="site-long-motto" minlength="1" class="materialize-textarea">${site.siteLongMotto}</textarea>
                        <label for="site-long-motto">底部motto</label>
                    </div>
                </div>
                <div class="row">
                    <div class="input-field col s6">
                        <input id="site-bg" type="text" class="validate" minlength="1" maxlength="32" value="${site.siteBg}">
                        <label for="site-bg">首页背景图片链接</label>
                    </div>
                </div>
                <a class="btn waves-effect red lighten-1 waves-green admin-site-submit">
                    提交
                </a>
            </form>
        </div>
    </div>
</template:admin>