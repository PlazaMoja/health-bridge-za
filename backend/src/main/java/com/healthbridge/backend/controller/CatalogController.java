package com.healthbridge.backend.controller;

import com.healthbridge.backend.model.Clinic;
import com.healthbridge.backend.model.Doctor;
import com.healthbridge.backend.model.Medication;
import com.healthbridge.backend.service.CatalogService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

/**
 * GET /api/health       -> quick "is the server up?" check
 * GET /api/clinics
 * GET /api/doctors
 * GET /api/medications
 */
@RestController
@RequestMapping("/api")
public class CatalogController {

    private final CatalogService catalogService;

    public CatalogController(CatalogService catalogService) {
        this.catalogService = catalogService;
    }

    @GetMapping("/health")
    public Map<String, String> health() {
        return Map.of("status", "ok");
    }

    @GetMapping("/clinics")
    public List<Clinic> clinics() {
        return catalogService.getClinics();
    }

    @GetMapping("/doctors")
    public List<Doctor> doctors() {
        return catalogService.getDoctors();
    }

    @GetMapping("/medications")
    public List<Medication> medications() {
        return catalogService.getMedications();
    }
}
