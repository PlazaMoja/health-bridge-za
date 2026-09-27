package com.healthbridge.backend.service;

import com.google.api.core.ApiFuture;

import java.util.concurrent.ExecutionException;

/** Firestore calls are asynchronous. This waits for the result so the code reads top-to-bottom. */
final class Futures {

    private Futures() {
    }

    static <T> T await(ApiFuture<T> future) {
        try {
            return future.get();
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            throw new IllegalStateException("Interrupted while waiting for Firestore", e);
        } catch (ExecutionException e) {
            throw new IllegalStateException("Firestore request failed: " + e.getCause().getMessage(), e.getCause());
        }
    }
}
