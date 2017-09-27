<template:main htmlTitle="没有找到你想要的页面哦">
    <jsp:attribute name="nav">
    </jsp:attribute>
    <jsp:attribute name="footer">
    </jsp:attribute>
    <jsp:body>

        <style>
            main {
                padding-left: 0 !important;
            }

            .card-404-parent {
                height: 100vh;
            }

            .card-404 {
                width: 300px;
                height: 200px;
                margin: 0 auto;
                margin-top: -60px;
            }

            .card-404 span {
                font-size: 32px;
                margin: 0 auto;
            }

            .card-404-tool {
                padding: 8px;
            }

            .card-404-tool {
                cursor: pointer;
            }
        </style>
        <script>
            $(document).ready(function () {
                    $(".card-404-tool").click(function () {
                        window.location.href = "/home"
                    })
                }
            )
        </script>
        <div class="card-404-parent teal lighten-3 valign-wrapper stripe-bg ">
            <div class="card-panel teal hoverable card-404-tool">
                <i class="material-icons white-text" id="back">home</i>
            </div>
            <div class="card-panel card-404 valign-wrapper teal hoverable">
                <div>
                    <span class="white-text">404</span><br>
                    <span class="white-text">NOT FOUND</span>
                </div>
            </div>
        </div>
    </jsp:body>
</template:main>
