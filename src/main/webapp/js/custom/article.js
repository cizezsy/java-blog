$(document).ready(function () {

    $('.scrollspy').scrollSpy();

    var set = false;
    var width = $('#pin-scroll').width();
    $(window).scroll(function () {
        var scrollTop = $(window).scrollTop();
        var scrollSpyNav = $('#pin-scroll');
        if (scrollTop < 400) {
            if (!set) {
                set = true;
            }
            scrollSpyNav.removeClass("pinned");
            return;
        }
        if (scrollTop + 42 >= scrollSpyNav.offset().top) {
            if (set) {
                scrollSpyNav.width(width);
                set = false;
            }
            scrollSpyNav.addClass('pinned');
        }
    });

    $(".article-content h5").each(function () {
        var ele = $(this);
        var idValue = ele.attr("id");
        $("<li/>").append($("<a>", {
            href: "#" + idValue,
            text: ele.text()
        })).appendTo("#scroll-spy-ul")
    });
    $(".article-content h5").scrollSpy();
})