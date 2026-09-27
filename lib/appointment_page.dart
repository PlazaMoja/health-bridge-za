import 'package:flutter/material.dart';
import 'services/app_error.dart';
import 'services/sql_service.dart';

class AppointmentPage extends StatefulWidget {
  final String clinicId;

  const AppointmentPage({super.key, required this.clinicId});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  final SqlService _sql = SqlService();
  final TextEditingController _reason = TextEditingController();
  String? _workerId;
  String? _serviceId;
  DateTime? _date;
  TimeOfDay? _time;
  bool _loading = true;
  bool _saving = false;
  String? _error;
  List<dynamic> _workers = [];
  List<dynamic> _services = [];

  @override
  void initState() {
    super.initState();
    _loadOptions();
  }

  Future<void> _loadOptions() async {
    try {
      final results = await Future.wait([
        _sql.healthcareWorkers(widget.clinicId),
        _sql.services(widget.clinicId),
      ]);
      if (!mounted) return;
      setState(() {
        _workers = results[0];
        _services = results[1];
        _loading = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _error = AppError.message(error);
        _loading = false;
      });
    }
  }

  Future<void> _book() async {
    if (_workerId == null || _serviceId == null || _date == null || _time == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Select a doctor, service, date, and time.')),
      );
      return;
    }
    setState(() => _saving = true);
    try {
      final start = '${_time!.hour.toString().padLeft(2, '0')}:${_time!.minute.toString().padLeft(2, '0')}';
      final endHour = (_time!.hour + 1) % 24;
      final end = '${endHour.toString().padLeft(2, '0')}:${_time!.minute.toString().padLeft(2, '0')}';
      await _sql.createAppointment(
        clinicId: widget.clinicId,
        serviceId: _serviceId!,
        healthcareWorkerId: _workerId!,
        appointmentDate: _date!,
        startTime: start,
        endTime: end,
        reason: _reason.text.trim(),
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Appointment booked successfully.')),
        );
        Navigator.pop(context);
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not book appointment: ${AppError.message(error)}')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  void dispose() {
    _reason.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (_error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Book Appointment')),
        body: Center(child: Text('Unable to load booking options.\n$_error', textAlign: TextAlign.center)),
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Book Appointment')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: 'Healthcare professional'),
            items: _workers.map((worker) => DropdownMenuItem<String>(
              value: worker.id,
              child: Text('${worker.user.firstName} ${worker.user.lastName}'),
            )).toList(),
            onChanged: (value) => setState(() => _workerId = value),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: 'Service'),
            items: _services.map((service) => DropdownMenuItem<String>(
              value: service.id,
              child: Text(service.name),
            )).toList(),
            onChanged: (value) => setState(() => _serviceId = value),
          ),
          const SizedBox(height: 16),
          ListTile(
            title: Text(_date == null ? 'Select date' : '${_date!.day}/${_date!.month}/${_date!.year}'),
            leading: const Icon(Icons.calendar_today),
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                firstDate: DateTime.now(),
                lastDate: DateTime(2035),
                initialDate: DateTime.now(),
              );
              if (date != null) setState(() => _date = date);
            },
          ),
          ListTile(
            title: Text(_time == null ? 'Select time' : _time!.format(context)),
            leading: const Icon(Icons.access_time),
            onTap: () async {
              final time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
              if (time != null) setState(() => _time = time);
            },
          ),
          TextField(
            controller: _reason,
            maxLines: 3,
            decoration: const InputDecoration(labelText: 'Reason for visit'),
          ),
          const SizedBox(height: 28),
          FilledButton(
            onPressed: _saving ? null : _book,
            child: Text(_saving ? 'Booking...' : 'Book appointment'),
          ),
        ],
      ),
    );
  }
}
