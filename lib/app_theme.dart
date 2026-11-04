import 'package:flutter/material.dart';

/// The app's light and dark themes. Screens take their colours from here
/// (Theme.of(context)...) instead of hardcoding white/black, so they work
/// in both modes.
class AppTheme {
  static const brandBlue = Color(0xFF2F80ED);

  static ThemeData light() => _build(Brightness.light);
  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final scheme = ColorScheme.fromSeed(
      seedColor: brandBlue,
      brightness: brightness,
    );
    // Page background and card colours. Light mode keeps the original look.
    final background = isDark ? const Color(0xFF121418) : const Color(0xFFF7F9FC);
    final card = isDark ? const Color(0xFF1E2228) : Colors.white;
    final text = isDark ? Colors.white : Colors.black;

    return ThemeData(
      fontFamily: 'Arial',
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: background,
      cardColor: card,
      appBarTheme: AppBarTheme(
        backgroundColor: card,
        foregroundColor: text,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: text),
        titleTextStyle: TextStyle(
          fontFamily: 'Arial',
          fontSize: 22,
          color: text,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(backgroundColor: card),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: card,
      ),
      dialogTheme: DialogThemeData(backgroundColor: card),
    );
  }
}
