package me.cizezsy.service;

import me.cizezsy.dao.ArticleDao;
import me.cizezsy.domain.Article;
import me.cizezsy.exception.ArticleException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class ArticleService {

    private ArticleDao articleDao;


    public List<Article> findArticleList(Article example, int start, int limits) {
        List<Article> articles = findArticleList(example);
        return articles.stream()
                .sorted()
                .skip(start)
                .limit(limits)
                .collect(Collectors.toList());
    }

    public List<Article> findArticleList(Article example) {
        return articleDao.findByExample(example);
    }

    public Article findArticle(Article example) throws ArticleException {
        List<Article> articles = findArticleList(example);

        if (articles == null || articles.size() == 0)
            throw new ArticleException("找不到此文件");
        else
            return articles.get(0);
    }

    @Transactional
    public void saveArticle(Article article) {
        articleDao.save(article);
    }


    @Autowired
    public void setArticleDao(ArticleDao articleDao) {
        this.articleDao = articleDao;
    }
}
