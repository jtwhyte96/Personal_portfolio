import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/glass_card.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../models/about_data.dart';

/// Screen 003: Professional Profile ("A Little About Me") Section.
///
/// Features maintainable, editable descriptions of core engineering capabilities,
/// software problem solving, AI agent workflows, UI/UX design, and continuous learning.
class ProfessionalProfileSection extends StatelessWidget {
  const ProfessionalProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= AppConstants.desktopBreakpoint;
    final isMobile = screenWidth < AppConstants.tabletBreakpoint;

    final pillars = ProfilePillar.allPillars;

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
                eyebrow: '// A LITTLE ABOUT ME',
                title: 'Background & Approach',
                description:
                    'An overview of my technical foundation, problem-solving mindset, and practical focus areas.',
              ),
              const SizedBox(height: 40),

              LayoutBuilder(
                builder: (context, constraints) {
                  if (isDesktop) {
                    // 2 Column Grid for Desktop
                    final itemWidth = (constraints.maxWidth - 24) / 2;
                    return Wrap(
                      spacing: 24,
                      runSpacing: 24,
                      children: pillars.map((pillar) {
                        return SizedBox(
                          width: itemWidth,
                          child: _ProfileCard(pillar: pillar),
                        );
                      }).toList(),
                    );
                  } else {
                    // Single column on tablet & mobile
                    return Column(
                      children: pillars.map((pillar) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: _ProfileCard(pillar: pillar),
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

class _ProfileCard extends StatelessWidget {
  final ProfilePillar pillar;

  const _ProfileCard({required this.pillar});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      enableHoverLift: true,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: pillar.accentColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: pillar.accentColor.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Icon(
                  pillar.icon,
                  size: 20,
                  color: pillar.accentColor,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pillar.title,
                      style: AppTypography.titleMedium().copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      pillar.subtitle,
                      style: AppTypography.eyebrow(color: pillar.accentColor)
                          .copyWith(fontSize: 10, letterSpacing: 1.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            pillar.description,
            style: AppTypography.bodyMedium().copyWith(height: 1.6),
          ),
        ],
      ),
    );
  }
}
