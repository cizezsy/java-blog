<template:admin title="文章编辑"
                breadcrumpItems="${['仪表盘','文章管理','文章编辑']}"><%--@elvariable id="article" type="me.cizezsy.domain.Article"--%>
    <script src="http://libs.cdnjs.net/showdown/1.8.0/showdown.min.js"></script>
    <script src="http://libs.cdnjs.net/highlight.js/9.9.0/highlight.min.js"></script>
    <script async="async">

        $(document).ready(function () {
            $('.fixed-action-btn').floatingActionButton();
            $('.tooltipped').tooltip();

            var converter = new showdown.Converter();
            var preview = $("#markdown-preview");
            var editorArea = $("#markdown-editor-textarea");
            var markdownDiv = $("#markdown");
            var markdownEditorDiv = $("#markdown-editor");
            var editorAreaModal = $('#markdown-editor-textarea-modal');
            var previewModal = $("#markdown-preview-modal");

            converter.setOption("headerLevelStart", 3);
            converter.setOption("strikethrough", true);
            converter.setOption("tables", true);
            converter.setOption("ghCodeBlocks ", true);
            converter.setOption("customizedHeaderId", true);
            converter.setOption("simpleLineBreaks", true);


            function heightAdapt() {
                markdownDiv.height($(window).height() - markdownDiv.offset().top - 10);
                markdownEditorDiv.height($(window).height() - markdownEditorDiv.offset().top - 10);
            }

            $('#modal1').modal({
                dismissible: false,
                startingTop: '2%',
                endingTop: '5%',
                onOpenStart: function () {
                    M.toast({html:'ESC键退出', displayLength:2000, class:'rounded'});
                    $('html').on("keyup.modals", function (e) {
                        if (e.keyCode !== 27) {
                            return false;
                        }
                        $('#modal1').modal("close");
                        $(this).off("keyup.modals")
                    });
                }
            });

            $("#modal-background-img").modal({

            });

            heightAdapt();

            editorArea.add(editorAreaModal)
                .val($("<div/>").html(editorArea.html()).text()).empty()
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
                    $('pre code').each(function (i, block) {
                        hljs.highlightBlock(block);
                    });
                }).trigger("input");

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

            $(".chip .tag").on('input', resizeInput)
                .each(resizeInput);

            function clipTagClick() {
                var parent = $(this).parent();
                $(this).remove();
                parent.empty();
                var input = $('<input>').attr("type", "text").attr("maxLength", 32).attr("placeholder", "标签名")
                    .addClass("tag")
                    .on('input', resizeInput).each(resizeInput)
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
                var articleBgUrl = $("#article-background-img").val();
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
                            'articleRawContent': articleRawContent,
                            'articleBgUrl':articleBgUrl
                        },
                        success: submitResult,
                        error: function () {
                            M.toast({html:'保存失败', displayLength:2000, class:'rounded'});
                        }
                    }
                )
            });

            function submitResult(result) {
                if (result.status === 200) {
                    $("#article-id").val(result.message);
                    M.toast({html:'保存成功', displayLength:2000, class:'rounded'});
                } else {
                    M.toast({html:'保存成功', displayLength:2000, class:'rounded'});

                    M.toast(result.message, 2000, 'rounded');
                }
            }
        });
    </script>
    <link rel="stylesheet" href="<c:url value="/css/markdown-editor.css"/>">
    <div class="container">
        <div class="input-field col s12">
            <input id="article-id" type="hidden" name="article-id" value="${article.articleId}">
            <input id="article-title-input" placeholder="标题" type="text" value="${article.articleTitle}">
        </div>
        <div class="flex-container" style="margin-bottom: 4px">
            <c:if test="${fn:length(article.tagList) gt 0}">
                <c:forEach items="${article.tagList}" var="tag">
                    <div class="chip">
                        <input type="text" maxlength="32" placeholder="标签名" class="tag" value="${tag.tagName}">
                    </div>
                </c:forEach>
            </c:if>
            <div class="chip">
                添加标签
                <i class="icon material-icons">add</i>
            </div>
        </div>
    </div>
    <div id="markdown" class="markdown container row scale-transition">
        <div id="markdown-editor" class="markdown-editor col s6">
            <textarea id="markdown-editor-textarea" class="markdown-editor-textarea" title="markdown-editor-textarea"
                      placeholder="请输入markdown">${cf:htmlUnescape(article.articleRawContent)}</textarea>
        </div>
        <div id="markdown-preview" class="markdown-preview col s6">${article.articleContent}</div>
    </div>

    <div class="fixed-action-btn">
        <a class="btn-floating btn-large waves-effect waves-light red">
            <i class="material-icons">menu</i>
        </a>
        <ul>
            <li>
                <a class="btn-floating green tooltipped modal-trigger" data-position="left" href="#modal-background-img"
                   data-delay="50" data-tooltip="背景图片"><i class="material-icons" id="bg-img">image</i></a>
            </li>
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
            <div id="markdown-preview-modal" class="markdown-preview col s6"></div>
        </div>
    </div>

    <div id="modal-background-img" class="modal">
        <div class="modal-content">
            <p>请输入图片地址</p>
            <div class="input-field col s6">
                <input placeholder="URL" id="article-background-img" type="text" class="validate" maxlength="512" value="${article.articleBgUrl}">
                <label for="article-background-img"></label>
            </div>
        </div>
        <div class="modal-footer">
            <a href="javascript:void(0)" class="modal-action modal-close waves-effect waves-green btn-flat" id="background-img-confirm">确定</a>
        </div>
    </div>
</template:admin>