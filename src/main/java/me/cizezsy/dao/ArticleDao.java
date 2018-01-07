package me.cizezsy.dao;

import me.cizezsy.domain.Article;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.hibernate.query.Query;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

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

  public List<Article> findAllByPage(int firstSize, int maxSize, Map<String, Object> parameters) {
    return getHibernateTemplate().execute(session -> {
      StringBuilder queryString = new StringBuilder();
      queryString.append("from Article a ");
      if (parameters.size() != 0) {
        queryString.append("where ");
        for (Map.Entry<String, Object> param : parameters.entrySet()) {
          queryString.append(" a.").append(param.getKey()).append(" = ").append(":").append(param.getKey()).append(" and ");
        }
      }
      String hql = queryString.toString();
      if (hql.endsWith("and ")) {
        hql = hql.substring(0, hql.length() - 4);
      }
      Query<Article> query = session.createQuery(hql, Article.class);
      for (Map.Entry<String, Object> params : parameters.entrySet()) {
        query.setParameter(params.getKey(), params.getValue());
      }
      query.setFirstResult(firstSize);
      query.setMaxResults(maxSize);
      return query.getResultList();
    });
  }
}
