import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

/// Data models and structured content for Screen 003: About Me / Professional Profile.
/// Keeps presentation cleanly decoupled from editable biographical and technical content.

class TechnicalFocusArea {
  final String category;
  final String tag;
  final IconData icon;
  final Color accentColor;
  final String description;
  final List<String> skills;

  const TechnicalFocusArea({
    required this.category,
    required this.tag,
    required this.icon,
    required this.accentColor,
    required this.description,
    required this.skills,
  });

  static const List<TechnicalFocusArea> allAreas = [
    TechnicalFocusArea(
      category: 'Software Development',
      tag: '// BACKEND & LOGIC',
      icon: Icons.terminal_rounded,
      accentColor: AppColors.accentBlue,
      description:
          'Writing structured, maintainable code with robust object-oriented principles, modular architecture, and reliable version control.',
      skills: [
        'Java',
        'Object-Oriented Programming',
        'Collections Framework',
        'Data Structures and Algorithms',
        'Git and GitHub',
      ],
    ),
    TechnicalFocusArea(
      category: 'AI & Agent Workflows',
      tag: '// AGENTIC WORKFLOWS',
      icon: Icons.auto_awesome_rounded,
      accentColor: AppColors.accentViolet,
      description:
          'Orchestrating agentic coding workflows, structuring high-leverage prompts, and critically verifying machine-generated implementations.',
      skills: [
        'Prompt Engineering',
        'AI Coding Assistants',
        'AI Agent Workflows',
        'Context and Instruction Design',
        'AI-Assisted Development',
      ],
    ),
    TechnicalFocusArea(
      category: 'UI/UX',
      tag: '// DESIGN & FRONTEND',
      icon: Icons.palette_rounded,
      accentColor: AppColors.accentCyan,
      description:
          'Crafting fluid, intuitive user interfaces with consistent design tokens, accessible contrast, and adaptive multi-device layouts.',
      skills: [
        'Interface Design',
        'Responsive Design',
        'Design Systems',
        'Prototyping',
        'Usability Principles',
      ],
    ),
    TechnicalFocusArea(
      category: 'General IT',
      tag: '// SYSTEMS & INFRA',
      icon: Icons.dns_rounded,
      accentColor: AppColors.accentEmerald,
      description:
          'Grounded technical foundations in operating systems, systematic debugging, network communication, and defensive security basics.',
      skills: [
        'Computer Systems',
        'Troubleshooting',
        'Networking Fundamentals',
        'IT Support Concepts',
        'Security Fundamentals',
      ],
    ),
  ];
}

class LearningFocusItem {
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final Color accentColor;

  const LearningFocusItem({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.accentColor,
  });

  static const List<LearningFocusItem> allItems = [
    LearningFocusItem(
      title: 'Engineering Fundamentals',
      subtitle: 'Core Rigor & Reliability',
      description:
          'Maintainable Java, programming logic, testing, and software architecture.',
      icon: Icons.architecture_rounded,
      accentColor: AppColors.accentBlue,
    ),
    LearningFocusItem(
      title: 'AI-Enhanced Development',
      subtitle: 'Modern Tooling & Review',
      description:
          'Effective AI-agent workflows, code review, and validation of generated code.',
      icon: Icons.psychology_rounded,
      accentColor: AppColors.accentViolet,
    ),
    LearningFocusItem(
      title: 'Building Real Projects',
      subtitle: 'Practical Delivery',
      description:
          'Complete applications, usability improvements, and technical documentation.',
      icon: Icons.rocket_launch_rounded,
      accentColor: AppColors.accentEmerald,
    ),
  ];
}

class JourneyMilestone {
  final String step;
  final String title;
  final String description;
  final IconData icon;
  final Color accentColor;

  const JourneyMilestone({
    required this.step,
    required this.title,
    required this.description,
    required this.icon,
    required this.accentColor,
  });

  static const List<JourneyMilestone> allMilestones = [
    JourneyMilestone(
      step: '01',
      title: 'Building foundations in programming and Java',
      description:
          'Mastering core syntax, object-oriented concepts, algorithm design, and computational thinking through deliberate daily practice.',
      icon: Icons.code_rounded,
      accentColor: AppColors.accentBlue,
    ),
    JourneyMilestone(
      step: '02',
      title: 'Developing object-oriented and data-driven applications',
      description:
          'Designing modular backend logic, managing structured collections, and building functional software with clean separation of concerns.',
      icon: Icons.data_object_rounded,
      accentColor: AppColors.accentCyan,
    ),
    JourneyMilestone(
      step: '03',
      title: 'Exploring AI-assisted development and agent workflows',
      description:
          'Integrating AI coding agents into engineering loops, designing context-rich prompts, and establishing rigorous code verification habits.',
      icon: Icons.auto_awesome_rounded,
      accentColor: AppColors.accentViolet,
    ),
    JourneyMilestone(
      step: '04',
      title: 'Building a professional portfolio and practical projects',
      description:
          'Shipping complete cross-platform web experiences, refining user journeys, and documenting practical software solutions.',
      icon: Icons.devices_rounded,
      accentColor: AppColors.accentAmber,
    ),
  ];
}

class ProfilePillar {
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final Color accentColor;

  const ProfilePillar({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.accentColor,
  });

  static const List<ProfilePillar> allPillars = [
    ProfilePillar(
      title: 'Java & Object-Oriented Development',
      subtitle: 'Architectural Rigor',
      description:
          'Focused on writing clean, modular, and maintainable Java code grounded in object-oriented principles, strong typing, and readable class design.',
      icon: Icons.terminal_rounded,
      accentColor: AppColors.accentBlue,
    ),
    ProfilePillar(
      title: 'Software Problem-Solving',
      subtitle: 'Systematic Logic',
      description:
          'Deconstructing complex functional requirements into clear, testable algorithmic steps, ensuring applications are both dependable and extensible.',
      icon: Icons.extension_rounded,
      accentColor: AppColors.accentCyan,
    ),
    ProfilePillar(
      title: 'AI Tools & Agent Workflows',
      subtitle: 'Amplified Productivity',
      description:
          'Harnessing AI coding assistants and autonomous agents through structured prompt architectures, continuous human review, and rigorous output validation.',
      icon: Icons.smart_toy_rounded,
      accentColor: AppColors.accentViolet,
    ),
    ProfilePillar(
      title: 'UI/UX & Responsive Design',
      subtitle: 'Human-Centered Interfaces',
      description:
          'Designing thoughtful visual hierarchies, fluid multi-breakpoint layouts, and accessible interfaces that make software straightforward and engaging to use.',
      icon: Icons.palette_rounded,
      accentColor: AppColors.accentAmber,
    ),
    ProfilePillar(
      title: 'Practical Learning & Iteration',
      subtitle: 'Continuous Growth',
      description:
          'Growing continuously through hands-on project creation, iterative code refactoring, and maintaining a student mindset as technologies evolve.',
      icon: Icons.trending_up_rounded,
      accentColor: AppColors.accentEmerald,
    ),
  ];
}
