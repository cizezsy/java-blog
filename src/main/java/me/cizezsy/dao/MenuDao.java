package me.cizezsy.dao;

import me.cizezsy.domain.Menu;
import org.springframework.stereotype.Repository;

@Repository
public class MenuDao extends BaseDao<Menu> {

    public MenuDao() {
        super(Menu.class);
    }
}
