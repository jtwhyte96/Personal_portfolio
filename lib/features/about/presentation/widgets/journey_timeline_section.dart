import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/glass_card.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../models/about_data.dart';

/// Screen 003: Professional Journey Timeline ("My Development Journey") Section.
///
/// Features a responsive vertical milestone timeline illustrating programming foundations,
/// OOP applications, AI-assisted development workflows, and portfolio project delivery.
class JourneyTimelineSection extends StatelessWidget {
  const JourneyTimelineSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < AppConstants.tabletBreakpoint;

    final milestones = JourneyMilestone.allMilestones;

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
                eyebrow: '// MY DEVELOPMENT JOURNEY',
                title: 'Development Milestones',
                description:
                    'Key milestones marking my ongoing technical evolution from software foundations to applied engineering.',
              ),
              const SizedBox(height: 48),

              // Responsive vertical timeline list
              Column(
                children: List.generate(milestones.length, (index) {
                  final milestone = milestones[index];
                  final isLast = index == milestones.length - 1;

                  return _TimelineRow(
                    milestone: milestone,
                    isLast: isLast,
                    isMobile: isMobile,
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TimelineRow extends StatelessWidget {
  final JourneyMilestone milestone;
  final bool isLast;
  final bool isMobile;

  const _TimelineRow({
    required this.milestone,
    required this.isLast,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Step Node Column with connecting line
          SizedBox(
            width: isMobile ? 44 : 64,
            child: Column(
              children: [
                // Step badge circle
                Container(
                  width: isMobile ? 36 : 48,
                  height: isMobile ? 36 : 48,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        milestone.accentColor,
                        milestone.accentColor.withValues(alpha: 0.6),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: milestone.accentColor.withValues(alpha: 0.35),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      milestone.step,
                      style: AppTypography.eyebrow(color: Colors.white).copyWith(
                        fontSize: isMobile ? 12 : 14,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                ),

                // Vertical Connector Line
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            milestone.accentColor.withValues(alpha: 0.6),
                            AppColors.borderSubtle,
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 14),

          // Milestone Content Card
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 28),
              child: GlassCard(
                enableHoverLift: true,
                padding: EdgeInsets.all(isMobile ? 18 : 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          milestone.icon,
                          size: 18,
                          color: milestone.accentColor,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            milestone.title,
                            style: AppTypography.titleMedium().copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: isMobile ? 15 : 17,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      milestone.description,
                      style: AppTypography.bodyMedium(color: AppColors.textSecondary)
                          .copyWith(height: 1.55),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
