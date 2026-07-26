import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/shared/widgets/dialogs/input_dialog_widget.dart';

void main() {
  Widget wrap(Widget child) => MaterialApp(
    supportedLocales: AppLocalizations.supportedLocales,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    home: Scaffold(body: child),
  );

  group('InputDialogWidget', () {
    testWidgets('renders title and label', (tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        wrap(
          InputDialogWidget(
            title: 'New database',
            controller: controller,
            label: 'Name',
            onSubmit: (value) async => true,
          ),
        ),
      );

      expect(find.text('New database'), findsOneWidget);
      expect(find.text('Name'), findsOneWidget);
    });

    testWidgets('shows validation error for empty input by default', (
      tester,
    ) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        wrap(
          InputDialogWidget(
            title: 'New database',
            controller: controller,
            label: 'Name',
            onSubmit: (value) async => true,
          ),
        ),
      );

      await tester.tap(find.text('Submit'));
      await tester.pumpAndSettle();

      expect(find.text('This field is required'), findsOneWidget);
    });

    testWidgets('calls onSubmit with the entered value and pops on success', (
      tester,
    ) async {
      final controller = TextEditingController();
      String? submittedValue;

      await tester.pumpWidget(
        wrap(
          Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () => InputDialogWidget.show(
                  context,
                  title: 'New database',
                  controller: controller,
                  label: 'Name',
                  onSubmit: (value) async {
                    submittedValue = value;
                    return true;
                  },
                ),
                child: const Text('Open'),
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField), 'my_db');
      await tester.tap(find.text('Submit'));
      await tester.pumpAndSettle();

      expect(submittedValue, 'my_db');
      expect(find.text('New database'), findsNothing);
    });

    testWidgets('keeps the dialog open when onSubmit returns false', (
      tester,
    ) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        wrap(
          InputDialogWidget(
            title: 'New database',
            controller: controller,
            label: 'Name',
            onSubmit: (value) async => false,
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'taken_name');
      await tester.tap(find.text('Submit'));
      await tester.pumpAndSettle();

      expect(find.text('New database'), findsOneWidget);
    });

    testWidgets('uses the custom submitText when provided', (tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        wrap(
          InputDialogWidget(
            title: 'Rename',
            controller: controller,
            label: 'Name',
            submitText: 'Save',
            onSubmit: (value) async => true,
          ),
        ),
      );

      expect(find.text('Save'), findsOneWidget);
      expect(find.text('Submit'), findsNothing);
    });
  });
}
