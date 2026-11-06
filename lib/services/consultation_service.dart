import '../dataconnect_generated/generated.dart';
import 'account_service.dart';

/// One consultation request as the app shows it.
class Consultation {
  final String id;
  final String doctorName;
  final String specialty;
  final String clinicName;
  final String clinicPhone;
  final String reason;
  final DateTime preferredDate;
  final String preferredTime; // 'morning', 'afternoon', 'evening'
  final String mode; // 'phone' or 'video'
  final String status; // 'requested', 'confirmed', 'completed', 'cancelled'

  const Consultation({
    required this.id,
    required this.doctorName,
    required this.specialty,
    required this.clinicName,
    required this.clinicPhone,
    required this.reason,
    required this.preferredDate,
    required this.preferredTime,
    required this.mode,
    required this.status,
  });
}

/// Talk to a Doctor: sending consultation requests and listing them.
class ConsultationService {
  static const times = {
    'morning': 'Morning (08:00–12:00)',
    'afternoon': 'Afternoon (12:00–16:00)',
    'evening': 'Evening (16:00–19:00)',
  };

  final HealthbridgeConnector _connector = HealthbridgeConnector.instance;
  final AccountService _account = AccountService();

  Future<void> request({
    required String healthcareWorkerId,
    required String reason,
    required DateTime preferredDate,
    required String preferredTime,
    required String mode,
  }) async {
    if (reason.trim().length < 5) {
      throw Exception('Please describe briefly what you would like to discuss.');
    }
    final today = DateTime.now();
    final day = DateTime(preferredDate.year, preferredDate.month, preferredDate.day);
    if (day.isBefore(DateTime(today.year, today.month, today.day))) {
      throw Exception('Please choose a date that is not in the past.');
    }
    final ids = await _account.ids();
    await _connector
        .insertConsultationRequest(
          patientId: ids.patientId,
          healthcareWorkerId: healthcareWorkerId,
          reason: reason.trim(),
          preferredDate: day,
          preferredTime: preferredTime,
          mode: mode,
        )
        .execute();
  }

  Future<List<Consultation>> mine() async {
    final ids = await _account.ids();
    final result = await _connector
        .listConsultationRequests(patientId: ids.patientId)
        .execute();
    return result.data.consultationRequests.map((c) {
      final worker = c.healthcareWorker;
      return Consultation(
        id: c.id,
        doctorName: 'Dr ${worker.user.firstName} ${worker.user.lastName}',
        specialty: worker.specialization ?? worker.profession ?? '',
        clinicName: worker.clinic.name,
        clinicPhone: worker.clinic.phoneNumber ?? '',
        reason: c.reason,
        preferredDate: c.preferredDate,
        preferredTime: c.preferredTime,
        mode: c.mode,
        status: c.status,
      );
    }).toList();
  }

  Future<void> cancel(String id) async {
    await _connector.cancelConsultationRequest(id: id).execute();
  }
}
