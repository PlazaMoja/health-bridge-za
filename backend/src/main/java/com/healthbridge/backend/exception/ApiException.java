package com.healthbridge.backend.exception;

import org.springframework.http.HttpStatus;

/** Thrown for expected problems (bad input, wrong password...) - the message is shown in the app. */
public class ApiException extends RuntimeException {

    private final HttpStatus status;

    public ApiException(HttpStatus status, String message) {
        super(message);
        this.status = status;
    }

    public HttpStatus getStatus() {
        return status;
    }
}
