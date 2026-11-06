# Basic Usage

```dart
HealthbridgeConnector.instance.InsertAppointment(insertAppointmentVariables).execute();
HealthbridgeConnector.instance.UpdateAppointment(updateAppointmentVariables).execute();
HealthbridgeConnector.instance.InsertConsultationRequest(insertConsultationRequestVariables).execute();
HealthbridgeConnector.instance.CancelConsultationRequest(cancelConsultationRequestVariables).execute();
HealthbridgeConnector.instance.InsertMedicationOrder(insertMedicationOrderVariables).execute();
HealthbridgeConnector.instance.InsertMedicationOrderItem(insertMedicationOrderItemVariables).execute();
HealthbridgeConnector.instance.CancelMedicationOrder(cancelMedicationOrderVariables).execute();
HealthbridgeConnector.instance.InsertPatient(insertPatientVariables).execute();
HealthbridgeConnector.instance.UpdateUserDetails(updateUserDetailsVariables).execute();
HealthbridgeConnector.instance.UpdatePatientDetails(updatePatientDetailsVariables).execute();

```

## Optional Fields

Some operations may have optional fields. In these cases, the Flutter SDK exposes a builder method, and will have to be set separately.

Optional fields can be discovered based on classes that have `Optional` object types.

This is an example of a mutation with an optional field:

```dart
await HealthbridgeConnector.instance.InsertUser({ ... })
.phoneNumber(...)
.execute();
```

Note: the above example is a mutation, but the same logic applies to query operations as well. Additionally, `createMovie` is an example, and may not be available to the user.

