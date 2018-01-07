package me.cizezsy.service;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import me.cizezsy.dao.ArticleDao;
import me.cizezsy.domain.Article;
import me.cizezsy.domain.Category;
import me.cizezsy.exception.ArticleException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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

  public Article findArticle(Serializable id) throws ArticleException {
    Article article = articleDao.get(id);
    if (article == null) {
      throw new ArticleException("无此文章");
    }
    return article;
  }

  public Article findArticle(Article example) throws ArticleException {
    List<Article> articles = findArticleList(example);

    if (articles == null || articles.size() == 0) {
      throw new ArticleException("无此文章");
    } else {
      return articles.get(0);
    }
  }

  public List<Article> findArticleByCategory(Category category) {
    DetachedCriteria criteria = DetachedCriteria.forClass(Article.class);
    criteria.add(Restrictions.eq("category", category));
    return articleDao.findByCriteria(criteria);
  }

  public List<Article> findArticleByCategory(Category category, int start, int limits) {
    DetachedCriteria criteria = DetachedCriteria.forClass(Article.class);
    criteria.add(Restrictions.eq("category", category));
    return articleDao.findByCriteria(criteria)
        .stream()
        .sorted()
        .skip(start)
        .limit(limits)
        .collect(Collectors.toList());
  }


  public List<Article> queryByDateAndCategories(List<Category> categories,
                                                LocalDateTime start, LocalDateTime end) {
    List<Article> articles = queryByDate(start, end);
    return articles.stream()
        .filter(a -> categories.contains(a.getCategory()))
        .collect(Collectors.toList());
  }

  public List<Article> queryByDate(LocalDateTime start, LocalDateTime end) {
    return articleDao.findByDateRestrict(start, end);
  }


  public List<Article> findAllPublishByPage(int firstSize, int maxSize) {
    Map<String, Object> parameters = new HashMap<>();
    parameters.put("isPublish", true);
    return articleDao.findAllByPage(firstSize, maxSize, parameters);
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
