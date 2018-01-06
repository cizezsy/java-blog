package me.cizezsy.web.front;

import javax.servlet.http.HttpServletRequest;

import me.cizezsy.domain.JsonMessage;
import me.cizezsy.domain.User;
import me.cizezsy.exception.LoginFailException;
import me.cizezsy.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/login")
public class LoginController {

  private UserService userService;

  @RequestMapping(method = RequestMethod.POST, params = {"userName", "password"})
  public @ResponseBody
  JsonMessage login(@RequestParam(name = "userName") String userName,
                    @RequestParam(name = "password") String password,
                    HttpServletRequest servletRequest) {
    User user;
    try {
      user = userService.verifyUser(userName, password, servletRequest);
    } catch (LoginFailException e) {
      return new JsonMessage(JsonMessage.STATUS_ERROR, e.getMessage());
    }
    servletRequest.getSession().setAttribute("user", user);
    return new JsonMessage(JsonMessage.STATUS_OK, "home");
  }

  @RequestMapping(method = RequestMethod.GET)
  public String login() {
    return "login";
  }

  @Autowired
  public void setUserService(UserService userService) {
    this.userService = userService;
  }
}
