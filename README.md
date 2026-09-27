# Health Bridge

Flutter health app with a Spring Boot backend that stores data in Firebase Firestore.

```
Flutter app  --HTTP-->  Spring Boot backend (backend/)  --Admin SDK-->  Firestore (health-28c44)
```

The Flutter app never talks to Firebase directly. Only the backend holds the Firebase admin key.

| Folder     | What it is                                    |
|------------|-----------------------------------------------|
| `lib/`     | Flutter app                                   |
| `backend/` | Spring Boot API (Java 17, Maven)              |

---

## 1. Run the backend

**First time only**

0. You need JDK 17 or newer. Check with `java -version`.
1. In the Firebase console for **health-28c44**, open **Firestore Database**. If it says *Create database*, create it (test mode is fine for development).
2. Copy the Firebase admin JSON key (`...firebase-adminsdk-....json`) into the `backend` folder, next to `pom.xml`. Renaming it to `serviceAccountKey.json` is optional.
   It is in `.gitignore`. **Never commit it.**

**Every time**

1. In VS Code, go to **File → Open Folder** and open the `backend` folder in its own window.
2. Wait until the status bar shows Java is ready. The first time, it downloads the dependencies, which takes a few minutes.
3. Open `src/main/java/com/healthbridge/backend/HealthBridgeBackendApplication.java` and click **Run** above `main`.
   (Or, if you have Maven: `mvn spring-boot:run` in the `backend` folder.)
4. Look for `Firestore connected - starter data is in place.` in the output.

**Check it works:** open these in your browser.

- http://localhost:8080/api/health shows `{"status":"ok"}`
- http://localhost:8080/api/clinics shows the 3 clinics

The first run fills Firestore with the clinics, doctors and medications that used to be hardcoded in the app. You can edit them in the Firebase console after that.

## 2. Run the Flutter app

Keep the backend running, then in the project folder:

```
flutter pub get
flutter run -d chrome
```

(Or pick **Chrome** in the bottom-right of VS Code and press **F5**.)

Try it: **Sign Up**, then book an appointment and open the **Appointments** tab. The booking also shows up in Firestore under `appointments`.

### Android emulator

The app automatically uses `http://10.0.2.2:8080` on the emulator, which is how the emulator reaches your PC.

1. If there's no `android` folder yet, run `flutter create --platforms=android .`
2. In `android/app/src/main/AndroidManifest.xml`:
   - above `<application`, add
     `<uses-permission android:name="android.permission.INTERNET"/>`
   - inside the `<application` tag, add
     `android:usesCleartextTraffic="true"`
     (this allows plain `http://` during development)

### Real phone

Put the phone on the same Wi-Fi as your PC, find your PC's IP address with `ipconfig`, then run:

```
flutter run --dart-define=API_URL=http://192.168.x.x:8080
```

---

## API endpoints

| Method | Path                               | Body / query                                                        |
|--------|------------------------------------|---------------------------------------------------------------------|
| GET    | `/api/health`                      | none                                                                |
| POST   | `/api/auth/register`               | `{ "name", "phone", "password" }`                                   |
| POST   | `/api/auth/login`                  | `{ "phone", "password" }`                                           |
| GET    | `/api/clinics`                     | none                                                                |
| GET    | `/api/doctors`                     | none                                                                |
| GET    | `/api/medications`                 | none                                                                |
| GET    | `/api/appointments?userId=...`     | none                                                                |
| POST   | `/api/appointments`                | `{ "userId", "doctorName", "doctorSpecialization", "reason", "date": "yyyy-MM-dd", "time": "HH:mm" }` |

Errors come back as `{ "message": "..." }`, and the app shows that message to the user.

## Firestore collections

| Collection     | Contents                                                              |
|----------------|-----------------------------------------------------------------------|
| `users`        | Document ID is the phone number (`+27...`). Fields: name, phone, passwordHash (BCrypt), createdAt |
| `clinics`      | name, address, distance, availability, order                          |
| `doctors`      | name, specialization, order                                           |
| `medications`  | name, type, category, order                                           |
| `appointments` | userId, doctorName, doctorSpecialization, reason, date, time, status, createdAt |

## Not connected yet

These still use placeholder data: Talk to Doctor, Health Records, the medication **Order** button, "Next available appointment", Forgot Password, and the social login buttons.

## Known limitations (fine for development)

- There's no login token. The app sends the user's ID with each request, and the backend trusts it. Add JWT or Firebase Auth before real users use the app.
- CORS allows any origin (see `CorsConfig.java`). Restrict it before deploying.
- The login is forgotten when the app closes.
