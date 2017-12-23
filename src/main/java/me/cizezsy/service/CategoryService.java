package me.cizezsy.service;

import me.cizezsy.dao.CategoryDao;
import me.cizezsy.domain.Category;
import me.cizezsy.exception.CategoryNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;
import java.util.List;

@Service
public class CategoryService {
    private CategoryDao categoryDao;

    public List<Category> findAllCategory() {
        return categoryDao.loadAll();
    }

    public Category findCategory(Serializable id) throws CategoryNotFoundException {
        Category category = categoryDao.get(id);
        if (category == null) throw new CategoryNotFoundException("Category Not found id database");
        return category;
    }

    public boolean isExist(Category category) {
        return categoryDao.findByExample(category).size() > 0;
    }

    @Transactional
    public void saveCategory(Category category) {
        categoryDao.save(category);
    }

    @Transactional
    public void removeCategory(Category category) {
        categoryDao.remove(category);
    }

    @Autowired
    public void setCategoryDao(CategoryDao categoryDao) {
        this.categoryDao = categoryDao;
    }

}
