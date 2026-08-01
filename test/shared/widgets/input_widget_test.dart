import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/src/core/app_theme.dart';
import 'package:sql_studio/src/shared/widgets/input_widget.dart';

void main() {
  Widget wrap(Widget child) => MaterialApp(
    theme: AppTheme.light,
    home: Scaffold(body: Form(child: child)),
  );

  group('InputWidget', () {
    testWidgets('renders the label and hint text', (tester) async {
      await tester.pumpWidget(
        wrap(
          const InputWidget(labelText: 'Name', hintText: 'Enter a name'),
        ),
      );

      expect(find.text('Name'), findsOneWidget);
      expect(find.text('Enter a name'), findsOneWidget);
    });

    testWidgets('calls onChanged as the user types', (tester) async {
      String? value;

      await tester.pumpWidget(
        wrap(InputWidget(onChanged: (v) => value = v)),
      );

      await tester.enterText(find.byType(InputWidget), 'hello');

      expect(value, 'hello');
    });

    testWidgets('shows the suffix icon when given', (tester) async {
      await tester.pumpWidget(
        wrap(const InputWidget(suffixIcon: Icon(Icons.search))),
      );

      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('runs the validator and surfaces its error text', (
      tester,
    ) async {
      final formKey = GlobalKey<FormState>();

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: Scaffold(
            body: Form(
              key: formKey,
              child: InputWidget(
                validator: (value) =>
                    (value == null || value.isEmpty) ? 'Required' : null,
              ),
            ),
          ),
        ),
      );

      formKey.currentState!.validate();
      await tester.pumpAndSettle();

      expect(find.text('Required'), findsOneWidget);
    });
  });
}
