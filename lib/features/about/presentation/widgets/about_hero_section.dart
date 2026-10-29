import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/app_buttons.dart';
import '../../../../shared/widgets/glass_card.dart';

/// Screen 003 Hero Section.
///
/// Features professional headline, primary heading, concise biography,
/// subtle code-inspired terminal card, and action buttons for Projects and Contact.
class AboutHeroSection extends StatelessWidget {
  final VoidCallback onExploreProjects;
  final VoidCallback onGetInTouch;

  const AboutHeroSection({
    super.key,
    required this.onExploreProjects,
    required this.onGetInTouch,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= AppConstants.desktopBreakpoint;
    final isMobile = screenWidth < AppConstants.tabletBreakpoint;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 32,
        vertical: isMobile ? 36 : 64,
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
                      child: _HeroContent(
                        isMobile: false,
                        onExploreProjects: onExploreProjects,
                        onGetInTouch: onGetInTouch,
                      ),
                    ),
                    const SizedBox(width: 48),
                    Expanded(
                      flex: 5,
                      child: const _AboutCodeTerminalVisual(),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _HeroContent(
                      isMobile: isMobile,
                      onExploreProjects: onExploreProjects,
                      onGetInTouch: onGetInTouch,
                    ),
                    const SizedBox(height: 40),
                    Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 580),
                        child: const _AboutCodeTerminalVisual(),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class _HeroContent extends StatelessWidget {
  final bool isMobile;
  final VoidCallback onExploreProjects;
  final VoidCallback onGetInTouch;

  const _HeroContent({
    required this.isMobile,
    required this.onExploreProjects,
    required this.onGetInTouch,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Eyebrow badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.accentViolet.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: AppColors.accentViolet.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Text(
            '// ABOUT ME',
            style: AppTypography.eyebrow(color: AppColors.accentViolet),
          ),
        ),
        const SizedBox(height: 16),

        // Headline
        Text(
          AppConstants.aboutPageHeading,
          style: isMobile
              ? AppTypography.displaySmall()
              : AppTypography.displayLarge(),
        ),
        const SizedBox(height: 16),

        // Professional subtitle / role badge
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppColors.accentCyan,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                AppConstants.heroHeadline,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.titleMedium(color: AppColors.accentCyan).copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: isMobile ? 14 : 18,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),

        // Concise professional introduction
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620),
          child: Text(
            'I am a software engineer focused on building robust Java applications, '
            'integrating AI-assisted workflows, and designing clean, responsive interfaces. '
            'Passionate about craftsmanship, practical problem-solving, and continuous technical growth.',
            style: isMobile
                ? AppTypography.bodyMedium().copyWith(height: 1.65)
                : AppTypography.bodyLarge().copyWith(height: 1.7),
          ),
        ),
        const SizedBox(height: 32),

        // Hero CTA buttons
        Wrap(
          spacing: 16,
          runSpacing: 12,
          children: [
            AppPrimaryButton(
              label: 'Explore My Projects',
              icon: Icons.arrow_outward_rounded,
              onPressed: onExploreProjects,
            ),
            AppSecondaryButton(
              label: 'Get In Touch',
              icon: Icons.send_rounded,
              onPressed: onGetInTouch,
            ),
          ],
        ),
      ],
    );
  }
}

/// Subtle code-inspired terminal card demonstrating technical focus cleanly
class _AboutCodeTerminalVisual extends StatelessWidget {
  const _AboutCodeTerminalVisual();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      enableHoverLift: true,
      padding: EdgeInsets.zero,
      borderColor: AppColors.accentViolet.withValues(alpha: 0.35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Window title bar with macOS-style controls
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: AppColors.surfaceSecondary,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              border: Border(
                bottom: BorderSide(color: AppColors.borderSubtle, width: 1),
              ),
            ),
            child: Row(
              children: [
                _buildDot(const Color(0xFFFF5F56)),
                const SizedBox(width: 6),
                _buildDot(const Color(0xFFFFBD2E)),
                const SizedBox(width: 6),
                _buildDot(const Color(0xFF27C93F)),
                const SizedBox(width: 12),
                const Icon(
                  Icons.terminal_rounded,
                  size: 14,
                  color: AppColors.accentViolet,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'DeveloperProfile.java',
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.codeSnippet(color: AppColors.textSecondary)
                        .copyWith(fontSize: 12),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.accentEmerald.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColors.accentEmerald.withValues(alpha: 0.4),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 5,
                        height: 5,
                        decoration: const BoxDecoration(
                          color: AppColors.accentEmerald,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'READY',
                        style: AppTypography.eyebrow(color: AppColors.accentEmerald)
                            .copyWith(fontSize: 9, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Code lines body
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCodeLine(1, 'package com.portfolio.developer;'),
                const SizedBox(height: 6),
                _buildCodeLine(2, 'public class DeveloperProfile {'),
                _buildCodeLine(
                  3,
                  '    final String name = "${AppConstants.placeholderName}";',
                  indent: 1,
                ),
                _buildCodeLine(
                  4,
                  '    final String role = "${AppConstants.heroHeadline}";',
                  indent: 1,
                ),
                _buildCodeLine(
                  5,
                  '    final String[] core = {"Java", "AI Agents", "UI/UX"};',
                  indent: 1,
                ),
                const SizedBox(height: 6),
                _buildCodeLine(
                  6,
                  '    public void buildSolution() {',
                  indent: 1,
                ),
                _buildCodeLine(
                  7,
                  '        // Crafting scalable, user-first software',
                  indent: 2,
                  isComment: true,
                ),
                _buildCodeLine(
                  8,
                  '        System.out.println("Ready to build.");',
                  indent: 2,
                ),
                _buildCodeLine(9, '    }', indent: 1),
                _buildCodeLine(10, '}'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(Color color) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildCodeLine(
    int lineNum,
    String text, {
    int indent = 0,
    bool isComment = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 24,
            child: Text(
              '$lineNum',
              style: AppTypography.codeSnippet(color: AppColors.textMuted)
                  .copyWith(fontSize: 12),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: AppTypography.codeSnippet(
                color: isComment
                    ? AppColors.textMuted
                    : (text.contains('class') || text.contains('package')
                        ? AppColors.accentViolet
                        : (text.contains('final') || text.contains('void')
                            ? AppColors.accentCyan
                            : (text.contains('"')
                                ? AppColors.accentEmerald
                                : AppColors.textPrimary))),
              ).copyWith(fontSize: 12.5),
            ),
          ),
        ],
      ),
    );
  }
}
