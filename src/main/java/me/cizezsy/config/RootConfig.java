package me.cizezsy.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.FilterType;
import org.springframework.stereotype.Controller;

@Configuration
@ComponentScan(basePackages = {"me.cizezsy"},
        excludeFilters = @ComponentScan.Filter(value = Controller.class, type = FilterType.ANNOTATION))
public class RootConfig {

}
