import 'package:flutter/material.dart';
import 'services/app_error.dart';
import 'services/sql_service.dart';

class AppointmentsPage extends StatefulWidget {
  const AppointmentsPage({super.key});

  @override
  State<AppointmentsPage> createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  final SqlService _sql = SqlService();
  late Future<List<dynamic>> _appointments;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  void _reload() => _appointments = _sql.appointments();

  Future<void> _cancel(dynamic appointment) async {
    try {
      await _sql.cancelAppointment(appointment.id, 'Cancelled by patient');
      if (mounted) {
        setState(() {
          _appointments = _sql.appointments();
        });
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not cancel appointment: ${AppError.message(error)}')),
        );
      }
    }
  }

  Future<void> _editNotes(dynamic appointment) async {
    final controller = TextEditingController(text: appointment.reason ?? '');
    final notes = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit appointment notes'),
        content: TextField(controller: controller, maxLines: 3),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, controller.text.trim()), child: const Text('Save')),
        ],
      ),
    );
    controller.dispose();
    if (notes == null) return;
    try {
      await _sql.updateAppointmentNotes(appointment.id, notes);
      if (mounted) {
        setState(() {
          _appointments = _sql.appointments();
        });
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not update appointment: ${AppError.message(error)}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Appointments')),
      body: FutureBuilder<List<dynamic>>(
        future: _appointments,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Unable to load appointments.\n${AppError.message(snapshot.error!)}', textAlign: TextAlign.center),
            );
          }
          final appointments = snapshot.data!;
          if (appointments.isEmpty) return const Center(child: Text('No appointments found'));
          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: appointments.length,
            itemBuilder: (context, index) {
              final appointment = appointments[index];
              final status = appointment.status ?? 'confirmed';
              return Card(
                child: ListTile(
                  title: Text(appointment.reason?.isNotEmpty == true ? appointment.reason! : 'Appointment'),
                  subtitle: Text('${appointment.clinic.name} - ${appointment.service.name}\n${appointment.appointmentDate.day}/${appointment.appointmentDate.month}/${appointment.appointmentDate.year} at ${appointment.startTime}'),
                  isThreeLine: true,
                  trailing: PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'cancel') _cancel(appointment);
                      if (value == 'edit') _editNotes(appointment);
                    },
                    itemBuilder: (_) => [
                      if (status == 'confirmed') const PopupMenuItem(value: 'edit', child: Text('Edit notes')),
                      if (status == 'confirmed') const PopupMenuItem(value: 'cancel', child: Text('Cancel appointment')),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
