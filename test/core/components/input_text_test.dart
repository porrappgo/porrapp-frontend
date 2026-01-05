import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:porrapp_frontend/core/components/input_text.dart';

void main() {
  group('InputText', () {
    testWidgets('renders TextFormField with label and hint', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: InputText(
              label: 'Email',
              hint: 'Enter your email',
              onChanged: (_) {},
            ),
          ),
        ),
      );

      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Enter your email'), findsOneWidget);
    });

    testWidgets('password field obscures and toggles visibility', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: InputText(
              label: 'Password',
              hint: 'Enter password',
              isPassword: true,
              onChanged: (_) {},
            ),
          ),
        ),
      );

      EditableText editableText = tester.widget(find.byType(EditableText));
      expect(editableText.obscureText, true);

      final toggleButton = find.byType(IconButton);
      expect(toggleButton, findsOneWidget);

      await tester.tap(toggleButton);
      await tester.pump();

      editableText = tester.widget(find.byType(EditableText));
      expect(editableText.obscureText, false);

      await tester.tap(toggleButton);
      await tester.pump();

      editableText = tester.widget(find.byType(EditableText));
      expect(editableText.obscureText, true);
    });

    testWidgets('calls onChanged when text is entered', (
      WidgetTester tester,
    ) async {
      String value = '';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: InputText(
              label: 'Test',
              hint: 'Test hint',
              onChanged: (v) => value = v,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'hello');
      expect(value, 'hello');
    });

    testWidgets('validator is called and error text is shown', (
      WidgetTester tester,
    ) async {
      final formKey = GlobalKey<FormState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: InputText(
                label: 'Test',
                hint: 'Test hint',
                onChanged: (_) {},
                validator: (_) => 'Error message',
              ),
            ),
          ),
        ),
      );

      formKey.currentState!.validate();
      await tester.pump();

      expect(find.text('Error message'), findsOneWidget);
    });

    testWidgets('displays prefix icon when provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: InputText(
              label: 'Email',
              hint: 'Enter email',
              prefixIcon: Icons.email,
              onChanged: (_) {},
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.email), findsOneWidget);
    });

    testWidgets('uses custom keyboard type (verified via EditableText)', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: InputText(
              label: 'Phone',
              hint: 'Enter phone',
              keyboardType: TextInputType.phone,
              onChanged: (_) {},
            ),
          ),
        ),
      );

      final editableText = tester.widget<EditableText>(
        find.byType(EditableText),
      );

      expect(editableText.keyboardType, TextInputType.phone);
    });

    testWidgets('uses default keyboardType TextInputType.none', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: InputText(
              label: 'Default',
              hint: 'Default keyboard',
              onChanged: (_) {},
            ),
          ),
        ),
      );

      final editableText = tester.widget<EditableText>(
        find.byType(EditableText),
      );

      expect(editableText.keyboardType, TextInputType.none);
    });

    testWidgets('applies textInputAction when provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: InputText(
              label: 'Next',
              hint: 'Next action',
              textInputAction: TextInputAction.next,
              onChanged: (_) {},
            ),
          ),
        ),
      );

      final editableText = tester.widget<EditableText>(
        find.byType(EditableText),
      );

      expect(editableText.textInputAction, TextInputAction.next);
    });
  });
}
