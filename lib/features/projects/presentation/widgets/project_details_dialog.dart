import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/app_buttons.dart';
import '../../../../shared/widgets/app_chip.dart';
import '../../models/project_model.dart';

/// Accessible project details preview dialog with planned milestones,
/// technology stack, truthful status badge, and Escape-key dismissal.
class ProjectDetailsDialog extends StatelessWidget {
  final ProjectModel project;

  const ProjectDetailsDialog({
    super.key,
    required this.project,
  });

  static Future<void> show(BuildContext context, ProjectModel project) {
    return showDialog<void>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.75),
      builder: (ctx) => ProjectDetailsDialog(project: project),
    );
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: FocusNode()..requestFocus(),
      onKeyEvent: (event) {
        if (event is KeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.escape) {
          Navigator.of(context).pop();
        }
      },
      child: Dialog(
        backgroundColor: AppColors.surfacePrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppColors.borderSubtle, width: 1.2),
        ),
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 580),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Row with category icon, title, and close button
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: project.accentColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: project.accentColor.withValues(alpha: 0.35),
                          ),
                        ),
                        child: Icon(
                          project.categoryIcon,
                          color: project.accentColor,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  project.category.toUpperCase(),
                                  style: AppTypography.eyebrow(
                                    color: AppColors.textSecondary,
                                  ).copyWith(fontSize: 11),
                                ),
                                const SizedBox(width: 10),
                                AppStatusBadge(
                                  label: project.status.label,
                                  color: project.status.color,
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              project.title,
                              style: AppTypography.titleMedium().copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        tooltip: 'Close dialog (Esc)',
                        icon: const Icon(
                          Icons.close_rounded,
                          color: AppColors.textSecondary,
                          size: 22,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Overview / Description
                  Text(
                    'PROJECT OVERVIEW',
                    style: AppTypography.eyebrow(color: AppColors.textMuted)
                        .copyWith(fontSize: 10),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    project.description,
                    style: AppTypography.bodyMedium().copyWith(height: 1.6),
                  ),
                  const SizedBox(height: 24),

                  // Technologies
                  Text(
                    'CORE TECHNOLOGIES',
                    style: AppTypography.eyebrow(color: AppColors.textMuted)
                        .copyWith(fontSize: 10),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: project.techTags.map((tag) {
                      return AppChip(
                        label: tag,
                        accentColor: project.accentColor,
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),

                  // Planned Milestones
                  if (project.plannedMilestones.isNotEmpty) ...[
                    Text(
                      'DEVELOPMENT MILESTONES',
                      style: AppTypography.eyebrow(color: AppColors.textMuted)
                          .copyWith(fontSize: 10),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceSecondary,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.borderSubtle),
                      ),
                      child: Column(
                        children: project.plannedMilestones
                            .asMap()
                            .entries
                            .map((entry) {
                          final index = entry.key + 1;
                          final milestone = entry.value;
                          final isLast =
                              entry.key == project.plannedMilestones.length - 1;

                          return Padding(
                            padding: EdgeInsets.only(bottom: isLast ? 0 : 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: project.accentColor
                                        .withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: project.accentColor
                                          .withValues(alpha: 0.4),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '$index',
                                      style: AppTypography.eyebrow(
                                        color: project.accentColor,
                                      ).copyWith(fontSize: 10),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    milestone,
                                    style: AppTypography.bodySmall(
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Action Footer
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceSecondary,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.borderSubtle),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.info_outline_rounded,
                          size: 18,
                          color: AppColors.accentBlue,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Live URLs and repository links will be activated as project milestones complete.',
                            style: AppTypography.bodySmall(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  Align(
                    alignment: Alignment.centerRight,
                    child: AppSecondaryButton(
                      label: 'Close Details',
                      icon: Icons.check_rounded,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
