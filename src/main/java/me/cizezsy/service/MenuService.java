package me.cizezsy.service;

import me.cizezsy.dao.MenuDao;
import me.cizezsy.domain.Menu;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MenuService {

    private MenuDao menuDao;

    public List<Menu> findAllMenuList() {
        return menuDao.loadAll();
    }

    @Autowired
    public void setMenuDao(MenuDao menuDao) {
        this.menuDao = menuDao;
    }
}
