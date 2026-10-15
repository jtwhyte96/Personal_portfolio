import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import 'widgets/about_preview_section.dart';
import 'widgets/contact_section.dart';
import 'widgets/featured_projects_section.dart';
import 'widgets/footer.dart';
import 'widgets/hero_section.dart';
import 'widgets/navbar.dart';
import 'widgets/tech_strip.dart';

/// Screen 001: Main Portfolio Homepage.
///
/// Implements responsive dark layout with sticky glass navigation,
/// hero section with abstract cyber-tech composition, skills strip,
/// upcoming featured projects, about preview, contact CTA, and footer.
class HomePage extends StatefulWidget {
  final String? initialSection;

  const HomePage({super.key, this.initialSection});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  String _activeSection = AppConstants.navHome;

  @override
  void initState() {
    super.initState();
    if (widget.initialSection != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _handleInitialSection(widget.initialSection!);
      });
    }
  }

  void _handleInitialSection(String section) {
    switch (section) {
      case AppConstants.navProjects:
        _scrollToKey(_projectsKey, AppConstants.navProjects);
        break;
      case AppConstants.navAbout:
        _scrollToKey(_aboutKey, AppConstants.navAbout);
        break;
      case AppConstants.navContact:
        _scrollToKey(_contactKey, AppConstants.navContact);
        break;
      default:
        _scrollToKey(_homeKey, AppConstants.navHome);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToKey(GlobalKey key, String sectionName) {
    setState(() => _activeSection = sectionName);
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeInOutCubic,
        alignment: 0.0,
      );
    }
  }

  void _navigateToProjectsGallery() {
    Navigator.pushNamed(context, AppRoutes.projects);
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
                    center: const Alignment(-0.6, -0.7),
                    radius: 1.2,
                    colors: [
                      AppColors.accentViolet.withValues(alpha: 0.08),
                      AppColors.accentBlue.withValues(alpha: 0.04),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.5, 1.0],
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
                  Container(
                    key: _homeKey,
                    child: HeroSection(
                      onExploreWork: () =>
                          _scrollToKey(_projectsKey, AppConstants.navProjects),
                      onGetInTouch: () =>
                          _scrollToKey(_contactKey, AppConstants.navContact),
                    ),
                  ),

                  // Technology and skills strip
                  const TechStrip(),

                  // Selected Work / Featured Projects Section
                  Container(
                    key: _projectsKey,
                    child: FeaturedProjectsSection(
                      onViewAllProjects: _navigateToProjectsGallery,
                    ),
                  ),

                  // About Me Preview Section
                  Container(
                    key: _aboutKey,
                    child: AboutPreviewSection(
                      onLearnMore: () =>
                          _scrollToKey(_contactKey, AppConstants.navContact),
                    ),
                  ),

                  // Contact Call-To-Action Section
                  Container(
                    key: _contactKey,
                    child: const ContactSection(),
                  ),

                  // Footer
                  AppFooter(
                    onHomeTap: () =>
                        _scrollToKey(_homeKey, AppConstants.navHome),
                    onProjectsTap: _navigateToProjectsGallery,
                    onAboutTap: () =>
                        _scrollToKey(_aboutKey, AppConstants.navAbout),
                    onContactTap: () =>
                        _scrollToKey(_contactKey, AppConstants.navContact),
                  ),
                ],
              ),
            ),
          ),

          // Sticky Top Navigation Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppNavBar(
              activeSection: _activeSection,
              onHomeTap: () => _scrollToKey(_homeKey, AppConstants.navHome),
              onProjectsTap: _navigateToProjectsGallery,
              onAboutTap: () => _scrollToKey(_aboutKey, AppConstants.navAbout),
              onContactTap: () =>
                  _scrollToKey(_contactKey, AppConstants.navContact),
            ),
          ),
        ],
      ),
    );
  }
}
