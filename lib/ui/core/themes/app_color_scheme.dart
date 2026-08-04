import 'package:flutter/material.dart';

class AppColorScheme {
  final Color background;
  final Color cardBackground;
  final Color inputBackground;
  final Color inputBorder;
  final Color buttonSecondary;
  final Color textPrimary;
  final Color textSecondary;
  final Color divider;

  const AppColorScheme({
    required this.background,
    required this.cardBackground,
    required this.inputBackground,
    required this.inputBorder,
    required this.buttonSecondary,
    required this.textPrimary,
    required this.textSecondary,
    required this.divider,
  });

  static const AppColorScheme dark = AppColorScheme(
    background: Color(0xFF0D1420),
    cardBackground: Color(0xFF141E30),
    inputBackground: Color(0xFF1A2540),
    inputBorder: Color(0xFF263555),
    buttonSecondary: Color(0xFF1A2540),
    textPrimary: Colors.white,
    textSecondary: Color(0xFF7B8FA8),
    divider: Color(0xFF263555),
  );

  static const AppColorScheme light = AppColorScheme(
    background: Color(0xFFF2F5F9),
    cardBackground: Colors.white,
    inputBackground: Color(0xFFEEF2F8),
    inputBorder: Color(0xFFC8D4E8),
    buttonSecondary: Color(0xFFEEF2F8),
    textPrimary: Color(0xFF0D1420),
    textSecondary: Color(0xFF6B7FA8),
    divider: Color(0xFFC8D4E8),
  );

  static AppColorScheme of(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? dark : light;
}
