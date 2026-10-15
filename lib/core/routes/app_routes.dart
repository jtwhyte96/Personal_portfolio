import 'package:flutter/material.dart';
import '../../features/home/presentation/home_page.dart';
import '../../features/projects/presentation/projects_page.dart';

/// Centralized route definitions for the portfolio application.
class AppRoutes {
  AppRoutes._();

  static const String home = '/';
  static const String projects = '/projects';

  /// Generates routes with proper URL synchronization for Flutter Web.
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        final initialSection = settings.arguments as String?;
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => HomePage(initialSection: initialSection),
        );

      case projects:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => const ProjectsPage(),
        );

      default:
        // Graceful fallback to Home for unknown routes
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => const HomePage(),
        );
    }
  }
}
