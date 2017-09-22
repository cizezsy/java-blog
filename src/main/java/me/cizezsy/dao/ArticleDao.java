package me.cizezsy.dao;

import me.cizezsy.domain.Article;
import org.springframework.stereotype.Repository;

@Repository
public class ArticleDao extends BaseDao<Article> {

    public ArticleDao() {
        super(Article.class);
    }
}
