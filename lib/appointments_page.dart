import 'package:flutter/material.dart';
import 'api_service.dart';
import 'models.dart';
import 'session.dart';
import 'widgets/load_state.dart';

class AppointmentsPage extends StatefulWidget {
  const AppointmentsPage({super.key});

  @override
  State<AppointmentsPage> createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  // Appointments now come from the database (via the backend)
  List<Appointment> appointments = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadAppointments();
  }

  Future<void> loadAppointments({bool showSpinner = true}) async {
    final user = Session.currentUser;
    if (user == null) {
      setState(() {
        isLoading = false;
        errorMessage = 'Please log in again.';
      });
      return;
    }

    setState(() {
      isLoading = showSpinner;
      errorMessage = null;
    });

    try {
      final result = await ApiService.getAppointments(user.id);
      if (!mounted) return;
      setState(() {
        appointments = result;
        isLoading = false;
      });
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() {
        errorMessage = e.message;
        isLoading = false;
      });
    }
  }

  // "2026-10-01" -> "Today", "Tomorrow" or "1/10/2026"
  String displayDate(String value) {
    final date = DateTime.tryParse(value);
    if (date == null) return value;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final difference = DateTime(date.year, date.month, date.day)
        .difference(today)
        .inDays;

    if (difference == 0) return 'Today';
    if (difference == 1) return 'Tomorrow';
    return '${date.day}/${date.month}/${date.year}';
  }

  // "14:30" -> "2:30 PM" (or 24-hour, depending on the phone's settings)
  String displayTime(String value) {
    final parts = value.split(':');
    if (parts.length < 2) return value;
    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    if (hour == null || minute == null) return value;
    return TimeOfDay(hour: hour, minute: minute).format(context);
  }

  bool isUpcoming(Appointment appointment) {
    final date = DateTime.tryParse(appointment.date);
    if (date == null) return true;
    final now = DateTime.now();
    return !date.isBefore(DateTime(now.year, now.month, now.day));
  }

  @override
  Widget build(BuildContext context) {
    final upcoming = appointments.where(isUpcoming).toList();
    final past = appointments.where((a) => !isUpcoming(a)).toList().reversed;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),

      // App Bar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'My Appointments',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),

      body: isLoading || errorMessage != null
          ? LoadState(
              isLoading: isLoading,
              errorMessage: errorMessage,
              onRetry: loadAppointments,
            )
          : RefreshIndicator(
              onRefresh: () => loadAppointments(showSpinner: false),
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [

                  // Upcoming Appointments
                  const Text(
                    'Upcoming Appointments',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  if (upcoming.isEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Text(
                        'No upcoming appointments. '
                        'Book one from the Home page.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),

                  ...upcoming.map(_appointmentCard),

                  // Past Appointments
                  if (past.isNotEmpty) ...[
                    const SizedBox(height: 15),
                    const Text(
                      'Past Appointments',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    ...past.map(_appointmentCard),
                  ],
                ],
              ),
            ),
    );
  }

  Widget _appointmentCard(Appointment appointment) {
    final confirmed = appointment.status == 'Confirmed';

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // Doctor
          Row(
            children: [
              const CircleAvatar(
                radius: 25,
                child: Icon(Icons.person),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appointment.doctorName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (appointment.doctorSpecialization.isNotEmpty)
                      Text(
                        appointment.doctorSpecialization,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Date
          Row(
            children: [
              const Icon(
                Icons.calendar_today,
                color: Color(0xFF2F80ED),
              ),
              const SizedBox(width: 10),
              Text(
                displayDate(appointment.date),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Time
          Row(
            children: [
              const Icon(
                Icons.access_time,
                color: Color(0xFF2F80ED),
              ),
              const SizedBox(width: 10),
              Text(
                displayTime(appointment.time),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          // Reason
          if (appointment.reason.isNotEmpty) ...[
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.notes,
                  color: Color(0xFF2F80ED),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    appointment.reason,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ],

          const SizedBox(height: 20),

          // Status
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 7,
            ),
            decoration: BoxDecoration(
              color: confirmed ? Colors.green.shade50 : Colors.orange.shade50,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              appointment.status,
              style: TextStyle(
                color: confirmed ? Colors.green : Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
