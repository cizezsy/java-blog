package me.cizezsy.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

import me.cizezsy.dao.CategoryDao;
import me.cizezsy.domain.Category;
import me.cizezsy.exception.CategoryNotFoundException;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class CategoryService {
  private CategoryDao categoryDao;

  public List<Category> findAllCategory() {
    return categoryDao.loadAll();
  }

  public Category findCategory(String categoryId) throws CategoryNotFoundException {
    UUID id;
    try {
      id = UUID.fromString(categoryId);
    } catch (IllegalArgumentException e) {
      throw new CategoryNotFoundException(e);
    }
    Category category = categoryDao.get(id);
    if (category == null) {
      throw new CategoryNotFoundException("Category Not found id database");
    }
    return category;
  }

  public boolean isExist(Category category) {
    return categoryDao.findByExample(category).size() > 0;
  }

  public List<Category> mapToCategory(String categoryIds) {
    if (StringUtils.isEmpty(categoryIds)) {
      return new ArrayList<>();
    }
    return Arrays.stream(categoryIds.split(","))
        .filter(s -> {
          try {
            UUID ignored = UUID.fromString(s);
            return true;
          } catch (IllegalArgumentException e) {
            return false;
          }
        }).map(s -> categoryDao.get(UUID.fromString(s))).collect(Collectors.toList());
  }

  @Transactional
  public void saveCategory(Category category) {
    categoryDao.save(category);
  }

  @Transactional
  public void removeCategory(Category category) {
    categoryDao.remove(category);
  }

  @Transactional
  public void updateCategory(Category category) {
    categoryDao.update(category);
  }

  @Autowired
  public void setCategoryDao(CategoryDao categoryDao) {
    this.categoryDao = categoryDao;
  }

}
