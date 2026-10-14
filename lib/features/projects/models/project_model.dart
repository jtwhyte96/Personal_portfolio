import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

enum ProjectStatus {
  upcoming('Upcoming', AppColors.accentAmber),
  inProgress('In Progress', AppColors.accentBlue),
  completed('Completed', AppColors.accentEmerald);

  final String label;
  final Color color;

  const ProjectStatus(this.label, this.color);
}

class ProjectModel {
  final String id;
  final String title;
  final String category;
  final String description;
  final List<String> techTags;
  final ProjectStatus status;
  final IconData categoryIcon;
  final Color accentColor;
  final String? liveUrl;
  final String? sourceCodeUrl;
  final String? caseStudyRoute;

  const ProjectModel({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.techTags,
    required this.status,
    required this.categoryIcon,
    this.accentColor = AppColors.accentViolet,
    this.liveUrl,
    this.sourceCodeUrl,
    this.caseStudyRoute,
  });

  /// The 3 explicitly marked upcoming placeholder projects per portfolio requirements
  static List<ProjectModel> get initialProjects => const [
        ProjectModel(
          id: 'web-app-upcoming',
          title: 'Full-Stack Web Application',
          category: 'Web Application',
          description:
              'Upcoming production-ready web application showcasing responsive state management, '
              'modern design tokens, and modular Dart architecture.',
          techTags: ['Flutter Web', 'Dart', 'REST API', 'Responsive UI'],
          status: ProjectStatus.upcoming,
          categoryIcon: Icons.web_rounded,
          accentColor: AppColors.accentBlue,
          caseStudyRoute: '/projects/web-app',
        ),
        ProjectModel(
          id: 'ui-ux-design-upcoming',
          title: 'Design System & UX Case Study',
          category: 'UI/UX Design',
          description:
              'Upcoming comprehensive design system and user research case study examining '
              'accessible interactions, typography hierarchies, and dark-mode component architecture.',
          techTags: ['Design System', 'Figma', 'Accessibility', 'Interaction Design'],
          status: ProjectStatus.upcoming,
          categoryIcon: Icons.design_services_rounded,
          accentColor: AppColors.accentViolet,
          caseStudyRoute: '/projects/ui-ux',
        ),
        ProjectModel(
          id: 'software-project-upcoming',
          title: 'Enterprise Java & AI Workflow Engine',
          category: 'Software Project',
          description:
              'Upcoming backend integration platform combining Java microservices architecture '
              'with automated AI prompting pipelines and developer tooling.',
          techTags: ['Java', 'Spring Boot', 'AI Workflows', 'Clean Architecture'],
          status: ProjectStatus.upcoming,
          categoryIcon: Icons.terminal_rounded,
          accentColor: AppColors.accentCyan,
          caseStudyRoute: '/projects/software-engine',
        ),
      ];
}
