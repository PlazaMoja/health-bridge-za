import 'dart:convert';
import 'package:http/http.dart' as http;

class PostgresService {
  static const String baseUrl =
      'https://us-central1-plaza-dd8b3.cloudfunctions.net';

  Future<dynamic> get(String endpoint) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to post data: ${response.statusCode}');
    }
  }

  Future<List<dynamic>> getList(String endpoint) async {
    final data = await get(endpoint);
    if (data is List) return data;
    if (data is Map<String, dynamic>) {
      final result = data['data'];
      if (result is List) return result;
    }
    return <dynamic>[];
  }

  Future<Map<String, dynamic>> getById(String endpoint, String id) async {
    final data = await get('$endpoint/$id');
    if (data is Map<String, dynamic>) return data;
    throw Exception('Invalid response format');
  }

  // Users
  Future<Map<String, dynamic>> createUser(Map<String, dynamic> userData) async {
    return await post('users', userData);
  }

  Future<Map<String, dynamic>> getUser(String uid) async {
    return await getById('users', uid);
  }

  // Clinics
  Future<List<dynamic>> getClinics() async {
    return await getList('clinics');
  }

  Future<Map<String, dynamic>> getClinic(String clinicId) async {
    return await getById('clinics', clinicId);
  }

  // Healthcare Workers
  Future<List<dynamic>> getHealthcareWorkers(String clinicId) async {
    return await getList('healthcareWorkers?clinicId=$clinicId');
  }

  // Services
  Future<List<dynamic>> getClinicServices(String clinicId) async {
    return await getList('clinicServices?clinicId=$clinicId');
  }

  // Appointments
  Future<Map<String, dynamic>> createAppointment(
      Map<String, dynamic> appointmentData) async {
    return await post('appointments', appointmentData) as Map<String, dynamic>;
  }

  Future<List<dynamic>> getPatientAppointments(String patientId) async {
    return await getList('appointments?patientId=$patientId');
  }

  // Medicines
  Future<List<dynamic>> getMedicines(String clinicId) async {
    return await getList('clinicMedicines?clinicId=$clinicId');
  }

  Future<List<dynamic>> searchMedicines(String query) async {
    return await getList('medicines?search=$query');
  }

  // Queue
  Future<Map<String, dynamic>> joinQueue(
      String clinicId, String patientId, String appointmentId) async {
    return await post('queueEntries', {
      'clinicId': clinicId,
      'patientId': patientId,
      'appointmentId': appointmentId,
    }) as Map<String, dynamic>;
  }

  Future<List<dynamic>> getQueueEntries(String clinicId, String date) async {
    return await getList('queueEntries?clinicId=$clinicId&date=$date');
  }

  // Medical Records
  Future<List<dynamic>> getMedicalRecords(String patientId) async {
    return await getList('medicalRecords?patientId=$patientId');
  }

  // Prescriptions
  Future<List<dynamic>> getPrescriptions(String patientId) async {
    return await getList('prescriptions?patientId=$patientId');
  }

  Future<Map<String, dynamic>> createPrescription(
      Map<String, dynamic> prescriptionData) async {
    return await post('prescriptions', prescriptionData) as Map<String, dynamic>;
  }
}
