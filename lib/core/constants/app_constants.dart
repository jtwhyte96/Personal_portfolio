import 'package:flutter/material.dart';

/// Centralized application constants and configurable placeholders.
///
/// Easily customize your personal identity, portfolio links, and skill list
/// without modifying layout widgets.
class AppConstants {
  AppConstants._();

  // Personal identity placeholders
  static const String placeholderName = '[JOSEPH WHYTE]';
  static const String eyebrowTag = '// SOFTWARE ENGINEER & DESIGNER';
  static const String heroHeadline = 'Java Developer • AI & UI/UX';
  static const String heroSubheadline =
      'Building thoughtful digital experiences through software engineering, '
      'AI-powered workflows, and user-centered design.';

  // About Preview text
  static const String aboutEyebrow = '// ABOUT ME';
  static const String aboutHeadline =
      'Bridging technical depth with intuitive visual design.';
  static const String aboutDescription =
      'I specialize in building reliable, scalable backend systems with Java and crafting '
      'responsive, engaging user interfaces with Flutter and modern web technologies. '
      'By integrating AI-assisted workflows into my engineering process, I focus on '
      'rapid prototyping without sacrificing clean architecture, performance, or code quality.';

  // Contact section
  static const String contactEyebrow = '// GET IN TOUCH';
  static const String contactHeadline = 'Have an idea worth building?';
  static const String contactSubheadline =
      'Whether you are looking to build a high-performance Java application, explore AI-assisted '
      'workflows, or craft a modern web experience, let us connect.';

  // Configurable external placeholders
  static const String placeholderEmail = 'contact@example.com';
  static const String placeholderGithub = 'https://github.com/your-username';
  static const String placeholderLinkedin = 'https://linkedin.com/in/your-username';
  static const String placeholderResumeUrl = '';

  // About Page Headings & CTAs (Screen 003)
  static const String aboutPageHeading =
      'Building software. Exploring AI. Designing better experiences.';
  static const String aboutCtaHeadline = "LET'S BUILD SOMETHING MEANINGFUL";
  static const String aboutCtaSubheadline =
      "I'm interested in opportunities to learn, collaborate, and contribute to practical software and AI-enabled projects.";

  // Navigation targets
  static const String navHome = 'Home';
  static const String navProjects = 'Projects';
  static const String navAbout = 'About';
  static const String navContact = 'Contact';

  // Skills & technology list (data-driven)
  static const List<TechSkillItem> skills = [
    TechSkillItem(name: 'Java', icon: Icons.terminal_rounded),
    TechSkillItem(name: 'Flutter', icon: Icons.flutter_dash_rounded),
    TechSkillItem(name: 'Dart', icon: Icons.code_rounded),
    TechSkillItem(name: 'AI Tools', icon: Icons.auto_awesome_rounded),
    TechSkillItem(name: 'Prompt Engineering', icon: Icons.psychology_rounded),
    TechSkillItem(name: 'UI/UX Design', icon: Icons.design_services_rounded),
    TechSkillItem(name: 'Git & GitHub', icon: Icons.alt_route_rounded),
  ];

  // Responsive Breakpoints
  static const double desktopBreakpoint = 1024.0;
  static const double tabletBreakpoint = 680.0;
  static const double maxContentWidth = 1200.0;
}

class TechSkillItem {
  final String name;
  final IconData icon;

  const TechSkillItem({
    required this.name,
    required this.icon,
  });
}
