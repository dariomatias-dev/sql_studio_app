import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';

void main() {
  Widget wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

  group('ButtonWidget', () {
    testWidgets('renders the text and calls onPressed when tapped', (
      tester,
    ) async {
      var tapped = false;

      await tester.pumpWidget(
        wrap(ButtonWidget(onPressed: () => tapped = true, text: 'Save')),
      );

      expect(find.text('Save'), findsOneWidget);

      await tester.tap(find.byType(ButtonWidget));

      expect(tapped, isTrue);
    });

    testWidgets('disables the tap target when onPressed is null', (
      tester,
    ) async {
      await tester.pumpWidget(
        wrap(const ButtonWidget(onPressed: null, text: 'Save')),
      );

      final inkWell = tester.widget<InkWell>(find.byType(InkWell));

      expect(inkWell.onTap, isNull);
    });

    testWidgets('renders a custom child instead of the text', (tester) async {
      await tester.pumpWidget(
        wrap(
          ButtonWidget(
            onPressed: () {},
            text: 'Save',
            child: const Icon(Icons.add),
          ),
        ),
      );

      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.text('Save'), findsNothing);
    });
  });
}
