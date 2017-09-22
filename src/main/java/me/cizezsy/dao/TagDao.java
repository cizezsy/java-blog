package me.cizezsy.dao;

import me.cizezsy.domain.Tag;
import org.springframework.stereotype.Repository;

@Repository
public class TagDao extends BaseDao<Tag> {

    public TagDao() {
        super(Tag.class);
    }
}
