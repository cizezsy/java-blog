package me.cizezsy.service;

import me.cizezsy.cons.WebConstant;
import me.cizezsy.dao.UserDao;
import me.cizezsy.domain.User;
import me.cizezsy.exception.LoginFailException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Service
public class UserService {

    private UserDao userDao;

    @Transactional
    public User verifyUser(String username, String password, HttpServletRequest servletRequest) throws LoginFailException {
        User user = userDao.getUserByName(username);
        if (user == null || !user.getPassword().equals(password)) {
            throw new LoginFailException(WebConstant.LOGIN_FAIL_MES);
        }
        user.setLastIp(servletRequest.getRemoteUser());
        userDao.save(user);
        return user;
    }

    public List<User> findAllUser() {
        return userDao.loadAll();
    }

    @Autowired
    public void setUserDao(UserDao userDao) {
        this.userDao = userDao;
    }

}
