# Profile, Order Medication and Dark Mode

What this branch adds on top of `main`:

| Area | What it does | Where the data lives |
|---|---|---|
| Profile > Personal Information | Edit first/last name, phone, date of birth, gender, address, emergency contact | `User` + `Patient` (new fields: `address`, `emergencyContactName`) |
| Profile > Privacy & Security | Change password (Firebase Auth), research-data switch, delete account | Firebase Auth + `DeletePatientAccount` mutation |
| Profile > Notifications | Reminder switches and reminder time | new `Preference` table |
| Profile > Settings | **Dark mode** (System / Light / Dark) and text size, applied app-wide | new `Preference` table |
| Order Medication | Medication list with prices, cart, collect at a clinic or delivery, My Orders with cancel | new `Medication`, `MedicationOrder`, `MedicationOrderItem` tables |
| Talk to a Doctor | Request a phone or video consultation (reason, preferred date and time); My Consultations with cancel | new `ConsultationRequest` table |
| Nearby Clinics | Asks for the user's location and sorts clinics nearest first with the distance; A–Z if location is refused | existing `Clinic.latitude` / `longitude`, filled by `seed_clinic_locations.gql` |

The old Order Medication page called a Cloud Function in another project
(`us-central1-plaza-dd8b3`), which failed. It now uses Data Connect like the rest of the app.
`lib/services/postgres_service.dart` is no longer used by any screen.

## One-time setup (needs Firebase CLI access to `health-28c44`)

Run these from the project folder:

```
npm install -g firebase-tools
firebase login

# 1. Regenerate the Dart SDK in lib/dataconnect_generated (also checks the .gql files)
firebase dataconnect:sdk:generate

# 2. Deploy the schema + operations. It will show the SQL changes
#    (new tables/columns only - nothing is dropped) and ask you to confirm.
firebase deploy --only dataconnect

# 3. Add the starter medications (safe to run again)
firebase dataconnect:execute dataconnect/seed/seed_medications.gql SeedMedications

# 4. Add map coordinates to the 15 clinics (safe to run again)
firebase dataconnect:execute dataconnect/seed/seed_clinic_locations.gql SeedClinicLocations
```

Then:

```
flutter pub get
flutter run -d web-server --web-port 5001
```

## Testing on your own PC (no access to health-28c44 needed)

The local emulators give you a private copy of Auth and the database. Nothing
you do here touches the real project.

Terminal 1 - start the emulators (leave it running):

```
firebase dataconnect:sdk:generate
firebase emulators:start --only auth,dataconnect
```

Terminal 2 - fill the local database, then run the app against it:

```
$env:FIREBASE_DATA_CONNECT_EMULATOR_HOST = "127.0.0.1:9399"
firebase dataconnect:execute dataconnect/seed/seed_all.gql SeedAll
firebase dataconnect:execute dataconnect/seed/seed_medications.gql SeedMedications
flutter run -d web-server --web-port 5001 --dart-define=USE_EMULATOR=true
```

(That `$env:` line is PowerShell. In Git Bash use
`export FIREBASE_DATA_CONNECT_EMULATOR_HOST=127.0.0.1:9399`.)

Open http://localhost:5001 and **sign up a new account** - accounts on the real
project don't exist in the emulator. The emulator dashboard at
http://localhost:4000 shows the test users. The local data is kept in
`dataconnect/.dataconnect/pgliteData` (git-ignored), so it survives restarts.
Run the seed commands only once.

Without `--dart-define=USE_EMULATOR=true` the app uses the real project as normal.

## Things to know

- Order totals are worked out in the app. Data Connect has no server code here to
  re-check prices, so a modified app could send its own prices. Fine for the
  project; a Cloud Function should place orders before real use.
- Orders start as `pending`. There's no pharmacy screen yet, so change `status` to
  `ready` / `completed` in the Firebase console to test those.
- Like the existing operations, the new ones use `@auth(level: USER)` and take IDs
  from the app, so a signed-in user could in theory read or change another user's
  rows. Switching to `auth.uid` checks would fix this for all operations.
- Notification settings are saved, but nothing sends notifications yet.
- Consultation requests stay `requested` until a clinic confirms them; there's no clinic-staff screen yet, so change `status` in the Firebase console to test `confirmed` / `completed`.
- Clinic coordinates are approximate (within about 1 km). The browser only shares location on `localhost` or HTTPS.
