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

    function componentToHex(c) {
        var hex = Number(c).toString(16);
        return hex.length === 1 ? "0" + hex : hex;
    }
    function rgbToHex(r, g, b) {
        return "" + componentToHex(r) + componentToHex(g) + componentToHex(b);
    }


    function colorInit() {
        var image = $(".color-thief-target")[0];
        var colorThief = new ColorThief();
        if (image) {
            var rgb = colorThief.getColor(image, 10);
            var scheme = new ColorScheme;
            var colors = scheme.from_hex(rgbToHex(rgb[0],rgb[1],rgb[2]))
                .scheme("mono")
                .variation("soft")
                .colors();

            addGlobalCss(".color-scheme-strongest",
                "{background-color:#"+colors[1]+"!important;}");
            addGlobalCss(".color-scheme-strongest-text",
                "{color:#"+colors[1]+"!important;}");
            addGlobalCss(".color-scheme-strong",
                "{background-color:#"+colors[0]+"!important;}");

            addGlobalCss(".color-scheme-strong-text",
                "{color:#"+colors[0]+"!important;}");

            addGlobalCss(".color-scheme-normal",
                "{background-color:#"+colors[3]+"!important;}");

            addGlobalCss(".color-scheme-normal-text",
                "{color:#"+colors[3]+"!important;}");

            addGlobalCss(".color-scheme-light",
                "{background-color:#"+colors[2]+"!important;}");

            addGlobalCss(".color-scheme-light-text",
                "{color:#"+colors[2]+"!important;}");

            addGlobalCss(".table-of-contents a.active, .border-left-main-image-color",
                "{border-left-color: #"+colors[0]+"!important;}");

            $(".table-of-contents a").hover(function () {
                $(this).toggleClass("border-left-main-image-color")
            });
        }
    }

    $(".color-thief-target").one("load", function () {
        colorInit();
    }).each(function () {
        this.complete && $(this).trigger('load');
    });

});