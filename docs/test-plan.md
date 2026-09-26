# HealthBridge test plan

## Repository scope and limitations

The supplied checkout currently contains a Flutter client backed by Firebase Authentication and Cloud Firestore, plus a `PostgresService` that calls a Cloud Functions HTTP base URL. It does not contain `schema.gql`, `dataconnect.yaml`, generated Data Connect GraphQL operations or SDK, a `seed-data/` directory, a backend implementation, or the report that identifies the test-matrix spreadsheet. Therefore SQL seed counts, Data Connect constraint behavior, and server-side journey results cannot be confirmed or exercised from this checkout.

Do not treat the expected cases below as passing results. They need to be run against the team's deployed Data Connect API or its configured local/emulator environment once the backend and schema are included.

## Automated backend test cases requested

| ID | Case | Required assertion | Result |
|---|---|---|---|
| API-01 | Insert appointment with valid patient | Mutation succeeds and appointment is readable | Not run: GraphQL API/schema absent |
| API-02 | Insert appointment with invalid patient ID | Mutation is rejected by the patient foreign key | Not run: GraphQL API/schema absent |
| API-03 | Insert user without email | Mutation is rejected by the NOT NULL constraint | Not run: GraphQL API/schema absent |
| API-04 | Duplicate clinic-medicine key | Second insert is rejected by the composite key | Not run: GraphQL API/schema absent |
| API-05 | Concurrent queue entries | Concurrent inserts receive unique sequential queue numbers | Not run: GraphQL API/schema absent |
| FLOW-01 | Patient journey | Register user, create patient, book appointment, join queue, complete appointment, create medical record; read back each persisted step | Not run: backend API/schema absent |

## UAT cases

The requested UAT actual results depend on a live backend and realistic test accounts. No test run or live environment credentials/configuration for the described Data Connect backend are present here, so actual outcomes are **not verified**. Do not enter “Pass” based on this plan.

| UAT case | Actual result from this checkout |
|---|---|
| Patient registers and books appointment at preferred clinic | Not verified; no live Data Connect API available in repository |
| Patient views medical history | Not verified; no live Data Connect API available in repository |
| Clinic worker updates daily queue | Not verified; no live Data Connect API available in repository |
| System prevents double booking | Not verified; no backend uniqueness/transaction implementation available in repository |
| Patient cancels appointment | UI now requests confirmation before calling the Firestore cancellation update; persistence not verified against a running Firebase project |

## Flutter checks

- Appointments are streamed from Firestore in `lib/appointments_page.dart`.
- Clinic discovery queries Firestore and lets a user search clinic names and province text in `lib/Clinics_page.dart`; no sort control was found.
- Appointment cancellation uses a confirmation dialog and shows green success or red error feedback.
- Full CRUD coverage for Patient and Appointment screens is not present in this checkout: there is no Patient screen, and only appointment creation and cancellation are exposed in the reviewed Flutter screens. Small-screen rendering still needs device verification. Firestore stream errors are shown on appointments and clinic screens; booking-time errors are shown as a SnackBar.
- No hardcoded clinician or appointment examples were found in the UI scan, but that does not establish that every screen is backed by a live query.
- No emulator/device execution was performed as part of this repository audit.
