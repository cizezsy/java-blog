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


    $(".admin-article-action-is-publish-box").change(function () {
        var ele = $(this);
        var articleId = ele.parents(".table-row").find(".admin-article-id").val();
        $.post({
            method: 'post',
            url: '/admin/article',
            data: {'articleId': articleId, 'action': 'publish'},
            dataType: 'text',
            success: function (data) {
                data = JSON.parse(data);
                if (data.status === 200) {
                    Materialize.toast(data.message, 2000);
                    var b = ele.find(".admin-article-action-is-top-box");
                    b.checked = !b.checked;
                } else {
                    Materialize.toast(data.message, 2000);
                }
            },
            error: function () {
                Materialize.toast("设置失败", 2000);
            }
        });
    });

    $('.admin-article-action-is-top-box').change(function () {
        var ele = $(this);
        var articleId = ele.parents(".table-row").find(".admin-article-id").val();
        $.post({
            method: 'post',
            url: '/admin/article',
            data: {'articleId': articleId, 'action': 'top'},
            dataType: 'text',
            success: function (data) {
                data = JSON.parse(data);
                if (data.status === 200) {
                    Materialize.toast(data.message, 2000);
                    var b = ele.find(".admin-article-action-is-top-box");
                    b.checked = !b.checked;
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
        var articleId = ele.parents(".table-row").find(".admin-article-id").val();
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
            if (categoryName.length > 32) {
                Materialize.toast("目录名应小于32个字符", 2000);
            } else if (categoryName.length === 0) {
                Materialize.toast("目录名不可为空", 2000);
            } else {
                $.post({
                    method: 'post',
                    url: '/admin/article',
                    data: {'categoryName': categoryName},
                    dataType: 'text',
                    success: function (data) {
                        data = JSON.parse(data);
                        if (data.status === 200) {
                            //TODO add new category to category List
                            var option = $("<option/>", {
                                value: data.message,
                                class: "red-text lighten-text-2",
                                text: categoryName
                            });

                            $(".article-category-select").material_select("destroy");
                            $(".article-category-select").append(option).material_select();
                            $(".category-filter-select").material_select("destroy");
                            $(".category-filter-select").append(option).material_select();
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
        var start = $("#startDatePicker").val();
        var end = $("#endDatePicker").val();
        if (start === '') {
            start = Date.parse("1970-01-01");
        } else {
            start = Date.parse(start)
        }
        if (end === '') {
            end = Date.now();
        } else {
            end = Date.parse(end);
        }
        var categoryIds = $("#category-filter-select").val();

        var form;
        form = $('<form />', {
            action: "/admin/article",
            method: "get",
            style: 'display: none;'
        });
        $('<input />', {
            type: 'hidden',
            name: "categoryIds",
            value: categoryIds
        }).appendTo(form);
        $('<input />', {
            type: 'hidden',
            name: "start",
            value: start
        }).appendTo(form);
        $('<input />', {
            type: 'hidden',
            name: "end",
            value: end
        }).appendTo(form);

        form.appendTo('body').submit();
    });

    var fadeTime = 1000;
    $(".table-row").hover(function () {
        $(this).addClass("table-hover");
    }, function () {
        $(this).removeClass("table-hover");
    }).hide().each(function () {
        $(this).fadeIn(fadeTime);
        fadeTime += 1000;
    })
});