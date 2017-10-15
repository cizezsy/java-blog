package me.cizezsy.web;

import me.cizezsy.cons.WebConstant;
import me.cizezsy.domain.Article;
import me.cizezsy.domain.Category;
import me.cizezsy.service.ArticleService;
import me.cizezsy.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping({"/home", "/"})
public class HomeController {

    private ArticleService articleService;
    private CategoryService categoryService;

    @RequestMapping
    public String home(Model model, Article article) {
        article.setPublish(true);
        List<Article> articleList = articleService.findArticleList(article, WebConstant.DEFAULT_PAGE_START, WebConstant.DEFAULT_PAGE_LIMIT);
        List<Category> categoryList = categoryService.findAllCategory();

        model.addAttribute("articleList", articleList);
        model.addAttribute("categoryList", categoryList);

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
}
