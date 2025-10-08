import 'package:flutter/material.dart';

/// Ocean Professional theme configuration for the app.
/// Uses Material 3 with blue primary, amber secondary accents, and clean surfaces.
class AppTheme {
  AppTheme._();

  // Core color palette
  static const Color primary = Color(0xFF2563EB); // Blue 600-ish
  static const Color secondary = Color(0xFFF59E0B); // Amber 500
  static const Color success = Color(0xFFF59E0B); // Alias to secondary as requested
  static const Color error = Color(0xFFEF4444); // Red 500
  static const Color surface = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF9FAFB);
  static const Color text = Color(0xFF111827);

  // Gradient for headers/sections: soft blue to gray
  // from blue-500/10 to gray-50 => Color(0x1A3B82F6) to Color(0xFFFAFAFA)
  static const LinearGradient headerGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0x1A3B82F6),
      Color(0xFFFAFAFA),
    ],
  );

  // Rounded corners
  static const BorderRadius commonRadius = BorderRadius.all(Radius.circular(12));

  // PUBLIC_INTERFACE
  static ThemeData lightTheme() {
    final colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: primary,
      onPrimary: Colors.white,
      secondary: secondary,
      onSecondary: Colors.black,
      error: error,
      onError: Colors.white,
      surface: surface,
      onSurface: text,
      // For completeness in M3:
      tertiary: const Color(0xFF0EA5E9), // cyan accent (subtle)
      onTertiary: Colors.white,
      surfaceContainerHighest: const Color(0xFFF3F4F6),
      surfaceContainerHigh: const Color(0xFFF5F6F8),
      surfaceContainer: const Color(0xFFF7F8FA),
      surfaceContainerLow: const Color(0xFFF8FAFC),
      surfaceContainerLowest: const Color(0xFFFFFFFF),
      outline: const Color(0xFFCBD5E1),
      outlineVariant: const Color(0xFFE5E7EB),
      scrim: Colors.black.withAlpha(66),
      shadow: Colors.black.withAlpha(28),
      surfaceTint: primary,
      inverseSurface: const Color(0xFF111827),
      onInverseSurface: const Color(0xFFF9FAFB),
      inversePrimary: const Color(0xFF93C5FD),
      primaryContainer: const Color(0xFFE0E7FF),
      onPrimaryContainer: const Color(0xFF1E3A8A),
      secondaryContainer: const Color(0xFFFFF3C4),
      onSecondaryContainer: const Color(0xFF92400E),
      errorContainer: const Color(0xFFFFE4E6),
      onErrorContainer: const Color(0xFF7F1D1D),
      surfaceBright: const Color(0xFFFFFFFF),
      surfaceDim: const Color(0xFFF3F4F6),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: background,
      fontFamily: null,
      textTheme: const TextTheme(
        headlineLarge: TextStyle(fontWeight: FontWeight.w700, color: text),
        headlineMedium: TextStyle(fontWeight: FontWeight.w700, color: text),
        headlineSmall: TextStyle(fontWeight: FontWeight.w600, color: text),
        titleLarge: TextStyle(fontWeight: FontWeight.w600, color: text),
        titleMedium: TextStyle(fontWeight: FontWeight.w600, color: text),
        bodyLarge: TextStyle(fontWeight: FontWeight.w400, color: text),
        bodyMedium: TextStyle(fontWeight: FontWeight.w400, color: text),
        labelLarge: TextStyle(fontWeight: FontWeight.w600, color: text),
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0.5,
        scrolledUnderElevation: 1.0,
        centerTitle: true,
        backgroundColor: surface,
        foregroundColor: text,
      ),
      cardTheme: CardTheme(
        elevation: 1.0,
        color: surface,
        surfaceTintColor: primary,
        shape: RoundedRectangleBorder(borderRadius: commonRadius),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: primary,
        unselectedItemColor: Color(0xFF6B7280),
        backgroundColor: surface,
        elevation: 2,
        type: BottomNavigationBarType.fixed,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: const Color(0xFFE5E7EB),
        selectedColor: secondary.withAlpha(230),
        labelStyle: const TextStyle(color: text, fontWeight: FontWeight.w600),
        shape: const StadiumBorder(),
        side: const BorderSide(color: Color(0xFFE5E7EB)),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 1.0,
          backgroundColor: primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: commonRadius),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: secondary,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: commonRadius),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFF3F4F6),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: commonRadius,
          borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: commonRadius,
          borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: commonRadius,
          borderSide: const BorderSide(color: primary, width: 1.5),
        ),
      ),
    );
  }
}
