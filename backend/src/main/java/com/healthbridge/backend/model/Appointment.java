package com.healthbridge.backend.model;

/**
 * A booked appointment.
 * date is "yyyy-MM-dd" and time is "HH:mm" (24-hour), so they sort correctly as text.
 */
public record Appointment(
        String id,
        String userId,
        String doctorName,
        String doctorSpecialization,
        String reason,
        String date,
        String time,
        String status,
        String createdAt) {
}
