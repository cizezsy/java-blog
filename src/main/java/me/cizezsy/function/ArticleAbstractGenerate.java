package me.cizezsy.function;

public class ArticleAbstractGenerate {

  /**
   * Removes html tag of content and cut its length to 100 (if more than 1000).
   *
   * @param content article content
   * @return abstract
   */
  public static String abstractGenerate(String content) {
    String result = content.replaceAll("</?[^>]*>", "");
    if (result.length() > 100) {
      return result.substring(0, 100);
    } else {
      return result;
    }
  }

}
