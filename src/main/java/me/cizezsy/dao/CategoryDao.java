package me.cizezsy.dao;

import me.cizezsy.domain.Category;
import org.springframework.stereotype.Repository;

@Repository
public class CategoryDao extends BaseDao<Category> {

  public CategoryDao() {
    super(Category.class);
  }


}
