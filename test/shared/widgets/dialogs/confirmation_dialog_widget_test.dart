import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/app_theme.dart';
import 'package:sql_studio/src/shared/widgets/dialogs/confirmation_dialog_widget.dart';

void main() {
  Widget wrap(Widget child) => MaterialApp(
    theme: AppTheme.light,
    supportedLocales: AppLocalizations.supportedLocales,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    home: Scaffold(body: child),
  );

  group('ConfirmationDialogWidget', () {
    testWidgets('renders title, description and confirm button', (
      tester,
    ) async {
      await tester.pumpWidget(
        wrap(
          ConfirmationDialogWidget(
            title: 'Delete database',
            description: 'This action cannot be undone.',
            confirmButton: ElevatedButton(
              onPressed: () {},
              child: const Text('Delete'),
            ),
          ),
        ),
      );

      expect(find.text('Delete database'), findsOneWidget);
      expect(find.text('This action cannot be undone.'), findsOneWidget);
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
