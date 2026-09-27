package com.healthbridge.backend.config;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.cloud.firestore.Firestore;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.cloud.FirestoreClient;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Stream;

/**
 * Connects the backend to Firebase using the admin (service account) key.
 * The key stays on the server - the Flutter app never sees it.
 */
@Configuration
public class FirebaseConfig {

    private static final Logger log = LoggerFactory.getLogger(FirebaseConfig.class);

    @Value("${firebase.credentials-path:serviceAccountKey.json}")
    private String credentialsPath;

    @Bean
    public Firestore firestore() throws IOException {
        if (FirebaseApp.getApps().isEmpty()) {
            Path keyFile = findKeyFile();
            log.info("Using Firebase key: {}", keyFile.toAbsolutePath());

            try (InputStream key = Files.newInputStream(keyFile)) {
                FirebaseOptions options = FirebaseOptions.builder()
                        .setCredentials(GoogleCredentials.fromStream(key))
                        .build();
                FirebaseApp.initializeApp(options);
            }
        }
        return FirestoreClient.getFirestore();
    }

    /**
     * Looks for the key in the configured path first, then for any
     * "*firebase-adminsdk*.json" file in the current folder or a "backend" subfolder.
     * This way it works whether VS Code opened the backend folder or the whole project.
     */
    private Path findKeyFile() throws IOException {
        // Plain text list of where we looked (for the error message). Kept as text because
        // Windows doesn't allow '*' in a real file path.
        List<String> searched = new ArrayList<>();

        for (Path candidate : List.of(Path.of(credentialsPath), Path.of("backend").resolve(credentialsPath))) {
            searched.add(candidate.toAbsolutePath().toString());
            if (Files.isRegularFile(candidate)) {
                return candidate;
            }
        }

        for (Path folder : List.of(Path.of("."), Path.of("backend"))) {
            if (!Files.isDirectory(folder)) {
                continue;
            }
            searched.add(folder.toAbsolutePath().normalize() + java.io.File.separator + "*firebase-adminsdk*.json");
            try (Stream<Path> files = Files.list(folder)) {
                var match = files
                        .filter(Files::isRegularFile)
                        .filter(p -> {
                            String name = p.getFileName().toString();
                            return name.contains("firebase-adminsdk") && name.endsWith(".json");
                        })
                        .findFirst();
                if (match.isPresent()) {
                    return match.get();
                }
            }
        }

        throw new IllegalStateException(
                "\n\nFirebase admin key not found. Copy the firebase-adminsdk JSON file into the backend folder "
                        + "(next to pom.xml) and rename it to serviceAccountKey.json.\nLooked in:\n  "
                        + String.join("\n  ", searched) + "\n");
    }
}