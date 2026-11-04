import 'package:flutter/material.dart';

import 'services/app_error.dart';
import 'services/settings_service.dart';

/// Profile > Notifications. Each switch is saved to the backend straight away.
class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool isSaving = false;

  Future<void> save(Map<String, dynamic> changes) async {
    setState(() => isSaving = true);
    try {
      await SettingsService.saveMap(changes);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppError.message(e))),
      );
    } finally {
      if (mounted) setState(() => isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Notifications',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        bottom: isSaving
            ? const PreferredSize(
                preferredSize: Size.fromHeight(2),
                child: LinearProgressIndicator(minHeight: 2),
              )
            : null,
      ),
      body: ValueListenableBuilder<AppSettings>(
        valueListenable: SettingsService.settings,
        builder: (context, settings, _) => ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _card('Appointments', [
              _switch(
                title: 'Appointment reminders',
                subtitle: 'Get a reminder before each booked appointment.',
                value: settings.appointmentReminders,
                onChanged: (v) => save({'appointmentReminders': v}),
              ),
              if (settings.appointmentReminders) ...[
                const SizedBox(height: 10),
                const Text(
                  'Remind me',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: SegmentedButton<String>(
                    segments: const [
                      ButtonSegment(value: '15min', label: Text('15 min')),
                      ButtonSegment(value: '1hour', label: Text('1 hour')),
                      ButtonSegment(value: '1day', label: Text('1 day')),
                    ],
                    selected: {settings.reminderTime},
                    showSelectedIcon: false,
                    onSelectionChanged: isSaving
                        ? null
                        : (selection) =>
                            save({'reminderTime': selection.first}),
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'before the appointment',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ]),
            const SizedBox(height: 20),
            _card('Health', [
              _switch(
                title: 'Medication reminders',
                subtitle: 'Reminders to take or re-order your medication.',
                value: settings.medicationReminders,
                onChanged: (v) => save({'medicationReminders': v}),
              ),
              const Divider(),
              _switch(
                title: 'Health tips',
                subtitle: 'Occasional tips for staying healthy.',
                value: settings.healthTips,
                onChanged: (v) => save({'healthTips': v}),
              ),
            ]),
            const SizedBox(height: 20),
            _card('Other', [
              _switch(
                title: 'News and offers',
                subtitle: 'Updates about new Health Bridge features.',
                value: settings.promotions,
                onChanged: (v) => save({'promotions': v}),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _switch({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle),
      value: value,
      onChanged: isSaving ? null : onChanged,
    );
  }

  Widget _card(String title, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }
}
