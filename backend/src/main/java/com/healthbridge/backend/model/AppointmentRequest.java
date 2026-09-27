package com.healthbridge.backend.model;

/** What the app sends to book an appointment. */
public record AppointmentRequest(
        String userId,
        String doctorName,
        String doctorSpecialization,
        String reason,
        String date,
        String time) {
}
