import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'models.dart';

/// Thrown when a request fails. [message] is safe to show to the user.
class ApiException implements Exception {
  final String message;
  const ApiException(this.message);

  @override
  String toString() => message;
}

/// All calls from the app to the Spring Boot backend live here.
/// The app never talks to Firebase directly - the backend does that.
class ApiService {
  /// Where the backend is running.
  /// - Chrome / Windows app: http://localhost:8080
  /// - Android emulator:     http://10.0.2.2:8080 (the emulator's name for your PC)
  /// - Real phone: run with  --dart-define=API_URL=http://<your PC's IP>:8080
  static String get baseUrl {
    const override = String.fromEnvironment('API_URL');
    if (override.isNotEmpty) return override;
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      return 'http://10.0.2.2:8080';
    }
    return 'http://localhost:8080';
  }

  static const _timeout = Duration(seconds: 15);
  static const _jsonHeaders = {'Content-Type': 'application/json'};

  // ---------- Auth ----------

  static Future<AppUser> login(String phone, String password) async {
    final data = await _post('/api/auth/login', {
      'phone': phone,
      'password': password,
    });
    return AppUser.fromJson(data);
  }

  static Future<AppUser> register(
      String name, String phone, String password) async {
    final data = await _post('/api/auth/register', {
      'name': name,
      'phone': phone,
      'password': password,
    });
    return AppUser.fromJson(data);
  }

  // ---------- Lists ----------

  static Future<List<Clinic>> getClinics() async {
    final data = await _get('/api/clinics') as List;
    return data.map((e) => Clinic.fromJson(e)).toList();
  }

  static Future<List<Doctor>> getDoctors() async {
    final data = await _get('/api/doctors') as List;
    return data.map((e) => Doctor.fromJson(e)).toList();
  }

  static Future<List<Medication>> getMedications() async {
    final data = await _get('/api/medications') as List;
    return data.map((e) => Medication.fromJson(e)).toList();
  }

  // ---------- Appointments ----------

  static Future<List<Appointment>> getAppointments(String userId) async {
    final data =
        await _get('/api/appointments', query: {'userId': userId}) as List;
    return data.map((e) => Appointment.fromJson(e)).toList();
  }

  static Future<Appointment> bookAppointment({
    required String userId,
    required Doctor doctor,
    required String reason,
    required String date, // yyyy-MM-dd
    required String time, // HH:mm
  }) async {
    final data = await _post('/api/appointments', {
      'userId': userId,
      'doctorName': doctor.name,
      'doctorSpecialization': doctor.specialization,
      'reason': reason,
      'date': date,
      'time': time,
    });
    return Appointment.fromJson(data);
  }

  // ---------- Helpers ----------

  static Future<dynamic> _get(String path, {Map<String, String>? query}) {
    final uri = Uri.parse('$baseUrl$path').replace(queryParameters: query);
    return _send(() => http.get(uri));
  }

  static Future<dynamic> _post(String path, Map<String, dynamic> body) {
    final uri = Uri.parse('$baseUrl$path');
    return _send(
        () => http.post(uri, headers: _jsonHeaders, body: jsonEncode(body)));
  }

  static Future<dynamic> _send(Future<http.Response> Function() request) async {
    final http.Response response;
    try {
      response = await request().timeout(_timeout);
    } on TimeoutException {
      throw const ApiException(
          'The server took too long to respond. Please try again.');
    } catch (_) {
      throw const ApiException(
          "Can't reach the server. Make sure the backend is running.");
    }

    dynamic data;
    if (response.body.isNotEmpty) {
      try {
        data = jsonDecode(response.body);
      } on FormatException {
        data = null;
      }
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return data;
    }

    final message = data is Map && data['message'] is String
        ? data['message'] as String
        : 'Something went wrong (error ${response.statusCode}).';
    throw ApiException(message);
  }
}
