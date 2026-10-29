import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

/// Reusable tech tag chip with subtle border, optional icon, and hover highlight.
class AppChip extends StatefulWidget {
  final String label;
  final IconData? icon;
  final Color? accentColor;
  final bool isInteractive;
  final VoidCallback? onTap;

  const AppChip({
    super.key,
    required this.label,
    this.icon,
    this.accentColor,
    this.isInteractive = false,
    this.onTap,
  });

  @override
  State<AppChip> createState() => _AppChipState();
}

class _AppChipState extends State<AppChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final effectiveAccent = widget.accentColor ?? AppColors.accentViolet;

    return FocusableActionDetector(
      onShowHoverHighlight: widget.isInteractive
          ? (val) => setState(() => _isHovered = val)
          : null,
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(8),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: _isHovered
                ? effectiveAccent.withValues(alpha: 0.15)
                : AppColors.surfaceSecondary.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _isHovered
                  ? effectiveAccent.withValues(alpha: 0.5)
                  : AppColors.borderSubtle,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                Icon(
                  widget.icon,
                  size: 13,
                  color: effectiveAccent,
                ),
                const SizedBox(width: 6),
              ],
              Flexible(
                child: Text(
                  widget.label,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.bodySmall(
                    color: _isHovered ? AppColors.textPrimary : AppColors.textSecondary,
                  ).copyWith(fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Status badge specifically styled for project states (Upcoming, In Progress, etc.)
class AppStatusBadge extends StatelessWidget {
  final String label;
  final Color color;

  const AppStatusBadge({
    super.key,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.4), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label.toUpperCase(),
            style: AppTypography.eyebrow(color: color).copyWith(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}
