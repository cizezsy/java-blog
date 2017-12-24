$(document).ready(function () {
    $("#site-long-motto").trigger("autoresize");
    Materialize.updateTextFields();

    $(".admin-site-submit").click(function () {
        var siteName = $("#site-name").val();
        var siteMotto = $("#site-motto").val();
        var siteLongMotto = $("#site-long-motto").html();
        var siteBg = $("#site-bg").val();

        $.post({
            method: 'post',
            url: '/admin/site',
            data: {"siteName": siteName, "siteMotto": siteMotto, "siteLongMotto": siteLongMotto, "siteBg": siteBg},
            dataType: 'text',
            success: function (data) {
                data = JSON.parse(data);
                if (data.status === 200) {
                    Materialize.toast(data.message, 2000);
                } else {
                    Materialize.toast(data.message, 2000);
                }
            },
            error: function () {
                Materialize.toast("提交失败", 2000);
            }
        })
    });
});