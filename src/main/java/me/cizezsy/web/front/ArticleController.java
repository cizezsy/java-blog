package me.cizezsy.web.front;

import me.cizezsy.domain.Article;
import me.cizezsy.domain.Category;
import me.cizezsy.domain.Site;
import me.cizezsy.exception.ArticleException;
import me.cizezsy.exception.SiteInfoNotExistException;
import me.cizezsy.service.ArticleService;
import me.cizezsy.service.CategoryService;
import me.cizezsy.service.SiteService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Comparator;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/article")
public class ArticleController {

    private Logger logger = LoggerFactory.getLogger(ArticleController.class);

    private ArticleService articleService;
    private CategoryService categoryService;
    private SiteService siteService;

    @RequestMapping(value = "/detail", method = RequestMethod.GET, params = {"articleId"})
    public String articleDetail(@RequestParam(name = "articleId") String articleId,
                                Article article, Model model) {
        try {
            article = articleService.findArticle(UUID.fromString(articleId));
        } catch (ArticleException e) {
            logger.error(e.getMessage());
            return "error/404";
        }

        List<Category> categoryList = categoryService.findAllCategory();
        categoryList.sort(Comparator.comparingInt(Category::getCategoryOrder));

        Site site;
        try {
            site = siteService.getSite();
        } catch (SiteInfoNotExistException e) {
            return "redirect:error/505";
        }

        model.addAttribute("site", site);
        model.addAttribute("categoryList", categoryList);
        model.addAttribute("article", article);
        return "article";
    }


    @Autowired
    public void setArticleService(ArticleService articleService) {
        this.articleService = articleService;
    }

    @Autowired
    public void setCategoryService(CategoryService categoryService) {
        this.categoryService = categoryService;
    }

    @Autowired
    public void setSiteService(SiteService siteService) {
        this.siteService = siteService;
    }
}
