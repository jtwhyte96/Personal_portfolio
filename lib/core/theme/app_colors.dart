import 'package:flutter/material.dart';

/// Centralized color palette based on the Stitch visual direction.
/// Dark aesthetic with charcoal backgrounds, glowing violet/blue accents,
/// and high-contrast typography.
class AppColors {
  AppColors._();

  // Core backgrounds & surfaces
  static const Color background = Color(0xFF0B0D12);
  static const Color surfacePrimary = Color(0xFF12151D);
  static const Color surfaceSecondary = Color(0xFF191D28);
  static const Color surfaceTertiary = Color(0xFF222736);

  // Borders & Dividers
  static const Color borderSubtle = Color(0xFF232838);
  static const Color borderCard = Color(0xFF2D3449);
  static const Color borderFocus = Color(0xFF8B5CF6);

  // Typography
  static const Color textPrimary = Color(0xFFF4F6FC);
  static const Color textSecondary = Color(0xFFA4ABBC);
  static const Color textMuted = Color(0xFF6B7280);

  // Accents
  static const Color accentViolet = Color(0xFF8B5CF6);
  static const Color accentBlue = Color(0xFF4F8CFF);
  static const Color accentCyan = Color(0xFF38BDF8);
  static const Color accentEmerald = Color(0xFF10B981);
  static const Color accentAmber = Color(0xFFF59E0B);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [accentViolet, accentBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient surfaceGradient = LinearGradient(
    colors: [Color(0xFF161A24), Color(0xFF0E1118)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient glowGradient = LinearGradient(
    colors: [Color(0x338B5CF6), Color(0x1A4F8CFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroCardGlow = LinearGradient(
    colors: [Color(0x1F8B5CF6), Color(0x1A4F8CFF), Colors.transparent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
