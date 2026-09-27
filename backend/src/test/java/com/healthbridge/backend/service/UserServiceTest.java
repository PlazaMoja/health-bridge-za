package com.healthbridge.backend.service;

import com.healthbridge.backend.exception.ApiException;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;

/** Runs without Firebase - checks phone numbers are stored in one consistent format. */
class UserServiceTest {

    @Test
    void acceptsCommonSouthAfricanFormats() {
        assertEquals("+27821234567", UserService.normalisePhone("0821234567"));
        assertEquals("+27821234567", UserService.normalisePhone("082 123 4567"));
        assertEquals("+27821234567", UserService.normalisePhone("821234567"));
        assertEquals("+27821234567", UserService.normalisePhone("+27 82 123 4567"));
        assertEquals("+27821234567", UserService.normalisePhone("27821234567"));
    }

    @Test
    void rejectsInvalidNumbers() {
        assertThrows(ApiException.class, () -> UserService.normalisePhone("12345"));
        assertThrows(ApiException.class, () -> UserService.normalisePhone(""));
        assertThrows(ApiException.class, () -> UserService.normalisePhone(null));
    }
}
