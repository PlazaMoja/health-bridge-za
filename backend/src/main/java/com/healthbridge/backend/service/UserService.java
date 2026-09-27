package com.healthbridge.backend.service;

import com.google.cloud.firestore.DocumentReference;
import com.google.cloud.firestore.DocumentSnapshot;
import com.google.cloud.firestore.Firestore;
import com.healthbridge.backend.exception.ApiException;
import com.healthbridge.backend.model.LoginRequest;
import com.healthbridge.backend.model.RegisterRequest;
import com.healthbridge.backend.model.UserResponse;
import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.util.HashMap;
import java.util.Map;

/**
 * Users are stored in the "users" collection. The document ID is the phone number
 * in +27 format, so each phone number can only register once.
 * Passwords are stored as BCrypt hashes, never as plain text.
 */
@Service
public class UserService {

    static final String USERS = "users";

    private final Firestore db;
    private final BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    public UserService(Firestore db) {
        this.db = db;
    }

    public UserResponse register(RegisterRequest request) {
        String name = request.name() == null ? "" : request.name().trim();
        String password = request.password() == null ? "" : request.password();
        String phone = normalisePhone(request.phone());

        if (name.isEmpty()) {
            throw new ApiException(HttpStatus.BAD_REQUEST, "Please enter your name.");
        }
        if (password.length() < 6) {
            throw new ApiException(HttpStatus.BAD_REQUEST, "Password must be at least 6 characters.");
        }

        DocumentReference ref = db.collection(USERS).document(phone);
        if (Futures.await(ref.get()).exists()) {
            throw new ApiException(HttpStatus.CONFLICT, "An account with this phone number already exists.");
        }

        Map<String, Object> user = new HashMap<>();
        user.put("name", name);
        user.put("phone", phone);
        user.put("passwordHash", passwordEncoder.encode(password));
        user.put("createdAt", Instant.now().toString());
        Futures.await(ref.set(user));

        return new UserResponse(phone, name, phone);
    }

    public UserResponse login(LoginRequest request) {
        String password = request.password() == null ? "" : request.password();
        String phone;
        try {
            phone = normalisePhone(request.phone());
        } catch (ApiException e) {
            throw wrongDetails();
        }

        DocumentSnapshot doc = Futures.await(db.collection(USERS).document(phone).get());
        if (!doc.exists()) {
            throw wrongDetails();
        }

        String hash = doc.getString("passwordHash");
        if (hash == null || !passwordEncoder.matches(password, hash)) {
            throw wrongDetails();
        }

        return new UserResponse(doc.getId(), doc.getString("name"), doc.getString("phone"));
    }

    public boolean exists(String userId) {
        if (userId == null || userId.isBlank()) {
            return false;
        }
        return Futures.await(db.collection(USERS).document(userId).get()).exists();
    }

    /**
     * Accepts "082 123 4567", "0821234567", "821234567", "27821234567" or "+27821234567"
     * and turns them all into "+27821234567".
     */
    static String normalisePhone(String raw) {
        String digits = raw == null ? "" : raw.replaceAll("\\D", "");
        if (digits.startsWith("27") && digits.length() == 11) {
            digits = digits.substring(2);
        } else if (digits.startsWith("0") && digits.length() == 10) {
            digits = digits.substring(1);
        }
        if (digits.length() != 9) {
            throw new ApiException(HttpStatus.BAD_REQUEST, "Please enter a valid South African phone number.");
        }
        return "+27" + digits;
    }

    private static ApiException wrongDetails() {
        // Same message for "no account" and "wrong password" so nobody can check which numbers are registered.
        return new ApiException(HttpStatus.UNAUTHORIZED, "Incorrect phone number or password.");
    }
}
