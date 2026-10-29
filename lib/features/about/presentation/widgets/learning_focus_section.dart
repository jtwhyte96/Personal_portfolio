import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/glass_card.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../models/about_data.dart';

/// Screen 003: Current Learning Focus ("What I'm Focused On") Section.
///
/// Features three distinct development cards highlighting Engineering Fundamentals,
/// AI-Enhanced Development, and Building Real Projects.
class LearningFocusSection extends StatelessWidget {
  const LearningFocusSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < AppConstants.tabletBreakpoint;

    final items = LearningFocusItem.allItems;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.surfacePrimary,
        border: Border.symmetric(
          horizontal: BorderSide(color: AppColors.borderSubtle, width: 1),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 32,
        vertical: isMobile ? 56 : 80,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                eyebrow: "// WHAT I'M FOCUSED ON",
                title: 'Current Learning & Development Focus',
                description:
                    'Active growth areas and competencies I am strengthening through continuous practice and projects.',
              ),
              const SizedBox(height: 40),

              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth >= 900) {
                    // 3 columns on wider screens
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (int i = 0; i < items.length; i++) ...[
                          if (i > 0) const SizedBox(width: 16),
                          Expanded(
                            child: _LearningCard(item: items[i]),
                          ),
                        ],
                      ],
                    );
                  } else {
                    // 1 column on tablet & mobile
                    return Column(
                      children: items.map((item) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: _LearningCard(item: item),
                        );
                      }).toList(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LearningCard extends StatelessWidget {
  final LearningFocusItem item;

  const _LearningCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      enableHoverLift: true,
      borderColor: item.accentColor.withValues(alpha: 0.25),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: item.accentColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: item.accentColor.withValues(alpha: 0.35),
              ),
            ),
            child: Icon(
              item.icon,
              size: 24,
              color: item.accentColor,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            item.title,
            style: AppTypography.titleMedium().copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            item.subtitle,
            style: AppTypography.eyebrow(color: item.accentColor)
                .copyWith(fontSize: 10, letterSpacing: 1.0),
          ),
          const SizedBox(height: 14),
          Text(
            item.description,
            style: AppTypography.bodyMedium().copyWith(height: 1.6),
          ),
        ],
      ),
    );
  }
}
