package com.healthbridge.backend.service;

import com.google.cloud.firestore.DocumentReference;
import com.google.cloud.firestore.DocumentSnapshot;
import com.google.cloud.firestore.Firestore;
import com.healthbridge.backend.exception.ApiException;
import com.healthbridge.backend.model.Appointment;
import com.healthbridge.backend.model.AppointmentRequest;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeParseException;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/** Appointments are stored in the "appointments" collection, linked to a user by userId. */
@Service
public class AppointmentService {

    static final String APPOINTMENTS = "appointments";

    private final Firestore db;
    private final UserService userService;

    public AppointmentService(Firestore db, UserService userService) {
        this.db = db;
        this.userService = userService;
    }

    public List<Appointment> getForUser(String userId) {
        if (userId == null || userId.isBlank()) {
            throw new ApiException(HttpStatus.BAD_REQUEST, "userId is required.");
        }
        // In a URL a "+" turns into a space unless it's written as %2B, so fix that up here.
        userId = userId.trim();
        if (userId.matches("27\\d{9}")) {
            userId = "+" + userId;
        }
        // Sorted here rather than with Firestore's orderBy, because where + orderBy
        // on different fields needs an extra Firestore index to be created by hand.
        return Futures.await(db.collection(APPOINTMENTS).whereEqualTo("userId", userId).get())
                .getDocuments().stream()
                .map(AppointmentService::toAppointment)
                .sorted(Comparator.comparing(Appointment::date).thenComparing(Appointment::time))
                .toList();
    }

    public Appointment create(AppointmentRequest request) {
        if (!userService.exists(request.userId())) {
            throw new ApiException(HttpStatus.UNAUTHORIZED, "Please log in again.");
        }
        if (isBlank(request.doctorName())) {
            throw new ApiException(HttpStatus.BAD_REQUEST, "Please select a healthcare professional.");
        }
        if (isBlank(request.reason())) {
            throw new ApiException(HttpStatus.BAD_REQUEST, "Please enter the reason for your visit.");
        }
        LocalDate date = parseDate(request.date());
        LocalTime time = parseTime(request.time());
        if (date.isBefore(LocalDate.now())) {
            throw new ApiException(HttpStatus.BAD_REQUEST, "Please choose a date that isn't in the past.");
        }

        Map<String, Object> data = new HashMap<>();
        data.put("userId", request.userId());
        data.put("doctorName", request.doctorName().trim());
        data.put("doctorSpecialization", request.doctorSpecialization() == null ? "" : request.doctorSpecialization());
        data.put("reason", request.reason().trim());
        data.put("date", date.toString());                // yyyy-MM-dd
        data.put("time", time.toString());                // HH:mm
        data.put("status", "Confirmed");
        data.put("createdAt", Instant.now().toString());

        DocumentReference ref = Futures.await(db.collection(APPOINTMENTS).add(data));
        return toAppointment(Futures.await(ref.get()));
    }

    private static Appointment toAppointment(DocumentSnapshot d) {
        return new Appointment(
                d.getId(),
                d.getString("userId"),
                d.getString("doctorName"),
                d.getString("doctorSpecialization"),
                d.getString("reason"),
                d.getString("date"),
                d.getString("time"),
                d.getString("status"),
                d.getString("createdAt"));
    }

    private static LocalDate parseDate(String value) {
        try {
            return LocalDate.parse(value == null ? "" : value);
        } catch (DateTimeParseException e) {
            throw new ApiException(HttpStatus.BAD_REQUEST, "Please select an appointment date.");
        }
    }

    private static LocalTime parseTime(String value) {
        try {
            return LocalTime.parse(value == null ? "" : value);
        } catch (DateTimeParseException e) {
            throw new ApiException(HttpStatus.BAD_REQUEST, "Please select an appointment time.");
        }
    }

    private static boolean isBlank(String value) {
        return value == null || value.isBlank();
    }
}
