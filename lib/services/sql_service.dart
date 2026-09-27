import 'package:firebase_auth/firebase_auth.dart';
import '../dataconnect_generated/generated.dart';

class SqlService {
  final HealthbridgeConnector _connector = HealthbridgeConnector.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> currentPatientId() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception('Please sign in to continue.');

    final userResult = await _connector.getUser(firebaseUid: uid).execute();
    final user = userResult.data.user;
    if (user == null) throw Exception('Your account profile is not ready yet.');

    final patientResult = await _connector
        .getPatientByUserId(userId: user.id)
        .execute();
    final patient = patientResult.data.patient;
    if (patient == null) {
      final created = await _connector.insertPatient(userId: user.id).execute();
      return created.data.patient_insert.id;
    }
    return patient.id;
  }

  Future<List<ListClinicsClinics>> clinics() async {
    return (await _connector.listClinics().execute()).data.clinics;
  }

  Future<List<ListHealthcareWorkersHealthcareWorkers>> healthcareWorkers(
    String clinicId,
  ) async {
    return (await _connector.listHealthcareWorkers(clinicId: clinicId).execute())
        .data
        .healthcareWorkers;
  }

        Future<List<ListAllHealthcareWorkersHealthcareWorkers>> allHealthcareWorkers() async {
          return (await _connector.listAllHealthcareWorkers().execute())
          .data
          .healthcareWorkers;
        }

  Future<List<ListServicesServices>> services(String clinicId) async {
    return (await _connector.listServices(clinicId: clinicId).execute())
        .data
        .services;
  }

  Future<String> createAppointment({
    required String clinicId,
    required String serviceId,
    required String healthcareWorkerId,
    required DateTime appointmentDate,
    required String startTime,
    required String endTime,
    String? reason,
  }) async {
    final result = await _connector
        .insertAppointment(
          patientId: await currentPatientId(),
          clinicId: clinicId,
          serviceId: serviceId,
          appointmentDate: appointmentDate,
          startTime: startTime,
        )
        .healthcareWorkerId(healthcareWorkerId)
        .endTime(endTime)
        .reason(reason)
        .execute();
    return result.data.appointment_insert.id;
  }

  Future<List<ListAppointmentsAppointments>> appointments() async {
    return (await _connector
            .listAppointments(patientId: await currentPatientId())
            .execute())
        .data
        .appointments;
  }

  Future<void> cancelAppointment(String id, String reason) async {
    await _connector
        .updateAppointment(id: id)
        .status('cancelled')
        .cancellationReason(reason)
        .execute();
  }

  Future<void> updateAppointmentNotes(String id, String notes) async {
    await _connector.updateAppointment(id: id).reason(notes).execute();
  }

  Future<List<ListMedicalRecordsMedicalRecords>> medicalRecords() async {
    return (await _connector
            .listMedicalRecords(patientId: await currentPatientId())
            .execute())
        .data
        .medicalRecords;
  }
}
