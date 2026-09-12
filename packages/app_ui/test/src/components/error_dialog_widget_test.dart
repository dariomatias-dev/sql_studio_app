import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget wrap(Widget child) => MaterialApp(
    theme: AppTheme.light,
    home: Scaffold(body: child),
  );

  group('ErrorDialogWidget', () {
    testWidgets('renders the given title, description and dismiss label', (
      tester,
    ) async {
      await tester.pumpWidget(
        wrap(
          const ErrorDialogWidget(
            title: 'Error',
            description: 'Something went wrong',
            dismissLabel: 'OK',
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Error'), findsOneWidget);
      expect(find.text('Something went wrong'), findsOneWidget);
      expect(find.text('OK'), findsOneWidget);
    });

    testWidgets('show displays the dialog and dismiss closes it', (
      tester,
    ) async {
      await tester.pumpWidget(
        wrap(
          Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () => ErrorDialogWidget.show(
                  context,
                  title: 'Error',
                  description: 'Failed to save',
                  dismissLabel: 'OK',
                ),
                child: const Text('Trigger'),
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('Trigger'));
      await tester.pumpAndSettle();

      expect(find.text('Failed to save'), findsOneWidget);

      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      expect(find.text('Failed to save'), findsNothing);
    });
  });
}
