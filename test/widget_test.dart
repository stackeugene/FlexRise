import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flex_rise/main.dart';

void main() {
  testWidgets('FlexRiseApp builds without crashing', (WidgetTester tester) async {
    // Build the FlexRiseApp widget
    await tester.pumpWidget(const FlexRiseApp());

    // Verify that the Sign-In screen is displayed
    // Look for the "Sign In" text in the body (with specific style)
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Text &&
            widget.data == 'Sign In' &&
            widget.style?.fontSize == 24 &&
            widget.style?.fontWeight == FontWeight.bold,
      ),
      findsOneWidget,
    );

    // Verify that the Email and Password fields are displayed
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
  });
}