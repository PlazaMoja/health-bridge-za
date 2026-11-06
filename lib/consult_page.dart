import 'package:flutter/material.dart';
import 'consultations_page.dart';
import 'services/app_error.dart';
import 'services/consultation_service.dart';
import 'services/sql_service.dart';

class ConsultPage extends StatefulWidget {
  const ConsultPage({super.key});

  @override
  State<ConsultPage> createState() => _ConsultPageState();
}

class _ConsultPageState extends State<ConsultPage> {
  final SqlService _sql = SqlService();
  late Future<List<dynamic>> _workers;

  @override
  void initState() {
    super.initState();
    _workers = _sql.allHealthcareWorkers();
  }

  void openMyConsultations() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ConsultationsPage()),
    );
  }

  Future<void> requestConsultation(dynamic worker) async {
    final doctorName = 'Dr ${worker.user.firstName} ${worker.user.lastName}';
    final sent = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) => _RequestForm(
        doctorName: doctorName,
        healthcareWorkerId: worker.id as String,
      ),
    );
    if (sent == true && mounted) {
      final messenger = ScaffoldMessenger.of(context);
      messenger.hideCurrentSnackBar();
      // Newer Flutter keeps a snackbar that has a button on screen until it
      // is tapped, so it gets a close (X) icon and is hidden after 4 seconds.
      final bar = messenger.showSnackBar(
        SnackBar(
          content: Text('Request sent to $doctorName.'),
          duration: const Duration(seconds: 4),
          showCloseIcon: true,
          action: SnackBarAction(
            label: 'View',
            onPressed: openMyConsultations,
          ),
        ),
      );
      var isShowing = true;
      bar.closed.then((_) => isShowing = false);
      Future.delayed(const Duration(seconds: 4), () {
        if (isShowing) bar.close();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Talk to a Doctor'),
        actions: [
          IconButton(
            tooltip: 'My consultations',
            onPressed: openMyConsultations,
            icon: const Icon(Icons.event_note_outlined),
          ),
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _workers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Unable to load doctors.\n${AppError.message(snapshot.error!)}', textAlign: TextAlign.center));
          }
          final workers = snapshot.data!;
          if (workers.isEmpty) return const Center(child: Text('No doctors available'));
          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: workers.length,
            itemBuilder: (context, index) {
              final worker = workers[index];
              final specialty = worker.specialization ?? worker.profession ?? 'General Practitioner';
              return Card(
                child: ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  title: Text('Dr ${worker.user.firstName} ${worker.user.lastName}'),
                  subtitle: Text('$specialty\n${worker.clinic.name}'),
                  isThreeLine: true,
                  trailing: FilledButton(
                    onPressed: () => requestConsultation(worker),
                    child: const Text('Request'),
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

/// The bottom sheet where the patient fills in the request.
/// Pops true once the request is saved.
class _RequestForm extends StatefulWidget {
  final String doctorName;
  final String healthcareWorkerId;

  const _RequestForm({required this.doctorName, required this.healthcareWorkerId});

  @override
  State<_RequestForm> createState() => _RequestFormState();
}

class _RequestFormState extends State<_RequestForm> {
  final reasonController = TextEditingController();
  DateTime date = DateTime.now().add(const Duration(days: 1));
  String time = 'morning';
  String mode = 'phone';
  bool isSending = false;

  @override
  void dispose() {
    reasonController.dispose();
    super.dispose();
  }

  Future<void> pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(now.year, now.month, now.day),
      lastDate: now.add(const Duration(days: 60)),
      helpText: 'Preferred date',
    );
    if (picked != null) setState(() => date = picked);
  }

  Future<void> send() async {
    setState(() => isSending = true);
    try {
      await ConsultationService().request(
        healthcareWorkerId: widget.healthcareWorkerId,
        reason: reasonController.text,
        preferredDate: date,
        preferredTime: time,
        mode: mode,
      );
      if (mounted) Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppError.message(e))),
      );
    } finally {
      if (mounted) setState(() => isSending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Keeps the form above the keyboard on phones.
      padding: EdgeInsets.fromLTRB(
          20, 0, 20, MediaQuery.of(context).viewInsets.bottom + 20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Request a consultation with ${widget.doctorName}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: reasonController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'What would you like to discuss?',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text('How would you like to talk?',
                style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(
                    value: 'phone',
                    icon: Icon(Icons.phone_outlined),
                    label: Text('Phone call')),
                ButtonSegment(
                    value: 'video',
                    icon: Icon(Icons.videocam_outlined),
                    label: Text('Video call')),
              ],
              selected: {mode},
              showSelectedIcon: false,
              onSelectionChanged: (s) => setState(() => mode = s.first),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: pickDate,
              icon: const Icon(Icons.calendar_today_outlined),
              label: Text(
                  'Preferred date: ${date.day}/${date.month}/${date.year}'),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: time,
              decoration: const InputDecoration(
                labelText: 'Preferred time',
                border: OutlineInputBorder(),
              ),
              items: ConsultationService.times.entries
                  .map((e) =>
                      DropdownMenuItem(value: e.key, child: Text(e.value)))
                  .toList(),
              onChanged: (v) => setState(() => time = v ?? 'morning'),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: isSending ? null : send,
              child: isSending
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2))
                  : const Text('Send request'),
            ),
            const SizedBox(height: 8),
            const Text(
              'The clinic will contact you to confirm a time.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
