import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget wrap(Widget child) => MaterialApp(
    theme: AppTheme.light,
    home: Scaffold(body: child),
  );

  Widget cancelButton() =>
      ElevatedButton(onPressed: () {}, child: const Text('Cancel'));

  group('InputDialogWidget', () {
    testWidgets('renders title, label and submit text', (tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        wrap(
          InputDialogWidget(
            title: 'New database',
            controller: controller,
            label: 'Name',
            cancelButton: cancelButton(),
            submitText: 'Submit',
            onSubmit: (value) async => true,
          ),
        ),
      );

      expect(find.text('New database'), findsOneWidget);
      expect(find.text('Name'), findsOneWidget);
      expect(find.text('Submit'), findsOneWidget);
    });

    testWidgets('runs a caller-supplied validator on submit', (tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        wrap(
          InputDialogWidget(
            title: 'New database',
            controller: controller,
            label: 'Name',
            cancelButton: cancelButton(),
            submitText: 'Submit',
            validator: (value) => (value == null || value.trim().isEmpty)
                ? 'This field is required'
                : null,
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
                  cancelButton: cancelButton(),
                  submitText: 'Submit',
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
            cancelButton: cancelButton(),
            submitText: 'Submit',
            onSubmit: (value) async => false,
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'taken_name');
      await tester.tap(find.text('Submit'));
      await tester.pumpAndSettle();

      expect(find.text('New database'), findsOneWidget);
    });

    testWidgets('renders the cancel button passed by the caller', (
      tester,
    ) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        wrap(
          InputDialogWidget(
            title: 'Rename',
            controller: controller,
            label: 'Name',
            cancelButton: cancelButton(),
            submitText: 'Save',
            onSubmit: (value) async => true,
          ),
        ),
      );

      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('Save'), findsOneWidget);
    });
  });
}
