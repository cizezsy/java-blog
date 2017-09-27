package me.cizezsy.security;

import com.fasterxml.jackson.databind.ObjectMapper;
import me.cizezsy.domain.JsonMessage;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.util.StringUtils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Arrays;
import java.util.stream.Collectors;

public class AjaxAuthenticationSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {

    private ObjectMapper mapper = new ObjectMapper();
    private RequestCache requestCache = new HttpSessionRequestCache();

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
        if ("true".equals(request.getHeader("X-Ajax-call"))) {
            SavedRequest savedRequest
                    = requestCache.getRequest(request, response);

            if (savedRequest == null) {
                clearAuthenticationAttributes(request);
                response.getWriter().print(mapper.writeValueAsString(new JsonMessage(JsonMessage.STATUS_OK, "/admin/article")));
                return;
            }
            String targetUrlParam = getTargetUrlParameter();
            if (isAlwaysUseDefaultTargetUrl()
                    || (targetUrlParam != null
                    && StringUtils.hasText(request.getParameter(targetUrlParam)))) {
                requestCache.removeRequest(request, response);
                clearAuthenticationAttributes(request);
                return;
            }
            response.getWriter().print(mapper.writeValueAsString(new JsonMessage(JsonMessage.STATUS_OK, savedRequest.getRedirectUrl())));
            clearAuthenticationAttributes(request);
        } else {
            super.onAuthenticationSuccess(request, response, authentication);
        }
    }
}
