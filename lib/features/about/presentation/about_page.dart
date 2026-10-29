import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/contact_dialog.dart';
import '../../home/presentation/widgets/footer.dart';
import '../../home/presentation/widgets/navbar.dart';
import 'widgets/about_cta_section.dart';
import 'widgets/about_hero_section.dart';
import 'widgets/journey_timeline_section.dart';
import 'widgets/learning_focus_section.dart';
import 'widgets/professional_profile_section.dart';
import 'widgets/technical_focus_section.dart';

/// Screen 003: About Me / Professional Profile Page.
///
/// Features professional headline, primary heading, concise biography,
/// code-inspired terminal visual, 5-area professional profile, 4 technical focus cards,
/// 3 current learning cards, 4-step development timeline, and closing contact CTA.
class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _ctaKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _navigateToHome([String? section]) {
    Navigator.pushNamed(context, AppRoutes.home, arguments: section);
  }

  void _navigateToProjects() {
    Navigator.pushNamed(context, AppRoutes.projects);
  }

  void _scrollToTop() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeOutCubic,
      );
    }
  }

  void _scrollToCta() {
    final ctx = _ctaKey.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
        alignment: 0.1,
      );
    } else {
      AppContactDialog.show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background ambient gradient mesh
          Positioned.fill(
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: const Alignment(-0.5, -0.6),
                    radius: 1.3,
                    colors: [
                      AppColors.accentViolet.withValues(alpha: 0.08),
                      AppColors.accentCyan.withValues(alpha: 0.04),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.55, 1.0],
                  ),
                ),
              ),
            ),
          ),

          // Main scrollable content
          Positioned.fill(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  // Spacer for sticky navbar
                  const SizedBox(height: 72),

                  // Hero Section
                  AboutHeroSection(
                    onExploreProjects: _navigateToProjects,
                    onGetInTouch: () => AppContactDialog.show(context),
                  ),

                  // A Little About Me (Professional Profile)
                  const ProfessionalProfileSection(),

                  // Technical Focus Cards (4 areas)
                  const TechnicalFocusSection(),

                  // What I'm Focused On (3 cards)
                  const LearningFocusSection(),

                  // My Development Journey (4 milestones)
                  const JourneyTimelineSection(),

                  // Résumé and Contact CTA
                  Container(
                    key: _ctaKey,
                    child: const AboutCtaSection(),
                  ),

                  // Reusable Shared Footer
                  AppFooter(
                    onHomeTap: () => _navigateToHome(null),
                    onProjectsTap: _navigateToProjects,
                    onAboutTap: _scrollToTop,
                    onContactTap: () => AppContactDialog.show(context),
                  ),
                ],
              ),
            ),
          ),

          // Shared Sticky Top Navigation Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppNavBar(
              activeSection: AppConstants.navAbout,
              onHomeTap: () => _navigateToHome(null),
              onProjectsTap: _navigateToProjects,
              onAboutTap: _scrollToTop,
              onContactTap: _scrollToCta,
            ),
          ),
        ],
      ),
    );
  }
}
