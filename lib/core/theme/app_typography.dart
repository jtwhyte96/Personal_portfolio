import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Centralized typography definitions combining modern Google Fonts
/// (Outfit for headlines, Inter for body, JetBrains Mono for eyebrows/code)
/// with graceful fallbacks.
class AppTypography {
  AppTypography._();

  // Eyebrows / Monospace tags
  static TextStyle eyebrow({Color color = AppColors.accentViolet}) {
    return GoogleFonts.jetBrainsMono(
      fontSize: 13,
      fontWeight: FontWeight.w600,
      letterSpacing: 1.5,
      color: color,
    );
  }

  // Display / Hero Headings
  static TextStyle displayLarge({Color color = AppColors.textPrimary}) {
    return GoogleFonts.outfit(
      fontSize: 48,
      fontWeight: FontWeight.w800,
      letterSpacing: -1.2,
      height: 1.15,
      color: color,
    );
  }

  static TextStyle displayMedium({Color color = AppColors.textPrimary}) {
    return GoogleFonts.outfit(
      fontSize: 36,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.8,
      height: 1.2,
      color: color,
    );
  }

  static TextStyle displaySmall({Color color = AppColors.textPrimary}) {
    return GoogleFonts.outfit(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.5,
      height: 1.25,
      color: color,
    );
  }

  // Section Headlines
  static TextStyle headlineMedium({Color color = AppColors.textPrimary}) {
    return GoogleFonts.outfit(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.4,
      height: 1.3,
      color: color,
    );
  }

  static TextStyle titleMedium({Color color = AppColors.textPrimary}) {
    return GoogleFonts.outfit(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.2,
      height: 1.35,
      color: color,
    );
  }

  // Body text
  static TextStyle bodyLarge({Color color = AppColors.textSecondary}) {
    return GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.1,
      height: 1.6,
      color: color,
    );
  }

  static TextStyle bodyMedium({Color color = AppColors.textSecondary}) {
    return GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.1,
      height: 1.55,
      color: color,
    );
  }

  static TextStyle bodySmall({Color color = AppColors.textMuted}) {
    return GoogleFonts.inter(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.2,
      height: 1.5,
      color: color,
    );
  }

  // Button text
  static TextStyle button({Color color = Colors.white}) {
    return GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.3,
      color: color,
    );
  }

  // Code / Monospace snippet
  static TextStyle codeSnippet({Color color = AppColors.textPrimary}) {
    return GoogleFonts.jetBrainsMono(
      fontSize: 13,
      fontWeight: FontWeight.w400,
      height: 1.5,
      color: color,
    );
  }
}
