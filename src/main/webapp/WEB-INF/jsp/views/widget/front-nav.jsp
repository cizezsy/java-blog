<script src="http://libs.cdnjs.net/particles.js/2.0.0/particles.js"></script>
<style>
    #side-out {
        display: flex;
        flex-wrap: wrap;
    }

    #particles-js {
        width: 100%;
    }

    canvas {
        display: block;
        position: fixed;
        z-index: -1;
    }

    #side-out ul {
        position: absolute;
        width: 100%;
    }

    #side-out ul {
        text-align: center;
    }

    .sidenav-header {
        text-align: center;
    }

    .sidenav-footer {
        width: 100%;
        display: -webkit-flex;
        display: flex;
        flex-wrap: nowrap;
        justify-content: center;
        align-items: center;
        margin-bottom: 10px;
    }

    .sidenav .sidenav-footer > a {
        padding: 0 10px;
    }

    .sidenav .sidenav-footer > a img {
        width: 75%;
        height: 75%;
    }

    .sidenav-footer {
        align-self: flex-end;
    }


</style>
<div id="side-out" class="sidenav sidenav-fixed z-depth-2">
    <div id="particles-js">
        <div class="sidenav-header">
            <h4>CIZEZSY</h4>
        </div>
        <ul>
            <li><a class="subheader">Category</a></li>
            <%--@elvariable id="categoryList" type="java.util.List<me.cizezsy.domain.Category>"--%>
            <c:forEach items="${categoryList}" var="category" end="6">
                <li><a class="waves-effect"
                       href="<c:url value="/home?categoryId=${category.categoryId}"/>">${category.categoryTitle}</a>
                </li>
            </c:forEach>
            <li><a class="subheader">近期发布</a></li>
        </ul>
    </div>
    <div class="sidenav-footer">
        <a href="https://github.com/cizezsy"><img src="<c:url value="/image/github.svg"/>"/></a>
        <a href="https://www.zhihu.com/people/zheng-shen-yu-14"><img src="<c:url value="/image/zhihu.svg"/>"/></a>
        <a href="https://www.douban.com/people/137907636/"><img src="<c:url value="/image/douban.svg"/>"/></a>
        <a href="mailto:zsy19980307@gmail.com"><img src="<c:url value="/image/gmail.svg"/>"/></a>
    </div>
</div>

