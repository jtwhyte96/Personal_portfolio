import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// Reusable charcoal surface card with subtle border, optional hover highlight,
/// and smooth transitions.
class GlassCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final Color? borderColor;
  final Color? backgroundColor;
  final double borderRadius;
  final bool enableHoverLift;

  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
    this.onTap,
    this.borderColor,
    this.backgroundColor,
    this.borderRadius = 16,
    this.enableHoverLift = false,
  });

  @override
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final effectiveBorder = widget.borderColor ?? AppColors.borderSubtle;
    final effectiveBg = widget.backgroundColor ?? AppColors.surfacePrimary;

    return FocusableActionDetector(
      onShowHoverHighlight: (val) => setState(() => _isHovered = val),
      child: AnimatedScale(
        scale: _isHovered && widget.enableHoverLift ? 1.015 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          decoration: BoxDecoration(
            color: _isHovered && widget.enableHoverLift
                ? AppColors.surfaceSecondary
                : effectiveBg,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: Border.all(
              color: _isHovered && widget.enableHoverLift
                  ? AppColors.accentViolet.withValues(alpha: 0.5)
                  : effectiveBorder,
              width: 1,
            ),
            boxShadow: [
              if (_isHovered && widget.enableHoverLift)
                BoxShadow(
                  color: AppColors.accentViolet.withValues(alpha: 0.12),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                )
              else
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              onTap: widget.onTap,
              child: Padding(
                padding: widget.padding,
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
