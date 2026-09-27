package com.healthbridge.backend.controller;

import com.healthbridge.backend.model.Appointment;
import com.healthbridge.backend.model.AppointmentRequest;
import com.healthbridge.backend.service.AppointmentService;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * GET  /api/appointments?userId=+27821234567
 * POST /api/appointments  { "userId", "doctorName", "doctorSpecialization", "reason", "date": "2026-10-01", "time": "14:30" }
 */
@RestController
@RequestMapping("/api/appointments")
public class AppointmentController {

    private final AppointmentService appointmentService;

    public AppointmentController(AppointmentService appointmentService) {
        this.appointmentService = appointmentService;
    }

    @GetMapping
    public List<Appointment> list(@RequestParam(required = false) String userId) {
        return appointmentService.getForUser(userId);
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public Appointment create(@RequestBody AppointmentRequest request) {
        return appointmentService.create(request);
    }
}
