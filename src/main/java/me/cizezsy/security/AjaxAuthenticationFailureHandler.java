package me.cizezsy.security;

import com.fasterxml.jackson.databind.ObjectMapper;
import me.cizezsy.domain.JsonMessage;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class AjaxAuthenticationFailureHandler extends SimpleUrlAuthenticationFailureHandler {

    private ObjectMapper mapper = new ObjectMapper();

    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception) throws IOException, ServletException {
        if ("true".equals(request.getHeader("X-Ajax-call"))) {
            response.getWriter().print(mapper.writeValueAsString(new JsonMessage(JsonMessage.STATUS_ERROR, exception.getMessage())));
            response.getWriter().flush();
        } else {
            super.onAuthenticationFailure(request, response, exception);
        }
    }
}
