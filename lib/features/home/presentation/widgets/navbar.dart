import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/app_buttons.dart';

/// Responsive top navigation bar with frosted glass effect, smooth anchor
/// scrolling, and expandable mobile drawer.
class AppNavBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onHomeTap;
  final VoidCallback onProjectsTap;
  final VoidCallback onAboutTap;
  final VoidCallback onContactTap;
  final String activeSection;

  const AppNavBar({
    super.key,
    required this.onHomeTap,
    required this.onProjectsTap,
    required this.onAboutTap,
    required this.onContactTap,
    this.activeSection = AppConstants.navHome,
  });

  @override
  Size get preferredSize => const Size.fromHeight(72);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < AppConstants.desktopBreakpoint;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          height: 72,
          decoration: BoxDecoration(
            color: AppColors.background.withValues(alpha: 0.82),
            border: const Border(
              bottom: BorderSide(color: AppColors.borderSubtle, width: 1),
            ),
          ),
          child: Center(
            child: ConstrainedBox(
              constraints:
                  const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 24),
                child: Row(
                  children: [
                    // Brand / Name placeholder
                    if (isMobile)
                      Expanded(
                        child: _BrandLogo(onTap: onHomeTap, isMobile: true),
                      )
                    else ...[
                      _BrandLogo(onTap: onHomeTap, isMobile: false),
                      const Spacer(),
                    ],

                    // Desktop Navigation links
                    if (!isMobile) ...[
                      _NavLink(
                        label: AppConstants.navHome,
                        isActive: activeSection == AppConstants.navHome,
                        onTap: onHomeTap,
                      ),
                      const SizedBox(width: 8),
                      _NavLink(
                        label: AppConstants.navProjects,
                        isActive: activeSection == AppConstants.navProjects,
                        onTap: onProjectsTap,
                      ),
                      const SizedBox(width: 8),
                      _NavLink(
                        label: AppConstants.navAbout,
                        isActive: activeSection == AppConstants.navAbout,
                        onTap: onAboutTap,
                      ),
                      const SizedBox(width: 8),
                      _NavLink(
                        label: AppConstants.navContact,
                        isActive: activeSection == AppConstants.navContact,
                        onTap: onContactTap,
                      ),
                      const SizedBox(width: 24),
                      AppPrimaryButton(
                        label: "Let's Talk",
                        icon: Icons.arrow_outward_rounded,
                        onPressed: onContactTap,
                      ),
                    ] else ...[
                      // Mobile Menu Trigger Button
                      _MobileMenuButton(
                        onHomeTap: onHomeTap,
                        onProjectsTap: onProjectsTap,
                        onAboutTap: onAboutTap,
                        onContactTap: onContactTap,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BrandLogo extends StatefulWidget {
  final VoidCallback onTap;
  final bool isMobile;

  const _BrandLogo({
    required this.onTap,
    this.isMobile = false,
  });

  @override
  State<_BrandLogo> createState() => _BrandLogoState();
}

class _BrandLogoState extends State<_BrandLogo> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      onShowHoverHighlight: (val) => setState(() => _isHovered = val),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Row(
            mainAxisSize: widget.isMobile ? MainAxisSize.max : MainAxisSize.min,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accentViolet.withValues(alpha: 0.35),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.terminal_rounded,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 180),
                  style: AppTypography.titleMedium(
                    color: _isHovered
                        ? AppColors.textPrimary
                        : AppColors.textPrimary.withValues(alpha: 0.9),
                  ).copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: widget.isMobile ? 15 : 18,
                  ),
                  child: const Text(
                    AppConstants.placeholderName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavLink({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isHighlight = widget.isActive || _isHovered;

    return FocusableActionDetector(
      onShowHoverHighlight: (val) => setState(() => _isHovered = val),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: AppTypography.button(
                  color: isHighlight
                      ? AppColors.textPrimary
                      : AppColors.textSecondary,
                ).copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2,
                width: widget.isActive ? 20 : (_isHovered ? 12 : 0),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MobileMenuButton extends StatelessWidget {
  final VoidCallback onHomeTap;
  final VoidCallback onProjectsTap;
  final VoidCallback onAboutTap;
  final VoidCallback onContactTap;

  const _MobileMenuButton({
    required this.onHomeTap,
    required this.onProjectsTap,
    required this.onAboutTap,
    required this.onContactTap,
  });

  void _openMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surfacePrimary,
      barrierColor: Colors.black.withValues(alpha: 0.7),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.borderSubtle,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 20),
                _MobileMenuItem(
                  icon: Icons.home_rounded,
                  label: AppConstants.navHome,
                  onTap: () {
                    Navigator.pop(ctx);
                    onHomeTap();
                  },
                ),
                _MobileMenuItem(
                  icon: Icons.code_rounded,
                  label: AppConstants.navProjects,
                  onTap: () {
                    Navigator.pop(ctx);
                    onProjectsTap();
                  },
                ),
                _MobileMenuItem(
                  icon: Icons.person_rounded,
                  label: AppConstants.navAbout,
                  onTap: () {
                    Navigator.pop(ctx);
                    onAboutTap();
                  },
                ),
                _MobileMenuItem(
                  icon: Icons.mail_rounded,
                  label: AppConstants.navContact,
                  onTap: () {
                    Navigator.pop(ctx);
                    onContactTap();
                  },
                ),
                const SizedBox(height: 16),
                AppPrimaryButton(
                  label: "Let's Talk",
                  icon: Icons.arrow_outward_rounded,
                  isFullWidth: true,
                  onPressed: () {
                    Navigator.pop(ctx);
                    onContactTap();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.menu_rounded, color: AppColors.textPrimary, size: 28),
      tooltip: 'Open navigation menu',
      onPressed: () => _openMobileMenu(context),
    );
  }
}

class _MobileMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _MobileMenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.accentViolet),
      title: Text(
        label,
        style: AppTypography.titleMedium(color: AppColors.textPrimary),
      ),
      trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onTap: onTap,
    );
  }
}
