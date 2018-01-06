package me.cizezsy.service;

import java.util.List;
import javax.servlet.http.HttpServletRequest;

import me.cizezsy.cons.WebConstant;
import me.cizezsy.dao.UserDao;
import me.cizezsy.domain.User;
import me.cizezsy.exception.LoginFailException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class UserService {

  private UserDao userDao;

  /**
   * Verify User
   * @param username username
   * @param password password
   * @param servletRequest exact ip address storing into user instance
   * @return User which get by username and password, if success
   * @throws LoginFailException throw when verify failed
   */
  @Transactional
  public User verifyUser(String username,
                         String password,
                         HttpServletRequest servletRequest) throws LoginFailException {
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
