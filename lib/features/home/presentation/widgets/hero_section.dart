import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/app_buttons.dart';
import 'hero_tech_visual.dart';

/// Hero Section containing headline, supporting copy, primary/secondary CTAs,
/// and the abstract interactive tech composition.
class HeroSection extends StatelessWidget {
  final VoidCallback onExploreWork;
  final VoidCallback onGetInTouch;

  const HeroSection({
    super.key,
    required this.onExploreWork,
    required this.onGetInTouch,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= AppConstants.desktopBreakpoint;
    final isMobile = screenWidth < AppConstants.tabletBreakpoint;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 32,
        vertical: isMobile ? 48 : 80,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
          child: isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 6,
                      child: _HeroCopy(
                        isMobile: false,
                        onExploreWork: onExploreWork,
                        onGetInTouch: onGetInTouch,
                      ),
                    ),
                    const SizedBox(width: 48),
                    const Expanded(
                      flex: 5,
                      child: HeroTechVisual(),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _HeroCopy(
                      isMobile: isMobile,
                      onExploreWork: onExploreWork,
                      onGetInTouch: onGetInTouch,
                    ),
                    const SizedBox(height: 48),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 420),
                      child: const HeroTechVisual(),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class _HeroCopy extends StatelessWidget {
  final bool isMobile;
  final VoidCallback onExploreWork;
  final VoidCallback onGetInTouch;

  const _HeroCopy({
    required this.isMobile,
    required this.onExploreWork,
    required this.onGetInTouch,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Intro eyebrow with editable personal-name placeholder
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.accentViolet.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.accentViolet.withValues(alpha: 0.35),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: AppColors.accentViolet,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  '// WELCOME • ${AppConstants.placeholderName}',
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.eyebrow(color: AppColors.accentViolet).copyWith(
                    fontSize: isMobile ? 11 : 13,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Exact headline with gradient accent
        if (isMobile)
          Text(
            AppConstants.heroHeadline,
            textAlign: TextAlign.center,
            style: AppTypography.displaySmall(),
          )
        else
          Text.rich(
            TextSpan(
              style: AppTypography.displayLarge(),
              children: [
                const TextSpan(text: 'Java Developer\n• '),
                WidgetSpan(
                  child: ShaderMask(
                    shaderCallback: (bounds) =>
                        AppColors.primaryGradient.createShader(bounds),
                    child: Text(
                      'AI & UI/UX',
                      style: AppTypography.displayLarge(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 20),

        // Supporting copy
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 580),
          child: Text(
            AppConstants.heroSubheadline,
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            style: isMobile
                ? AppTypography.bodyMedium()
                : AppTypography.bodyLarge(),
          ),
        ),
        const SizedBox(height: 36),

        // Action buttons
        Wrap(
          spacing: 16,
          runSpacing: 14,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: [
            AppPrimaryButton(
              label: 'Explore My Work',
              icon: Icons.arrow_downward_rounded,
              onPressed: onExploreWork,
            ),
            AppSecondaryButton(
              label: 'Get In Touch',
              icon: Icons.mail_outline_rounded,
              onPressed: onGetInTouch,
            ),
          ],
        ),
      ],
    );
  }
}
