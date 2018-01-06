package me.cizezsy.web.admin;

import me.cizezsy.domain.Article;
import me.cizezsy.domain.Category;
import me.cizezsy.domain.JsonMessage;
import me.cizezsy.domain.User;
import me.cizezsy.exception.ArticleException;
import me.cizezsy.exception.CategoryNotFoundException;
import me.cizezsy.service.ArticleService;
import me.cizezsy.service.CategoryService;
import me.cizezsy.service.TagService;
import me.cizezsy.service.UserService;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Collections;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/admin")
public class ArticleAdminController {
    private ArticleService articleService;
    private TagService tagService;
    private UserService userService;
    private CategoryService categoryService;
    private Logger logger = LoggerFactory.getLogger(ArticleAdminController.class);

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

    @RequestMapping(value = {"/article"}, method = RequestMethod.GET, params = {"categoryIds", "start", "end"})
    public String article(Model model, @RequestParam("categoryIds") String categoryIds,
                          @RequestParam("start") long start,
                          @RequestParam("end") long end) {
        LocalDateTime startDate = LocalDateTime.ofInstant(Instant.ofEpochMilli(start), ZoneId.systemDefault());
        LocalDateTime endDate = LocalDateTime.ofInstant(Instant.ofEpochMilli(end), ZoneId.systemDefault());
        List<Article> articles;
        if (categoryIds.contains("all")) {
            articles = articleService.queryByDate(startDate, endDate);
        } else {
            List<Category> categories = categoryService.mapToCategory(categoryIds);
            articles = articleService.queryByDateAndCategories(categories, startDate, endDate);
        }
        Collections.sort(articles);
        List<Category> categories = categoryService.findAllCategory();
        model.addAttribute("articles", articles);
        model.addAttribute("categories", categories);
        return "admin/article-admin";
    }

    @RequestMapping(value = "/article", method = RequestMethod.POST, params = {"articleId", "action"})
    public @ResponseBody
    JsonMessage articleAction(@RequestParam("articleId") String articleId, @RequestParam("action") String action) {
        Article article;
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
        } else if ("delete".equals(action)) {
            articleService.deleteArticle(article);
            return new JsonMessage(JsonMessage.STATUS_OK, "删除成功");
        }
        articleService.updateArticle(article);
        return new JsonMessage(JsonMessage.STATUS_OK, "设置成功");
    }

    @RequestMapping(value = "/article", method = RequestMethod.POST, params = {"articleId", "categoryId"})
    public @ResponseBody
    JsonMessage articleCategoryChange(@RequestParam("articleId") String articleId, @RequestParam("categoryId") String categoryId) {
        Article article;
        Category category;
        try {
            article = articleService.findArticle(UUID.fromString(articleId));
            category = categoryService.findCategory(categoryId);
        } catch (ArticleException | CategoryNotFoundException e) {
            logger.error(e.getMessage());
            return new JsonMessage(JsonMessage.STATUS_ERROR, "目录更改失败");
        }
        article.setCategory(category);
        articleService.updateArticle(article);
        return new JsonMessage(JsonMessage.STATUS_OK, "目录更改成功");
    }

    @RequestMapping(value = "/article", method = RequestMethod.POST, params = {"categoryName"})
    public @ResponseBody
    JsonMessage articleCategoryCreate(@RequestParam("categoryName") String categoryName) {
        Category category = new Category();
        category.setCategoryTitle(categoryName);
        if (categoryService.isExist(category)) {
            return new JsonMessage(JsonMessage.STATUS_ERROR, "目录已经存在");
        } else {
            categoryService.saveCategory(category);
            return new JsonMessage(JsonMessage.STATUS_OK, category.getCategoryId().toString());
        }
    }

    @RequestMapping(value = "/article/edit", method = RequestMethod.GET)

    public String articleEdit() {
        return "admin/article-admin-edit";
    }

    @RequestMapping(value = "/article/edit", method = RequestMethod.GET, params = {"articleId"})
    public String articleEdit(@RequestParam("articleId") String articleId, Article article, Model model) {
        try {
            article = articleService.findArticle(UUID.fromString(articleId));
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
        if (!StringUtils.isEmpty(articleId)) {
            try {
                article = articleService.findArticle(UUID.fromString(articleId));
            } catch (ArticleException e) {
                logger.error(e.getMessage());
                return new JsonMessage(JsonMessage.STATUS_ERROR, "保存失败");
            }
        }

        User user = userService.findAllUser().get(0);
        article.setUser(user);
        article.setTagList(tagService.mapToTag(tag));
        article.setArticleTitle(articleTitle);
        article.setArticleContent(articleContent);
        article.setArticleRawContent(articleRawContent);

        if (!StringUtils.isEmpty(articleId)) {
            articleService.updateArticle(article);
        } else {
            article.setTop(false);
            article.setPublish(true);
            articleService.saveArticle(article);
        }


//        if (StringUtils.isEmpty(articleId)) {
//            articleId = articleService.saveArticle(article).toString();
//            article.setTop(false);
//            article.setPublish(true);
//            article.setArticleId(UUID.fromString(articleId));
//        } else {
//            try {
//                article = articleService.findArticle(UUID.fromString(articleId));
//            } catch (ArticleException e) {
//                logger.error(e.getMessage());
//                return new JsonMessage(JsonMessage.STATUS_ERROR, "保存失败");
//            }
//        }
//
//        article.setUser(user);
//        article.setTagList(tagService.mapToTag(tag));
//        article.setArticleTitle(articleTitle);
//        article.setArticleContent(articleContent);
//        article.setArticleRawContent(articleRawContent);
//
//        articleService.updateArticle(article);

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
