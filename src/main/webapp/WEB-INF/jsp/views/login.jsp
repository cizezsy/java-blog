<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <%@include file="/WEB-INF/jsp/component/default-css-and-js.jsp" %>
    <title>登录</title>
    <style>
        .bcImg {
            background-image: url("/image/426H.jpg");
        }
    </style>
    <script>
        $(document).ready(function () {
            function loginResult(result) {
                var data = JSON.parse(result);
                if (data.status === 200) {
                    location.href = data.message
                } else {
                    var $toastContent = $('<span>' + data.message + '</span>').add($('<button class="btn-flat toast-action toastCancelBtn">确定</button>'));
                    Materialize.toast($toastContent, 5000);
                    $('.toastCancelBtn').click(function () {
                        var toastElement = $(this).parent()[0];
                        var toastInstance = toastElement.M_Toast;
                        toastInstance.remove();
                    })
                }
            }

            $("#submitBtn").click(function () {
                var userName = $("#userName").val();
                var password = $("#password").val();
                $.ajax({
                        url: '/login',
                        method: 'post',
                        data: {'userName': userName, 'password': password},
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader("X-Ajax-call", true);
                        },
                        dataType: 'text',
                        success: loginResult
                    }
                )
            });

        })
    </script>
</head>
<body>
<div class="row full-height bcImg vertical-center-child">
    <div class="col s4" style="margin-right: auto">
        <div class="card z-depth-2 lighten-2">
            <div class="card-content" style="clear: both">
                <span class="card-title center-align red-text">登录</span>
                <div class="row center-align">
                    <div class="input-field col s10 offset-s1">
                        <input id="userName" name="userName" type="text">
                        <label for="userName">用户名</label>
                    </div>
                </div>
                <div class="row">
                    <div class="input-field col s10 offset-s1">
                        <input id="password" name="password" type="password">
                        <label for="password">密码</label>
                    </div>
                </div>
                <div class="child-right-align">
                    <button id="submitBtn" class="btn waves-effect red lighten-1 waves-green" type="submit">提交
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>