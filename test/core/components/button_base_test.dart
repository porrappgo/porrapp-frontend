import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:porrapp_frontend/core/components/button_base.dart';

void main() {
  group('ButtonBase', () {
    testWidgets('renders with text', (WidgetTester tester) async {
      // Arrange
      const buttonText = 'Test Button';
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ButtonBase(onPressed: () {}, text: buttonText),
          ),
        ),
      );
      // Assert
      expect(find.text(buttonText), findsOneWidget);
    });

    testWidgets('calls onPressed callback when tapped', (
      WidgetTester tester,
    ) async {
      // Arrange
      bool pressed = false;
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ButtonBase(
              onPressed: () => pressed = true,
              text: 'Test Button',
            ),
          ),
        ),
      );
      await tester.tap(find.byType(MaterialButton));
      // Assert
      expect(pressed, true);
    });

    testWidgets('is disabled when isDisabled is true', (
      WidgetTester tester,
    ) async {
      // Arrange
      bool pressed = false;
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ButtonBase(
              onPressed: () => pressed = true,
              text: 'Test Button',
              isDisabled: true,
            ),
          ),
        ),
      );
      await tester.tap(find.byType(MaterialButton));
      // Assert
      expect(pressed, false);
    });

    testWidgets('shows loading indicator when isLoading is true', (
      WidgetTester tester,
    ) async {
      // Arrange
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ButtonBase(
              onPressed: () {},
              text: 'Test Button',
              isLoading: true,
            ),
          ),
        ),
      );
      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Test Button'), findsNothing);
    });

    testWidgets('expands to fill parent when isExpanded is true', (
      WidgetTester tester,
    ) async {
      // Arrange
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ButtonBase(
              onPressed: () {},
              text: 'Test Button',
              isExpanded: true,
            ),
          ),
        ),
      );
      // Assert
      final MaterialButton button =
          find.byType(MaterialButton).evaluate().first.widget as MaterialButton;
      expect(button.minWidth, double.infinity);
    });

    testWidgets('uses custom width when isExpanded is false', (
      WidgetTester tester,
    ) async {
      // Arrange
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ButtonBase(
              onPressed: () {},
              text: 'Test Button',
              width: 200,
              isExpanded: false,
            ),
          ),
        ),
      );
      // Assert
      final MaterialButton button =
          find.byType(MaterialButton).evaluate().first.widget as MaterialButton;
      expect(button.minWidth, 200);
    });

    testWidgets('is disabled when isLoading is true', (
      WidgetTester tester,
    ) async {
      // Arrange
      bool pressed = false;
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ButtonBase(
              onPressed: () => pressed = true,
              text: 'Test Button',
              isLoading: true,
            ),
          ),
        ),
      );
      await tester.tap(find.byType(MaterialButton));
      // Assert
      expect(pressed, false);
    });
  });
}
