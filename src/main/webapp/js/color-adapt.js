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
    btnCps.sidenav();
    btnCps.show();

    function componentToHex(c) {
        var hex = Number(c).toString(16);
        return hex.length === 1 ? "0" + hex : hex;
    }
    function rgbToHex(r, g, b) {
        return "" + componentToHex(r) + componentToHex(g) + componentToHex(b);
    }


    var src = $("main").css("background-image");
    var url = src.match(/\((.*?)\)/)[1].replace(/('|")/g,'');
    var img = new Image();
    img.onload = function (ev) {
        colorInit(img);
    };
    img.src = url;
    if(img.complete) img.onload();

    function colorInit(image) {

        //var image = $(".color-thief-target")[0];
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

            particlesJS("particles-js", {
                "particles": {
                    "number": {
                        "value": 380,
                        "density": {
                            "enable": true,
                            "value_area": 800
                        }
                    },
                    "color": {
                        "value": "#"+colors[1]
                    },
                    "shape": {
                        "type": "circle",
                        "stroke": {
                            "width": 0,
                            "color": "#"+colors[1]
                        },
                        "polygon": {
                            "nb_sides": 5
                        },
                        "image": {
                            "src": "img/github.svg",
                            "width": 100,
                            "height": 100
                        }
                    },
                    "opacity": {
                        "value": 0.3,
                        "random": false,
                        "anim": {
                            "enable": false,
                            "speed": 1,
                            "opacity_min": 0.1,
                            "sync": false
                        }
                    },
                    "size": {
                        "value": 4,
                        "random": true,
                        "anim": {
                            "enable": false,
                            "speed": 40,
                            "size_min": 0.1,
                            "sync": false
                        }
                    },
                    "line_linked": {
                        "enable": true,
                        "distance": 150,
                        "color": "#"+colors[1],
                        "opacity": 0.1,
                        "width": 2
                    },
                    "move": {
                        "enable": true,
                        "speed": 2,
                        "direction": "none",
                        "random": false,
                        "straight": false,
                        "out_mode": "out",
                        "bounce": false,
                        "attract": {
                            "enable": false,
                            "rotateX": 600,
                            "rotateY": 1200
                        }
                    }
                },
                "interactivity": {
                    "detect_on": "canvas",
                    "events": {
                        "onhover": {
                            "enable": true,
                            "mode": "grab"
                        },
                        "onclick": {
                            "enable": true,
                            "mode": "push"
                        },
                        "resize": true
                    },
                    "modes": {
                        "grab": {
                            "distance": 140,
                            "line_linked": {
                                "opacity": 1
                            }
                        },
                        "bubble": {
                            "distance": 400,
                            "size": 40,
                            "duration": 2,
                            "opacity": 8,
                            "speed": 3
                        },
                        "repulse": {
                            "distance": 200,
                            "duration": 0.4
                        },
                        "push": {
                            "particles_nb": 4
                        },
                        "remove": {
                            "particles_nb": 2
                        }
                    }
                },
                "retina_detect": true
            });
        }
    }

    // $(".color-thief-target").one("load", function () {
    //     colorInit();
    // }).each(function () {
    //     this.complete && $(this).trigger('load');
    // });

    if (/Edge\/\d./i.test(navigator.userAgent) || /MSIE 9/i.test(navigator.userAgent) || /rv:11.0/i.test(navigator.userAgent)){
        $('body').on("mousewheel", function () {
            event.preventDefault();

            var wheelDelta = event.wheelDelta;

            var currentScrollPosition = window.pageYOffset;
            window.scrollTo(0, currentScrollPosition - wheelDelta);
        });

        $('body').keydown(function (e) {
            e.preventDefault(); // prevent the default action (scroll / move caret)
            var currentScrollPosition = window.pageYOffset;

            switch (e.which) {

                case 38: // up
                    window.scrollTo(0, currentScrollPosition - 120);
                    break;

                case 40: // down
                    window.scrollTo(0, currentScrollPosition + 120);
                    break;

                default: return; // exit this handler for other keys
            }
        });
    }

});