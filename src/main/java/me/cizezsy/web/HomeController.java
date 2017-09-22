package me.cizezsy.web;

import me.cizezsy.cons.WebConstant;
import me.cizezsy.domain.Article;
import me.cizezsy.service.ArticleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping({"/home", "/"})
public class HomeController {
    private ArticleService articleService;

    @RequestMapping
    public String home(Model model, Article article) {
        List<Article> articles = articleService.findArticleList(article, WebConstant.DEFAULT_PAGE_START, WebConstant.DEFAULT_PAGE_LIMIT);
        articles.add(articles.get(0));
        articles.add(articles.get(0));
        articles.add(articles.get(0));
        articles.add(articles.get(0));
        articles.add(articles.get(0));
        articles.add(articles.get(0));
        articles.add(articles.get(0));
        articles.add(articles.get(0));
        model.addAttribute("articleList", articles);
        return "home";
    }

    @Autowired
    public void setArticleService(ArticleService articleService) {
        this.articleService = articleService;
    }

}
