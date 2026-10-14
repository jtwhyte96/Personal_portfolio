import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

/// Responsive footer widget with dynamic copyright year, navigation links,
/// and developer credits.
class AppFooter extends StatelessWidget {
  final VoidCallback onHomeTap;
  final VoidCallback onProjectsTap;
  final VoidCallback onAboutTap;
  final VoidCallback onContactTap;

  const AppFooter({
    super.key,
    required this.onHomeTap,
    required this.onProjectsTap,
    required this.onAboutTap,
    required this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    final currentYear = DateTime.now().year;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 680;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(
          top: BorderSide(color: AppColors.borderSubtle, width: 1),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
          child: Column(
            children: [
              if (isMobile)
                Column(
                  children: [
                    _FooterBrand(onHomeTap: onHomeTap),
                    const SizedBox(height: 20),
                    _FooterNavLinks(
                      onHomeTap: onHomeTap,
                      onProjectsTap: onProjectsTap,
                      onAboutTap: onAboutTap,
                      onContactTap: onContactTap,
                      isMobile: true,
                    ),
                  ],
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _FooterBrand(onHomeTap: onHomeTap),
                    _FooterNavLinks(
                      onHomeTap: onHomeTap,
                      onProjectsTap: onProjectsTap,
                      onAboutTap: onAboutTap,
                      onContactTap: onContactTap,
                      isMobile: false,
                    ),
                  ],
                ),
              const SizedBox(height: 32),
              const Divider(color: AppColors.borderSubtle),
              const SizedBox(height: 24),
              if (isMobile)
                Column(
                  children: [
                    Text(
                      '© $currentYear ${AppConstants.placeholderName}. All rights reserved.',
                      textAlign: TextAlign.center,
                      style: AppTypography.bodySmall(),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.flutter_dash_rounded,
                          size: 14,
                          color: AppColors.accentBlue,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Built with Flutter Web',
                          style: AppTypography.bodySmall(color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ],
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        '© $currentYear ${AppConstants.placeholderName}. All rights reserved.',
                        style: AppTypography.bodySmall(),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.flutter_dash_rounded,
                          size: 14,
                          color: AppColors.accentBlue,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Built with Flutter Web',
                          style: AppTypography.bodySmall(color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FooterBrand extends StatelessWidget {
  final VoidCallback onHomeTap;

  const _FooterBrand({required this.onHomeTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onHomeTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Center(
                child: Icon(Icons.code_rounded, size: 16, color: Colors.white),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              AppConstants.placeholderName,
              style: AppTypography.titleMedium().copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FooterNavLinks extends StatelessWidget {
  final VoidCallback onHomeTap;
  final VoidCallback onProjectsTap;
  final VoidCallback onAboutTap;
  final VoidCallback onContactTap;
  final bool isMobile;

  const _FooterNavLinks({
    required this.onHomeTap,
    required this.onProjectsTap,
    required this.onAboutTap,
    required this.onContactTap,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final links = [
      _TextLink(label: AppConstants.navHome, onTap: onHomeTap),
      _TextLink(label: AppConstants.navProjects, onTap: onProjectsTap),
      _TextLink(label: AppConstants.navAbout, onTap: onAboutTap),
      _TextLink(label: AppConstants.navContact, onTap: onContactTap),
    ];

    if (isMobile) {
      return Wrap(
        alignment: WrapAlignment.center,
        spacing: 16,
        runSpacing: 8,
        children: links,
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: links
          .map((l) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: l,
              ))
          .toList(),
    );
  }
}

class _TextLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _TextLink({
    required this.label,
    required this.onTap,
  });

  @override
  State<_TextLink> createState() => _TextLinkState();
}

class _TextLinkState extends State<_TextLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      onShowHoverHighlight: (val) => setState(() => _isHovered = val),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
          child: Text(
            widget.label,
            style: AppTypography.bodySmall(
              color: _isHovered ? AppColors.textPrimary : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
