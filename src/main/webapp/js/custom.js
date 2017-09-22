function addGlobalCss(selector, rule) {
    var stylesheet = document.styleSheets[0];
    if (stylesheet.insertRule) {
        stylesheet.insertRule(selector + rule, stylesheet.cssRules.length);
    } else if (stylesheet.addRule) {
        stylesheet.addRule(selector, rule, -1);
    }

}

$(document).ready(function () {

    var btnCps = $('.button-collapse');
    btnCps.sideNav();
    btnCps.show();

    $(".color-thief-target").$(".color-thief-target").ready(function () {
        var image = $(".color-thief-target")[0];
        var colorThief = new ColorThief();
        if (image) {
            var rgb = colorThief.getColor(image);
            var selector = ".table-of-contents a.active",
                rule = "{border-left-color: rgb(" + rgb[0] + "," + rgb[1] + "," + rgb[2] + ") !important;}";
            addGlobalCss(".border-left-main-image-color", rule);
            addGlobalCss(selector, rule);
            addGlobalCss(".imageColor", "{background-color: rgb(" + rgb[0] + "," + rgb[1] + "," + rgb[2] + ") !important;}")
            $(".table-of-contents a").hover(function () {
                $(this).toggleClass("border-left-main-image-color")
            });
        }
    });

});