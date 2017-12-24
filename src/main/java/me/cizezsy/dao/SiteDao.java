package me.cizezsy.dao;

import me.cizezsy.domain.Site;
import org.springframework.stereotype.Repository;

@Repository
public class SiteDao extends BaseDao<Site> {
    public SiteDao() {
        super(Site.class);
    }
}
