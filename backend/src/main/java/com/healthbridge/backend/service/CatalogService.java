package com.healthbridge.backend.service;

import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.QueryDocumentSnapshot;
import com.healthbridge.backend.model.Clinic;
import com.healthbridge.backend.model.Doctor;
import com.healthbridge.backend.model.Medication;
import org.springframework.stereotype.Service;

import java.util.Comparator;
import java.util.List;
import java.util.function.Function;

/**
 * Read-only lists the app shows: clinics, doctors and medications.
 * Each document has an "order" number so the app shows them in a fixed order.
 * You can add/edit entries straight in the Firebase console.
 */
@Service
public class CatalogService {

    public static final String CLINICS = "clinics";
    public static final String DOCTORS = "doctors";
    public static final String MEDICATIONS = "medications";

    private final Firestore db;

    public CatalogService(Firestore db) {
        this.db = db;
    }

    public List<Clinic> getClinics() {
        return readAll(CLINICS, d -> new Clinic(
                d.getId(),
                d.getString("name"),
                d.getString("address"),
                d.getString("distance"),
                d.getString("availability")));
    }

    public List<Doctor> getDoctors() {
        return readAll(DOCTORS, d -> new Doctor(
                d.getId(),
                d.getString("name"),
                d.getString("specialization")));
    }

    public List<Medication> getMedications() {
        return readAll(MEDICATIONS, d -> new Medication(
                d.getId(),
                d.getString("name"),
                d.getString("type"),
                d.getString("category")));
    }

    private <T> List<T> readAll(String collection, Function<QueryDocumentSnapshot, T> mapper) {
        return Futures.await(db.collection(collection).get()).getDocuments().stream()
                .sorted(Comparator.comparingLong(CatalogService::orderOf))
                .map(mapper)
                .toList();
    }

    private static long orderOf(QueryDocumentSnapshot doc) {
        Long order = doc.getLong("order");
        return order == null ? Long.MAX_VALUE : order;
    }
}
