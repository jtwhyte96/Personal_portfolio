import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:personal_portfolio/app.dart';
import 'package:personal_portfolio/core/constants/app_constants.dart';

void main() {
  testWidgets('Portfolio Homepage desktop smoke test and section verification',
      (WidgetTester tester) async {
    // Configure desktop viewport (1440 x 900)
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    // Build the portfolio application
    await tester.pumpWidget(const PortfolioApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    // Verify personal identity placeholder
    expect(find.text(AppConstants.placeholderName), findsAtLeastNWidgets(1));

    // Verify exact headline or its components
    expect(find.textContaining('Java Developer'), findsAtLeastNWidgets(1));

    // Verify CTAs
    expect(find.text('Explore My Work'), findsOneWidget);
    expect(find.text('Get In Touch'), findsAtLeastNWidgets(1));

    // Verify skills items
    expect(find.text('Java'), findsAtLeastNWidgets(1));
    expect(find.text('Flutter'), findsOneWidget);
    expect(find.text('AI Tools'), findsOneWidget);

    // Verify Featured Projects section
    expect(find.text('Featured Projects'), findsOneWidget);

    // Verify 3 placeholder project cards
    expect(find.text('Full-Stack Web Application'), findsOneWidget);
    expect(find.text('Design System & UX Case Study'), findsOneWidget);
    expect(find.text('Enterprise Java & AI Workflow Engine'), findsOneWidget);
  });

  testWidgets('Portfolio Homepage mobile viewport test (390 x 844)',
      (WidgetTester tester) async {
    // Configure mobile viewport (390 x 844)
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    // Build the portfolio application
    await tester.pumpWidget(const PortfolioApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    // Verify mobile hamburger menu icon is rendered
    expect(find.byIcon(Icons.menu_rounded), findsOneWidget);

    // Verify headline is present in mobile layout
    expect(find.text(AppConstants.heroHeadline), findsOneWidget);

    // Verify CTAs
    expect(find.text('Explore My Work'), findsOneWidget);
  });
}
