package com.healthbridge.backend.model;

/** What the app gets back after login/register. Never includes the password. */
public record UserResponse(String id, String name, String phone) {
}
