import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/app_buttons.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../../projects/models/project_model.dart';
import '../../../projects/presentation/widgets/project_card.dart';

/// Featured Projects section displaying upcoming portfolio items,
/// responsive grid layout, and "View All Projects" action.
class FeaturedProjectsSection extends StatelessWidget {
  final VoidCallback? onViewAllProjects;

  const FeaturedProjectsSection({
    super.key,
    this.onViewAllProjects,
  });

  void _showProjectPreviewDialog(BuildContext context, ProjectModel project) {
    showDialog(
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
              Icon(project.categoryIcon, color: project.accentColor, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  project.title,
                  style: AppTypography.titleMedium(),
                ),
              ),
            ],
          ),
          content: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: project.status.color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: project.status.color),
                  ),
                  child: Text(
                    'STATUS: ${project.status.label.toUpperCase()}',
                    style: AppTypography.eyebrow(color: project.status.color),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  project.description,
                  style: AppTypography.bodyMedium(),
                ),
                const SizedBox(height: 20),
                Text(
                  'PLANNED ARCHITECTURE & TECH STACK',
                  style: AppTypography.eyebrow(color: AppColors.textMuted),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: project.techTags.map((tag) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceSecondary,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: AppColors.borderSubtle),
                      ),
                      child: Text(
                        tag,
                        style: AppTypography.bodySmall(
                            color: AppColors.textSecondary),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceSecondary,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.borderSubtle),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline_rounded,
                          size: 18, color: AppColors.accentBlue),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Full source repository and live preview link will be activated upon initial milestone completion.',
                          style: AppTypography.bodySmall(),
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
                style: AppTypography.button(color: AppColors.textPrimary),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showAllProjectsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: AppColors.surfacePrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: const BorderSide(color: AppColors.borderSubtle),
          ),
          title: Row(
            children: [
              const Icon(Icons.folder_special_rounded,
                  color: AppColors.accentViolet, size: 24),
              const SizedBox(width: 12),
              Text(
                'Projects Catalog Roadmap',
                style: AppTypography.titleMedium(),
              ),
            ],
          ),
          content: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'The full multi-project archive is scheduled for release in Phase 2. '
                  'The 3 highlighted previews represent the primary development tracks:',
                  style: AppTypography.bodyMedium(),
                ),
                const SizedBox(height: 16),
                _roadmapItem('1. Web Application', 'Flutter Web & Dart frontend architecture.'),
                _roadmapItem('2. UI/UX Design System', 'Figma specifications and interaction design.'),
                _roadmapItem('3. Software Engine', 'Enterprise Java backend services and AI workflows.'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(
                'Got It',
                style: AppTypography.button(color: AppColors.accentViolet),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _roadmapItem(String title, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_outline_rounded,
              size: 16, color: AppColors.accentEmerald),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: AppTypography.bodySmall(),
                children: [
                  TextSpan(
                    text: '$title: ',
                    style: AppTypography.bodySmall(color: AppColors.textPrimary)
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  TextSpan(text: desc),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final projects = ProjectModel.initialProjects;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: (screenWidth < 680) ? 20 : 32,
        vertical: 80,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section Header
              const SectionHeader(
                eyebrow: '// SELECTED WORK',
                title: 'Featured Projects',
                description:
                    'A curated selection of upcoming software systems, interactive web applications, '
                    'and design case studies currently in development.',
              ),
              const SizedBox(height: 48),

              // Responsive Project Grid
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth >= 900) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: projects.map((project) {
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: ProjectCard(
                              project: project,
                              onDetailsTap: () =>
                                  _showProjectPreviewDialog(context, project),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  } else if (constraints.maxWidth >= 580) {
                    final cardWidth = (constraints.maxWidth - 20) / 2;
                    return Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      children: projects.map((project) {
                        return SizedBox(
                          width: cardWidth,
                          child: ProjectCard(
                            project: project,
                            onDetailsTap: () =>
                                _showProjectPreviewDialog(context, project),
                          ),
                        );
                      }).toList(),
                    );
                  } else {
                    return Column(
                      children: projects.map((project) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: ProjectCard(
                            project: project,
                            onDetailsTap: () =>
                                _showProjectPreviewDialog(context, project),
                          ),
                        );
                      }).toList(),
                    );
                  }
                },
              ),

              const SizedBox(height: 48),

              // Centered "View All Projects" CTA
              Center(
                child: AppSecondaryButton(
                  label: 'View All Projects',
                  icon: Icons.grid_view_rounded,
                  onPressed: onViewAllProjects ??
                      () => _showAllProjectsDialog(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
