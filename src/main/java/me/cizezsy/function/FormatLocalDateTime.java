package me.cizezsy.function;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public final class FormatLocalDateTime {
  private FormatLocalDateTime() {
  }

  public static String formatLocalDateTime(LocalDateTime localDateTime, String pattern) {
    return localDateTime.format(DateTimeFormatter.ofPattern(pattern));
  }
}
