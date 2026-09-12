import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget wrap(Widget child) => MaterialApp(
    theme: AppTheme.light,
    home: Scaffold(body: child),
  );

  group('ConfirmationDialogWidget', () {
    testWidgets('renders title, description, cancel and confirm buttons', (
      tester,
    ) async {
      await tester.pumpWidget(
        wrap(
          ConfirmationDialogWidget(
            title: 'Delete database',
            description: 'This action cannot be undone.',
            cancelButton: ElevatedButton(
              onPressed: () {},
              child: const Text('Cancel'),
            ),
            confirmButton: ElevatedButton(
              onPressed: () {},
              child: const Text('Delete'),
            ),
          ),
        ),
      );

      expect(find.text('Delete database'), findsOneWidget);
      expect(find.text('This action cannot be undone.'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('Delete'), findsOneWidget);
    });

    testWidgets('show displays the dialog and returns its popped result', (
      tester,
    ) async {
      bool? result;

      await tester.pumpWidget(
        wrap(
          Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () async {
                  result = await ConfirmationDialogWidget.show<bool>(
                    context,
                    title: 'Confirm',
                    description: 'Proceed?',
                    cancelButton: ElevatedButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('No'),
                    ),
                    confirmButton: ElevatedButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Yes'),
                    ),
                  );
                },
                child: const Text('Open'),
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('Confirm'), findsOneWidget);

      await tester.tap(find.text('Yes'));
      await tester.pumpAndSettle();

      expect(result, isTrue);
    });
  });
}
