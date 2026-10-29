import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:personal_portfolio/app.dart';
import 'package:personal_portfolio/core/constants/app_constants.dart';
import 'package:personal_portfolio/features/about/presentation/about_page.dart';
import 'package:personal_portfolio/features/home/presentation/widgets/navbar.dart';

void main() {
  testWidgets('Screen 003: About page renders main heading and key sections',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1440, 1800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const MaterialApp(
        home: AboutPage(),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    // Verify eyebrow and main page heading
    expect(find.text('// ABOUT ME'), findsOneWidget);
    expect(find.text(AppConstants.aboutPageHeading), findsOneWidget);

    // Verify professional headline
    expect(find.text(AppConstants.heroHeadline), findsOneWidget);

    // Verify key sections
    expect(find.text('// A LITTLE ABOUT ME'), findsOneWidget);
    expect(find.text('Background & Approach'), findsOneWidget);

    expect(find.text('// TECHNICAL FOCUS'), findsOneWidget);
    expect(find.text('Technical Focus Areas'), findsOneWidget);

    expect(find.text("// WHAT I'M FOCUSED ON"), findsOneWidget);
    expect(find.text('Current Learning & Development Focus'), findsOneWidget);

    expect(find.text('// MY DEVELOPMENT JOURNEY'), findsOneWidget);
    expect(find.text('Development Milestones'), findsOneWidget);

    expect(find.text(AppConstants.aboutCtaHeadline), findsOneWidget);
    expect(find.text(AppConstants.aboutCtaSubheadline), findsOneWidget);

    // Verify key CTA buttons
    expect(find.text('Explore My Projects'), findsOneWidget);
    expect(find.text('Get In Touch'), findsOneWidget);
    expect(find.text('View Résumé'), findsOneWidget);
    expect(find.text('Contact Me'), findsOneWidget);
  });

  testWidgets('Screen 003: Technical focus cards render expected content',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1440, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const MaterialApp(
        home: AboutPage(),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    // Verify 4 technical focus categories
    expect(find.text('Software Development'), findsOneWidget);
    expect(find.text('AI & Agent Workflows'), findsOneWidget);
    expect(find.text('UI/UX'), findsOneWidget);
    expect(find.text('General IT'), findsOneWidget);

    // Verify key skills under each focus area
    expect(find.text('Java'), findsOneWidget);
    expect(find.text('Object-Oriented Programming'), findsAtLeastNWidgets(1));
    expect(find.text('Collections Framework'), findsOneWidget);
    expect(find.text('Data Structures and Algorithms'), findsOneWidget);
    expect(find.text('Git and GitHub'), findsOneWidget);

    expect(find.text('Prompt Engineering'), findsOneWidget);
    expect(find.text('AI Coding Assistants'), findsOneWidget);
    expect(find.text('AI Agent Workflows'), findsOneWidget);
    expect(find.text('Context and Instruction Design'), findsOneWidget);
    expect(find.text('AI-Assisted Development'), findsOneWidget);

    expect(find.text('Interface Design'), findsOneWidget);
    expect(find.text('Responsive Design'), findsOneWidget);
    expect(find.text('Design Systems'), findsOneWidget);
    expect(find.text('Prototyping'), findsOneWidget);
    expect(find.text('Usability Principles'), findsOneWidget);

    expect(find.text('Computer Systems'), findsOneWidget);
    expect(find.text('Troubleshooting'), findsOneWidget);
    expect(find.text('Networking Fundamentals'), findsOneWidget);
    expect(find.text('IT Support Concepts'), findsOneWidget);
    expect(find.text('Security Fundamentals'), findsOneWidget);
  });

  testWidgets('Screen 003: Current learning focus cards render expected content',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1440, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const MaterialApp(
        home: AboutPage(),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    expect(find.text('Engineering Fundamentals'), findsOneWidget);
    expect(find.text('AI-Enhanced Development'), findsOneWidget);
    expect(find.text('Building Real Projects'), findsOneWidget);

    expect(
      find.textContaining('Maintainable Java, programming logic'),
      findsOneWidget,
    );
    expect(
      find.textContaining('Effective AI-agent workflows'),
      findsOneWidget,
    );
    expect(
      find.textContaining('Complete applications, usability improvements'),
      findsOneWidget,
    );
  });

  testWidgets('Screen 003: Development milestones render expected content',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1440, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const MaterialApp(
        home: AboutPage(),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    expect(find.text('01'), findsOneWidget);
    expect(find.text('02'), findsOneWidget);
    expect(find.text('03'), findsOneWidget);
    expect(find.text('04'), findsOneWidget);

    expect(
      find.text('Building foundations in programming and Java'),
      findsOneWidget,
    );
    expect(
      find.text('Developing object-oriented and data-driven applications'),
      findsOneWidget,
    );
    expect(
      find.text('Exploring AI-assisted development and agent workflows'),
      findsOneWidget,
    );
    expect(
      find.text('Building a professional portfolio and practical projects'),
      findsOneWidget,
    );
  });

  testWidgets('Screen 003: Navigation from Home to About works',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(const PortfolioApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    // Tap "About" link inside the AppNavBar
    final navAbout = find.descendant(
      of: find.byType(AppNavBar),
      matching: find.text('About'),
    );
    expect(navAbout, findsOneWidget);

    await tester.tap(navAbout);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pump(const Duration(milliseconds: 300));

    // Verify we arrived on the About Page
    expect(find.text(AppConstants.aboutPageHeading), findsOneWidget);
  });

  testWidgets('Screen 003: Explore My Projects navigates to Projects Gallery',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(const PortfolioApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    // Navigate to About
    final navAbout = find.descendant(
      of: find.byType(AppNavBar),
      matching: find.text('About'),
    );
    await tester.tap(navAbout);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pump(const Duration(milliseconds: 300));

    // Tap "Explore My Projects" button
    final exploreBtn = find.text('Explore My Projects');
    expect(exploreBtn, findsOneWidget);

    await tester.tap(exploreBtn);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pump(const Duration(milliseconds: 300));

    // Verify we reached Projects Gallery
    expect(find.text('Projects Gallery'), findsOneWidget);
    expect(find.text('Showing 4 of 4 projects'), findsOneWidget);
  });

  testWidgets('Screen 003: Contact actions open contact dialog',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const MaterialApp(
        home: AboutPage(),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    // Tap "Get In Touch" in the hero
    final getInTouchBtn = find.text('Get In Touch');
    expect(getInTouchBtn, findsOneWidget);

    await tester.tap(getInTouchBtn);
    await tester.pumpAndSettle();

    // Verify contact dialog opens
    expect(find.text("Let's Connect"), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('GitHub'), findsOneWidget);
    expect(find.text('LinkedIn'), findsOneWidget);

    // Close the dialog
    await tester.tap(find.text('Close'));
    await tester.pumpAndSettle();

    expect(find.text("Let's Connect"), findsNothing);
  });

  testWidgets('Screen 003: View Résumé action opens graceful fallback dialog',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1440, 2000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const MaterialApp(
        home: AboutPage(),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    // Tap "View Résumé" button
    final resumeBtn = find.text('View Résumé');
    expect(resumeBtn, findsOneWidget);

    await tester.ensureVisible(resumeBtn);
    await tester.pumpAndSettle();

    await tester.tap(resumeBtn);
    await tester.pumpAndSettle();

    // Verify graceful fallback dialog
    expect(find.text('Résumé Status'), findsOneWidget);
    expect(
      find.textContaining('The official résumé document will be linked here'),
      findsOneWidget,
    );

    // Close fallback dialog
    await tester.tap(find.text('Close'));
    await tester.pumpAndSettle();

    expect(find.text('Résumé Status'), findsNothing);
  });

  testWidgets('Screen 003: Mobile viewport test (390 x 844)',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const MaterialApp(
        home: AboutPage(),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    // Verify mobile hamburger menu icon is rendered
    expect(find.byIcon(Icons.menu_rounded), findsOneWidget);

    // Verify main heading is present in mobile layout
    expect(find.text(AppConstants.aboutPageHeading), findsOneWidget);

    // Verify CTAs are rendered
    expect(find.text('Explore My Projects'), findsOneWidget);
    expect(find.text('Get In Touch'), findsOneWidget);
  });

  testWidgets('Screen 003: Tablet viewport test (768 x 1024)',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(768, 1024);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const MaterialApp(
        home: AboutPage(),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    // Verify main heading is present
    expect(find.text(AppConstants.aboutPageHeading), findsOneWidget);

    // Verify CTAs
    expect(find.text('Explore My Projects'), findsOneWidget);
    expect(find.text('Get In Touch'), findsOneWidget);
  });
}
