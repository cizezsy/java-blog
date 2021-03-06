package me.cizezsy.dao;

import java.util.List;

import me.cizezsy.domain.User;
import org.springframework.stereotype.Repository;

@Repository
public class UserDao extends BaseDao<User> {

  public UserDao() {
    super(User.class);
  }

  public User getUserByName(String username) {
    User user = new User();
    user.setUserName(username);
    List<User> userList = findByExample(user);
    return userList.size() == 0 ? null : userList.get(0);
  }
}
