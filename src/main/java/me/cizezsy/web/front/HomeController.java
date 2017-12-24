package me.cizezsy.web.front;

import me.cizezsy.cons.WebConstant;
import me.cizezsy.domain.Article;
import me.cizezsy.domain.Category;
import me.cizezsy.domain.Site;
import me.cizezsy.exception.CategoryNotFoundException;
import me.cizezsy.exception.SiteInfoNotExistException;
import me.cizezsy.service.ArticleService;
import me.cizezsy.service.CategoryService;
import me.cizezsy.service.SiteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.Arrays;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping({"/home", "/"})
public class HomeController {

    private ArticleService articleService;
    private CategoryService categoryService;
    private SiteService siteService;

    @RequestMapping(method = RequestMethod.GET)
    public String home(Model model, Article article) {
        article.setPublish(true);
        List<Article> articleList = articleService.findArticleList(article, WebConstant.DEFAULT_PAGE_START, WebConstant.DEFAULT_PAGE_LIMIT);
        List<Category> categoryList = categoryService.findAllCategory();
        categoryList.sort(Comparator.comparingInt(Category::getCategoryOrder));

        Site site;
        try {
            site = siteService.getSite();
        } catch (SiteInfoNotExistException e) {
            return "redirect:error/505";
        }

        String[] mottoLines = site.getSiteLongMotto().split("\n");

        model.addAttribute("articleList", articleList);
        model.addAttribute("categoryList", categoryList);
        model.addAttribute("site", site);
        model.addAttribute("mottoLines", mottoLines);

        return "home";
    }

    @RequestMapping(method = RequestMethod.GET, params = {"categoryId"})
    public String home(Model model, String categoryId) {
        Category category;
        try {
            category = categoryService.findCategory(categoryId);
        } catch (CategoryNotFoundException e) {
            return "redirect:/error/500";
        }

        List<Article> articleList = articleService
                .findArticleByCategory(category, WebConstant.DEFAULT_PAGE_START, WebConstant.DEFAULT_PAGE_LIMIT)
                .stream()
                .filter(Article::isPublish)
                .collect(Collectors.toList());
        List<Category> categoryList = categoryService.findAllCategory();
        categoryList.sort(Comparator.comparingInt(Category::getCategoryOrder));

        Site site;
        try {
            site = siteService.getSite();
        } catch (SiteInfoNotExistException e) {
            return "redirect:error/505";
        }

        String[] mottoLines = site.getSiteLongMotto().split("\n");

        model.addAttribute("articleList", articleList);
        model.addAttribute("categoryList", categoryList);
        model.addAttribute("site", site);
        model.addAttribute("mottoLines", mottoLines);

        return "home";
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
