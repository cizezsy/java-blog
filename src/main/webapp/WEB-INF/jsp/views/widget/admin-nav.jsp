<script>
    $(document).ready(function () {
        var index = $(".side-nav a:contains(" + $(".admin-header div h4").text() + ")").toggleClass("red lighten-2 white-text").parents(".collapsible > li").index();
        $(".collapsible").collapsible("open", index);
    })
</script>
<style>
    .no-hover {
        pointer-events: none;
    }

    .driver-panel {
        font-size: 18px !important;
        text-align: center;
        letter-spacing: 2px;
    }
</style>
<ul id="side-out" class="side-nav fixed z-depth-2">
    <li>
        <a href="javascript:void(0)" class="white-text red lighten-2 stripe-bg z-depth-1 driver-panel no-hover">仪表盘</a>
    </li>
    <li class="no-padding">
        <ul class="collapsible">
            <li style="font-weight: bold">
                <a class="waves-effect collapsible-header">文章管理</a>
                <div class="collapsible-body">
                    <ul>
                        <li><a href="<c:url value="/admin/article"/>">文章列表</a></li>
                        <li><a href="<c:url value="/admin/article/edit"/>">文章编辑</a></li>
                    </ul>
                </div>
            </li>
            <li style="font-weight: bold">
                <a class="waves-effect collapsible-header">用户管理</a>
                <div class="collapsible-body"></div>
            </li>
            <li style="font-weight: bold">
                <a class="waves-effect collapsible-header">评论管理</a>
                <div class="collapsible-body"></div>
            </li>
            <li style="font-weight: bold">
                <a class="waves-effect collapsible-header">菜单管理</a>
                <div class="collapsible-body"></div>
            </li>
        </ul>
    </li>
</ul>