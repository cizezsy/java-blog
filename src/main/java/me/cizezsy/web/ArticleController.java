package me.cizezsy.web;

import me.cizezsy.domain.Article;
import me.cizezsy.exception.ArticleException;
import me.cizezsy.service.ArticleService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.UUID;

@Controller
@RequestMapping("/article")
public class ArticleController {

    private Logger logger = LoggerFactory.getLogger(ArticleController.class);

    private ArticleService articleService;

    @RequestMapping(value = "/detail", method = RequestMethod.GET, params = {"articleId"})
    public String articleDetail(@RequestParam(name = "articleId") String articleId,
                                Article article, Model model) {
        article.setArticleId(UUID.fromString(articleId));
        try {
            article = articleService.findArticle(article);
        } catch (ArticleException e) {
            logger.error(e.getMessage());
            return "error/404";
        }
        model.addAttribute("article", article);
        return "article";
    }


    @Autowired
    public void setArticleService(ArticleService articleService) {
        this.articleService = articleService;
    }
}
