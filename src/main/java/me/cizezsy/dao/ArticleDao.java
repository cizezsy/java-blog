package me.cizezsy.dao;

import java.time.LocalDateTime;
import java.util.List;

import me.cizezsy.domain.Article;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

@Repository
public class ArticleDao extends BaseDao<Article> {

  public ArticleDao() {
    super(Article.class);
  }

  public List<Article> findByDateRestrict(LocalDateTime start, LocalDateTime end) {
    DetachedCriteria criteria = DetachedCriteria.forClass(Article.class);
    criteria.add(Restrictions.ge("createTime", start));
    criteria.add(Restrictions.le("createTime", end));
    return findByCriteria(criteria);
  }
}
