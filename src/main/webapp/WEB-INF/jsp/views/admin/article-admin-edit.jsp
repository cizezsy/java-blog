<template:admin title="文章编辑"
                breadcrumpItems="${['仪表盘','文章管理','文章编辑']}"><%--@elvariable id="article" type="me.cizezsy.domain.Article"--%>
    <script src="<c:url value="/js/showdown.min.js"/>"></script>
    <script async="async">

        $(document).ready(function () {
            var converter = new showdown.Converter();
            var preview = $("#markdown-preview");
            var editorArea = $("#markdown-editor-textarea");
            var markdownDiv = $("#markdown");
            var markdownEditorDiv = $("#markdown-editor");
            var editorAreaModal = $('#markdown-editor-textarea-modal');
            var previewModal = $("#markdown-preview-modal");

            function heightAdapt() {
                markdownDiv.height($(window).height() - markdownDiv.offset().top - 10);
                markdownEditorDiv.height($(window).height() - markdownEditorDiv.offset().top - 10);
            }

            $('.modal').modal({
                dismissible: false,
                startingTop: '2%',
                endingTop: '5%',
                ready: function () {
                    Materialize.toast('ESC键退出', 2000, 'rounded');
                    $('html').on("keyup.modals", function (e) {
                        if (e.keyCode !== 27) {
                            return false;
                        }
                        $('#modal1').modal("close");
                        $(this).off("keyup.modals")
                    });
                }
            });


            heightAdapt();


            $(".markdown-editor-textarea")
                .val("")
                .on('input propertychange', function () {
                    var current = $(this)[0];
                    var value = current.value;

                    if ($(this).is(editorArea))
                        editorAreaModal.val(value);
                    else
                        editorArea.val(value);

                    var html = converter.makeHtml(value);
                    preview.html(html);
                    previewModal.html(html);
                });

            $(window).on('resize', function () {
                heightAdapt();
            });

            $('.chip .icon').click(clipTagClick);

            function resizeInput() {
                var inputWidth = $(this).textWidth();
                $(this).width(inputWidth);
            }

            $.fn.textWidth = function (text, font) {
                if (!$.fn.textWidth.fakeEl)
                    $.fn.textWidth.fakeEl = $('<span>').hide().appendTo(document.body);
                $.fn.textWidth.fakeEl.text(text || this.val() || this.text() || this.attr('placeholder')).css('font', font || this.css('font'));
                return $.fn.textWidth.fakeEl.width();
            };

            function clipTagClick() {
                var parent = $(this).parent();
                $(this).remove();
                parent.empty();
                var input = $('<input>')
                    .attr("type", "text")
                    .attr("maxLength", 32)
                    .attr("placeholder", "标签名")
                    .addClass("tag")
                    .on('input', resizeInput)
                    .each(resizeInput)
                    .focusout(function () {
                        var addIcon = $(".chip .icon");
                        if ($(this).val().length === 0) {
                            $(this).remove();
                            if (addIcon.length === 0) {
                                parent.append("添加标签 <i class=\"icon material-icons\">add</i>");
                            } else {
                                parent.remove()
                            }
                        } else {
                            if (addIcon.length === 0) {
                                parent.parent().append('<div class="chip">添加标签 <i class="icon material-icons">add</i></div>')
                            }
                        }
                        $('.chip .icon').click(clipTagClick);
                    });
                parent.append(input);
                input.focus();
            }

            $("#publish").click(function () {
                var articleTitle = $("#article-title-input").val();
                var articleContent = $("#markdown-preview").html();
                var articleRawContent = $("#markdown-editor-textarea").val();
                var articleId = $("#article-id").val();
                var tag = [];
                $(".chip .tag").each(function () {
                    tag.push($(this).val());
                });
                $.ajax({
                        url: '/admin/article/edit',
                        method: 'post',
                        data: {
                            'articleId': articleId,
                            'articleTitle': articleTitle,
                            'articleContent': articleContent,
                            'tag': tag.join(','),
                            'articleRawContent': articleRawContent
                        },
                        success: submitResult
                    }
                )
            });

            function submitResult(result) {
                var data = JSON.parse(result);
                if (data.status === 200) {
                    $("article-id").val(data.message);
                } else {
                    Materialize.toast(data.message, 2000, 'rounded');
                }
            }
        });
    </script>
    <style>
    </style>
    <link rel="stylesheet" href="<c:url value="/css/markdown-editor.css"/>">
    <div class="container">
        <div class="input-field col s12">
            <input id="article-id" type="hidden" name="article-id" value="${article.articleId}">
            <input id="article-title-input" placeholder="标题" type="text" value="${article.articleTitle}">
        </div>
        <div class="flex-container" style="margin-bottom: 4px">
            <c:choose>
                <c:when test="${fn:length(article.tagList) eq 0}">
                    <div class="chip">
                        添加标签
                        <i class="icon material-icons">add</i>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${article.tagList}" var="tag">
                        <div class="chip">
                            <input type="text" maxlength="32" placeholder="标签名" class="tag" value="${tag.tagName}">
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    <div id="markdown" class="markdown container row scale-transition">
        <div id="markdown-editor" class="markdown-editor col s6">
            <textarea id="markdown-editor-textarea" class="markdown-editor-textarea" title="markdown-editor-textarea"
                      placeholder="请输入markdown">
                    ${article.articleRawContent}
            </textarea>
        </div>
        <div id="markdown-preview" class="markdown-preview col m6">${article.articleContent}</div>
    </div>

    <div class="fixed-action-btn">
        <a class="btn-floating btn-large waves-effect waves-light red">
            <i class="material-icons">menu</i>
        </a>
        <ul>

            <li>
                <a class="btn-floating blue modal-trigger tooltipped" href="#modal1" data-position="left"
                   data-delay="50" data-tooltip="全屏编辑">
                    <i class="material-icons" id="fullscreen">fullscreen</i></a>
            </li>
            <li>
                <a class="btn-floating green tooltipped" data-position="left"
                   data-delay="50" data-tooltip="提交"><i class="material-icons" id="publish">publish</i></a>
            </li>
        </ul>
    </div>

    <div id="modal1" class="modal">
        <div id="markdown-modal" class="markdown row scale-transition">
            <div id="markdown-editor-modal" class="markdown-editor col s6">
            <textarea id="markdown-editor-textarea-modal" class="markdown-editor-textarea"
                      title="markdown-editor-textarea"
                      placeholder="请输入markdown">
            </textarea>
            </div>
            <div id="markdown-preview-modal" class="markdown-preview col m6"></div>
        </div>
    </div>
</template:admin>