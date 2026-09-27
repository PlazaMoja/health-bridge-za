// Data classes that match the JSON the backend sends back.

class AppUser {
  final String id;
  final String name;
  final String phone;

  const AppUser({required this.id, required this.name, required this.phone});

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        phone: json['phone'] ?? '',
      );
}

class Clinic {
  final String id;
  final String name;
  final String address;
  final String distance;
  final String availability;

  const Clinic({
    required this.id,
    required this.name,
    required this.address,
    required this.distance,
    required this.availability,
  });

  factory Clinic.fromJson(Map<String, dynamic> json) => Clinic(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        address: json['address'] ?? '',
        distance: json['distance'] ?? '',
        availability: json['availability'] ?? '',
      );
}

class Doctor {
  final String id;
  final String name;
  final String specialization;

  const Doctor({
    required this.id,
    required this.name,
    required this.specialization,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        specialization: json['specialization'] ?? '',
      );
}

class Medication {
  final String id;
  final String name;
  final String type;
  final String category;

  const Medication({
    required this.id,
    required this.name,
    required this.type,
    required this.category,
  });

  factory Medication.fromJson(Map<String, dynamic> json) => Medication(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        type: json['type'] ?? '',
        category: json['category'] ?? '',
      );
}

class Appointment {
  final String id;
  final String doctorName;
  final String doctorSpecialization;
  final String reason;
  final String date; // yyyy-MM-dd
  final String time; // HH:mm (24-hour)
  final String status;

  const Appointment({
    required this.id,
    required this.doctorName,
    required this.doctorSpecialization,
    required this.reason,
    required this.date,
    required this.time,
    required this.status,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
        id: json['id'] ?? '',
        doctorName: json['doctorName'] ?? '',
        doctorSpecialization: json['doctorSpecialization'] ?? '',
        reason: json['reason'] ?? '',
        date: json['date'] ?? '',
        time: json['time'] ?? '',
        status: json['status'] ?? '',
      );
}
