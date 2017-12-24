$(document).ready(function () {
    $(".article-more").hover(function () {
        $(this).toggleClass("color-scheme-strongest-text");
    }, function () {
        $(this).toggleClass("color-scheme-strongest-text");
    }).click(function () {
        var parent = $(this).parents(".article-item-section").find(".color-scheme-strongest-text");
        window.location.href = parent.attr("href")
    })
});