import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

/// Primary action button with rich violet-blue gradient, subtle hover glow,
/// and smooth scale feedback.
class AppPrimaryButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isFullWidth;
  final String? semanticLabel;

  const AppPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isFullWidth = false,
    this.semanticLabel,
  });

  @override
  State<AppPrimaryButton> createState() => _AppPrimaryButtonState();
}

class _AppPrimaryButtonState extends State<AppPrimaryButton> {
  bool _isHovered = false;
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.onPressed != null;

    return Semantics(
      button: true,
      enabled: isEnabled,
      label: widget.semanticLabel ?? widget.label,
      child: FocusableActionDetector(
        onShowFocusHighlight: (val) => setState(() => _isFocused = val),
        onShowHoverHighlight: (val) => setState(() => _isHovered = val),
        child: AnimatedScale(
          scale: _isHovered && isEnabled ? 1.02 : 1.0,
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              gradient: isEnabled
                  ? AppColors.primaryGradient
                  : const LinearGradient(
                      colors: [Color(0xFF333848), Color(0xFF262A36)],
                    ),
              borderRadius: BorderRadius.circular(10),
              border: _isFocused
                  ? Border.all(color: Colors.white, width: 2)
                  : Border.all(
                      color: _isHovered
                          ? AppColors.accentBlue.withValues(alpha: 0.8)
                          : Colors.transparent,
                      width: 1,
                    ),
              boxShadow: [
                if (_isHovered && isEnabled)
                  BoxShadow(
                    color: AppColors.accentViolet.withValues(alpha: 0.4),
                    blurRadius: 18,
                    spreadRadius: 1,
                    offset: const Offset(0, 4),
                  ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: widget.onPressed,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                  child: Row(
                    mainAxisSize:
                        widget.isFullWidth ? MainAxisSize.max : MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          widget.label,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.button(
                            color: isEnabled
                                ? Colors.white
                                : AppColors.textSecondary.withValues(alpha: 0.6),
                          ),
                        ),
                      ),
                      if (widget.icon != null) ...[
                        const SizedBox(width: 8),
                        Icon(
                          widget.icon,
                          size: 16,
                          color: isEnabled
                              ? Colors.white
                              : AppColors.textSecondary.withValues(alpha: 0.6),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Secondary action button with dark surface, crisp border, and hover glow.
class AppSecondaryButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isFullWidth;
  final String? semanticLabel;

  const AppSecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isFullWidth = false,
    this.semanticLabel,
  });

  @override
  State<AppSecondaryButton> createState() => _AppSecondaryButtonState();
}

class _AppSecondaryButtonState extends State<AppSecondaryButton> {
  bool _isHovered = false;
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.onPressed != null;

    return Semantics(
      button: true,
      enabled: isEnabled,
      label: widget.semanticLabel ?? widget.label,
      child: FocusableActionDetector(
        onShowFocusHighlight: (val) => setState(() => _isFocused = val),
        onShowHoverHighlight: (val) => setState(() => _isHovered = val),
        child: AnimatedScale(
          scale: _isHovered && isEnabled ? 1.02 : 1.0,
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: _isHovered && isEnabled
                  ? AppColors.surfaceSecondary
                  : AppColors.surfacePrimary,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: _isFocused
                    ? Colors.white
                    : (_isHovered && isEnabled
                        ? AppColors.accentViolet.withValues(alpha: 0.7)
                        : AppColors.borderCard),
                width: 1.2,
              ),
              boxShadow: [
                if (_isHovered && isEnabled)
                  BoxShadow(
                    color: AppColors.accentViolet.withValues(alpha: 0.15),
                    blurRadius: 12,
                    offset: const Offset(0, 3),
                  ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: widget.onPressed,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                  child: Row(
                    mainAxisSize:
                        widget.isFullWidth ? MainAxisSize.max : MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          widget.label,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.button(
                            color: isEnabled
                                ? (_isHovered
                                    ? AppColors.textPrimary
                                    : AppColors.textSecondary)
                                : AppColors.textMuted,
                          ),
                        ),
                      ),
                      if (widget.icon != null) ...[
                        const SizedBox(width: 8),
                        Icon(
                          widget.icon,
                          size: 16,
                          color: isEnabled
                              ? (_isHovered
                                  ? AppColors.accentViolet
                                  : AppColors.textSecondary)
                              : AppColors.textMuted,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
