import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/shared/widgets/dialogs/error_dialog_widget.dart';

void main() {
  Widget wrap(Widget child) => MaterialApp(
    supportedLocales: AppLocalizations.supportedLocales,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    home: Scaffold(body: child),
  );

  group('ErrorDialogWidget', () {
    testWidgets('renders the given description and a default title', (
      tester,
    ) async {
      await tester.pumpWidget(
        wrap(const ErrorDialogWidget(description: 'Something went wrong')),
      );
      await tester.pumpAndSettle();

      expect(find.text('Something went wrong'), findsOneWidget);
      expect(find.text('Ok'), findsOneWidget);
    });

    testWidgets('renders a custom title when provided', (tester) async {
      await tester.pumpWidget(
        wrap(
          const ErrorDialogWidget(
            title: 'Connection failed',
            description: 'Could not reach the database',
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Connection failed'), findsOneWidget);
    });

    testWidgets('show displays the dialog and Ok dismisses it', (
      tester,
    ) async {
      await tester.pumpWidget(
        wrap(
          Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () => ErrorDialogWidget.show(
                  context,
                  description: 'Failed to save',
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

      await tester.tap(find.text('Ok'));
      await tester.pumpAndSettle();

      expect(find.text('Failed to save'), findsNothing);
    });
  });
}
