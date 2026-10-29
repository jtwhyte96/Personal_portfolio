import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/app_chip.dart';
import '../../../../shared/widgets/glass_card.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../models/about_data.dart';

/// Screen 003: Technical Focus Section.
///
/// Features 4 responsive cards for Software Development, AI & Agent Workflows,
/// UI/UX, and General IT, presenting skills as focus areas without arbitrary scores.
class TechnicalFocusSection extends StatelessWidget {
  const TechnicalFocusSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < AppConstants.tabletBreakpoint;

    final areas = TechnicalFocusArea.allAreas;

    return Padding(
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
                eyebrow: '// TECHNICAL FOCUS',
                title: 'Technical Focus Areas',
                description:
                    'Core areas of practice, engineering disciplines, and software tools I actively utilize and develop.',
              ),
              const SizedBox(height: 40),

              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth >= 960) {
                    // 2x2 Grid on Large screens
                    final cardWidth = (constraints.maxWidth - 24) / 2;
                    return Wrap(
                      spacing: 24,
                      runSpacing: 24,
                      children: areas.map((area) {
                        return SizedBox(
                          width: cardWidth,
                          child: _TechnicalFocusCard(area: area),
                        );
                      }).toList(),
                    );
                  } else {
                    // 1 Column on smaller screens
                    return Column(
                      children: areas.map((area) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: _TechnicalFocusCard(area: area),
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

class _TechnicalFocusCard extends StatelessWidget {
  final TechnicalFocusArea area;

  const _TechnicalFocusCard({required this.area});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < AppConstants.tabletBreakpoint;

    return GlassCard(
      enableHoverLift: true,
      borderColor: area.accentColor.withValues(alpha: 0.25),
      padding: EdgeInsets.all(isMobile ? 18 : 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row with Icon, Category Title, and Tag
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: area.accentColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: area.accentColor.withValues(alpha: 0.35),
                  ),
                ),
                child: Icon(
                  area.icon,
                  size: 22,
                  color: area.accentColor,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      area.category,
                      style: AppTypography.titleMedium().copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      area.tag,
                      style: AppTypography.eyebrow(color: area.accentColor)
                          .copyWith(fontSize: 10, letterSpacing: 1.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Short descriptive paragraph
          Text(
            area.description,
            style: AppTypography.bodySmall(color: AppColors.textSecondary)
                .copyWith(height: 1.55),
          ),
          const SizedBox(height: 20),

          const Divider(color: AppColors.borderSubtle),
          const SizedBox(height: 16),

          // Skills Chips
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: area.skills.map((skill) {
              return AppChip(
                label: skill,
                accentColor: area.accentColor,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
