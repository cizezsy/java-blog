<link rel="stylesheet" href="<c:url value="/css/markdown-editor.css"/>">
<div id="markdown" class="row" style="display: none">
    <div id="markdown-editor" class="col s6">
        <div class="row valign-wrapper z-depth-2 red lighten-2" id="markdown-editor-tool-bar">
            <img src="<c:url value="/image/ic_full_screen.png"/>" style="display: none"/>
            <img src="<c:url value="/image/ic_minimize.png"/>" class="right">
        </div>
        <textarea id="markdown-editor-textarea" title="markdown-editor-textarea">
                    </textarea>
    </div>
    <div id="markdown-preview" class="col m6"></div>
</div>
<script src="<c:url value="/js/showdown.min.js"/>"></script>
<script async="async">
    $(document).ready(function () {
            var converter = new showdown.Converter();
            var preview = $("#markdown-preview");
            var editor = $("#markdown-editor-textarea");

            editor.val("");
            editor.bind('input propertychange', function () {
                var html = converter.makeHtml($(this)[0].value);
                preview.html(html);
            })
        }
    );

</script>