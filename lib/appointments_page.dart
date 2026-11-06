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
    final sure = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel this appointment?'),
        content: const Text('The clinic will see that you cancelled it. This cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Keep it')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Cancel appointment')),
        ],
      ),
    );
    if (sure != true) return;
    try {
      await _sql.cancelAppointment(appointment.id, 'Cancelled by patient');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Appointment cancelled.')),
        );
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

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
      child: Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    );
  }

  Widget _appointmentCard(dynamic appointment) {
    final status = appointment.status ?? 'confirmed';
    final isCancelled = status == 'cancelled';
    final canChange = status == 'confirmed';
    final date = appointment.appointmentDate;

    return Opacity(
      opacity: isCancelled ? 0.6 : 1,
      child: Card(
        child: ListTile(
          title: Text(appointment.reason?.isNotEmpty == true ? appointment.reason! : 'Appointment'),
          subtitle: Text(
            '${appointment.clinic.name} - ${appointment.service.name}\n'
            '${date.day}/${date.month}/${date.year} at ${appointment.startTime}',
          ),
          isThreeLine: true,
          // Only confirmed appointments get the menu, so cancelled ones
          // no longer show a button that opens nothing.
          trailing: canChange
              ? PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'cancel') _cancel(appointment);
                    if (value == 'edit') _editNotes(appointment);
                  },
                  itemBuilder: (_) => const [
                    PopupMenuItem(value: 'edit', child: Text('Edit notes')),
                    PopupMenuItem(value: 'cancel', child: Text('Cancel appointment')),
                  ],
                )
              : Chip(
                  label: Text(status[0].toUpperCase() + status.substring(1)),
                  visualDensity: VisualDensity.compact,
                ),
        ),
      ),
    );
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

          final active = appointments.where((a) => (a.status ?? 'confirmed') != 'cancelled').toList();
          final cancelled = appointments.where((a) => a.status == 'cancelled').toList();

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              if (active.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Center(child: Text('No upcoming appointments')),
                ),
              ...active.map(_appointmentCard),
              if (cancelled.isNotEmpty) ...[
                const SizedBox(height: 16),
                _sectionTitle('Cancelled'),
                ...cancelled.map(_appointmentCard),
              ],
            ],
          );
        },
      ),
    );
  }
}
