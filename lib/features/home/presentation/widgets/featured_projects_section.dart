import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../shared/widgets/app_buttons.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../../projects/models/project_model.dart';
import '../../../projects/presentation/widgets/project_card.dart';
import '../../../projects/presentation/widgets/project_details_dialog.dart';

/// Featured Projects section displaying upcoming portfolio items,
/// responsive grid layout, and "View All Projects" action.
class FeaturedProjectsSection extends StatelessWidget {
  final VoidCallback? onViewAllProjects;

  const FeaturedProjectsSection({
    super.key,
    this.onViewAllProjects,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final projects = ProjectModel.featuredProjects;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: (screenWidth < 680) ? 20 : 32,
        vertical: 80,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
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
                                  ProjectDetailsDialog.show(context, project),
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
                                ProjectDetailsDialog.show(context, project),
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
                                ProjectDetailsDialog.show(context, project),
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
                  onPressed: onViewAllProjects,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
