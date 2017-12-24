package me.cizezsy.web.admin;

import me.cizezsy.domain.Category;
import me.cizezsy.domain.JsonMessage;
import me.cizezsy.exception.CategoryNotFoundException;
import me.cizezsy.service.CategoryService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Comparator;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class CategoryAdminController {

    private Logger logger = LoggerFactory.getLogger(CategoryAdminController.class);
    private CategoryService categoryService;

    @RequestMapping(value = "/category", method = RequestMethod.GET)
    public String category(Model model) {
        List<Category> categories = categoryService.findAllCategory();
        categories.sort(Comparator.comparingInt(Category::getCategoryOrder));
        model.addAttribute("categories", categories);
        return "admin/category-admin";
    }

    @RequestMapping(value = "/category", method = RequestMethod.POST, params = {"categoryId", "categoryTitle"})
    public @ResponseBody
    JsonMessage categoryTitleChange(@RequestParam("categoryId") String categoryId,
                                    @RequestParam("categoryTitle") String categoryTitle) {
        Category category;
        try {
            category = categoryService.findCategory(categoryId);
        } catch (CategoryNotFoundException e) {
            logger.error(e.getMessage());
            return new JsonMessage(JsonMessage.STATUS_ERROR, "找不到目录，修改失败");
        }

        category.setCategoryTitle(categoryTitle);
        categoryService.updateCategory(category);

        return new JsonMessage(JsonMessage.STATUS_OK, "修改成功");
    }

    @RequestMapping(value = "/category", method = RequestMethod.POST, params = {"categoryId", "categoryOrder"})
    public @ResponseBody
    JsonMessage categoryOrderChange(@RequestParam("categoryId") String categoryId,
                                    @RequestParam("categoryOrder") String order) {

        Category category;
        try {
            category = categoryService.findCategory(categoryId);
        } catch (CategoryNotFoundException e) {
            logger.error(e.getMessage());
            return new JsonMessage(JsonMessage.STATUS_ERROR, "找不到目录，修改失败");
        }

        category.setCategoryOrder(Integer.parseInt(order));
        categoryService.updateCategory(category);

        return new JsonMessage(JsonMessage.STATUS_OK, "修改成功");
    }

    @RequestMapping(value = "/category/delete", method = RequestMethod.POST, params = {"categoryId"})
    public @ResponseBody
    JsonMessage categoryDelete(@RequestParam("categoryId") String categoryId) {

        Category category;
        try {
            category = categoryService.findCategory(categoryId);
        } catch (CategoryNotFoundException e) {
            logger.error(e.getMessage());
            return new JsonMessage(JsonMessage.STATUS_ERROR, "找不到目录，修改失败");
        }
        categoryService.removeCategory(category);
        return new JsonMessage(JsonMessage.STATUS_OK, "删除成功");
    }

    @RequestMapping(value = "/category", method = RequestMethod.POST, params = {"categoryId", "categoryTitle", "categoryDesc", "categoryOrder"})
    public @ResponseBody
    JsonMessage categorySubmit(@RequestParam("categoryId") String categoryId,
                               @RequestParam("categoryTitle") String categoryTitle,
                               @RequestParam("categoryDesc") String categoryDesc,
                               @RequestParam("categoryOrder") int categoryOrder) {

        if ("new".equals(categoryId)) {
            Category category = new Category();
            category.setCategoryTitle(categoryTitle);
            if (categoryService.isExist(category)) {
                return new JsonMessage(JsonMessage.STATUS_ERROR, "创建失败，已有同名目录");
            }
            category.setCategoryDesc(categoryDesc);
            category.setCategoryOrder(categoryOrder);

            categoryService.saveCategory(category);
            return new JsonMessage(JsonMessage.STATUS_OK, "创建成功");
        }

        Category category;
        try {
            category = categoryService.findCategory(categoryId);
        } catch (CategoryNotFoundException e) {
            logger.error(e.getMessage());
            return new JsonMessage(JsonMessage.STATUS_ERROR, "找不到目录，修改失败");
        }
        category.setCategoryTitle(categoryTitle);
        category.setCategoryDesc(categoryDesc);
        category.setCategoryOrder(categoryOrder);
        categoryService.updateCategory(category);
        return new JsonMessage(JsonMessage.STATUS_OK, "修改成功");
    }

    @Autowired
    public void setCategoryService(CategoryService categoryService) {
        this.categoryService = categoryService;
    }
}
