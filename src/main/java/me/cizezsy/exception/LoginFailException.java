package me.cizezsy.exception;

public class LoginFailException extends Exception {
  public LoginFailException() {
  }

  public LoginFailException(String message) {
    super(message);
  }

  public LoginFailException(String message, Throwable cause) {
    super(message, cause);
  }

  public LoginFailException(Throwable cause) {
    super(cause);
  }

  public LoginFailException(String message, Throwable cause,
                            boolean enableSuppression, boolean writableStackTrace) {
    super(message, cause, enableSuppression, writableStackTrace);
  }
}
