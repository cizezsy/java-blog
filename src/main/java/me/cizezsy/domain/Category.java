package me.cizezsy.domain;

import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.util.UUID;

@Entity
@Table(name = "blog_category")
public class Category extends BaseDomain{

    @Id
    @Type(type = "uuid-char")
    @GeneratedValue
    @Column(name = "category_id")
    private UUID categoryId;

    @Column(name = "category_title")
    private String categoryTitle;
    @Column(name = "category_desc")
    private String categoryDesc;
    @Column(name = "category_order")
    private int categoryOrder;

    public UUID getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(UUID categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryTitle() {
        return categoryTitle;
    }

    public void setCategoryTitle(String categoryTitle) {
        this.categoryTitle = categoryTitle;
    }

    public String getCategoryDesc() {
        return categoryDesc;
    }

    public void setCategoryDesc(String categoryDesc) {
        this.categoryDesc = categoryDesc;
    }

    public int getCategoryOrder() {
        return categoryOrder;
    }

    public void setCategoryOrder(int categoryOrder) {
        this.categoryOrder = categoryOrder;
    }
}
