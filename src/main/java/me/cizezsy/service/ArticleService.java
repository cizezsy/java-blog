package me.cizezsy.service;

import me.cizezsy.dao.ArticleDao;
import me.cizezsy.domain.Article;
import me.cizezsy.exception.ArticleException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;
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


    public List<Article> findAllArticle() {
        return articleDao.loadAll();
    }

    public Article findArticle(Article example) throws ArticleException {
        List<Article> articles = findArticleList(example);

        if (articles == null || articles.size() == 0)
            throw new ArticleException("无此文章");
        else
            return articles.get(0);
    }

    public Article findArticle(Serializable id) throws ArticleException {
        Article article = articleDao.get(id);
        if (article == null)
            throw new ArticleException("无此文章");
        return article;
    }


    @Transactional
    public void updateArticle(Article article) {
        articleDao.update(article);
    }

    @Transactional
    public Serializable saveArticle(Article article) {
        return articleDao.save(article);
    }

    @Transactional
    public void deleteArticle(Article article) {
        articleDao.remove(article);
    }

    @Autowired
    public void setArticleDao(ArticleDao articleDao) {
        this.articleDao = articleDao;
    }
}
