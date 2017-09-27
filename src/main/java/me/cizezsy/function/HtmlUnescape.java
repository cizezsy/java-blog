package me.cizezsy.function;


import org.springframework.web.util.HtmlUtils;

public class HtmlUnescape {
    private HtmlUnescape(){}

    public static String htmlUnescape(String s){
        return HtmlUtils.htmlUnescape(s);
    }
}
