import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/app_chip.dart';
import '../../../../shared/widgets/glass_card.dart';
import '../../models/project_model.dart';

/// Reusable project card widget displaying preview canvas, category, status,
/// title, description, tech tags, and clearly defined action states.
class ProjectCard extends StatelessWidget {
  final ProjectModel project;
  final VoidCallback? onDetailsTap;

  const ProjectCard({
    super.key,
    required this.project,
    this.onDetailsTap,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      enableHoverLift: true,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Project Visual Preview Banner
          _ProjectPreviewBanner(project: project),

          // Content body
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category & Status row
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          project.categoryIcon,
                          size: 16,
                          color: project.accentColor,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          project.category.toUpperCase(),
                          style: AppTypography.eyebrow(
                            color: AppColors.textSecondary,
                          ).copyWith(fontSize: 11),
                        ),
                      ],
                    ),
                    AppStatusBadge(
                      label: project.status.label,
                      color: project.status.color,
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Title
                Text(
                  project.title,
                  style: AppTypography.titleMedium().copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),

                // Description
                Text(
                  project.description,
                  style: AppTypography.bodyMedium(),
                ),
                const SizedBox(height: 18),

                // Tech tags
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: project.techTags.map((tag) {
                    return AppChip(label: tag);
                  }).toList(),
                ),
                const SizedBox(height: 22),

                // Action Footer
                const Divider(color: AppColors.borderSubtle),
                const SizedBox(height: 14),
                _ProjectActionRow(
                  project: project,
                  onDetailsTap: onDetailsTap,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProjectActionRow extends StatelessWidget {
  final ProjectModel project;
  final VoidCallback? onDetailsTap;

  const _ProjectActionRow({
    required this.project,
    this.onDetailsTap,
  });

  @override
  Widget build(BuildContext context) {
    final isUpcoming = project.status == ProjectStatus.upcoming;

    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 12,
      runSpacing: 10,
      children: [
        // Status explanation / action
        if (isUpcoming)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.hourglass_top_rounded,
                size: 15,
                color: AppColors.accentAmber,
              ),
              const SizedBox(width: 6),
              Text(
                'In Active Development',
                style: AppTypography.bodySmall(color: AppColors.accentAmber)
                    .copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          )
        else
          InkWell(
            onTap: onDetailsTap,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Case Study',
                  style: AppTypography.button(color: AppColors.accentViolet),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.arrow_forward_rounded,
                  size: 14,
                  color: AppColors.accentViolet,
                ),
              ],
            ),
          ),

        // Non-misleading action button
        TextButton.icon(
          onPressed: onDetailsTap,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            backgroundColor: AppColors.surfaceSecondary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(color: AppColors.borderSubtle),
            ),
          ),
          icon: Icon(
            isUpcoming ? Icons.info_outline_rounded : Icons.open_in_new_rounded,
            size: 14,
            color: AppColors.textSecondary,
          ),
          label: Text(
            isUpcoming ? 'Details Preview' : 'Explore',
            style: AppTypography.bodySmall(color: AppColors.textSecondary),
          ),
        ),
      ],
    );
  }
}

/// Abstract geometric canvas preview tailored to the project category.
/// Ensures zero remote asset dependency.
class _ProjectPreviewBanner extends StatelessWidget {
  final ProjectModel project;

  const _ProjectPreviewBanner({required this.project});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: AppColors.surfaceSecondary,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
        border: const Border(
          bottom: BorderSide(color: AppColors.borderSubtle, width: 1),
        ),
      ),
      child: Stack(
        children: [
          // Background ambient gradient
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    project.accentColor.withValues(alpha: 0.15),
                    Colors.transparent,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),

          // Category illustration
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: _buildCategoryIllustration(project),
              ),
            ),
          ),

          // Top right subtle tag
          Positioned(
            top: 14,
            right: 14,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.surfacePrimary.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: AppColors.borderSubtle),
              ),
              child: Text(
                'SPECIFICATION 001',
                style: AppTypography.eyebrow(color: AppColors.textMuted)
                    .copyWith(fontSize: 9),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryIllustration(ProjectModel project) {
    switch (project.category) {
      case 'Web Application':
        return _buildWebAppIllustration();
      case 'UI/UX Design':
        return _buildDesignIllustration();
      case 'Software Project':
        return _buildBackendIllustration();
      default:
        return Icon(project.categoryIcon, size: 54, color: project.accentColor);
    }
  }

  Widget _buildWebAppIllustration() {
    return Container(
      width: 240,
      height: 120,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfacePrimary,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.accentBlue.withValues(alpha: 0.4),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.accentBlue.withValues(alpha: 0.1),
            blurRadius: 15,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFFEF4444), shape: BoxShape.circle)),
              const SizedBox(width: 4),
              Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFFF59E0B), shape: BoxShape.circle)),
              const SizedBox(width: 4),
              Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFF10B981), shape: BoxShape.circle)),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  height: 10,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceSecondary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceSecondary,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Center(
                    child: Icon(Icons.bar_chart_rounded, size: 24, color: AppColors.accentBlue),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Container(height: 12, decoration: BoxDecoration(color: AppColors.accentBlue.withValues(alpha: 0.3), borderRadius: BorderRadius.circular(3))),
                    const SizedBox(height: 8),
                    Container(height: 12, decoration: BoxDecoration(color: AppColors.surfaceSecondary, borderRadius: BorderRadius.circular(3))),
                    const SizedBox(height: 8),
                    Container(height: 12, decoration: BoxDecoration(color: AppColors.surfaceSecondary, borderRadius: BorderRadius.circular(3))),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDesignIllustration() {
    return Container(
      width: 240,
      height: 110,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfacePrimary,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.accentViolet.withValues(alpha: 0.4),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _colorSwatch(AppColors.accentViolet),
              _colorSwatch(AppColors.accentBlue),
              _colorSwatch(AppColors.accentCyan),
              _colorSwatch(AppColors.accentEmerald),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.style_rounded, size: 15, color: AppColors.accentViolet),
              const SizedBox(width: 6),
              Text(
                'Design Tokens',
                style: AppTypography.eyebrow(color: AppColors.textSecondary)
                    .copyWith(fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _colorSwatch(Color c) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: c,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: c.withValues(alpha: 0.3),
            blurRadius: 8,
          ),
        ],
      ),
    );
  }

  Widget _buildBackendIllustration() {
    return Container(
      width: 240,
      height: 110,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfacePrimary,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.accentCyan.withValues(alpha: 0.4),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _nodeBox(Icons.dns_rounded, 'Java API', AppColors.accentCyan),
          const Icon(Icons.sync_alt_rounded, size: 18, color: AppColors.textMuted),
          _nodeBox(Icons.auto_awesome_rounded, 'AI Engine', AppColors.accentViolet),
        ],
      ),
    );
  }

  Widget _nodeBox(IconData icon, String label, Color c) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: c.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: c.withValues(alpha: 0.4)),
          ),
          child: Icon(icon, size: 20, color: c),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: AppTypography.eyebrow(color: AppColors.textPrimary)
              .copyWith(fontSize: 10),
        ),
      ],
    );
  }
}
