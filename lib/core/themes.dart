import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../features/authentication/auth_mock_data.dart';

class AppThemes {
  // Role-based color schemes
  static const Color studentPrimary = Color(0xFF3B82F6); // Blue
  static const Color hrPrimary = Color(0xFF059669); // Green
  static const Color adminPrimary = Color(0xFFDC2626); // Red
  static const Color financePrimary = Color(0xFFF59E0B); // Gold

  static ThemeData light({UserRole? role}) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(seedColor: _roleColor(role)),
      textTheme: GoogleFonts.poppinsTextTheme(),
      cardTheme: const CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
    );
  }

  static ThemeData dark({UserRole? role}) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _roleColor(role),
        brightness: Brightness.dark,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData(brightness: Brightness.dark).textTheme),
      cardTheme: const CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
    );
  }

  static Color _roleColor(UserRole? role) {
    switch (role) {
      case UserRole.hr:
        return hrPrimary;
      case UserRole.admin:
        return adminPrimary;
      case UserRole.finance:
        return financePrimary;
      case UserRole.student:
      default:
        return studentPrimary;
    }
  }
} 