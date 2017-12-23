$(document).ready(function () {

    $('select').material_select();


    $('.datepicker').pickadate({
        selectMonths: true, // Creates a dropdown to control month
        selectYears: 15, // Creates a dropdown of 15 years to control year,
        today: '今天',
        clear: '清除',
        close: '确定',
        closeOnSelect: false // Close upon selecting a date,
    });

    $(".add-article").click(function () {
        location.href = "/admin/article/edit";
    });

    $('.create-category-div').hide();


    $(".admin-article-action-publish").click(function () {
        var ele = $(this);
        var articleId = ele.parent().children(".admin-article-id").val();
        $.ajax({
            method: 'post',
            url: '/admin/article',
            data: {'articleId': articleId, 'action': 'publish'},
            success: function (data) {
                data = JSON.parse(data);
                if (data.status === 200) {
                    Materialize.toast(data.message, 2000);
                    ele.text(ele.text().trim() === "公布" ? "隐藏" : "公布")
                } else {
                    Materialize.toast(data.message, 2000);
                }
            },
            error: function () {
                Materialize.toast("设置失败", 2000);
            }
        });
    });

    $('.admin-article-action-top').click(function () {
        var ele = $(this);
        var articleId = ele.parent().children(".admin-article-id").val();
        $.post({
            method: 'post',
            url: '/admin/article',
            data: {'articleId': articleId, 'action': 'top'},
            dataType: 'text',
            success: function (data) {
                data = JSON.parse(data);
                if (data.status === 200) {
                    Materialize.toast(data.message, 2000);
                    ele.text(ele.text().trim() === "置顶" ? "取消置顶" : "置顶")
                } else {
                    Materialize.toast(data.message, 2000);
                }
            },
            error: function () {
                Materialize.toast("设置失败", 2000)
            }
        });
    });

    $(".admin-article-action-delete").click(function () {
        var ele = $(this);
        var articleId = ele.parent().children(".admin-article-id").val();
        $.post({
            method: 'post',
            url: '/admin/article',
            data: {'articleId': articleId, 'action': 'delete'},
            dataType: 'text',
            success: function (data) {
                data = JSON.parse(data);
                if (data.status === 200) {
                    Materialize.toast(data.message, 2000);
                    ele.parent().parent().remove();
                } else {
                    Materialize.toast(data.message, 2000);
                }
            },
            error: function () {
                Materialize.toast("删除失败", 2000)
            }
        })
    });

    $('.table-cell-category').hover(function () {
        $('.table-cell-create-category').show();
    }, function () {
        if ($('.create-category-div').is(":hidden"))
            $('.table-cell-create-category').hide();
    });

    $('.table-cell-category').click(function (event) {
        event.stopImmediatePropagation()
    });

    $('.table-cell-create-category').click(function () {
        var createCategory = $('.create-category-div');
        if (createCategory.is(":hidden")) {
            createCategory.show();
            $('.table-cell-create-category').text("确定");
        } else {
            var categoryName = $('.create-category-input').val();
            $.post({
                method: 'post',
                url: '/admin/article',
                data: {'categoryName': categoryName},
                dataType: 'text',
                success: function (data) {
                    data = JSON.parse(data);
                    if (data.status === 200) {
                        //TODO add new category to category List
                        Materialize.toast("创建成功", 2000);
                    } else {
                        Materialize.toast(data.message, 2000);
                    }
                },
                error: function () {
                    Materialize.toast("删除失败", 2000)
                }
            });
            createCategory.hide();
            $('.create-category-input').val("");
            $('.table-cell-create-category').text("创建");
        }
    });

    $(document).bind("click", function () {
        $('.create-category-div').hide();
        $('.table-cell-create-category').hide();
        $('.create-category-input').val("");
        $('.table-cell-create-category').text("创建");
    });

    $(".table-row .select-dropdown li").click(function () {
        var ele = $(this);
        var categoryName = ele.find("span").text();
        var articleId = ele.parents(".table-row").find(".admin-article-id").val();
        var categoryId = null;
        $(".article-category-select").find("option").each(function () {
            var t = $(this).text();
            if (t === categoryName) {
                categoryId = $(this).val();
            }
        });
        if (categoryId) {
            $.post({
                method: 'post',
                url: '/admin/article',
                data: {'articleId': articleId, 'categoryId': categoryId},
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
                    Materialize.toast("更改目录失败", 2000)
                }
            });
        }
    });

    $(".article-filter-btn").click(function () {

    })
});