package me.cizezsy.config;

import me.cizezsy.security.AjaxAuthenticationFailureHandler;
import me.cizezsy.security.AjaxAuthenticationSuccessHandler;
import me.cizezsy.security.BlogUserDetailsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

@EnableWebSecurity
@Configuration
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    private BlogUserDetailsService blogUserDetailsService;

    @Override
    public void configure(WebSecurity web) throws Exception {
        web.ignoring().antMatchers("/resources/**");
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.csrf().disable()
                .authorizeRequests()
                .antMatchers("/article/**", "/index/**", "/home/**", "/login/**").permitAll()
                .antMatchers("/admin/**").hasRole("USER")
                .and()
                .formLogin()
                .loginPage("/login")
                .usernameParameter("userName")
                .passwordParameter("password")
                .successHandler(ajaxAuthenticationSuccessHandler())
                .failureHandler(ajaxAuthenticationFailureHandler());
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(blogUserDetailsService);
    }

    @Autowired
    public void configure(AuthenticationManagerBuilder auth, BlogUserDetailsService userDetailsService) throws Exception {
        auth.userDetailsService(userDetailsService);
    }

    @Autowired
    public void setBlogUserDetailsService(BlogUserDetailsService blogUserDetailsService) {
        this.blogUserDetailsService = blogUserDetailsService;
    }

    @Bean
    public AjaxAuthenticationSuccessHandler ajaxAuthenticationSuccessHandler() {
        return new AjaxAuthenticationSuccessHandler();
    }

    @Bean
    AjaxAuthenticationFailureHandler ajaxAuthenticationFailureHandler() {
        return new AjaxAuthenticationFailureHandler();
    }
}
