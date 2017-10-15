package me.cizezsy.web;

import me.cizezsy.domain.Article;
import me.cizezsy.domain.Category;
import me.cizezsy.domain.JsonMessage;
import me.cizezsy.domain.User;
import me.cizezsy.exception.ArticleException;
import me.cizezsy.service.ArticleService;
import me.cizezsy.service.CategoryService;
import me.cizezsy.service.TagService;
import me.cizezsy.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Collections;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/admin")
public class AdminController {
    private ArticleService articleService;
    private TagService tagService;
    private UserService userService;
    private CategoryService categoryService;
    private Logger logger = LoggerFactory.getLogger(AdminController.class);

    @RequestMapping(value = {"/article", "/"}, method = RequestMethod.GET)
    public String article(Model model) {
        List<Article> articles = articleService
                .findAllArticle();
        Collections.sort(articles);
        List<Category> categories = categoryService.findAllCategory();
        model.addAttribute("articles", articles);
        model.addAttribute("categories", categories);
        return "admin/article-admin";
    }

    @RequestMapping(value = "/article", method = RequestMethod.POST, params = {"articleId", "action"})
    public @ResponseBody
    JsonMessage articleAction(@RequestParam("articleId") String articleId, @RequestParam("action") String action) {
        Article article = null;
        try {
            article = articleService.findArticle(UUID.fromString(articleId));
        } catch (ArticleException e) {
            logger.error(e.getMessage());
            return new JsonMessage(JsonMessage.STATUS_ERROR, "设置失败");
        }
        if ("top".equals(action)) {
            article.setTop(!article.isTop());
        } else if ("publish".equals(action)) {
            article.setPublish(!article.isPublish());
        }
        articleService.updateArticle(article);
        return new JsonMessage(JsonMessage.STATUS_OK, "设置成功");
    }

    @RequestMapping(value = "/article/edit", method = RequestMethod.GET)
    public String articleEdit() {
        return "admin/article-admin-edit";
    }

    @RequestMapping(value = "/article/edit", method = RequestMethod.GET, params = {"articleId"})
    public String articleEdit(@RequestParam("articleId") String articleId, Article article, Model model) {
        article.setArticleId(UUID.fromString(articleId));
        try {
            article = articleService.findArticle(article);
            model.addAttribute("article", article);
            return "admin/article-admin-edit";
        } catch (ArticleException e) {
            return "error/404";
        }
    }

    @Transactional
    @RequestMapping(value = "/article/edit",
            method = RequestMethod.POST,
            params = {"articleId", "articleTitle", "articleContent", "tag", "articleRawContent"})
    public @ResponseBody
    JsonMessage articlePost(@RequestParam(name = "articleId") String articleId,
                            @RequestParam(name = "articleTitle") String articleTitle,
                            @RequestParam(name = "articleContent") String articleContent,
                            @RequestParam(name = "tag") String tag,
                            @RequestParam(name = "articleRawContent") String articleRawContent) {

        Article article = new Article();
        if (articleId == null) {
            articleId = articleService.saveArticle(article).toString();
            article.setTop(false);
            article.setPublish(true);
            article.setArticleId(UUID.fromString(articleId));
        } else {
            try {
                article = articleService.findArticle(UUID.fromString(articleId));
            } catch (ArticleException e) {
                logger.error(e.getMessage());
                return new JsonMessage(JsonMessage.STATUS_ERROR, "保存失败");
            }
        }

        //调试
        User user = userService.findAllUser().get(0);
        article.setUser(user);
        article.setTagList(tagService.mapToTag(tag));
        article.setArticleTitle(articleTitle);
        article.setArticleContent(articleContent);
        article.setArticleRawContent(articleRawContent);

        articleService.updateArticle(article);

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

    @Autowired
    public void setCategoryService(CategoryService categoryService) {
        this.categoryService = categoryService;
    }
}
