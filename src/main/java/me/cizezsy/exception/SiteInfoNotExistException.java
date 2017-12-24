package me.cizezsy.exception;

public class SiteInfoNotExistException extends Exception{

    public SiteInfoNotExistException() {
    }

    public SiteInfoNotExistException(String message) {
        super(message);
    }

    public SiteInfoNotExistException(String message, Throwable cause) {
        super(message, cause);
    }

    public SiteInfoNotExistException(Throwable cause) {
        super(cause);
    }

    public SiteInfoNotExistException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}
