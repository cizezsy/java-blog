package me.cizezsy.domain;

import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;
import org.hibernate.annotations.Type;

import javax.persistence.*;

@Entity
@Table(name = "blog_menu")
public class Menu extends BaseDomain {

    @Id
    @Column(name = "menu_id")
    @GeneratedValue
    @Type(type = "uuid-char")
    private String menuId;

    @NotFound(action = NotFoundAction.IGNORE)
    @ManyToOne
    @JoinColumn(name = "parent_id")
    private Menu parent;

    @Column(name = "menu_name")
    private String menuName;

    @Column(name = "menu_url")
    private String menuUrl;

    @Column(name = "menu_type")
    private int menuType;

    public String getMenuId() {
        return menuId;
    }

    public void setMenuId(String menu_id) {
        this.menuId = menu_id;
    }

    public String getMenuName() {
        return menuName;
    }

    public void setMenuName(String menu_name) {
        this.menuName = menu_name;
    }

    public String getMenuUrl() {
        return menuUrl;
    }

    public void setMenuUrl(String menu_url) {
        this.menuUrl = menu_url;
    }

    public int getMenuType() {
        return menuType;
    }

    public void setMenuType(int menu_type) {
        this.menuType = menu_type;
    }

    public void setParent(Menu parent) {
        this.parent = parent;
    }

    public Menu getParent() {
        return parent;
    }
}
