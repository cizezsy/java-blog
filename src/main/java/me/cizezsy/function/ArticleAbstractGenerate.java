package me.cizezsy.function;

public class ArticleAbstractGenerate {

    public static String abstractGenerate(String content) {
        String result = content.replaceAll("</?[^>]*>","");
        if(result.length() > 100) {
            return result.substring(0, 100);
        } else {
            return result;
        }
    }

}
