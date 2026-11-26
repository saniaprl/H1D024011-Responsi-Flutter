import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData get theme {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
    ).copyWith(
      primary: AppColors.primaryDark,
      onPrimary: Colors.white,
      secondary: AppColors.secondary,
      onSecondary: AppColors.textPrimary,
      tertiary: AppColors.tertiary,
      onTertiary: AppColors.textPrimary,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
      error: AppColors.error,
      onError: Colors.white,
      outline: AppColors.border,
    );
    return _build(scheme, AppColors.background, AppColors.surface);
  }

  static ThemeData get darkTheme {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
    ).copyWith(
      primary: AppColors.primary,
      onPrimary: const Color(0xFF12343A),
      secondary: AppColors.secondary,
      onSecondary: const Color(0xFF17351D),
      tertiary: AppColors.tertiary,
      onTertiary: const Color(0xFF20351A),
      surface: const Color(0xFF172427),
      onSurface: const Color(0xFFE5F0ED),
      error: AppColors.error,
      onError: Colors.white,
      outline: const Color(0xFF526864),
    );
    return _build(
      scheme,
      const Color(0xFF101A1C),
      const Color(0xFF172427),
    );
  }

  static ThemeData _build(
    ColorScheme scheme,
    Color background,
    Color surface,
  ) {
    final isDark = scheme.brightness == Brightness.dark;
    final textPrimary = scheme.onSurface;
    final textSecondary = isDark
        ? const Color(0xFFB5C8C3)
        : AppColors.textSecondary;
    final textMuted = isDark
        ? const Color(0xFF8FA7A0)
        : AppColors.textMuted;

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: background,
      canvasColor: background,
      appBarTheme: AppBarTheme(
        centerTitle: false,
        backgroundColor: Colors.transparent,
        foregroundColor: textPrimary,
        surfaceTintColor: background,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        hintStyle: TextStyle(color: textMuted),
        prefixIconColor: scheme.primary,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide(color: scheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide(color: scheme.primary, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
      textTheme: TextTheme(
        headlineMedium: TextStyle(fontWeight: FontWeight.w800, color: textPrimary),
        titleLarge: TextStyle(fontWeight: FontWeight.w700, color: textPrimary),
        titleMedium: TextStyle(fontWeight: FontWeight.w700, color: textPrimary),
        bodyLarge: TextStyle(color: textPrimary),
        bodyMedium: TextStyle(color: textSecondary),
        bodySmall: TextStyle(color: textMuted),
      ),
    );
  }
}
