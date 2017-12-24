$(document).ready(function () {

    $(document).ready(function () {
        $('.modal').modal({
            complete: function () {
                clearModal();
                $("#category-edit-confirm").unbind("click").click(submitCategory)
            }
        });
    });

    var fadeTime = 1000;
    $(".table-row").hover(function () {
        $(this).addClass("table-hover");
    }, function () {
        $(this).removeClass("table-hover");
    }).hide().each(function () {
        $(this).fadeIn(fadeTime);
        fadeTime += 1000;
    });

    function createEditableText(ele) {
        var width = ele.parent().outerWidth();
        var text = ele.html();
        var editableText = $("<input />", {
            "css": {
                "margin": 0,
                "padding": 0,
                "max-width": width
            }
        });
        editableText.val(text);
        ele.replaceWith(editableText);
        editableText.focus();
        return editableText;
    }

    function categoryTitleClick() {
        var editableText = createEditableText($(this));
        var origin = editableText.val();

        editableText.blur(function () {
                var changedTitle = $(this).val();
                if (changedTitle.length > 32) {
                    Materialize.toast("目录名应小于32个字符", 2000);
                } else {
                    var viewableText = $("<span>");
                    if (changedTitle.length === 0) {
                        Materialize.toast("目录名不可为空", 2000);
                        changedTitle = origin;
                    }
                    if (changedTitle !== origin) {
                        var categoryId = $(this).parents(".table-row").find(".admin-category-id").val();
                        $.post({
                            method: 'post',
                            url: '/admin/category',
                            data: {'categoryId': categoryId, 'categoryTitle': changedTitle},
                            dataType: 'text',
                            success: function (data) {
                                data = JSON.parse(data);
                                if (data.status === 200) {
                                    Materialize.toast(data.message, 2000);
                                } else {
                                    viewableText.html(origin);
                                    Materialize.toast(data.message, 2000);
                                }
                            },
                            error: function () {
                                viewableText.html(origin);
                                Materialize.toast("修改失败", 2000);
                            }
                        })
                    }
                    viewableText.html(changedTitle);
                    $(this).replaceWith(viewableText);
                    $(viewableText).click(categoryTitleClick);
                }
            }
        );
    }

    function categoryOrderClick() {
        var editableText = createEditableText($(this));
        var origin = editableText.val();

        editableText.blur(function () {
                var changedOrder = $(this).val();
                if (!$.isNumeric(changedOrder)) {
                    Materialize.toast("请输入数字", 2000);
                    return;
                }

                if (changedOrder > 1024) {
                    Materialize.toast("order值应小于1024", 2000);
                } else {
                    var viewableText = $("<span>");
                    if (changedOrder.length === 0) {
                        Materialize.toast("order值不可为空", 2000);
                        changedOrder = origin;
                    }
                    if (changedOrder !== origin) {
                        var categoryId = $(this).parents(".table-row").find(".admin-category-id").val();
                        $.post({
                            method: 'post',
                            url: '/admin/category',
                            data: {'categoryId': categoryId, 'categoryOrder': changedOrder},
                            dataType: 'text',
                            success: function (data) {
                                data = JSON.parse(data);
                                if (data.status === 200) {
                                    Materialize.toast(data.message, 2000);
                                } else {
                                    viewableText.html(origin);
                                    Materialize.toast(data.message, 2000);
                                }
                            },
                            error: function () {
                                viewableText.html(origin);
                                Materialize.toast("修改失败", 2000);
                            }
                        })
                    }
                    viewableText.html(changedOrder);
                    $(this).replaceWith(viewableText);
                    $(viewableText).click(categoryOrderClick);
                }
            }
        );
    }

    function clearModal() {
        $("#category-title").val("");
        $("#category-desc").val("");
        $("#category-desc").trigger("autoresize");
        $("#category-order").val("");
        Materialize.updateTextFields();
    }

    function submitCategory(categoryId, ele) {
        var title = $("#category-title").val();
        if (title === "") {
            Materialize.toast("目录名不能为空", 2000);
            return;
        }
        var desc = $("#category-desc").val();
        var order = $("#category-order").val();
        if (!$.isNumeric(order)) {
            Materialize.toast("顺序必须是数字", 2000);
            return;
        }
        if (!categoryId) {
            categoryId = "new";
        }
        var excerpt;
        if (desc === "") {
            excerpt = "暂无描述~";
        } else if (desc.length > 20) {
            excerpt = desc.substr(0, 18) + "...";
        } else {
            excerpt = desc;
        }

        $.post({
            method: 'post',
            url: '/admin/category',
            data: {'categoryId': categoryId, 'categoryOrder': order, 'categoryTitle': title, 'categoryDesc': desc},
            dataType: 'text',
            success: function (data) {
                clearModal();
                data = JSON.parse(data);
                if (data.status === 200) {
                    if (categoryId === "new") {
                        var row = $("<div/>", {
                            class: "table-row"
                        }).appendTo(".table-row-group");


                        $("<div/>", {
                            class: "table-cell admin-category-title"
                        }).append("<span>" + title + "</span>").appendTo(row);


                        $("<div/>", {
                            class: "table-cell admin-category-desc"
                        }).append("<span>" + excerpt + "</span><div hidden class='admin-category-desc-real'>" + desc + "</div>").appendTo(row);

                        $("<div/>", {
                            class: "table-cell admin-category-order"
                        }).append("<span>" + order + "</span>").appendTo(row);

                        $("<div/>", {
                            class: "table-cell"
                        }).html("<input type=\"hidden\" value=\"" + data.message + "\" class=\"admin-category-id\">\n" +
                            "<a href=\"#\" class=\"admin-category-edit\">修改</a>" +
                            "<a href=\"#\" class=\"admin-category-delete\">删除</a>").appendTo(row);

                    } else {
                        ele.find(".admin-category-title span").html(title);
                        ele.find(".admin-category-desc span").html(excerpt);
                        ele.find(".admin-category-desc-real").html(desc);
                        ele.find(".admin-category-order span").html(order);
                    }
                    $('#category-edit').modal('close');
                    Materialize.toast(data.message, 2000);
                } else {
                    Materialize.toast(data.message, 2000);
                }
                $("#category-edit-confirm").unbind("click").click(submitCategory);
            },
            error: function () {
                clearModal();
                $("#category-edit-confirm").unbind("click").click(submitCategory);
                Materialize.toast("提交失败", 2000);
            }
        })
    }

    $(".admin-category-title span").click(categoryTitleClick);

    $(".admin-category-order span").click(categoryOrderClick);

    $("#category-edit-confirm").click(submitCategory);

    $(".admin-category-edit").click(function () {
        var parent = $(this).parents(".table-row");
        var categoryId = parent.find(".admin-category-id").val();
        $("#category-title").val(parent.find(".admin-category-title span").html());
        $("#category-desc").val(parent.find(".admin-category-desc-real").html());
        $("#category-desc").trigger("autoresize");
        $("#category-order").val(parent.find(".admin-category-order span").html());
        Materialize.updateTextFields();
        $("#category-edit").modal("open");

        $("#category-edit-confirm").unbind("click").click(function () {
            submitCategory(categoryId, parent)
        });
    });

    $(".admin-category-delete").click(function () {
        var parent = $(this).parents(".table-row");
        var categoryId = parent.find(".admin-category-id").val();

        $.post({
            method: 'post',
            url: '/admin/category/delete',
            data: {"categoryId": categoryId},
            dataType: 'text',
            success: function (data) {
                data = JSON.parse(data);
                if (data.status === 200) {
                    Materialize.toast(data.message, 2000);
                    parent.remove();
                } else {
                    Materialize.toast(data.message, 2000);
                }
            },
            error:function () {
                Materialize.toast("提交失败", 2000);
            }
        })
    })
});