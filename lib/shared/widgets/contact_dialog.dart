import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import 'glass_card.dart';

/// Reusable contact dialog providing direct access to email, GitHub,
/// and LinkedIn with clipboard copy and link launching.
class AppContactDialog extends StatelessWidget {
  const AppContactDialog({super.key});

  /// Displays the centralized contact modal.
  static Future<void> show(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (ctx) => const AppContactDialog(),
    );
  }

  static Future<void> handleLinkTap(
    BuildContext context,
    String url,
    String label,
  ) async {
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
              '$label copied to clipboard: $url',
              style: AppTypography.bodySmall(color: AppColors.textPrimary),
            ),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
              color: AppColors.accentViolet.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.send_rounded,
              color: AppColors.accentViolet,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            "Let's Connect",
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
              'Reach out directly via email or check my developer profiles:',
              style: AppTypography.bodyMedium(),
            ),
            const SizedBox(height: 18),
            _ContactItem(
              icon: Icons.email_rounded,
              title: 'Email',
              subtitle: AppConstants.placeholderEmail,
              onTap: () {
                Navigator.pop(context);
                handleLinkTap(
                  context,
                  'mailto:${AppConstants.placeholderEmail}',
                  'Email',
                );
              },
            ),
            const SizedBox(height: 10),
            _ContactItem(
              icon: Icons.code_rounded,
              title: 'GitHub',
              subtitle: AppConstants.placeholderGithub,
              onTap: () {
                Navigator.pop(context);
                handleLinkTap(
                  context,
                  AppConstants.placeholderGithub,
                  'GitHub',
                );
              },
            ),
            const SizedBox(height: 10),
            _ContactItem(
              icon: Icons.link_rounded,
              title: 'LinkedIn',
              subtitle: AppConstants.placeholderLinkedin,
              onTap: () {
                Navigator.pop(context);
                handleLinkTap(
                  context,
                  AppConstants.placeholderLinkedin,
                  'LinkedIn',
                );
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Close',
            style: AppTypography.button(color: AppColors.textPrimary),
          ),
        ),
      ],
    );
  }
}

class _ContactItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ContactItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      enableHoverLift: true,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.accentViolet.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.accentViolet, size: 18),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.titleMedium().copyWith(fontSize: 14),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: AppTypography.bodySmall(color: AppColors.textSecondary),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_outward_rounded,
            size: 16,
            color: AppColors.textMuted,
          ),
        ],
      ),
    );
  }
}
