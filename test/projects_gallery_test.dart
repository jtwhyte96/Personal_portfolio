import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:personal_portfolio/app.dart';
import 'package:personal_portfolio/features/home/presentation/widgets/navbar.dart';
import 'package:personal_portfolio/features/projects/presentation/projects_page.dart';

void main() {
  testWidgets('Screen 002: Projects Gallery renders correctly',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const MaterialApp(
        home: ProjectsPage(),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    // Verify title and subtitle
    expect(find.text('Projects Gallery'), findsOneWidget);
    expect(find.textContaining('Explore ongoing software engineering systems'),
        findsOneWidget);

    // Verify search bar
    expect(find.byType(TextField), findsOneWidget);

    // Verify categories
    expect(find.byKey(const ValueKey('filter_chip_All Work')), findsOneWidget);
    expect(find.byKey(const ValueKey('filter_chip_Web Apps')), findsOneWidget);
    expect(find.byKey(const ValueKey('filter_chip_UI/UX')), findsOneWidget);
    expect(find.byKey(const ValueKey('filter_chip_Java')), findsOneWidget);
    expect(find.byKey(const ValueKey('filter_chip_AI')), findsOneWidget);

    // Verify all 4 initial projects are rendered
    expect(find.text('Full-Stack Web Application'), findsOneWidget);
    expect(find.text('Design System & Interface Architecture'), findsOneWidget);
    expect(find.text('Enterprise Java Service Engine'), findsOneWidget);
    expect(find.text('AI Workflow & Prompt Engineering Lab'), findsOneWidget);

    // Verify initial results counter
    expect(find.text('Showing 4 of 4 projects'), findsOneWidget);
  });

  testWidgets('Screen 002: Category filtering works',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const MaterialApp(
        home: ProjectsPage(),
      ),
    );
    await tester.pump();

    // Tap on "Java" category chip
    await tester.tap(find.byKey(const ValueKey('filter_chip_Java')));
    await tester.pumpAndSettle();

    // Verify only Java project is visible
    expect(find.text('Enterprise Java Service Engine'), findsOneWidget);
    expect(find.text('Full-Stack Web Application'), findsNothing);
    expect(find.text('AI Workflow & Prompt Engineering Lab'), findsNothing);
    expect(find.text('Showing 1 of 4 projects'), findsOneWidget);

    // Tap "All Work" to reset
    await tester.tap(find.byKey(const ValueKey('filter_chip_All Work')));
    await tester.pumpAndSettle();

    expect(find.text('Showing 4 of 4 projects'), findsOneWidget);
  });

  testWidgets('Screen 002: Search filtering works',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const MaterialApp(
        home: ProjectsPage(),
      ),
    );
    await tester.pump();

    // Enter search text "Figma" (found in UI/UX tech tags)
    await tester.enterText(find.byType(TextField), 'Figma');
    await tester.pumpAndSettle();

    expect(find.text('Design System & Interface Architecture'), findsOneWidget);
    expect(find.text('Full-Stack Web Application'), findsNothing);
    expect(find.text('Showing 1 of 4 projects'), findsOneWidget);
  });

  testWidgets('Screen 002: Search and Category combine correctly',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const MaterialApp(
        home: ProjectsPage(),
      ),
    );
    await tester.pump();

    // Select "AI" category
    await tester.tap(find.byKey(const ValueKey('filter_chip_AI')));
    await tester.pumpAndSettle();

    // Search for "Prompt"
    await tester.enterText(find.byType(TextField), 'Prompt');
    await tester.pumpAndSettle();

    expect(find.text('AI Workflow & Prompt Engineering Lab'), findsOneWidget);
    expect(find.text('Showing 1 of 4 projects'), findsOneWidget);

    // Now search for "Spring" while AI is selected -> 0 matches
    await tester.enterText(find.byType(TextField), 'Spring');
    await tester.pumpAndSettle();

    expect(find.text('No matching projects found'), findsOneWidget);
  });

  testWidgets('Screen 002: Empty state appears and Clear Filters resets',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const MaterialApp(
        home: ProjectsPage(),
      ),
    );
    await tester.pump();

    // Tap "Websites" (no website projects currently)
    await tester.tap(find.byKey(const ValueKey('filter_chip_Websites')));
    await tester.pumpAndSettle();

    expect(find.text('No matching projects found'), findsOneWidget);
    expect(find.text('Clear Filters'), findsOneWidget);

    // Tap "Clear Filters"
    await tester.tap(find.text('Clear Filters'));
    await tester.pumpAndSettle();

    // Verify all 4 projects are restored
    expect(find.text('Showing 4 of 4 projects'), findsOneWidget);
    expect(find.text('Full-Stack Web Application'), findsOneWidget);
  });

  testWidgets('Screen 002: Project details preview opens and closes',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1440, 1400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const MaterialApp(
        home: ProjectsPage(),
      ),
    );
    await tester.pump();

    // Ensure the "Details Preview" button is visible and tap it
    final detailsBtn = find.text('Details Preview').first;
    await tester.tap(detailsBtn);
    await tester.pumpAndSettle();

    // Verify dialog content
    expect(find.text('PROJECT OVERVIEW'), findsOneWidget);
    expect(find.text('CORE TECHNOLOGIES'), findsOneWidget);
    expect(find.text('DEVELOPMENT MILESTONES'), findsOneWidget);
    expect(find.text('Close Details'), findsOneWidget);

    // Close dialog
    await tester.tap(find.text('Close Details'));
    await tester.pumpAndSettle();

    expect(find.text('PROJECT OVERVIEW'), findsNothing);
  });

  testWidgets('Screen 002: Navigation from Home to Projects works',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(const PortfolioApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    // Tap "Projects" link inside the AppNavBar
    final navProjects = find.descendant(
      of: find.byType(AppNavBar),
      matching: find.text('Projects'),
    );
    expect(navProjects, findsOneWidget);

    await tester.tap(navProjects);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pump(const Duration(milliseconds: 300));

    // Verify we arrived on the Projects Gallery
    expect(find.text('Projects Gallery'), findsOneWidget);
    expect(find.text('Showing 4 of 4 projects'), findsOneWidget);
  });
}
