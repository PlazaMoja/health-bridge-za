import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'services/app_error.dart';
import 'services/settings_service.dart';

/// Profile > Settings: theme (light/dark), text size and app info.
/// Theme and text size apply to the whole app straight away.
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ValueListenableBuilder<AppSettings>(
        valueListenable: SettingsService.settings,
        builder: (context, settings, _) => ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _card('Display', [
              const Text(
                'Theme',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(
                      value: 'system',
                      icon: Icon(Icons.brightness_auto_outlined),
                      label: Text('System'),
                    ),
                    ButtonSegment(
                      value: 'light',
                      icon: Icon(Icons.light_mode_outlined),
                      label: Text('Light'),
                    ),
                    ButtonSegment(
                      value: 'dark',
                      icon: Icon(Icons.dark_mode_outlined),
                      label: Text('Dark'),
                    ),
                  ],
                  selected: {settings.themeMode},
                  showSelectedIcon: false,
                  onSelectionChanged: isSaving
                      ? null
                      : (selection) => save({'themeMode': selection.first}),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'System follows your phone or computer\'s dark mode setting.',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),
              const Text(
                'Text size',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(value: 'small', label: Text('Small')),
                    ButtonSegment(value: 'normal', label: Text('Normal')),
                    ButtonSegment(value: 'large', label: Text('Large')),
                  ],
                  selected: {settings.textSize},
                  showSelectedIcon: false,
                  onSelectionChanged: isSaving
                      ? null
                      : (selection) => save({'textSize': selection.first}),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Preview: Your next appointment is tomorrow at 10:00.',
                ),
              ),
            ]),
            const SizedBox(height: 20),
            _card('About', [
              const ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.info_outline, color: Color(0xFF2F80ED)),
                title: Text('App version'),
                trailing: Text('1.0.0'),
              ),
              const Divider(),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.account_circle_outlined,
                    color: Color(0xFF2F80ED)),
                title: const Text('Signed in as'),
                subtitle: Text(
                    FirebaseAuth.instance.currentUser?.email ?? 'Not signed in'),
              ),
            ]),
          ],
        ),
      ),
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
