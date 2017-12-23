package me.cizezsy.dao;

import me.cizezsy.domain.Article;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.hibernate.internal.CriteriaImpl;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

@Repository
public class ArticleDao extends BaseDao<Article> {

    public ArticleDao() {
        super(Article.class);
    }

//    public List<Article> findByDateRestrict(LocalDateTime start, LocalDateTime end) {
//        DetachedCriteria criteria = new DetachedCriteria()
//    }
}
