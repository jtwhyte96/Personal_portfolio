import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/app_buttons.dart';
import '../../../../shared/widgets/contact_dialog.dart';
import '../../../../shared/widgets/glass_card.dart';

/// Screen 003 Call to Action Section.
///
/// Features "LET'S BUILD SOMETHING MEANINGFUL" headline,
/// configurable "View Résumé" action, and "Contact Me" triggering the shared contact dialog.
class AboutCtaSection extends StatelessWidget {
  const AboutCtaSection({super.key});

  Future<void> _handleResumeTap(BuildContext context) async {
    final resumeUrl = AppConstants.placeholderResumeUrl.trim();

    if (resumeUrl.isNotEmpty && !resumeUrl.contains('example.com')) {
      final uri = Uri.tryParse(resumeUrl);
      if (uri != null && await canLaunchUrl(uri)) {
        await launchUrl(uri);
        return;
      }
    }

    // Graceful fallback dialog when résumé URL is not yet configured
    if (context.mounted) {
      showDialog<void>(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            backgroundColor: AppColors.surfacePrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: const BorderSide(color: AppColors.borderSubtle, width: 1.2),
            ),
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.accentBlue.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.description_rounded,
                    color: AppColors.accentBlue,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Résumé Status',
                  style: AppTypography.titleMedium(),
                ),
              ],
            ),
            content: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'The official résumé document will be linked here upon final deployment. '
                    'To review my full background or discuss collaboration opportunities, '
                    'feel free to connect directly via email.',
                    style: AppTypography.bodyMedium().copyWith(height: 1.6),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceSecondary,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.borderSubtle),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.mail_outline_rounded,
                          size: 16,
                          color: AppColors.accentCyan,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            AppConstants.placeholderEmail,
                            style: AppTypography.codeSnippet(color: AppColors.textPrimary)
                                .copyWith(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: Text(
                  'Close',
                  style: AppTypography.button(color: AppColors.textSecondary),
                ),
              ),
              AppPrimaryButton(
                label: 'Contact Me',
                icon: Icons.send_rounded,
                onPressed: () {
                  Navigator.pop(ctx);
                  AppContactDialog.show(context);
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < AppConstants.tabletBreakpoint;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 32,
        vertical: isMobile ? 56 : 80,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
          child: GlassCard(
            enableHoverLift: false,
            borderColor: AppColors.accentViolet.withValues(alpha: 0.35),
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 24 : 48,
              vertical: isMobile ? 40 : 64,
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.accentViolet.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.accentViolet.withValues(alpha: 0.35),
                    ),
                  ),
                  child: Text(
                    '// CONNECT & COLLABORATE',
                    style: AppTypography.eyebrow(color: AppColors.accentViolet),
                  ),
                ),
                const SizedBox(height: 20),

                Text(
                  AppConstants.aboutCtaHeadline,
                  textAlign: TextAlign.center,
                  style: isMobile
                      ? AppTypography.displaySmall()
                      : AppTypography.displayMedium(),
                ),
                const SizedBox(height: 16),

                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 620),
                  child: Text(
                    AppConstants.aboutCtaSubheadline,
                    textAlign: TextAlign.center,
                    style: isMobile
                        ? AppTypography.bodyMedium()
                        : AppTypography.bodyLarge(),
                  ),
                ),
                const SizedBox(height: 36),

                Wrap(
                  spacing: 16,
                  runSpacing: 14,
                  alignment: WrapAlignment.center,
                  children: [
                    AppSecondaryButton(
                      label: 'View Résumé',
                      icon: Icons.description_rounded,
                      onPressed: () => _handleResumeTap(context),
                    ),
                    AppPrimaryButton(
                      label: 'Contact Me',
                      icon: Icons.send_rounded,
                      onPressed: () => AppContactDialog.show(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
