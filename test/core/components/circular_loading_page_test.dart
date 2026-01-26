import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:porrapp_frontend/core/components/components.dart';

void main() {
  testWidgets(
    'CircularLoadingPage shows a CircularProgressIndicator centered',
    (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: CircularLoadingPage())),
      );

      // Act
      final centerFinder = find.byType(Center);
      final progressFinder = find.byType(CircularProgressIndicator);

      // Assert
      expect(centerFinder, findsOneWidget);
      expect(progressFinder, findsOneWidget);

      // Verify hierarchy (CircularProgressIndicator inside Center)
      final Center centerWidget = tester.widget(centerFinder);
      expect(centerWidget.child, isA<CircularProgressIndicator>());
    },
  );
}
