package me.cizezsy;

import javax.servlet.Filter;

import me.cizezsy.config.RepositoryConfig;
import me.cizezsy.config.RootConfig;
import me.cizezsy.config.SecurityConfig;
import me.cizezsy.config.WebConfig;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.filter.HiddenHttpMethodFilter;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

public class WebInitializer extends AbstractAnnotationConfigDispatcherServletInitializer {

  @Override
  protected Class<?>[] getRootConfigClasses() {
    return new Class[] {RootConfig.class, RepositoryConfig.class, SecurityConfig.class};
  }

  @Override
  protected Class<?>[] getServletConfigClasses() {
    return new Class[] {WebConfig.class};
  }

  @Override
  protected String[] getServletMappings() {
    return new String[] {"/"};
  }

  @Override
  protected Filter[] getServletFilters() {
    CharacterEncodingFilter characterEncodingFilter =
        new CharacterEncodingFilter("UTF-8", false);
    HiddenHttpMethodFilter hiddenHttpMethodFilter = new HiddenHttpMethodFilter();
    return new Filter[] {characterEncodingFilter, hiddenHttpMethodFilter};
  }
}
