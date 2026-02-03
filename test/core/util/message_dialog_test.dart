import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:porrapp_frontend/l10n/app_localizations.dart';
import 'package:porrapp_frontend/core/util/message_dialog.dart';

void main() {
  Widget wrapWithApp(Widget child) {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: child),
    );
  }

  testWidgets(
    'shows dialog with confirm and cancel buttons and executes callbacks',
    (WidgetTester tester) async {
      bool confirmed = false;
      bool closed = false;

      await tester.pumpWidget(
        wrapWithApp(
          Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  messageDialog(
                    context: context,
                    title: 'Title',
                    content: 'Content',
                    onConfirmed: () => confirmed = true,
                    onClosed: () => closed = true,
                  );
                },
                child: const Text('Open'),
              );
            },
          ),
        ),
      );

      // Open dialog
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      // Assert dialog content
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Content'), findsOneWidget);

      final l10n = AppLocalizations.of(
        tester.element(find.byType(AlertDialog)),
      )!;

      // Buttons exist
      expect(find.text(l10n.confirmButton), findsOneWidget);
      expect(find.text(l10n.cancelButton), findsOneWidget);

      // Tap confirm
      await tester.tap(find.text(l10n.confirmButton));
      await tester.pumpAndSettle();

      expect(confirmed, isTrue);
      expect(closed, isFalse);
    },
  );

  testWidgets('shows dialog with only cancel button and executes onClosed', (
    WidgetTester tester,
  ) async {
    bool closed = false;

    await tester.pumpWidget(
      wrapWithApp(
        Builder(
          builder: (context) {
            return ElevatedButton(
              onPressed: () {
                messageDialog(
                  context: context,
                  title: 'Title',
                  content: 'Content',
                  onClosed: () => closed = true,
                );
              },
              child: const Text('Open'),
            );
          },
        ),
      ),
    );

    // Open dialog
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    final l10n = AppLocalizations.of(tester.element(find.byType(AlertDialog)))!;

    // Only cancel button
    expect(find.text(l10n.confirmButton), findsNothing);
    expect(find.text(l10n.cancelButton), findsOneWidget);

    // Tap cancel
    await tester.tap(find.text(l10n.cancelButton));
    await tester.pumpAndSettle();

    expect(closed, isTrue);
  });

  testWidgets(
    'shows dialog with cancel button when no callbacks are provided',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithApp(
          Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  messageDialog(
                    context: context,
                    title: 'Title',
                    content: 'Content',
                  );
                },
                child: const Text('Open'),
              );
            },
          ),
        ),
      );

      // Open dialog
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      final l10n = AppLocalizations.of(
        tester.element(find.byType(AlertDialog)),
      )!;

      expect(find.text(l10n.confirmButton), findsNothing);
      expect(find.text(l10n.cancelButton), findsOneWidget);

      // Close dialog
      await tester.tap(find.text(l10n.cancelButton));
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsNothing);
    },
  );
}
