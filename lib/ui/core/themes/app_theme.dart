import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0D1420),
        colorScheme: const ColorScheme.dark(
          primary: AppColors.accent,
          secondary: AppColors.accentBlue,
          surface: Color(0xFF141E30),
          onPrimary: Colors.black,
          onSecondary: Colors.white,
          onSurface: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0D1420),
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.resolveWith(
            (s) => s.contains(WidgetState.selected) ? AppColors.accent : Colors.white38,
          ),
          trackColor: WidgetStateProperty.resolveWith(
            (s) => s.contains(WidgetState.selected)
                ? AppColors.accent.withOpacity(0.3)
                : const Color(0xFF263555),
          ),
        ),
      );

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF2F5F9),
        colorScheme: const ColorScheme.light(
          primary: AppColors.accent,
          secondary: AppColors.accentBlue,
          surface: Colors.white,
          onPrimary: Colors.black,
          onSecondary: Colors.white,
          onSurface: Color(0xFF0D1420),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF2F5F9),
          elevation: 0,
          iconTheme: IconThemeData(color: Color(0xFF0D1420)),
        ),
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.resolveWith(
            (s) => s.contains(WidgetState.selected) ? AppColors.accent : Colors.white,
          ),
          trackColor: WidgetStateProperty.resolveWith(
            (s) => s.contains(WidgetState.selected)
                ? AppColors.accent.withOpacity(0.4)
                : const Color(0xFFC8D4E8),
          ),
        ),
      );
}
