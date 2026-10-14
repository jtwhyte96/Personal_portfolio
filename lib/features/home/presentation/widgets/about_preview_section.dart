import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/app_buttons.dart';
import '../../../../shared/widgets/glass_card.dart';
import '../../../../shared/widgets/section_header.dart';

/// About Me preview section highlighting engineering philosophy,
/// core focus areas, and future about page roadmap.
class AboutPreviewSection extends StatelessWidget {
  final VoidCallback onLearnMore;

  const AboutPreviewSection({
    super.key,
    required this.onLearnMore,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= AppConstants.desktopBreakpoint;
    final isMobile = screenWidth < AppConstants.tabletBreakpoint;

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
        vertical: 80,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                eyebrow: AppConstants.aboutEyebrow,
                title: AppConstants.aboutHeadline,
              ),
              const SizedBox(height: 32),

              if (isDesktop)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: _AboutIntroCopy(onLearnMore: onLearnMore),
                    ),
                    const SizedBox(width: 48),
                    Expanded(
                      flex: 6,
                      child: _AboutPillarsColumn(),
                    ),
                  ],
                )
              else
                Column(
                  children: [
                    _AboutIntroCopy(onLearnMore: onLearnMore),
                    const SizedBox(height: 36),
                    _AboutPillarsColumn(),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AboutIntroCopy extends StatelessWidget {
  final VoidCallback onLearnMore;

  const _AboutIntroCopy({required this.onLearnMore});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppConstants.aboutDescription,
          style: AppTypography.bodyLarge().copyWith(height: 1.7),
        ),
        const SizedBox(height: 28),
        AppSecondaryButton(
          label: 'Contact & Collaboration',
          icon: Icons.arrow_outward_rounded,
          onPressed: onLearnMore,
        ),
      ],
    );
  }
}

class _AboutPillarsColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _PillarItem(
          icon: Icons.dns_rounded,
          accentColor: AppColors.accentCyan,
          title: 'Java & Clean Architecture',
          description:
              'Crafting maintainable, test-driven backend systems with strong architectural principles, robust typing, and reliable performance.',
        ),
        SizedBox(height: 16),
        _PillarItem(
          icon: Icons.auto_awesome_rounded,
          accentColor: AppColors.accentViolet,
          title: 'AI-Augmented Engineering',
          description:
              'Leveraging generative AI and structured prompt workflows to accelerate code iteration, automate testing, and explore new architectures.',
        ),
        SizedBox(height: 16),
        _PillarItem(
          icon: Icons.palette_rounded,
          accentColor: AppColors.accentBlue,
          title: 'User-Centered UI/UX',
          description:
              'Designing purposeful interfaces in Flutter Web with intuitive hierarchies, fluid micro-interactions, and accessible styling.',
        ),
      ],
    );
  }
}

class _PillarItem extends StatelessWidget {
  final IconData icon;
  final Color accentColor;
  final String title;
  final String description;

  const _PillarItem({
    required this.icon,
    required this.accentColor,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      enableHoverLift: true,
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: accentColor.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Icon(icon, size: 20, color: accentColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.titleMedium().copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: AppTypography.bodySmall(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
