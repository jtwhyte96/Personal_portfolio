import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/app_buttons.dart';
import '../../home/presentation/widgets/footer.dart';
import '../../home/presentation/widgets/navbar.dart';
import '../models/project_model.dart';
import 'widgets/project_card.dart';

/// Screen 002: Projects Gallery Page.
///
/// Features searchable, category-filtered portfolio archive with responsive grid,
/// empty states, details previews, and shared navigation.
class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  static const List<String> categories = [
    'All Work',
    'Websites',
    'Web Apps',
    'UI/UX',
    'Java',
    'AI',
  ];

  String _selectedCategory = 'All Work';
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.trim().toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  List<ProjectModel> get _filteredProjects {
    return ProjectModel.allProjects.where((project) {
      // 1. Category filter match
      final bool matchesCategory;
      if (_selectedCategory == 'All Work') {
        matchesCategory = true;
      } else if (_selectedCategory == 'Web Apps') {
        matchesCategory = project.category == 'Web Apps' ||
            project.category == 'Web Application';
      } else if (_selectedCategory == 'UI/UX') {
        matchesCategory = project.category == 'UI/UX' ||
            project.category == 'UI/UX Design' ||
            project.category == 'Interface Design';
      } else if (_selectedCategory == 'Java') {
        matchesCategory = project.category == 'Java' ||
            project.category == 'Software Project';
      } else if (_selectedCategory == 'AI') {
        matchesCategory = project.category == 'AI' ||
            project.category == 'AI Experiment';
      } else if (_selectedCategory == 'Websites') {
        matchesCategory = project.category.toLowerCase().contains('website') ||
            project.techTags.any((t) => t.toLowerCase().contains('website'));
      } else {
        matchesCategory = project.category == _selectedCategory;
      }

      // 2. Search query match
      final bool matchesSearch;
      if (_searchQuery.isEmpty) {
        matchesSearch = true;
      } else {
        final titleMatch = project.title.toLowerCase().contains(_searchQuery);
        final descMatch =
            project.description.toLowerCase().contains(_searchQuery);
        final catMatch = project.category.toLowerCase().contains(_searchQuery);
        final tagMatch = project.techTags
            .any((tag) => tag.toLowerCase().contains(_searchQuery));
        matchesSearch = titleMatch || descMatch || catMatch || tagMatch;
      }

      return matchesCategory && matchesSearch;
    }).toList();
  }

  void _clearAllFilters() {
    setState(() {
      _selectedCategory = 'All Work';
      _searchController.clear();
      _searchQuery = '';
    });
  }

  void _navigateToHomeSection(String? section) {
    Navigator.pushNamed(context, AppRoutes.home, arguments: section);
  }

  void _navigateToAbout() {
    Navigator.pushNamed(context, AppRoutes.about);
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = _filteredProjects;
    final totalCount = ProjectModel.allProjects.length;
    final isFiltered = _selectedCategory != 'All Work' || _searchQuery.isNotEmpty;

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
                    center: const Alignment(0.6, -0.7),
                    radius: 1.2,
                    colors: [
                      AppColors.accentBlue.withValues(alpha: 0.08),
                      AppColors.accentViolet.withValues(alpha: 0.04),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.5, 1.0],
                  ),
                ),
              ),
            ),
          ),

          // Main Scrollable Content
          Positioned.fill(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  const SizedBox(height: 72), // Navbar spacer

                  // Gallery Header Section
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 48),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                            maxWidth: AppConstants.maxContentWidth),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Eyebrow
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.accentViolet
                                    .withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: AppColors.accentViolet
                                      .withValues(alpha: 0.25),
                                ),
                              ),
                              child: Text(
                                '// PORTFOLIO ARCHIVE',
                                style: AppTypography.eyebrow(
                                  color: AppColors.accentViolet,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Heading
                            Text(
                              'Projects Gallery',
                              style: AppTypography.displayMedium(),
                            ),
                            const SizedBox(height: 12),

                            // Supporting copy
                            ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 680),
                              child: Text(
                                'Explore ongoing software engineering systems, UI/UX design architectures, '
                                'Java platforms, and AI-assisted workflows.',
                                style: AppTypography.bodyLarge(),
                              ),
                            ),
                            const SizedBox(height: 36),

                            // Search bar
                            _buildSearchBar(),
                            const SizedBox(height: 20),

                            // Category Filter Chips
                            _buildCategoryChips(),
                            const SizedBox(height: 24),

                            // Results counter & reset action
                            _buildResultsBar(
                              filteredCount: filteredList.length,
                              totalCount: totalCount,
                              isFiltered: isFiltered,
                            ),
                            const SizedBox(height: 32),

                            // Project Grid or Empty State
                            if (filteredList.isNotEmpty)
                              _buildProjectGrid(filteredList)
                            else
                              _buildEmptyState(),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Shared Footer
                  AppFooter(
                    onHomeTap: () => _navigateToHomeSection(null),
                    onProjectsTap: () {
                      _scrollController.animateTo(
                        0,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeOutCubic,
                      );
                    },
                    onAboutTap: _navigateToAbout,
                    onContactTap: () =>
                        _navigateToHomeSection(AppConstants.navContact),
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
              activeSection: AppConstants.navProjects,
              onHomeTap: () => _navigateToHomeSection(null),
              onProjectsTap: () {
                _scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOutCubic,
                );
              },
              onAboutTap: _navigateToAbout,
              onContactTap: () =>
                  _navigateToHomeSection(AppConstants.navContact),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfacePrimary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderCard, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        style: AppTypography.bodyMedium(color: AppColors.textPrimary),
        cursorColor: AppColors.accentViolet,
        decoration: InputDecoration(
          hintText: 'Search by project name, tech tag, or keyword...',
          hintStyle: AppTypography.bodyMedium(color: AppColors.textMuted),
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: AppColors.textSecondary,
            size: 20,
          ),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(
                    Icons.close_rounded,
                    color: AppColors.textSecondary,
                    size: 18,
                  ),
                  tooltip: 'Clear search',
                  onPressed: () {
                    _searchController.clear();
                  },
                )
              : null,
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }

  Widget _buildCategoryChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((cat) {
          final isSelected = _selectedCategory == cat;

          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: FocusableActionDetector(
              child: InkWell(
                key: ValueKey('filter_chip_$cat'),
                onTap: () {
                  setState(() {
                    _selectedCategory = cat;
                  });
                },
                borderRadius: BorderRadius.circular(20),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: isSelected ? AppColors.primaryGradient : null,
                    color: isSelected ? null : AppColors.surfaceSecondary,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.accentBlue
                          : AppColors.borderSubtle,
                      width: 1.2,
                    ),
                    boxShadow: [
                      if (isSelected)
                        BoxShadow(
                          color: AppColors.accentViolet.withValues(alpha: 0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 2),
                        ),
                    ],
                  ),
                  child: Text(
                    cat,
                    style: AppTypography.button(
                      color: isSelected
                          ? Colors.white
                          : AppColors.textSecondary,
                    ).copyWith(fontSize: 13),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildResultsBar({
    required int filteredCount,
    required int totalCount,
    required bool isFiltered,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(Icons.grid_view_rounded,
                size: 16, color: AppColors.accentViolet),
            const SizedBox(width: 8),
            Text(
              'Showing $filteredCount of $totalCount projects',
              style: AppTypography.bodySmall(color: AppColors.textSecondary)
                  .copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        if (isFiltered)
          TextButton.icon(
            onPressed: _clearAllFilters,
            icon: const Icon(Icons.refresh_rounded,
                size: 14, color: AppColors.accentViolet),
            label: Text(
              'Reset Filters',
              style: AppTypography.bodySmall(color: AppColors.accentViolet)
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ),
      ],
    );
  }

  Widget _buildProjectGrid(List<ProjectModel> projects) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 960) {
          // 3 Column Grid
          final itemWidth = (constraints.maxWidth - 40) / 3;
          return Wrap(
            spacing: 20,
            runSpacing: 24,
            children: projects.map((p) {
              return SizedBox(
                width: itemWidth,
                child: ProjectCard(project: p),
              );
            }).toList(),
          );
        } else if (constraints.maxWidth >= 640) {
          // 2 Column Grid
          final itemWidth = (constraints.maxWidth - 20) / 2;
          return Wrap(
            spacing: 20,
            runSpacing: 24,
            children: projects.map((p) {
              return SizedBox(
                width: itemWidth,
                child: ProjectCard(project: p),
              );
            }).toList(),
          );
        } else {
          // 1 Column Grid
          return Column(
            children: projects.map((p) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: ProjectCard(project: p),
              );
            }).toList(),
          );
        }
      },
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 56),
      decoration: BoxDecoration(
        color: AppColors.surfacePrimary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surfaceSecondary,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.borderCard),
            ),
            child: const Icon(
              Icons.filter_list_off_rounded,
              size: 36,
              color: AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'No matching projects found',
            style: AppTypography.titleMedium().copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: Text(
              'No projects matched "$_searchQuery" under the "$_selectedCategory" category. '
              'Try adjusting your search query or reset your filters.',
              textAlign: TextAlign.center,
              style: AppTypography.bodyMedium(),
            ),
          ),
          const SizedBox(height: 24),
          AppSecondaryButton(
            label: 'Clear Filters',
            icon: Icons.refresh_rounded,
            onPressed: _clearAllFilters,
          ),
        ],
      ),
    );
  }
}
