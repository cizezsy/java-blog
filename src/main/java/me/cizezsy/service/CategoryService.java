package me.cizezsy.service;

import me.cizezsy.dao.CategoryDao;
import me.cizezsy.domain.Category;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class CategoryService {
    private CategoryDao categoryDao;

    public List<Category> findAllCategory() {
        return categoryDao.loadAll();
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
