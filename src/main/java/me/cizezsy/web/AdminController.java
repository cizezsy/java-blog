package me.cizezsy.web;

import me.cizezsy.domain.Article;
import me.cizezsy.domain.JsonMessage;
import me.cizezsy.domain.User;
import me.cizezsy.exception.ArticleException;
import me.cizezsy.service.ArticleService;
import me.cizezsy.service.TagService;
import me.cizezsy.service.UserService;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/admin")
public class AdminController {

    private ArticleService articleService;
    private TagService tagService;
    private UserService userService;
    private Logger logger = LoggerFactory.getLogger(AdminController.class);

    @RequestMapping(value = "/article", method = RequestMethod.GET)
    public String article(Article article, Model model) {
        List<Article> articles = articleService
                .findArticleList(article)
                .stream()
                .sorted()
                .collect(Collectors.toList());
        model.addAttribute("articles", articles);
        return "admin/article-admin";
    }

    @RequestMapping(value = "/article/edit", method = RequestMethod.GET)
    public String articleEdit() {
        return "admin/article-admin-edit";
    }

    @RequestMapping(value = "/article/edit", method = RequestMethod.GET, params = {"articleId"})
    public String articleEdit(String articleId, Article article, Model model) {
        article.setArticleId(UUID.fromString(articleId));
        try {
            article = articleService.findArticle(article);
            model.addAttribute("article", article);
            return "admin/article-admin-edit";
        } catch (ArticleException e) {
            return "error/404";
        }
    }

    @RequestMapping(value = "/article/edit",
            method = RequestMethod.POST,
            params = {"articleId", "articleTitle", "articleContent", "tag", "articleRawContent"})
    public JsonMessage articlePost(@RequestParam(name = "articleId") String articleId,
                                   @RequestParam(name = "articleTitle") String articleTitle,
                                   @RequestParam(name = "articleContent") String articleContent,
                                   @RequestParam(name = "tag") String tag,
                                   @RequestParam(name = "articleRawContent") String articleRawContent, Article article) {
        if (!StringUtils.isEmpty(articleId)) {
            article.setArticleId(UUID.fromString(articleId));
            try {
                article = articleService.findArticle(article);
            } catch (ArticleException e) {
                logger.warn(e.getMessage());
                return new JsonMessage(JsonMessage.STATUS_ERROR, e.getMessage());
            }
        }
        article.setArticleTitle(articleTitle);
        article.setArticleContent(articleContent);
        article.setArticleRawContent(articleRawContent);
        article.setTagList(tagService.mapToTag(tag));
        //调试
        User user = userService.findAllUser().get(0);
        article.setUser(user);
        articleService.saveArticle(article);
        return new JsonMessage(JsonMessage.STATUS_OK, article.getArticleId().toString());
    }

    @Autowired
    public void setArticleService(ArticleService articleService) {
        this.articleService = articleService;
    }

    @Autowired
    public void setTagService(TagService tagService) {
        this.tagService = tagService;
    }

    @Autowired
    public void setUserService(UserService userService) {
        this.userService = userService;
    }
}
