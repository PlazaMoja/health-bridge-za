import 'package:flutter/material.dart';

import '../dataconnect_generated/generated.dart';
import 'account_service.dart';

/// The user's Notifications and Settings choices (the Preference table).
class AppSettings {
  final String themeMode; // 'system', 'light', 'dark'
  final String textSize; // 'small', 'normal', 'large'
  final bool appointmentReminders;
  final String reminderTime; // '15min', '1hour', '1day'
  final bool medicationReminders;
  final bool healthTips;
  final bool promotions;
  final bool shareDataForResearch;

  const AppSettings({
    this.themeMode = 'system',
    this.textSize = 'normal',
    this.appointmentReminders = true,
    this.reminderTime = '1hour',
    this.medicationReminders = true,
    this.healthTips = true,
    this.promotions = false,
    this.shareDataForResearch = false,
  });

  ThemeMode get flutterThemeMode {
    switch (themeMode) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  double get textScale {
    switch (textSize) {
      case 'small':
        return 0.9;
      case 'large':
        return 1.2;
      default:
        return 1.0;
    }
  }
}

/// Loads and saves [AppSettings]. The whole app listens to [settings], so a
/// new theme or text size shows straight away on every screen.
class SettingsService {
  static final ValueNotifier<AppSettings> settings =
      ValueNotifier(const AppSettings());

  static final HealthbridgeConnector _connector = HealthbridgeConnector.instance;

  static String? _loadedForUid;
  static String? _preferenceId;

  /// Called when someone logs in. Safe to call more than once.
  static Future<void> loadFor(String firebaseUid) async {
    if (_loadedForUid == firebaseUid) return;
    _loadedForUid = firebaseUid;
    try {
      await _load();
    } catch (_) {
      // Not fatal - the app just uses the default settings.
    }
  }

  /// Called on logout. The other settings go back to the defaults, but the
  /// theme and text size stay as they were, so the login screen does not
  /// suddenly switch between light and dark. The next person's own choices
  /// load as soon as they log in.
  static void reset() {
    _loadedForUid = null;
    _preferenceId = null;
    final current = settings.value;
    settings.value = AppSettings(
      themeMode: current.themeMode,
      textSize: current.textSize,
    );
  }

  static Future<void> _load() async {
    final ids = await AccountService().ids();
    final result =
        await _connector.getPreference(userId: ids.userId).execute();
    final p = result.data.preference;
    if (p == null) {
      final created =
          await _connector.insertPreference(userId: ids.userId).execute();
      _preferenceId = created.data.preference_insert.id;
      settings.value = const AppSettings();
      return;
    }
    _preferenceId = p.id;
    const d = AppSettings();
    settings.value = AppSettings(
      themeMode: p.themeMode ?? d.themeMode,
      textSize: p.textSize ?? d.textSize,
      appointmentReminders: p.appointmentReminders ?? d.appointmentReminders,
      reminderTime: p.reminderTime ?? d.reminderTime,
      medicationReminders: p.medicationReminders ?? d.medicationReminders,
      healthTips: p.healthTips ?? d.healthTips,
      promotions: p.promotions ?? d.promotions,
      shareDataForResearch: p.shareDataForResearch ?? d.shareDataForResearch,
    );
  }

  /// Same as [save], with the changes as a map, e.g. {'healthTips': false}.
  static Future<void> saveMap(Map<String, dynamic> changes) => save(
        themeMode: changes['themeMode'] as String?,
        textSize: changes['textSize'] as String?,
        appointmentReminders: changes['appointmentReminders'] as bool?,
        reminderTime: changes['reminderTime'] as String?,
        medicationReminders: changes['medicationReminders'] as bool?,
        healthTips: changes['healthTips'] as bool?,
        promotions: changes['promotions'] as bool?,
        shareDataForResearch: changes['shareDataForResearch'] as bool?,
      );

  /// Saves the given changes, e.g. save(themeMode: 'dark').
  /// The screen updates straight away; if saving fails it changes back
  /// and the error is thrown so the screen can show it.
  static Future<void> save({
    String? themeMode,
    String? textSize,
    bool? appointmentReminders,
    String? reminderTime,
    bool? medicationReminders,
    bool? healthTips,
    bool? promotions,
    bool? shareDataForResearch,
  }) async {
    final before = settings.value;
    settings.value = AppSettings(
      themeMode: themeMode ?? before.themeMode,
      textSize: textSize ?? before.textSize,
      appointmentReminders: appointmentReminders ?? before.appointmentReminders,
      reminderTime: reminderTime ?? before.reminderTime,
      medicationReminders: medicationReminders ?? before.medicationReminders,
      healthTips: healthTips ?? before.healthTips,
      promotions: promotions ?? before.promotions,
      shareDataForResearch: shareDataForResearch ?? before.shareDataForResearch,
    );

    try {
      if (_preferenceId == null) await _load();
      var update = _connector.updatePreference(id: _preferenceId!);
      if (themeMode != null) update = update.themeMode(themeMode);
      if (textSize != null) update = update.textSize(textSize);
      if (appointmentReminders != null) {
        update = update.appointmentReminders(appointmentReminders);
      }
      if (reminderTime != null) update = update.reminderTime(reminderTime);
      if (medicationReminders != null) {
        update = update.medicationReminders(medicationReminders);
      }
      if (healthTips != null) update = update.healthTips(healthTips);
      if (promotions != null) update = update.promotions(promotions);
      if (shareDataForResearch != null) {
        update = update.shareDataForResearch(shareDataForResearch);
      }
      await update.execute();
    } catch (_) {
      settings.value = before;
      rethrow;
    }
  }
}
