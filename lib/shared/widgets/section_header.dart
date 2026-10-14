import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

/// Reusable section title component providing consistent eyebrow, headline,
/// and description hierarchy across all portfolio sections.
class SectionHeader extends StatelessWidget {
  final String eyebrow;
  final String title;
  final String? description;
  final bool isCentered;
  final Color? eyebrowColor;

  const SectionHeader({
    super.key,
    required this.eyebrow,
    required this.title,
    this.description,
    this.isCentered = false,
    this.eyebrowColor,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 680;

    return Column(
      crossAxisAlignment:
          isCentered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Eyebrow tag
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: (eyebrowColor ?? AppColors.accentViolet).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: (eyebrowColor ?? AppColors.accentViolet).withValues(alpha: 0.25),
              width: 1,
            ),
          ),
          child: Text(
            eyebrow,
            style: AppTypography.eyebrow(
              color: eyebrowColor ?? AppColors.accentViolet,
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Main Title
        Text(
          title,
          textAlign: isCentered ? TextAlign.center : TextAlign.start,
          style: isMobile
              ? AppTypography.displaySmall()
              : AppTypography.displayMedium(),
        ),

        // Optional Description
        if (description != null) ...[
          const SizedBox(height: 12),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Text(
              description!,
              textAlign: isCentered ? TextAlign.center : TextAlign.start,
              style: isMobile
                  ? AppTypography.bodyMedium()
                  : AppTypography.bodyLarge(),
            ),
          ),
        ],
      ],
    );
  }
}
