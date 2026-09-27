package com.healthbridge.backend.config;

import com.google.cloud.firestore.CollectionReference;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.WriteBatch;
import com.healthbridge.backend.service.CatalogService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * On startup, fills the clinics, doctors and medications collections with the data
 * that used to be hardcoded in the Flutter pages - but only if a collection is empty,
 * so it never overwrites changes made in the Firebase console.
 * Turn it off with app.seed-data=false in application.properties.
 */
@Component
public class DataSeeder implements CommandLineRunner {

    private static final Logger log = LoggerFactory.getLogger(DataSeeder.class);

    private final Firestore db;

    @Value("${app.seed-data:true}")
    private boolean seedData;

    public DataSeeder(Firestore db) {
        this.db = db;
    }

    @Override
    public void run(String... args) {
        if (!seedData) {
            return;
        }
        try {
            seed(CatalogService.CLINICS, clinics());
            seed(CatalogService.DOCTORS, doctors());
            seed(CatalogService.MEDICATIONS, medications());
            log.info("Firestore connected - starter data is in place.");
        } catch (Exception e) {
            log.error("""


                    ============================================================
                    Could not read/write Firestore: {}

                    Check that:
                      1. The Firestore database exists
                         (Firebase console > Firestore Database > Create database)
                      2. The key file belongs to the health-28c44 project
                      3. This computer is online
                    ============================================================
                    """, e.getMessage());
        }
    }

    private void seed(String collection, List<Map<String, Object>> rows) throws Exception {
        CollectionReference ref = db.collection(collection);
        if (!ref.limit(1).get().get().isEmpty()) {
            return; // already has data - leave it alone
        }
        WriteBatch batch = db.batch();
        for (int i = 0; i < rows.size(); i++) {
            Map<String, Object> row = new HashMap<>(rows.get(i));
            row.put("order", i);
            batch.set(ref.document(), row);
        }
        batch.commit().get();
        log.info("Added {} starter documents to '{}'", rows.size(), collection);
    }

    // ---- Starter data (copied from the original Flutter pages) ----

    private static List<Map<String, Object>> clinics() {
        return List.of(
                Map.of("name", "Cape Town Health Clinic", "address", "12 Main Road, Cape Town",
                        "distance", "1.2 km away", "availability", "Available"),
                Map.of("name", "Community Health Centre", "address", "25 Long Street, Cape Town",
                        "distance", "2.4 km away", "availability", "Available"),
                Map.of("name", "City Medical Centre", "address", "45 Loop Street, Cape Town",
                        "distance", "3.1 km away", "availability", "Busy"));
    }

    private static List<Map<String, Object>> doctors() {
        return List.of(
                Map.of("name", "Dr. Mohau Mogorosi", "specialization", "General Practitioner"),
                Map.of("name", "Dr. Onkabetse Kgosana", "specialization", "General Practitioner"),
                Map.of("name", "Dr. Mbalenhle Motloung", "specialization", "General Practitioner"));
    }

    private static List<Map<String, Object>> medications() {
        return List.of(
                med("Headache & Pain", "Paracetamol", "Pain and fever relief"),
                med("Headache & Pain", "Ibuprofen", "Pain and inflammation relief"),
                med("Headache & Pain", "Aspirin", "Pain and fever relief"),
                med("Headache & Pain", "Diclofenac", "Pain and inflammation relief"),
                med("Headache & Pain", "Topical pain relief gel", "Local muscle and joint pain relief"),

                med("Cough & Cold", "Saline nasal spray", "Helps relieve blocked or dry nose"),
                med("Cough & Cold", "Guaifenesin", "Expectorant for mucus"),
                med("Cough & Cold", "Dextromethorphan", "Cough suppressant"),
                med("Cough & Cold", "Menthol lozenges", "Soothes throat irritation"),
                med("Cough & Cold", "Honey-based cough mixture", "Soothes cough and throat irritation"),

                med("Allergies", "Loratadine", "Antihistamine"),
                med("Allergies", "Cetirizine", "Antihistamine"),
                med("Allergies", "Chlorphenamine", "Antihistamine"),
                med("Allergies", "Saline nasal spray", "Helps rinse allergens from the nose"),
                med("Allergies", "Allergy eye drops", "Helps relieve itchy or watery eyes"),

                med("Diarrhoea & Dehydration", "Oral rehydration solution", "Replaces fluids and electrolytes"),
                med("Diarrhoea & Dehydration", "Oral rehydration salts", "Helps prevent dehydration"),
                med("Diarrhoea & Dehydration", "Zinc supplements", "May be used in some diarrhoeal illnesses"),
                med("Diarrhoea & Dehydration", "Loperamide", "Symptom relief for some types of diarrhoea"),
                med("Diarrhoea & Dehydration", "Electrolyte solution", "Replaces lost fluids and electrolytes"),

                med("Heartburn & Indigestion", "Calcium carbonate", "Antacid"),
                med("Heartburn & Indigestion", "Magnesium hydroxide", "Antacid"),
                med("Heartburn & Indigestion", "Aluminium hydroxide", "Antacid"),
                med("Heartburn & Indigestion", "Omeprazole", "Reduces stomach acid"),
                med("Heartburn & Indigestion", "Famotidine", "Reduces stomach acid"));
    }

    private static Map<String, Object> med(String category, String name, String type) {
        return Map.of("category", category, "name", name, "type", type);
    }
}
