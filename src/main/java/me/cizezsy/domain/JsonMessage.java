package me.cizezsy.domain;

public class JsonMessage {
    public final static int STATUS_OK = 200;
    public final static int STATUS_ERROR = 405;

    private int status;
    private String message;

    public JsonMessage() {
    }

    public JsonMessage(int status, String message) {
        this.status = status;
        this.message = message;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
