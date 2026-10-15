import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

enum ProjectStatus {
  upcoming('Upcoming', AppColors.accentAmber),
  inDevelopment('In Development', AppColors.accentBlue),
  planned('Planned', Color(0xFFA855F7)),
  completed('Completed', AppColors.accentEmerald);

  final String label;
  final Color color;

  const ProjectStatus(this.label, this.color);
}

/// Core project model holding metadata, technology tags, status, and milestone planning.
/// Data is maintained separately from visual UI rendering.
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
  final List<String> plannedMilestones;

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
    this.plannedMilestones = const [],
  });

  /// 4 initial placeholder projects per Stitch Screen 002 specification
  static List<ProjectModel> get allProjects => const [
        ProjectModel(
          id: 'web-app-platform',
          title: 'Full-Stack Web Application',
          category: 'Web Apps',
          description:
              'Upcoming production-ready web application showcasing responsive state management, '
              'modern design tokens, and modular Dart architecture.',
          techTags: ['Flutter Web', 'Dart', 'REST API', 'Responsive UI'],
          status: ProjectStatus.upcoming,
          categoryIcon: Icons.web_rounded,
          accentColor: AppColors.accentBlue,
          caseStudyRoute: '/projects/web-app-platform',
          plannedMilestones: [
            'Architecture blueprint & domain models',
            'Reusable component library & responsive layout tokens',
            'REST API client & state management integration',
            'End-to-end integration testing & web optimization',
          ],
        ),
        ProjectModel(
          id: 'interface-design-system',
          title: 'Design System & Interface Architecture',
          category: 'UI/UX',
          description:
              'Upcoming comprehensive design system and user research case study examining '
              'accessible interactions, typography hierarchies, and dark-mode component architecture.',
          techTags: ['Design System', 'Figma', 'Accessibility', 'Interaction Design'],
          status: ProjectStatus.upcoming,
          categoryIcon: Icons.design_services_rounded,
          accentColor: AppColors.accentViolet,
          caseStudyRoute: '/projects/interface-design-system',
          plannedMilestones: [
            'User journey mapping & accessibility audit (WCAG AA)',
            'Atomic design token library in Figma',
            'Interactive component prototyping & micro-interaction specs',
            'Flutter Web design token mapping & package publish',
          ],
        ),
        ProjectModel(
          id: 'enterprise-java-service',
          title: 'Enterprise Java Service Engine',
          category: 'Java',
          description:
              'Backend integration platform in active development, combining Java microservices architecture '
              'with clean domain boundaries, automated testing, and developer tooling.',
          techTags: ['Java', 'Spring Boot', 'Clean Architecture', 'Microservices'],
          status: ProjectStatus.inDevelopment,
          categoryIcon: Icons.terminal_rounded,
          accentColor: AppColors.accentCyan,
          caseStudyRoute: '/projects/enterprise-java-service',
          plannedMilestones: [
            'Clean Architecture domain layer & entity specifications',
            'Spring Boot RESTful service endpoints with JWT security',
            'Integration tests with Testcontainers & mock services',
            'Dockerized container pipeline & performance benchmarking',
          ],
        ),
        ProjectModel(
          id: 'ai-prompt-workflow-lab',
          title: 'AI Workflow & Prompt Engineering Lab',
          category: 'AI',
          description:
              'Planned experimental suite investigating generative AI prompt workflows, '
              'automated code verification pipelines, and agentic assistant scaffolding.',
          techTags: ['AI Workflows', 'Prompt Engineering', 'LLM APIs', 'Automation'],
          status: ProjectStatus.planned,
          categoryIcon: Icons.auto_awesome_rounded,
          accentColor: Color(0xFFA855F7),
          caseStudyRoute: '/projects/ai-prompt-workflow-lab',
          plannedMilestones: [
            'Structured prompting schemas & evaluation test suites',
            'LLM API orchestration layer with streaming responses',
            'Code refactoring tool-use agent prototypes',
            'Benchmark documentation & developer case study',
          ],
        ),
      ];

  /// Shared featured projects consumed by Homepage Screen 001
  static List<ProjectModel> get featuredProjects => allProjects.take(3).toList();

  /// Backwards-compatibility alias for initialProjects
  static List<ProjectModel> get initialProjects => featuredProjects;
}
