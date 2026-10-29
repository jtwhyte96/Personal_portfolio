import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/app_buttons.dart';
import '../../../../shared/widgets/contact_dialog.dart';
import '../../../../shared/widgets/glass_card.dart';

/// Contact section featuring call-to-action, direct email connection,
/// and configurable social placeholders (GitHub, LinkedIn).
class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  Future<void> _handleLinkTap(BuildContext context, String url, String label) async {
    final uri = Uri.tryParse(url);
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      if (context.mounted) {
        Clipboard.setData(ClipboardData(text: url));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.surfaceSecondary,
            content: Text(
              '$label placeholder copied to clipboard: $url',
              style: AppTypography.bodySmall(color: AppColors.textPrimary),
            ),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  void _showContactDialog(BuildContext context) {
    AppContactDialog.show(context);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < AppConstants.tabletBreakpoint;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 32,
        vertical: 80,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
          child: GlassCard(
            enableHoverLift: false,
            borderColor: AppColors.accentViolet.withValues(alpha: 0.3),
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
                    AppConstants.contactEyebrow,
                    style: AppTypography.eyebrow(color: AppColors.accentViolet),
                  ),
                ),
                const SizedBox(height: 20),

                Text(
                  AppConstants.contactHeadline,
                  textAlign: TextAlign.center,
                  style: isMobile
                      ? AppTypography.displaySmall()
                      : AppTypography.displayMedium(),
                ),
                const SizedBox(height: 16),

                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 620),
                  child: Text(
                    AppConstants.contactSubheadline,
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
                    AppPrimaryButton(
                      label: 'Get In Touch',
                      icon: Icons.send_rounded,
                      onPressed: () => _showContactDialog(context),
                    ),
                    AppSecondaryButton(
                      label: 'Copy Email',
                      icon: Icons.copy_rounded,
                      onPressed: () {
                        Clipboard.setData(
                          const ClipboardData(text: AppConstants.placeholderEmail),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: AppColors.surfaceSecondary,
                            content: Text(
                              'Email copied to clipboard (${AppConstants.placeholderEmail})',
                              style: AppTypography.bodySmall(
                                  color: AppColors.textPrimary),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 40),

                // Channels pill row
                Wrap(
                  spacing: 20,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: [
                    _ChannelLink(
                      icon: Icons.email_outlined,
                      label: AppConstants.placeholderEmail,
                      onTap: () => _handleLinkTap(
                        context,
                        'mailto:${AppConstants.placeholderEmail}',
                        'Email',
                      ),
                    ),
                    _ChannelLink(
                      icon: Icons.code_rounded,
                      label: 'GitHub Profile',
                      onTap: () => _handleLinkTap(
                        context,
                        AppConstants.placeholderGithub,
                        'GitHub',
                      ),
                    ),
                    _ChannelLink(
                      icon: Icons.work_outline_rounded,
                      label: 'LinkedIn Profile',
                      onTap: () => _handleLinkTap(
                        context,
                        AppConstants.placeholderLinkedin,
                        'LinkedIn',
                      ),
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

class _ChannelLink extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ChannelLink({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  State<_ChannelLink> createState() => _ChannelLinkState();
}

class _ChannelLinkState extends State<_ChannelLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      onShowHoverHighlight: (val) => setState(() => _isHovered = val),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: 16,
                color: _isHovered
                    ? AppColors.accentViolet
                    : AppColors.textSecondary,
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: AppTypography.bodySmall(
                  color: _isHovered
                      ? AppColors.textPrimary
                      : AppColors.textSecondary,
                ).copyWith(
                  decoration:
                      _isHovered ? TextDecoration.underline : TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

